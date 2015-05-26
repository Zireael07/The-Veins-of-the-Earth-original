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

require "engine.class"
local Base = require "engine.ui.Base"
local Tiles = require "engine.Tiles"
local Image = require "engine.ui.Image"

module(..., package.seeall, class.inherit(Base))

function _M:init(t)
	self.actor = assert(t.actor, "no actorframe actor")
	self.w = assert(t.w, "no actorframe w")
	self.h = assert(t.h, "no actorframe h")
--	self.tiles = t.tiles or Tiles.new(self.w, self.h, nil, nil, true, nil)

	Base.init(self, t)
end

function _M:generate()
end

function _M:display(x, y, nb_keyframes, ox, oy)
	local o = self.actor
	if o then --and o.toScreen then
		if o.show_portrait == true then

		if o.portrait and type(o.portrait) == "string" then
			self.image = Image.new{file=o.portrait, auto_width=true, auto_height=true}
			self.image.w = self.w
			self.image.h = self.h
			if self.image then
				self.image:display(x, y)
			end
		--	o:toScreen(self.tiles, x, y, self.w, self.h)
	--	elseif o.portrait and o.add_mos then

		--	o:toScreen(self.tiles, x, y - h, self.w, self.h * 2)
		end
		end
	end

	self.last_display_x = ox
	self.last_display_y = oy
end
