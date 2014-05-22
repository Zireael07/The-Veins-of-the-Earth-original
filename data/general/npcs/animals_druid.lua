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
	display = 'r', color=colors.WHITE,
	body = { INVEN = 10 },
	desc = [[A large primate.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=14, con=12, int=2, wis=12, cha=4, luc=2 },
	combat = { dam= {1,6} },
	skill_climb = 8,
	skill_movesilently = 4,
	skill_listen = 4,
	combat_natural = 1,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_BABOON",
	name = "baboon", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 150,
	max_life = resolvers.rngavg(3,7),
	hit_die = 1,
	challenge = 1/2,
	infravision = 1,
	movement_speed_bonus = 0.33,
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
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
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