-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2015 Nicolas Casalini
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local EquipDoll = require "engine.ui.EquipDoll"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"
local Tab = require "engine.ui.Tab"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, actor, filter, action)
	self.actor = actor
	self.filter = filter
	self.action = action
	Dialog.init(self, title or "Equipment", math.max(800, game.w * 0.8), math.max(600, game.h * 0.8))

	self.c_doll = EquipDoll.new{actor=actor, drag_enable=true, filter=filter,
		fct=function(item) self:use(item) end,
		on_select=function(ui, inven, item, o) self:select{item=item, object=o} end
	}

	local vsep = Separator.new{dir="horizontal", size=self.ih - 10}
	self.c_desc = TextzoneList.new{width=self.iw - self.c_doll.w - vsep.w, height=self.ih, no_color_bleed=true}

	self:loadUI{
		{left=0, top=0, ui=self.c_doll},
		{left=self.c_doll, top=5, ui=vsep},
		{left=vsep, right=0, top=0, ui=self.c_desc},
	}
	self:setFocus(self.c_doll)
	self:setupUI()

	self.key:addCommands{
		__TEXTINPUT = function(c)
			if self.list and self.list.chars[c] then
				self:use(self.list[self.list.chars[c]])
			end
		end,
	}
	self.key:addBinds{
		ACCEPT = function()
--			self:use(self.c_list.list[self.c_list.sel])
		end,
		EXIT = function() game:unregisterDialog(self) end,
	}
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:select(item)
	if item and self.uis[2] then
		if item.object then
			self.c_desc:switchItem(item, item.object:getDesc({do_color=true}, self.actor:getInven(item.object:wornInven())))
		end
	end
end
function _M:use(item)
	if item and item.object then
		self.action(item.object, item.inven, item.item)
	end
	game:unregisterDialog(self)
end
