-- Veins of the Earth
-- Zireael 2016
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
	name = "Egos test",
	level_range = {1, 1},
	max_level = 1000,
	max_cr = 1,
	decay = {300, 800},
	width = 44, height = 44,
--	persistent = "zone",
load_tips = {
{ text = [[Testing in progress...]] },
{ text = [[There is a world beyond these tunnels.]] },
{ text = [[Remember to wear your armor.]]},
{ text = [[Some spellcasters can cast spells innately.]]},
{ text = [[Certain races have innate magical abilities.]]},
{ text = [[Remember that being unable to move does not mean you're dead (yet).]]},
{ text = [[Do not rush into fights if you are wounded. Take your time to rest.]]},
},
	generator =  {
		map = {
			class = 'mod.class.generator.map.T2DungeonLevel',
	        floor = { weighted = { FLOOR={78,100}, MOSS={18,5} } },
	        fill = { weighted = { WALL={34,100}, WALL_MARBLE={66,0} } },
	        outer_wall = 'WALL',
	        inner_wall = 'WALL',
	        fill_step = 4,
	        up = 'UP',
	        down = 'DOWN',
			flags = {
	  	FLAT = true,
	        },
		},
		actor = {
			nb_npc = {10, 20},
		--	filters = { {type="encounter"} },
		--	class = "mod.class.generator.actor.EncounterSpots",
			class = "mod.class.generator.actor.OnSpots",
			nb_spots = 3, on_spot_chance = 75,
			spot_filters = { type="room"},
		},
		object = {
            class = "mod.class.generator.object.OnSpots",
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
