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
	name = "Small tunnels",
	level_range = {1, 1},
	max_level = 10,
--	decay = {300, 800},
	width = 44, height = 44,
--	persistent = "zone",
	load_tips = {
{ text = [[Do not go in too deep.]] },
{ text = [[There is a world beyond these tunnels.]] },
{ text = [[Remember to wear your armor.]]},
{ text = [[Some spellcasters can cast spells innately.]]},
{ text = [[If you're lucky at start, you might get some innate spells or resistances!]]},
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
		--	class = "mod.class.generator.actor.EncounterRandom",
			class = "mod.class.generator.actor.Random",
			nb_npc = {5, 10},
			--max cr filter is added to dlvl
			--NOTE: critters (especially humanoid) might have higher CR due to resolvers
			filters = {{max_cr=2}},
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
		if level.level == 1 then
			-- Place a lore note on each level
			game:placeRandomLoreObject("NOTE"..level.level)
		else
			-- Put lore near the up stairs
			game:placeRandomLoreObject("NOTE"..(rng.dice(1,7)+1))
		end
	end,
}
