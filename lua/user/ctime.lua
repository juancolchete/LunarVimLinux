-- Inspired by: https://github.com/arkav/lualine-lsp-progress

local CTimeLine = require('lualine.component'):extend()
local lastKeyStroke = os.time()
local IDLE=0
local ctimeInfo = ""
CTimeLine.init = function(self, options)
	CTimeLine.super.init(self, options)
end

vim.on_key(function(self)
  lastKeyStroke = os.time()
end)
CTimeLine.update_status = function(self)
  IDLE = math.floor((os.time()-lastKeyStroke)/60)
  if(IDLE>1) then
    ctimeInfo = "🕒 "..os.date(self.options.format or "%H:%M:%S", os.time()).." 💤"..IDLE
  else
    ctimeInfo = "🕒 "..os.date(self.options.format or "%H:%M:%S", os.time())
  end
  return ctimeInfo
end

return CTimeLine
