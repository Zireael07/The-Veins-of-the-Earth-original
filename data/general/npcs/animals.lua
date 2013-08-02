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
	rarity = 4,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/3,
}


newEntity{
	define_as = "BASE_NPC_SPIDER",
	type = "animal",
	display = 's', color=colors.BROWN,
	desc = [[A small spider.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=3, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,3} },
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "tiny spider", color=colors.BROWN,
	level_range = {1, 4}, exp_worth = 75,
	rarity = 1,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "small spider", color=colors.BROWN,
	level_range = {1, 4}, exp_worth = 100,
	rarity = 3,
	max_life = resolvers.rngavg(3,6),
	hit_die = 1,
	challenge = 1/3,
	stats = { str=7, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,4} }
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "medium spider", color=colors.BROWN,
	level_range = {1, 4}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(3,6),
	hit_die = 2,
	challenge = 1,
	stats = { str=11, dex=17, con=10, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,6} }
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "large spider", color=colors.BROWN,
	level_range = {1, 4}, exp_worth = 3000,
	rarity = 9,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 4,
	stats = { str=15, dex=17, con=12, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {1,8} }
}

newEntity{
	base = "BASE_NPC_SPIDER",
	name = "huge spider", color=colors.BROWN,
	exp_worth = 3300,
	rarity = 10,
	max_life = resolvers.rngavg(50,55),
	hit_die = 8,
	challenge = 8,
	stats = { str=19, dex=17, con=14, int=1, wis=10, cha=2, luc=10 },
	combat = { dam= {2,6} }
}

newEntity{
	define_as = "BASE_NPC_SNAKE",
	type = "animal",
	display = 's', color=colors.GREEN,
	desc = [[A small snake.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=4, dex=17, con=11, int=1, wis=12, cha=2, luc=10 },
	combat = { dam= {1,2} },
}

newEntity{
	base = "BASE_NPC_SNAKE",
	name = "tiny snake", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 75,
	rarity = 1,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
}

newEntity{
	base = "BASE_NPC_SNAKE",
	name = "small snake", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 100,
	rarity = 3,
	max_life = resolvers.rngavg(2,5),
	hit_die = 1,
	challenge = 1/3,
}

newEntity{
	base = "BASE_NPC_SNAKE",
	name = "medium snake", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(7,10),
	hit_die = 2,
	challenge = 1,
}