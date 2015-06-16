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
	name = "Fungi Forest",
	level_range = {1, 1},
	max_level = 5,
--	decay = {300, 800},
	width = 60, height = 60,
--	persistent = "zone",
	generator =  {
		map = {
			class = "engine.generator.map.Forest",
			edge_entrances = {4,6},
			zoom = 4,
			sqrt_percent = 30,
			noise = "fbm_perlin",
		--	floor = function() if rng.chance(20) then return "FLOWER" else return "GRASS" end end,
			floor = "FLOOR",
			wall = "FUNGI",
			up = {"UP", "SHAFT_UP"},
			down = { "DOWN", "SHAFT_DOWN" },
			door = "DOOR",
		--[[	road = "GRASS_ROAD_DIRT",
			add_road = true,
			do_ponds = {
				nb = {0, 2},
				size = {w=25, h=25},
				pond = {{0.6, "DEEP_WATER"}, {0.8, "DEEP_WATER"}},
			},]]

		--[[	nb_rooms = {0,0,0,1},
			rooms = {"lesser_vault"},
			lesser_vaults_list = {"honey_glade", "forest-ruined-building1", "forest-ruined-building2", "forest-ruined-building3", "forest-snake-pit", "mage-hideout"},
			]]
			lite_room_chance = 0,
		},
		actor = {
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

	end,
}
