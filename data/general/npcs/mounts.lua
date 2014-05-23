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

--Possible mounts
--These will not spawn by themselves in the dungeon

--Scent; Endurance, Run feats
newEntity{
	define_as = "BASE_NPC_HORSE",
	type = "animal",
	image = "tiles/horse.png",
	display = 'q', color=colors.TAN,
	body = { INVEN = 10 },
	desc = [[A large hoofed quadruped, often used as a mount.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=16, dex=13, con=15, int=2, wis=12, cha=6, luc=2 },
	combat = { dam= {1,6} },
	skill_spot = 3,
	skill_listen = 3,
	combat_natural = 2,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_HORSE",
	name = "heavy horse",
	level_range = {1, 4}, exp_worth = 300,
	max_life = resolvers.rngavg(17,21),
	hit_die = 3,
	challenge = 1,
	infravision = 1,
	movement_speed_bonus = 0.66,
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

newEntity{
	base = "BASE_NPC_HORSE",
	name = "light horse",
	level_range = {1, 4}, exp_worth = 300,
	max_life = resolvers.rngavg(17,21),
	hit_die = 3,
	challenge = 1,
	infravision = 1,
	movement_speed_bonus = 1,
	combat = { dam= {1,4} },
	stats = { str=14, dex=13, con=15, int=2, wis=12, cha=6, luc=2 },
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

newEntity{
	base = "BASE_NPC_HORSE",
	name = "heavy warhorse",
	level_range = {1, 4}, exp_worth = 600,
	max_life = resolvers.rngavg(28,32),
	hit_die = 4,
	challenge = 2,
	infravision = 1,
	movement_speed_bonus = 0.66,
	combat = { dam= {1,4} },
	combat_natural = 3,
	stats = { str=18, dex=13, con=17, int=2, wis=13, cha=6, luc=2 },
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

newEntity{
	base = "BASE_NPC_HORSE",
	name = "light warhorse",
	level_range = {1, 4}, exp_worth = 300,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 1,
	infravision = 1,
	movement_speed_bonus = 1,
	combat_natural = 3,
	stats = { str=16, dex=13, con=17, int=2, wis=13, cha=6, luc=2 },
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Scent
newEntity{
	define_as = "BASE_NPC_RIDING_DOG",
	type = "animal",
	image = "tiles/dog.png",
	display = 'q', color=colors.SANDY_BROWN,
	body = { INVEN = 10 },
	desc = [[A large hoofed quadruped, often used as a mount.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=15, con=15, int=2, wis=12, cha=6, luc=5 },
	combat = { dam= {1,6} },
	skill_spot = 4,
	skill_listen = 4,
	skill_jump = 6,
	skill_swim = 1,
	combat_natural = 4,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_RIDING_DOG",
	name = "riding dog",
	level_range = {1, 4}, exp_worth = 300,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	infravision = 1,
	movement_speed_bonus = 0.33,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Scent, Endurance feat
newEntity{
	define_as = "BASE_NPC_PONY",
	type = "animal",
	image = "tiles/horse.png",
	display = 'q', color=colors.DARK_TAN,
	body = { INVEN = 10 },
	desc = [[A small horse, under 5 feet tall at the shoulder, often used as a mount.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=12, int=2, wis=11, cha=4, luc=2 },
	combat = { dam= {1,3} },
	skill_spot = 5,
	skill_listen = 5,
	combat_natural = 2,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_PONY",
	name = "pony",
	level_range = {1, 4}, exp_worth = 75,
	max_life = resolvers.rngavg(10,13),
	hit_die = 2,
	infravision = 1,
	challenge = 1/4,
	movement_speed_bonus = 0.33,
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

newEntity{
	base = "BASE_NPC_PONY",
	name = "war pony",
	level_range = {1, 4}, exp_worth = 150,
	max_life = resolvers.rngavg(11,15),
	hit_die = 2,
	infravision = 1,
	challenge = 1/2,
	movement_speed_bonus = 0.33,
	stats = { str=15, dex=13, con=14, int=2, wis=11, cha=4, luc=2 },
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--From Incursion
newEntity{
	define_as = "BASE_NPC_RIDING_LIZARD",
	type = "animal",
	image = "tiles/lizard.png",
	display = 'R', color=colors.DARK_GREEN,
	body = { INVEN = 10 },
	desc = [[A gecko the size of a horse, often used as a mount by the deep-dwelling races.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=13, con=15, int=2, wis=12, cha=6, luc=2 },
	combat = { dam= {1,4} },
	skill_spot = 5,
	skill_listen = 5,
	skill_climb = 8,
	combat_natural = 2,
	alignment = "neutral",
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_RIDING_LIZARD",
	name = "riding lizard",
	level_range = {1, 4}, exp_worth = 300,
	max_life = resolvers.rngavg(12,15),
	hit_die = 4,
	infravision = 6,
	challenge = 1,
	movement_speed_bonus = 0.33,
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

newEntity{
	base = "BASE_NPC_RIDING_LIZARD",
	name = "war lizard",
	level_range = {1, 4}, exp_worth = 600,
	max_life = resolvers.rngavg(22,25),
	hit_die = 5,
	infravision = 6,
	challenge = 2,
	movement_speed_bonus = 0.33,
	stats = { str=19, dex=13, con=17, int=2, wis=12, cha=6, luc=2 },
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}

--Psionics: cell adjustment, brain lock, inertial barrier
newEntity{
	base = "BASE_NPC_RIDING_LIZARD",
	name = "psionic riding lizard",
	level_range = {1, 4}, exp_worth = 600,
	max_life = resolvers.rngavg(22,25),
	hit_die = 5,
	infravision = 6,
	challenge = 2,
	movement_speed_bonus = 0.33,
	stats = { str=19, dex=13, con=17, int=2, wis=12, cha=6, luc=2 },
--	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
}