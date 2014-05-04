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

require 'engine.class'
local ActorRandom = require 'engine.generator.actor.Random'
local Map = require 'engine.Map'

module(..., package.seeall, class.inherit(ActorRandom))

function _M:init(zone, map, level, spots)
  ActorRandom.init(self, zone, map, level, spots)
  self.data = level.data.generator.actor
  self.nb_encounters = self.data.nb_encounters or 4
end

function _M:generateOne()
	local nb_encounters_made = 0
	local f = nil
	if self.filters then f = self.filters[rng.range(1, #self.filters)] end
	local m = self.zone:makeEntity(self.level, "actor", f, nil, true)

	--Generate encounters only
	if nb_encounters_made <= self.nb_encounters then
		if m and m.type == "encounter" then
			--Special case - dlvl 1
			if game.level.level == 1 then
				if m.challenge <= (game.level.level + 3) then
					local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
					local tries = 0
					--No more spawning in walls!
						while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
						x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
						tries = tries + 1
					end
					if tries < 10000 then
						self.zone:addEntity(self.level, m, "actor", x, y)
						nb_encounters_made = nb_encounters_made + 1
					if self.post_generation then self.post_generation(m) end
					end
				end
			--Special case: dlvl 2-5
			elseif game.level.level == 2 or game.level.level == 3 or game.level.level == 4 or game.level.level == 5 then
				if m.challenge <= (game.level.level + 3) then
					local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
					local tries = 0
					--No more spawning in walls!
						while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
						x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
						tries = tries + 1
					end
					if tries < 10000 then
						self.zone:addEntity(self.level, m, "actor", x, y)
						nb_encounters_made = nb_encounters_made + 1
					if self.post_generation then self.post_generation(m) end
					end
				end

			--Normal
			else	
				if m.challenge <= (game.level.level + 5) then
				local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
				local tries = 0
				--No more spawning in walls!
					while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
					x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
					tries = tries + 1
					end
					if tries < 10000 then
						self.zone:addEntity(self.level, m, "actor", x, y)
						nb_encounters_made = nb_encounters_made + 1
					if self.post_generation then self.post_generation(m) end
					end
				end
			end
		end
	end
end