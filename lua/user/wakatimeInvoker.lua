-- Inspired by: https://github.com/arkav/lualine-lsp-progress

local wakatimeInvoker = require('lualine.component'):extend()
local wakatime = ""
local entered = false
local lastRun= os.time()
local timeout = 900
wakatimeInvoker.init = function(self, options)
	wakatimeInvoker.super.init(self, options)
end
wakatimeInvoker.update_status = function(self)
  if entered == false or os.time() > lastRun + timeout then
    local openPop = assert(io.popen('~/.wakatime/wakatime-cli --today', 'r'))
    wakatime = openPop:read('*all')
    openPop:close()
    lastRun= os.time()
    entered=true
  end
  return string.sub(wakatime,0,string.len(wakatime)-1)
end

return wakatimeInvoker
