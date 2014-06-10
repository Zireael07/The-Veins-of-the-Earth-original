-- TE4 - T-Engine 4
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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
local Base = require "engine.ui.Base"
local Focusable = require "engine.ui.Focusable"
local Slider = require "engine.ui.Slider"

--- A generic UI list
module(..., package.seeall, class.inherit(Base, Focusable))

function _M:init(t)
	self.list = assert(t.list, "no list list")
	self.w = assert(t.width, "no list width")
	self.h = t.height
	self.nb_items = t.nb_items
	assert(self.h or self.nb_items, "no list height/nb_items")
	self.fct = t.fct
	self.on_select = t.select
	self.on_drag = t.on_drag
	self.display_prop = t.display_prop or "name"
	self.scrollbar = t.scrollbar
	self.all_clicks = t.all_clicks
	self.font = core.display.newFont(veins.fonts.dialog.style or "/data/font/INSULA__.ttf", veins.fonts.dialog.size or 16)

	Base.init(self, t)
end

function _M:generate()
	self.mouse:reset()
	self.key:reset()

	self.sel = 1
	self.scroll = 1
	self.max = #self.list

	local fw, fh = self.w, self.font_h + 6
	self.fw, self.fh = fw, fh
	if not self.surf then self.surf = core.display.newSurface(fw, fh) end
	local s = self.surf

	self.frame = self:makeFrame(nil, fw, fh)
	self.frame_sel = self:makeFrame("ui/selector-sel", fw, fh)
	self.frame_usel = self:makeFrame("ui/selector", fw, fh)

	if not self.h then self.h = self.nb_items * fh end

	self.max_display = math.floor(self.h / fh)

	-- Draw the scrollbar
	if self.scrollbar then
		self.scrollbar = Slider.new{size=self.h - fh, max=self.max}
	end

	-- Draw the list items
	for i, item in ipairs(self.list) do
		self:drawItem(item)
	end

	-- Add UI controls
	self.mouse:registerZone(0, 0, self.w, self.h, function(button, x, y, xrel, yrel, bx, by, event)
		if button == "wheelup" and event == "button" then self.scroll = util.bound(self.scroll - 1, 1, self.max - self.max_display + 1)
		elseif button == "wheeldown" and event == "button" then self.scroll = util.bound(self.scroll + 1, 1, self.max - self.max_display + 1) end

		if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
		self.sel = util.bound(self.scroll + math.floor(by / self.fh), 1, self.max)
		if (self.all_clicks or button == "left") and event == "button" then self:onUse(button) end
		if event == "motion" and button == "left" and self.on_drag then self.on_drag(self.list[self.sel], self.sel) end
		self:onSelect()
	end)
	self.key:addBinds{
		ACCEPT = function() self:onUse() end,
		MOVE_UP = function()
			if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
			self.sel = util.boundWrap(self.sel - 1, 1, self.max) self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
			self:onSelect()
		end,
		MOVE_DOWN = function()
			if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
			self.sel = util.boundWrap(self.sel + 1, 1, self.max) self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
			self:onSelect()
		end,
	}
	self.key:addCommands{
		[{"_UP","ctrl"}] = function() self.key:triggerVirtual("MOVE_UP") end,
		[{"_DOWN","ctrl"}] = function() self.key:triggerVirtual("MOVE_DOWN") end,
		_HOME = function()
			if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
			self.sel = 1
			self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
			self:onSelect()
		end,
		_END = function()
			if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
			self.sel = self.max
			self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
			self:onSelect()
		end,
		_PAGEUP = function()
			if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
			self.sel = util.bound(self.sel - self.max_display, 1, self.max)
			self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
			self:onSelect()
		end,
		_PAGEDOWN = function()
			if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
			self.sel = util.bound(self.sel + self.max_display, 1, self.max)
			self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
			self:onSelect()
		end,
	}
	self:onSelect()
end

function _M:drawItem(item)
	--game.log("item.name: %s / item.file: %s", item.name, item.file)
	local s = self.surf
	local color = item.color or {255,255,255}
	local text = item.name
	if item.mono then color = {225,225,255} end
	local font = core.display.newFont("/data/font/"..item.file..".ttf", veins.fonts.dialog.size or 16)
	s:erase(0, 0, 0, 0)
	s:drawColorStringBlended(font, text, 0, (self.fh - self.font_h) / 2, color[1], color[2], color[3], true, fw)
	item._tex = {s:glTexture()}
end

function _M:select(i)
	if self.sel and self.list[self.sel] then self.list[self.sel].focus_decay = self.focus_decay_max end
	self.sel = util.bound(i, 1, #self.list)
	self.scroll = util.scroll(self.sel, self.scroll, self.max_display)
	self:onSelect()
end

function _M:onSelect()
	local item = self.list[self.sel]
	if not item then return end

	if rawget(self, "on_select") then self.on_select(item, self.sel) end
end

function _M:onUse(...)
	local item = self.list[self.sel]
	if not item then return end
	self:sound("button")
	if item.fct then item:fct(item, self.sel, ...)
	else self.fct(item, self.sel, ...) end
end

function _M:display(x, y, nb_keyframes)
	local bx, by = x, y

	local max = math.min(self.scroll + self.max_display - 1, self.max)
	for i = self.scroll, max do
		local item = self.list[i]
		if not item then break end
		if self.sel == i then
			if self.focused then self:drawFrame(self.frame_sel, x, y)
			else self:drawFrame(self.frame_usel, x, y) end
		else
			self:drawFrame(self.frame, x, y)
			if item.focus_decay then
				if self.focused then self:drawFrame(self.frame_sel, x, y, 1, 1, 1, item.focus_decay / self.focus_decay_max_d)
				else self:drawFrame(self.frame_usel, x, y, 1, 1, 1, item.focus_decay / self.focus_decay_max_d) end
				item.focus_decay = item.focus_decay - nb_keyframes
				if item.focus_decay <= 0 then item.focus_decay = nil end
			end
		end
		if self.text_shadow then item._tex[1]:toScreenFull(x+1 + self.frame_sel.b4.w, y+1, self.fw, self.fh, item._tex[2], item._tex[3], 0, 0, 0, self.text_shadow) end
		item._tex[1]:toScreenFull(x + self.frame_sel.b4.w, y, self.fw, self.fh, item._tex[2], item._tex[3])
		y = y + self.fh
	end

	if self.focused and self.scrollbar then
		self.scrollbar.pos = self.sel
		self.scrollbar:display(bx + self.w - self.scrollbar.w, by, by + self.fh)
	end
end
