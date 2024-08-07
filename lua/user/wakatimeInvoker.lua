-- Inspired by: https://github.com/arkav/lualine-lsp-progress

local wakatimeInvoker = require('lualine.component'):extend()
local wakatime = ""
local apiField = '"api_key       "'
local entered = false
local lastRun = os.time()
local timeout = 900
wakatimeInvoker.init = function(self, options)
  wakatimeInvoker.super.init(self, options)
end

local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
local function enc(data)
  return ((data:gsub('.', function(x)
    local r, b = '', x:byte()
    for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
    return r;
  end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
    if (#x < 6) then return '' end
    local c = 0
    for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
    return b:sub(c + 1, c + 1)
  end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

local function dec(data)
  data = string.gsub(data, '[^' .. b .. '=]', '')
  return (data:gsub('.', function(x)
    if (x == '=') then return '' end
    local r, f = '', (b:find(x) - 1)
    for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
    return r;
  end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
    if (#x ~= 8) then return '' end
    local c = 0
    for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
    return string.char(c)
  end))
end

wakatimeInvoker.update_status = function(self)
  if entered == false or os.time() > lastRun + timeout then
    local openPop = assert(io.popen('timeout 2 ~/.wakatime/wakatime-cli --today', 'r'))
    wakatime = openPop:read('*all')
    openPop:close()
    lastRun= os.time()
    entered = true
    if wakatime == "" then
      local openPop = assert(io.popen("awk -F= '$1 == " .. apiField .. "{print $2}' ~/.wakatime.cfg", 'r'))
      local wakatimeApiRaw = openPop:read('*all')
      openPop:close()
      local wakatimeApiEncoded = enc(string.sub(wakatimeApiRaw, 2, string.len(wakatimeApiRaw)-1))
      local openPopCurl = assert(io.popen("curl -s --location 'https://wakatime.com/api/v1/users/current/summaries?start=2024-05-31&end=2024-05-31' "
        .."--header 'Authorization: Basic "..wakatimeApiEncoded.."'"
        .."| jq .cumulative_total.text", 'r'))
      wakatime = openPopCurl:read('*all')
      wakatime = "api: "..string.sub(wakatime, 2, string.len(wakatime) - 1)
      openPopCurl:close()
    end
  end
  if wakatime == "" then
    return "📟 " .. "waka_err"
  else
    return "📟 " .. string.sub(wakatime, 0, string.len(wakatime) - 1)
  end
end

return wakatimeInvoker
