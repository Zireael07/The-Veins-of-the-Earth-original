-- Underdark
-- Zireael
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


local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_KOBOLD",
	type = "humanoid", subtype = "kobold",
	display = "k", color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
        desc = [[Ugly and green!]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=9, dex=13, con=10, int=10, wis=9, cha=8, luc=12 },
	combat = { dam= {1,6} },
        }

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "kobold warrior", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 75,
	rarity = 6,
	max_life = resolvers.rngavg(5,9),
	hit_die = 4,
}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "armoured kobold warrior", color=colors.AQUAMARINE,
	level_range = {6, 10}, exp_worth = 100,
	rarity = 20,
	max_life = resolvers.rngavg(10,12),
	hit_die = 6,
}

newEntity{
	define_as = "BASE_NPC_RAT",
	type = "animal",
	display = 'S', color=colors.WHITE,
	desc = [[A small rat.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=17, con=12, int=1, wis=12, cha=4, luc=2 },
	combat = { dam= {1,4} },
}

newEntity{
	base = "BASE_NPC_RAT",
	name = "dire rat", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 100,
	rarity = 2,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
}


newEntity{
	define_as = "BASE_NPC_SKEL",
	type = "undead",
	display = 's', color=colors.WHITE,
	desc = [[A humanoid skeleton.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str = 13, dex=13, con=1, int=1, wis=10, cha=1, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_SKEL",
	name = "skeleton", color=colors.WHITE,
	exp_worth = 100,
	rarity = 3,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
}
