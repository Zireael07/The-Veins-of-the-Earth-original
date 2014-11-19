-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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
require "engine.ui.Base"
local Shader = require "engine.Shader"
local Mouse = require "engine.Mouse"
local Slider = require "engine.ui.Slider"

--module(..., package.seeall, class.make)
module(..., package.seeall, class.inherit(engine.ui.Base))

function _M:init(actor, x, y, w, h, bgcolor, fontname, fontsize)
	self.actor = actor
	if type(bgcolor) ~= "string" then
		self.bgcolor = bgcolor or {0,0,0}
	else
		self.bgcolor = {0,0,0}
		self.bg_image = bgcolor
	end
	self.font = core.display.newFont(fontname or "/data/font/DroidSansMono.ttf", fontsize or 10)
	self.font_h = self.font:lineSkip()
	self:resize(x, y, w, h)
	self.nb_cols = 1
	self.scroll = 0
end

function _M:enableShadow(v)
	self.shadow = v
end

--- Resize the display area
function _M:resize(x, y, w, h)
	self.display_x, self.display_y = math.floor(x), math.floor(y)
	self.w, self.h = math.floor(w), math.floor(h)
	self.fw, self.fh = self.w - 4, self.font:lineSkip()
	self.max_display = math.floor(self.h / self.fh)
	self.surface = core.display.newSurface(w, h)
	self.texture, self.texture_w, self.texture_h = self.surface:glTexture()
	if self.actor then self.actor.changed = true end

	local cw, ch = self.font:size(" ")
	self.font_w = cw

	if self.bg_image then
		local fill = core.display.loadImage(self.bg_image)
		local fw, fh = fill:getSize()
		self.bg_surface = core.display.newSurface(w, h)
		self.bg_surface:erase(0, 0, 0)
		for i = 0, w, fw do for j = 0, h, fh do
			self.bg_surface:merge(fill, i, j)
		end end
	end
  
	self.scrollbar = Slider.new{size=self.h - 20, max=1, inverse=true}

	self.mouse = Mouse.new()
	self.mouse.delegate_offset_x = self.display_x
	self.mouse.delegate_offset_y = self.display_y
	self.mouse:registerZone(0, 0, self.w, self.h, function(button, x, y, xrel, yrel, bx, by, event) self:mouseEvent(button, x, y, xrel, yrel, bx, by, event) end)
end

--- Sets the display into nb columns
function _M:setColumns(nb)
	self.nb_cols = nb
end

function _M:onMouse(fct)
	self.on_mouse = fct
end

function _M:mouseEvent(button, x, y, xrel, yrel, bx, by, event)
  --game.log("button: "..button..", x: "..x..", y: "..y..", xrel: "..xrel..", yrel: "..yrel..", bx: "..bx..", by: "..by..", event: "..event)
	if button == "wheelup" then self:scrollUp(1)
	elseif button == "wheeldown" then self:scrollUp(-1)
	else
		if not self.on_mouse or not self.dlist then return end
    local row = math.ceil(by / self.font_h) + (self.scrollbar and self.scrollbar.pos or 0)
    --game.log("row: "..row)
    if self.dlist[row] and bx > self.display_x and bx < self.display_x + self.dlist[row].w then
			self.on_mouse(self.dlist[row].actor, button, event, x, y, xrel, yrel, bx, by)
		else
			self.on_mouse(nil, button, event, x, y, xrel, yrel, bx, by)
		end
	end
end

--- Displays the NPC list
function _M:display()
	local a = self.actor
	if not a or not (a and a.changed or self.changed) then return self.surface end

	self.surface:erase(self.bgcolor[1], self.bgcolor[2], self.bgcolor[3], 0)
	if self.bg_surface then self.surface:merge(self.bg_surface, 0, 0) end

	local list = {}
  local count = {}

	-- initialize the array
	for i, act in ipairs(a.fov.actors_dist) do
		if a:canSee(act) and a ~= act then
			local n = act.name:capitalize()
      count[n] = (count[n] or 0) + 1
      list[act.uid] = {}
			list[act.uid].actor = act
			list[act.uid].nb = count[n]
			list[act.uid].dist = math.floor(math.sqrt(a.fov.actors[act] and a.fov.actors[act].sqdist or 1))

			local r = a:reactionToward(act)
			if r > 0 then list[act.uid].color="#LIGHT_GREEN#"
			elseif r == 0 then list[act.uid].color="#LIGHT_STEEL_BLUE#"
			elseif r < 0 then list[act.uid].color="#LIGHT_RED#" end
		end
	end
	self.dlist = {}
	for _, a in pairs(list) do self.dlist[#self.dlist+1] = a end
	table.sort(self.dlist, function(a, b) return a.dist < b.dist end)
	table.sort(self.dlist, function(a, b) return a.actor.energy.value > b.actor.energy.value end)
  self.max = #self.dlist

	local x, y = 0 + self.scrollbar.w, 0
	for i, a in ipairs(self.dlist) do
    if i > self.scrollbar.pos and i <= self.max_display + self.scrollbar.pos then
--      local _, name_color = a.actor:TextRank()      
    local name_color = a.actor:TextColor()
      if self.shadow then
        self.surface:drawColorStringBlended(self.font, ("%s L %d, D %s, E %d"):format(a.actor.name, a.actor.level, a.dist, a.actor.energy.value), x + self.font_h + 2, y+2, 0,0,0)
      end
      local text = ("%s%s%s CR %d L %d, #YELLOW_GREEN#D %s, #LIGHT_UMBER#E %d"):format(name_color, a.actor.name, a.color, a.actor.challenge, a.actor.level, a.dist, a.actor.energy.value)
      local w, h = self.font:size(text)
      a.w = w + self.font_h
      self.surface:drawColorStringBlended(self.font, text, x + self.font_h, y)
      y = y + self.font_h
      --if y + self.font_h >= self.h then y = 0 x = x + math.floor(self.w / self.nb_cols) end
    end
	end

	self.surface:updateTexture(self.texture)
	return self.surface
end

function _M:toScreen()
	self:display()
	self.texture:toScreenFull(self.display_x, self.display_y, self.w, self.h, self.texture_w, self.texture_h)
  self.scrollbar.pos = self.scroll
  self.scrollbar.max = math.max(0, (self.max or 0) - self.max_display)
  if self.scrollbar.pos > 0 then
    self.scrollbar:display(self.display_x, self.display_y)
  end
  if self.shadow and shader then shader:use(false) end
  if not self.dlist then return end
	local x, y = 0 + self.scrollbar.w, 0
	for i, a in ipairs(self.dlist) do
    if i > self.scrollbar.pos and i <= self.max_display + self.scrollbar.pos then
      a.actor:toScreen(nil, x, y, self.font_h, self.font_h, 1, false, false)
      y = y + self.font_h
    end
  end
end

--- Scroll the zone
-- @param i number representing how many lines to scroll
function _M:scrollUp(i)
	self.scroll = self.scroll + i
	if self.scroll > self.scrollbar.max then self.scroll = self.scrollbar.max end
	if self.scroll < 0 then self.scroll = 0 end
	self.changed = true
end
