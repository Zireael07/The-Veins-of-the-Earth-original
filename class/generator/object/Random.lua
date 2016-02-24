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
local Map = require "engine.Map"
require "engine.Generator"
module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level)
	engine.Generator.init(self, zone, map, level)
	local data = level.data.generator.object

	if data.adjust_level_to_player and game:getPlayer() then
		self.adjust_level_to_player = {base=game:getPlayer().level, min=data.adjust_level_to_player[1], max=data.adjust_level_to_player[2]}
	end
	self.filters = data.filters
	self.nb_object = data.nb_object or {10, 20}
	self.level_range = data.level_range or {level, level}
end

function _M:generate()
	self:regenFrom(1)
end

function _M:generateOne()
	local f = nil
	if self.filters then f = self.filters[rng.range(1, #self.filters)] end
	local o = self.zone:makeEntity(self.level, "object", f, nil, true)
	if o then
		local x, y = rng.range(0, self.map.w-1), rng.range(0, self.map.h-1)
		local tries = 0
		while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or self.map(x, y, Map.OBJECT) or (self.map.room_map[x][y] and self.map.room_map[x][y].special))
		and tries < 10000 do
			x, y = rng.range(0, self.map.w-1), rng.range(0, self.map.h-1)
			tries = tries + 1
		end
		if tries < 10000 then
			self.zone:addEntity(self.level, o, "object", x, y)
			--Taken from ToME 2 port
			o.found = {
				type='floor',
				zone_name = self.zone.name,
				town_zone = self.zone.town,
				level = game:getDunDepth(),
				level_name = game.level.name,
			}
		end
	end
end

function _M:regenFrom(current)
	for i = current, rng.range(self.nb_object[1], self.nb_object[2]) do
		self:generateOne()
	end
end
