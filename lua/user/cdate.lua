local CTimeLine = require('lualine.component'):extend()

CTimeLine.init = function(self, options)
	CTimeLine.super.init(self, options)
end

CTimeLine.update_status = function(self)
    return "📅"..os.date(self.options.format or "%d/%m/%Y", os.time())
end

return CTimeLine
