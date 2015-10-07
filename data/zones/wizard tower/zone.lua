-- Veins of the Earth
-- Zireael 2013-2015
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

return {
	name = "Wizard Tower",
	level_range = {1, 1},
	max_level = 10, reverse_level_display=true,
--	decay = {300, 800},
	width = 50, height = 50,
--	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.TileSet",
			tileset = {"5x5/base", "5x5/tunnel", },
			tunnel_chance = 80,

			['.'] = "FLOOR_TILED",
	--		['.'] = { "FLOOR", "MOSS", "CHASM", "WATER", }
			['#'] = "WALL_WARDED",
	--		up = "UP",
			up = {"UP", "SHAFT_UP"},
	--		down = "DOWN",
			down = { "DOWN" },
			door = "DOOR_WARDED",
			['m'] = "MOSS",
			['x'] = "CHASM",
			['~'] = { "WATER", "WATER_DEEP" },
			['l'] = "LAVA",
			['i'] = "ICE",
			['>'] = { "DOWN" },
			['%'] = "MARBLE",
			['^'] = "WALL_WARDED",
			['&'] = "ALTAR",
			['T'] = "CHEST",
			['$'] = {"GOLD_VEIN", "DIAMOND_VEIN", "MITHRIL_VEIN", "ADAMANT_VEIN", "TREASURE_VEIN"},
		},
		actor = {
		--[[	class = "mod.class.generator.actor.Encounters",
			nb_encounters = 10,]]

		--	class = "mod.class.generator.actor.EncounterRandom",
			class = "mod.class.generator.actor.Random",
			nb_npc = {10, 20},
		--[[	class = "mod.class.generator.actor.OnSpots",
				nb_spots = 2, on_spot_chance = 75,]]

		},
		object = {
            class = "mod.class.generator.object.Random",
            nb_object = {20, 30},
        },
	},
	levels =
	{
	--Place exit to worldmap on level 1
		[1] = {
		generator = { map = {
		up = "EXIT",
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

		game:placeDungeonEntrance("PORTAL_FIRE")
		game:placeDungeonEntrance("PORTAL_AIR")
		game:placeDungeonEntrance("PORTAL_WATER")
		game:placeDungeonEntrance("PORTAL_EARTH")

	end,
}
