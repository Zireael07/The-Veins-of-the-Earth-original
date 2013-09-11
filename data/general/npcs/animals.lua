-- Veins of the Earth
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
	define_as = "BASE_NPC_ANIMAL",
	type = "animal",
	body = { INVEN = 10 },
	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_RAT",
	display = 'S', color=colors.WHITE,
	desc = [[A small rat.]],
	stats = { str=10, dex=17, con=12, int=1, wis=12, cha=4, luc=2 },
	combat = { dam= {1,4} },
	skill_climb = 10,
	skill_movesilently = 8,
	
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
	base = "BASE_NPC_RAT",
	name = "rat", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 50,
	rarity = 2,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/8,
	skill_hide = 14,
	skill_swim = 14,
	stats = { str=2, dex=15, con=10, int=2, wis=12, cha=2, luc=2 },
	
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_SNAKE",
	display = 's', color=colors.GREEN,
	desc = [[A small snake.]],
	stats = { str=4, dex=17, con=11, int=1, wis=12, cha=2, luc=10 },
	combat = { dam= {1,2} },
	skill_balance = 8,
	skill_climb = 8,
	skill_hide = 8,
	skill_listen = 5,
	skill_spot = 5,
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

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_LIZARD",
	display = 'l', color=colors.GREEN,
	desc = [[A small lizard.]],
	stats = { str=3, dex=15, con=10, int=1, wis=12, cha=2, luc=2 },
	combat = { dam= {1,4} },
	skill_climb = 10,
	skill_balance = 8,
	skill_hide = 10,
	skill_spot = 2,
}

newEntity{
	base = "BASE_NPC_LIZARD",
	name = "medium lizard", color=colors.GREEN,
	level_range = {1, 20}, exp_worth = 50,
	rarity = 5,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/6,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_MONLIZARD",
	display = 'l', color=colors.DARK_GREEN,
	desc = [[A large lizard.]],
	stats = { str=17, dex=15, con=17, int=1, wis=12, cha=2, luc=2 },
	combat = { dam= {1,8} },
	skill_climb = 4,
	skill_balance = 8,
	skill_hide = 4,
	skill_spot = 2,
	skill_swim = 8,
	skill_listen = 2,
}

newEntity{
	base = "BASE_NPC_LIZARD",
	name = "monitor lizard", color=colors.GREEN,
	level_range = {1, 20}, exp_worth = 600,
	rarity = 5,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 2,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_BAT",
	display = 'b', color=colors.BLACK,
	desc = [[A large bat.]],
	stats = { str=1, dex=15, con=10, int=2, wis=14, cha=4, luc=10 },
	combat = { dam= {1,2} },
	skill_movesilently = 4,
	skill_hide = 12,
	skill_spot = 6,
	skill_listen = 6,
}

newEntity{
	base = "BASE_NPC_BAT",
	name = "a bat", color=colors.BLACK,
	level_range = {1, 20}, exp_worth = 30,
	rarity = 2,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/10,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_RAVEN",
	display = 'r', color=colors.BLACK,
	desc = [[A large raven.]],
	stats = { str=1, dex=15, con=10, int=2, wis=14, cha=6, luc=10 },
	combat = { dam= {1,2} },
	skill_spot = 4,
	skill_listen = 3,
}

newEntity{
	base = "BASE_NPC_RAVEN",
	name = "a raven", color=colors.BLACK,
	level_range = {1, 20}, exp_worth = 50,
	rarity = 2,
	max_life = resolvers.rngavg(1,2),
	hit_die = 1,
	challenge = 1/6,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_WOLF",
	display = 'w', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A large wolf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=15, con=15, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,6} },
	skill_spot = 2,
	skill_listen = 2,
	skill_movesilently = 1,
	skill_survival = 5,
}

newEntity{
	base = "BASE_NPC_WOLF",
	name = "a wolf", color=colors.BLACK,
	level_range = {1, 20}, exp_worth = 300,
	rarity = 8,
	max_life = resolvers.rngavg(12,14),
	hit_die = 1,
	challenge = 1,
	movement_speed_bonus = 0.66,
}

newEntity{ base = "BASE_NPC_ANIMAL",
	define_as = "BASE_NPC_TORTOISE",
	display = 'B', color=colors.DARK_GREEN,
	desc = [[A large tortoise.]],
	stats = { str=17, dex=10, con=21, int=2, wis=15, cha=7, luc=2 },
	combat = { dam= {1,10} },
	skill_spot = 2,
	skill_swim = 8,
	skill_listen = 2,
}

newEntity{
	base = "BASE_NPC_TORTOISE",
	name = "giant tortoise", color=colors.BLACK,
	level_range = {10, 20}, exp_worth = 300,
	rarity = 10,
	max_life = resolvers.rngavg(65,72),
	hit_die = 7,
	challenge = 2,
}