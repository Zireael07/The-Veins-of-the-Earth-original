--Veins of the Earth
--Zireael 2014
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
--Zireael

require 'engine.class'
local ActorRandom = require 'engine.generator.actor.Random'
local Map = require 'engine.Map'

module(..., package.seeall, class.inherit(ActorRandom))

function _M:init(zone, map, level, spots)
  ActorRandom.init(self, zone, map, level, spots)
  self.data = level.data.generator.actor
end

function _M:generateOne()
	local f = nil
	if self.filters then f = self.filters[rng.range(1, #self.filters)] end
	local m = self.zone:makeEntity(self.level, "actor", f, nil, true)
	--Special case: dlevel 1
	if game.level.level == 1 then
		while m and m.challenge < (game.level.level + 1) do
			m = self.zone:makeEntity(self.level, "actor", f, nil, true)
		end
		if m then
		local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
		local tries = 0
		--No more spawning in walls!
		while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
			x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
			tries = tries + 1
		end
		if tries < 10000 then
			self.zone:addEntity(self.level, m, "actor", x, y)
			if self.post_generation then self.post_generation(m) end
		end
		end
	--Special case: dlvl 2-5
	elseif game.level.level == 2 or game.level.level == 3 or game.level.level == 4 or game.level.level == 5 then
		while m and m.challenge <= (game.level.level + 2) do
			m = self.zone:makeEntity(self.level, "actor", f, nil, true)
		end
		if m then
		local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
		local tries = 0
		--No more spawning in walls!
		while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
			x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
			tries = tries + 1
		end
		if tries < 10000 then
			self.zone:addEntity(self.level, m, "actor", x, y)
			if self.post_generation then self.post_generation(m) end
		end
		end


--	end
	--Normal
	else	
	--Hack! No more CR 20 opponents on dungeon level 1
	while m and m.challenge < (game.level.level + 5) do
		m = self.zone:makeEntity(self.level, "actor", f, nil, true)
	end
	if m then
		local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
		local tries = 0
		--No more spawning in walls!
		while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
			x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
			tries = tries + 1
		end
		if tries < 10000 then
			self.zone:addEntity(self.level, m, "actor", x, y)
			if self.post_generation then self.post_generation(m) end
		end
	end
	end
end