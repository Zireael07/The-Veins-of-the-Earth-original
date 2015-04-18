-- Veins of the Earth
-- Copyright (C) 2013 Zireael
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

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Inventory = require "engine.ui.Inventory"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, inven, filter, action, actor)
	self.inven = inven
	self.filter = filter
	self.action = action
	self.actor = actor
	Dialog.init(self, title or "Inventory", math.max(800, game.w * 0.8), math.max(600, game.h * 0.8))

	self.c_desc = TextzoneList.new{scrollbar = true, width=math.floor(self.iw / 2 - 10), height=self.ih}

	self.c_inven = Inventory.new{actor=actor, inven=inven, filter=filter, width=math.floor(self.iw / 2 - 10), height=self.ih - 10,
		fct=function(item, sel, button, event) self:use(item, button, event) end,
		select=function(item, force) self:select(item, force) end,
	--	select_tab=function(item) self:select(item) end,
	}

	self.c_inven.c_inven.on_focus_change = function(ui_self, status) if status == true then game.tooltip:erase() end end

	self:loadUI{
		{left=0, top=0, ui=self.c_inven},
		{right=0, top=0, ui=self.c_desc},
		{hcenter=0, top=5, ui=Separator.new{dir="horizontal", size=self.ih - 10}},
	}
	self:setFocus(self.c_inven)
	self:setupUI()

	self.key:addCommands{
		__TEXTINPUT = function(c)
			if self.focus_ui and self.focus_ui.ui == self.c_inven then
				self.c_inven:keyTrigger(c)
			end
		end,
	}
	self.key:addBinds{
		EXIT = function() game:unregisterDialog(self) end,
	}
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:select(item, force)
	if self.cur_item == item and not force then return end
	if not item then return end
	if item.last_display_x and item.object then
		if not item.desc or force then item.desc = item.object:getDesc({do_color=true}, self.actor:getInven(item.object:wornInven())) end
		self.c_desc:switchItem(item, item.desc, true)
	elseif item.last_display_x and item.data and item.data.desc then
		game:tooltipDisplayAtMap(item.last_display_x, item.last_display_y, item.data.desc, {up=true}, force)
	end
	self.cur_item = item
end

function _M:use(item)
	local dont_end = false
	if item and item.object then
		dont_end = self.action(item.object, item.item)
	end
	self.c_inven:generateList()
	self:select(self.c_inven.c_inven.list[self.c_inven.c_inven.sel])
	if not dont_end then game:unregisterDialog(self) end
end

function _M:updateList()
	self.c_inven:generateList()
	self:select(self.c_inven.c_inven.list[self.c_inven.c_inven.sel])
end

function _M:drawFrame(x, y, r, g, b, a)
	Dialog.drawFrame(self, x, y, r, g, b, a)
	if r == 0 then return end -- Drawing the shadow
	if self.ui ~= "metal" then return end
	if not self.title_fill then return end

	core.display.drawQuad(x + self.frame.title_x, y + self.frame.title_y, self.title_fill, self.frame.title_h, self.title_fill_color.r, self.title_fill_color.g, self.title_fill_color.b, 60)
end
