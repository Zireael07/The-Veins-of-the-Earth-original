require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"
local TextzoneList = require "engine.ui.TextzoneList"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, choices, func)
	self.title = title
	self.list = choices
	self.func = func

	Dialog.init(self, title, 300, 20)

    -- Hack: Duplicate of fh logic from engine.ui.List
    local height = (self.font_h + 6) * #self.list

    local scrollbar = false
    if height > game.h*0.7 then height = game.h*0.7 scrollbar = true end

	self.c_choices = List.new{width=self.iw/2, nb_items=#self.list, height=height, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:select(item,sel) end, scrollbar=scrollbar}
	self.c_descriptions = TextzoneList.new{width=self.iw/2-20, height = 400, text="#GOLD#Description#LAST#"}

	self:loadUI{
		{left=0, top=0, ui=self.c_choices},
		{right=0, top=0, ui=self.c_descriptions}
	}
	self:setFocus(self.c_choices)
	self:setupUI(false, true)

	self.key:addBinds{
		EXIT = function() game:unregisterDialog(self) end,
	}
end

function _M:use(item)
	self.func(item.name, item)
	game:unregisterDialog(self)
end

function _M:select(item, sel)
	if item and self.c_descriptions then
		self.c_descriptions:switchItem(item, item.desc)
	end
end
