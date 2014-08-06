-- Veins of the Earth
-- Zireael 2014
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it wil_l be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
local Map = require "engine.Map"


return {
	name = "Veins of the Earth",
	level_range = {1, 1},
	max_level = 1,
	width = 100, height = 100,
	all_lited = true,
	persistent = "zone",
	generator =  {
		map = {
			class = "mod.class.generator.map.RandomWorldmap",
			down = "DOWN",
			wall = "WALL",
			floor = "FLOOR",
		},
	},

	post_process = function(level)
		-- put dungeon entrances
		local l1 = game.zone:makeEntityByName(level, "terrain", "DOWN_UPPERDARK")
		if not l1 then return end

		local x, y = util.findFreeGrid(game.level.default_up.x, game.level.default_up.y, 5, true, {[Map.OBJECT]=true})
		game.zone:addEntity(level, l1, "terrain", x, y)
		print("Placed dungeon entrance", l1.name, x, y)

--[[		local x, y = rng.range(0, (game.level.map.w/2)-1), rng.range(0, (game.level.map.h/2)-1)

		local tries = 0
		while (game.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or game.level.map(x, y, Map.OBJECT) or game.level.map.room_map[x][y].special) and tries < 100 do
			x, y = rng.range(0, game.level.map.w-1), rng.range(0, game.level.map.h-1)
			tries = tries + 1
		end
		if tries < 100 then
			game.zone:addEntity(level, l1, "terrain", x, y)
			print("Placed dungeon entrance", l1, x, y)
		end]]

		local l2 = game.zone:makeEntityByName(level, "terrain", "DOWN_CAVERN")
		if not l2 then return end

		local x, y = rng.range(0, (game.level.map.w/2)-1), rng.range(0, (game.level.map.h/2)-1)

		local tries = 0
		while (game.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or game.level.map(x, y, Map.OBJECT) or game.level.map.room_map[x][y].special) and tries < 100 do
			x, y = rng.range(0, game.level.map.w-1), rng.range(0, game.level.map.h-1)
			tries = tries + 1
		end
		if tries < 100 then
			game.zone:addEntity(level, l2, "terrain", x, y)
			print("Placed dungeon entrance", l2.name, x, y)
		end

	end,
}
