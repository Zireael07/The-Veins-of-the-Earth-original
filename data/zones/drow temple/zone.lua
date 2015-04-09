-- Veins of the Earth
-- Zireael 2015
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
	name = "Drow Temple",
	level_range = {1, 1},
	max_level = 10,
--	decay = {300, 800},
	width = 30, height = 30,
	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Octopus",
			main_radius = {0.3, 0.4},
			arms_radius = {0.1, 0.2},
			arms_range = {0.7, 0.8},
			nb_rooms = {8, 8},
			['#'] = "WALL",
			['.'] = "FLOOR",
			up = "UP",
			down = "DOWN",
			door = "DOOR",
		},
		actor = {
		--	class = "mod.class.generator.actor.EncounterRandom",
			class = "mod.class.generator.actor.Random",
			nb_npc = {10, 20},
		--[[	class = "mod.class.generator.actor.OnSpots",
				nb_spots = 2, on_spot_chance = 75,]]
		},
		object = {
            class = "engine.generator.object.Random",
            nb_object = {20, 30},
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
	--No shaft up on level 2
		[2] = {
		generator = { map = {
		up = "UP",
		},},
	},

	},

	post_process = function(level)
		-- Put lore near the up stairs
		game:placeRandomLoreObject("NOTE"..level.level)

		game:placeTerrainMulti("FAERIE_TORCH", 10)

	end,
}
