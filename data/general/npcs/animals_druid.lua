-- Veins of the Earth
-- Zireael 2014
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

local animal_desc = [[It has low Intelligence and is always neutral. It needs to eat, sleep and breathe.]]

--Animals which can be:
--a) a druid's animal companions
--b) a druid's nature's allies
--c) wildshaped into
--They DO NOT spawn normally!


--Scent
newEntity{
	define_as = "BASE_NPC_BABOON",
	type = "animal",
	image = "tiles/ape.png",
	display = 'Y', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A large primate.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=14, con=12, int=2, wis=12, cha=4, luc=2 },
	combat = { dam= {1,6} },
	skill_climb = 8,
	skill_movesilently = 4,
	skill_listen = 4,
	combat_natural = 1,
	alignment = "Neutral",
}

newEntity{
	base = "BASE_NPC_BABOON",
	name = "baboon", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 150,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/2,
	infravision = 1,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Improved grab, hold breath (4x Con)
newEntity{
	define_as = "BASE_NPC_CROCODILE",
	type = "animal",
	image = "tiles/crocodile.png",
	display = 'r', color=colors.DARK_GREEN,
	body = { INVEN = 10 },
	desc = [[A large scaly predator.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=12, con=17, int=1, wis=12, cha=2, luc=2 },
	combat = { dam= {1,8} },
	skill_hide = 3,
	skill_swim = 8,
	skill_listen = 3,
	skill_spot = 3,
	combat_natural = 4,
	alignment = "Neutral",
}

newEntity{
	base = "BASE_NPC_CROCODILE",
	name = "crocodile", color=colors.DARK_GREEN,
	level_range = {1, 4}, exp_worth = 600,
	max_life = resolvers.rngavg(20,25),
	hit_die = 3,
	challenge = 2,
	infravision = 1,
--	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Scent
newEntity{
	define_as = "BASE_NPC_APE",
	name = "ape",
	image = "tiles/ape.png",
	display = 'Y', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A large primate.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=15, con=14, int=2, wis=12, cha=7, luc=2 },
	combat = { dam= {1,6} },
	skill_climb = 8,
	skill_spot = 4,
	skill_listen = 4,
	combat_natural = 1,
	alignment = "Neutral",

	level_range = {1, 4}, exp_worth = 600,
	max_life = resolvers.rngavg(7,10),
	hit_die = 4,
	challenge = 2,
	infravision = 1,
	--Brachiation feat from Incursion
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Can be a familiar
newEntity{
	define_as = "BASE_NPC_MONKEY",
	name = "monkey",
	image = "tiles/ape.png",
	display = 'Y', color=colors.SANDY_BROWN,
	body = { INVEN = 10 },
	desc = [[A small monkey.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=5, dex=17, con=10, int=2, wis=12, cha=5, luc=10 },
	combat = { dam= {1,3} },
	skill_climb = 8,
	skill_balance = 4,
	skill_hide = 6,
	combat_natural = 1,
	alignment = "Neutral",

	level_range = {1, 4}, exp_worth = 100,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/4,
	--Brachiation feat
	resolvers.talents{ [Talents.T_DODGE]=1, },
}

--Scent; Dash, Run feats
newEntity{
	define_as = "BASE_NPC_CHEETAH",
	name = "cheetah",
	image = "tiles/UT/tiger.png",
	display = 'c', color=colors.YELLOW,
	body = { INVEN = 10 },
	desc = [[Cheetahs are swift feline predators of the plains. A cheetah is 3 to 5 feet long and weighs 110 to 130 pounds.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=16, dex=19, con=15, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,6} },
	skill_hide = 8,
	skill_spot = 4,
	skill_listen = 4,
	skill_movesilently = 6,
	combat_natural = 1,
	infravision = 3,
	alignment = "Neutral",

	level_range = {1, 4}, exp_worth = 900,
	max_life = resolvers.rngavg(17,20),
	hit_die = 3,
	challenge = 3,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Scent; rake, pounce
newEntity{
	define_as = "BASE_NPC_LEOPARD",
	name = "leopard",
--	image = "tiles/cat.png",
	display = 'c', color=colors.GOLD,
	body = { INVEN = 10 },
	desc = [[These cats have an elongate and muscular body. Their paws are broad and their ears are short. The coloration varies from the color of straw to grayish to even chestnut.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=16, dex=19, con=15, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,6} },
	skill_hide = 10,
	skill_spot = 4,
	skill_movesilently = 4,
	skill_climb = 6,
	combat_natural = 1,
	infravision = 1,
	alignment = "Neutral",

	level_range = {1, 4}, exp_worth = 900,
	max_life = resolvers.rngavg(17,20),
	hit_die = 3,
	challenge = 3,
}

--Scent; pounce, rake, improved grab
newEntity{
	define_as = "BASE_NPC_TIGER",
	name = "tiger",
	image = "tiles/UT/tiger.png",
	display = 'c', color=colors.ORANGE,
	body = { INVEN = 10 },
	desc = [[This powerful feline predator moves with a deadly grace, its reddish-orange fur slashed with black stripes.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=23, dex=15, con=17, int=2, wis=12, cha=6, luc=12 },
	combat = { dam= {1,8} },
	skill_hide = 6,
	skill_movesilently = 4,
	skill_climb = 6,
	skill_balance = 4,
	skill_swim = 2,
	combat_natural = 2,
	infravision = 1,
	alignment = "Neutral",

	level_range = {1, 4}, exp_worth = 1200,
	max_life = resolvers.rngavg(42,46),
	hit_die = 6,
	challenge = 4,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
}

--Scent, constrict 1d4
newEntity{
	define_as = "BASE_NPC_BOA",
	name = "boa constrictor",
	image = "tiles/constrictor.png",
	display = 'R', color=colors.RED,
	body = { INVEN = 10 },
	desc = [[A large, coiled snake up to ten feet long, the boa constrictor is a carnivore that kills its prey by coiling around it and then crushing it to death.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=17, con=13, int=1, wis=12, cha=2, luc=10 },
	combat = { dam= {1,3} },
	skill_hide = 4,
	skill_listen = 4,
	skill_climb = 8,
	skill_balance = 8,
	skill_spot = 2,
	combat_natural = 2,
	alignment = "Neutral",

	level_range = {1, 4}, exp_worth = 600,
	max_life = resolvers.rngavg(20,25),
	hit_die = 3,
	challenge = 2,
	movement_speed = 0.66,
}

--Scent; Master Grapple
newEntity{
	define_as = "BASE_NPC_BOA",
	name = "giant constrictor",
	image = "tiles/constrictor.png",
	display = 'R', color=colors.DARK_RED,
	body = { INVEN = 10 },
	desc = [[A large, coiled snake up to twenty feet long, the boa constrictor is a carnivore that kills its prey by coiling around it and then crushing it to death.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=17, con=13, int=1, wis=12, cha=2, luc=10 },
	combat = { dam= {1,3} },
	skill_hide = 4,
	skill_listen = 4,
	skill_climb = 8,
	skill_balance = 8,
	skill_spot = 2,
	combat_natural = 3,
	alignment = "Neutral",

	level_range = {1, 20}, exp_worth = 1800,
	max_life = resolvers.rngavg(55,60),
	hit_die = 11,
	challenge = 6,
	movement_speed = 0.66,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}