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
local Map = require "engine.Map"
local Random = require "mod.class.generator.actor.Random"
module(..., package.seeall, class.inherit(Random))

function _M:init(zone, map, level, spots)
	Random.init(self, zone, map, level, spots)
	local data = level.data.generator.actor
	self.on_spot_chance = data.on_spot_chance or 70
	self.spot_radius = data.spot_radius or 5
	self.spot_filters = data.spot_filters or {}

	-- Pick a number of spots
	self.genspots = {}
	for i = 1, self.nb_spots or 2 do
		local spot = self.level:pickSpot(rng.table(self.spot_filters))
		if spot then self.genspots[#self.genspots+1] = spot end
	end
end

function _M:getSpawnSpot(m)
	-- Spawn near a spot
	if rng.percent(self.on_spot_chance) then
		-- Cycle through spots, looking for one with empty spaces
		local tries = 0
		local spot = rng.table(self.genspots)
		if not spot then
			print("No spots for spawning")
			return
		end
		local _, _, gs = util.findFreeGrid(spot.x, spot.y, self.spot_radius, "block_move", {[Map.ACTOR]=true})
		while not gs and tries < 10 do
			spot = rng.table(self.genspots)
			_, _, gs = util.findFreeGrid(spot.x, spot.y, self.spot_radius, "block_move", {[Map.ACTOR]=true})
			tries = tries + 1
		end
		if not gs then
			print("No more free space for spawning")
			return
		end
		-- Cycle through available spaces
		tries = 0
		local g = rng.table(gs)
		local x, y = g[1], g[2]
		while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
			g = rng.table(gs)
			x, y = g[1], g[2]
			tries = tries + 1
		end
		if tries < 100 then
			print("Spawning ", m.name, " near ", spot.type, spot.subtype, " at ", x, y)
			-- Count an actor there
			spot.spawned_actors = (spot.spawned_actors or 0) + 1
			return x, y
		end

	-- Spawn randomly
	else
		local x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
		local tries = 0
		while (self.map:checkEntity(x, y, Map.TERRAIN, "block_move") or (self.map.room_map[x][y] and self.map.room_map[x][y].special)) and tries < 100 do
			x, y = rng.range(self.area.x1, self.area.x2), rng.range(self.area.y1, self.area.y2)
			tries = tries + 1
		end
		if tries < 100 then
			return x, y
		end
	end
end

function _M:generateOne()
	local f = nil
	if self.filters then f = self.filters[rng.range(1, #self.filters)] end
	local m = self.zone:makeEntity(self.level, "actor", f, nil, true)
	if m then
		local x, y = self:getSpawnSpot(m)
		if x and y then
			self.zone:addEntity(self.level, m, "actor", x, y)
			if self.post_generation then self.post_generation(m) end
		end
	end
end
