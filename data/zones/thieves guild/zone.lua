-- Veins of the Earth
-- Zireael 2016
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

return {
	name = "Thieves' guild",
	level_range = {1, 1},
	max_level = 2,
--	decay = {300, 800},
	width = 30, height = 30,
	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Building",
			max_block_w = 20, max_block_h = 15,
			max_building_w = 10, max_building_h = 10,

			floor = "FLOOR_TILED",
			external_floor = "FLOOR",
			wall = "WALL",
			up = "UP",
			down = "DOWN",
			door = "DOOR",

			nb_rooms = false,
			rooms = false,
		},
		actor = {
			class = "mod.class.generator.actor.OnSpots",
			nb_npc = {10, 20},
			nb_spots = 2, on_spot_chance = 75,
		},
		object = {
            class = "mod.class.generator.object.Random",
            nb_object = {1, 5},
        },
	},
	levels =
	{
	--Place exit to town on level 1
		[1] = {
		generator = { map = {
		up = "EXIT_TOWN",
		},},
	},
	--maze level 2
		[2] = {
		generator = { map = {
		class = "engine.generator.map.Maze",
			up = "UP",
			--down = "DOWN",
			wall = "WALL",
			floor = "FLOOR",
			widen_w = 1, widen_h = 1,
		},
		actor = {
			nb_npc = {0, 0},
		},
		trap = {
			class = "engine.generator.trap.Random",
 			nb_trap = {8, 8},
  		},
		},
	},

	},

	post_process = function(level)
		if level.level == 1 then
		-- Put lore near the up stairs
		game:placeRandomLoreObject("NOTE"..level.level)

		game:placeTerrainMulti("FAERIE_TORCH", 10)

		--game:placeTerrainOnSpots("BED", 2)
		game:placeTerrainOnSpots("TABLE", 3)
		end
	end,
}
