-- Veins of the Earth
-- Zireael 2013
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
	name = "test",
	level_range = {1, 1},
	max_level = 1000,
	decay = {300, 800},
	width = 100, height = 100,
--	persistent = "zone",
	generator =  {
		map = {
			class = "mod.class.generator.map.Roomer",
			nb_rooms = 10,
			rooms = { 
			--Nothing special
			{"simple", 5}, {"circle", 5}, {"circle2", 5}, {"circle3", 5}, {"pilar", 10}, {"pilar2", 10}, {"pilar3", 10}, {"pilar4", 10}, {"rhomboid", 3}, {"rhomboid2", 3}, 
			--Special rooms
			{"chasm1", 2}, {"chasm2", 2}, {"chasm3", 2}, {"big_moss1", 20}, {"big_moss2", 20}, {"ice_patch", 10}, {"icefilled", 4}, {"marble", 10}, {"moss_patch1", 30}, {"moss_patch2", 30}, {"moss_pilar1", 40}, {"moss_pilar2", 40}, {"moss_pilar3", 40}, {"lavafilled_pilar", 2}, {"ritual", 5}, {"temple", 5}, {"treasure_room", 20}, {"veins", 20}, {"waterfilled_pilar", 7}, {"waterfilled", 1}, {"waterfilled2", 1}, {"waterfilled3", 1}, {"waterfilled4", 1}, {"waterfilled_half", 5}, {"waterfilled_half2", 5},
			--Additional stairs
			{"pilar_stairs", 6}, {"pilar_stairs2", 5}, {"pilar_stairs3", 2}
			},
			lite_room_chance = 0,
			door_chance = 1,
			tunnel_change = 90,
			tunnel_random = 40,
			['.'] = "FLOOR",
	--		['.'] = { "FLOOR", "MOSS", "CHASM", "WATER", }
			['#'] = "WALL",
	--		up = "UP",
			up = {"UP", "SHAFT_UP"},
	--		down = "DOWN",
			down = { "DOWN", "SHAFT_DOWN" },
			door = "DOOR",
			['m'] = "MOSS",
			['x'] = "CHASM",
			['~'] = { "WATER", "WATER_DEEP" },
			['l'] = "LAVA",
			['i'] = "ICE",
			['>'] = { "DOWN", "SHAFT_DOWN" },
			['%'] = "MARBLE",
			['^'] = "WALL_WARDED",
			['&'] = "ALTAR",
			['T'] = "CHEST",
			['$'] = {"GOLD_VEIN", "DIAMOND_VEIN", "MITHRIL_VEIN", "ADAMANT_VEIN", "TREASURE_VEIN"},
		},
		actor = {
			nb_npc = {10, 20},
			class = "mod.class.generator.actor.OnSpots",
			nb_spots = 7, on_spot_chance = 75,
			spot_filters = { type="room"},
			filters = { type="encounter" }
		},
		object = {
            class = "engine.generator.object.OnSpots",
            nb_spots = 7, on_spot_chance = 80,
            nb_object = {20, 30},
        },
	},
	levels =
	{
	--No stairs up on level 1
		[1] = { 
		generator = { map = { 
		up = "FLOOR",
		},},
	},
	--No shaft up on level 2
		[2] = { 
		generator = { map = { 
		up = "UP",
		},},
	},

	},
}
