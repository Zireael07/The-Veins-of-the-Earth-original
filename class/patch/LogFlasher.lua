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

--- Module that handles a single message line, with pausing and flashing
module(..., package.seeall, class.make)

GOOD = 1
NEUTRAL = 2
BAD = 3

--- Creates the log zone
function _M:init(x, y, w, h, max, fontname, fontsize, color, bgcolor)
	self.color = color or {255,255,255}
	self.bgcolor = bgcolor or {0,0,0}
	self.display_x, self.display_y = math.floor(x), math.floor(y)
	self.w, self.h = math.floor(w), math.floor(h)
	self.font = core.display.newFont(fontname or "/data/font/DroidSans.ttf", fontsize or 16)
	self.font_h = self.font:lineSkip()
	self.surface = core.display.newSurface(w, h)
	self.texture, self.texture_w, self.texture_h = self.surface:glTexture()
	self.log = {}
	getmetatable(self).__call = _M.call
	self.flashing_style = NEUTRAL
	self.flashing = 0
	self.changed = true
end

--- Resize the display area
function _M:resize(x, y, w, h)
	self.display_x, self.display_y = math.floor(x), math.floor(y)
	self.w, self.h = math.floor(w), math.floor(h)
	self.surface = core.display.newSurface(w, h)
	self.texture, self.texture_w, self.texture_h = self.surface:glTexture()
	self.changed = true
end

--- Appends text to the log
-- This method is set as the call methamethod too, this means it is usable like this:<br/>
-- log = LogDisplay.new(...)<br/>
-- log("foo %s", s)
function _M:call(style, str, ...)
	if self.flashing == 0 and #self.log > 0 then self.log = {} end

	local base = ""
	if #self.log > 0 then base = table.remove(self.log) end

	str = str:format(...)
	local lines = (base .. " " .. str):splitLines(self.w - 4, self.font)
	for i = 1, #lines do
		table.insert(self.log, lines[i])
	end
	self.flashing_style = style
	self.flashing = 20

	self:getNext()
end

function _M:getNext(remove)
	if remove then table.remove(self.log, 1) end
	local line = self.log[1]

	self.surface:erase(0,0,0,0)
	local old_style = self.font:getStyle()
	if line then
		self.surface:drawColorStringBlended(self.font, line, 0, 0, self.color[1], self.color[2], self.color[3], true)
	end
	self.font:setStyle(old_style)
	self.surface:updateTexture(self.texture)
	self.changed = true
end

--- Clear the log
function _M:empty(force)
	if self.flashing == 0 or force then
		self.log = {}
		self.flashing = 0
		self.changed = true
		self.surface:erase(0,0,0,0)
	end
end

function _M:display()
	self:toScreen()
	return self.surface
end

function _M:toScreen(nb_keyframe)
	nb_keyframe = nb_keyframe or 1
	self.changed = false

	-- Erase and the display the map
	if self.flashing_style == BAD then
		core.display.drawQuad(self.display_x, self.display_y, self.w, self.h, self.bgcolor[1] + self.flashing * 10, self.bgcolor[2], self.bgcolor[3], 255)
	elseif self.flashing_style == NEUTRAL then
		core.display.drawQuad(self.display_x, self.display_y, self.w, self.h, self.bgcolor[1], self.bgcolor[2], self.bgcolor[3] + self.flashing * 10, 255)
	else
		core.display.drawQuad(self.display_x, self.display_y, self.w, self.h, self.bgcolor[1], self.bgcolor[2] + self.flashing * 10, self.bgcolor[3], 255)
	end
	self.texture:toScreenFull(self.display_x, self.display_y, self.w, self.h, self.texture_w, self.texture_h)

	if self.flashing > 0 then self.flashing = self.flashing - nb_keyframe
	elseif self.changed then self:getNext(true) end
end
