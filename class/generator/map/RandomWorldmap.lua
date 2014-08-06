-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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
local Map = require "engine.Map"
require "engine.Generator"
module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level)
	self.grid_list = zone.grid_list
	self.data = data
	self.floor = self:resolve("floor")
	self.wall = self:resolve("wall")
	self.down = self:resolve("down")
end

function _M:generate()
	local chance = rng.dice(1,8)

	for i = 0, self.map.w - 1 do for j = 0, self.map.h - 1 do
	--[[	if rng.percent(25) then
			self.map(i, j, Map.TERRAIN, self.down)
		else]]if 	rng.percent(45) then
			self.map(i, j, Map.TERRAIN, self.floor)
		else
			self.map(i, j, Map.TERRAIN, self.wall)
		end
	end end

	-- Always starts at 1, 1
	self.map(1, 1, Map.TERRAIN, self.floor)
	self.map.room_map[1][1].special = "exit"
	return 1, 1
end