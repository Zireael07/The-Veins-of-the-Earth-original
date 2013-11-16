--Veins of the Earth
--Zireael
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

--Outsiders drop no corpses (except barghests)

newEntity{
	define_as = "BASE_NPC_ACHAIERAI",
	type = "outsider",
	display = 'ǒ', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A large bluish-reddish wolf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=13, con=14, int=11, wis=14, cha=16, luc=12 },
	combat = { dam= {2,6} },
}

--SR 19, black cloud (1 square ball, 2d6)
newEntity{
	base = "BASE_NPC_ACHAIERAI",
	name = "achaierai", color=colors.BLACK,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 6,
	challenge = 5,
	infravision = 4,
	combat_natural = 6,
	skill_balance = 9,
	skill_climb = 4,
	skill_diplomacy = 2,
	skill_hide = 5,
	skill_intimidate = 11,
	skill_jump = 17,
	skill_listen = 9,
	skill_movesilently = 8,
	skill_sensemotive = 9,
	skill_spot = 9,
}

newEntity{
	define_as = "BASE_NPC_BARGHEST",
	type = "outsider",
	display = 'd', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A large bluish-reddish wolf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=15, con=13, int=14, wis=14, cha=14, luc=12 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_BARGHEST",
	name = "barghest", color=colors.BLACK,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(30,35),
	hit_die = 6,
	challenge = 4,
	infravision = 4,
	combat_natural = 6,
	skill_bluff = 9,
	skill_diplomacy = 4,
	skill_hide = 9,
	skill_intimidate = 11,
	skill_jump = 9,
	skill_listen = 9,
	skill_movesilently = 8,
	skill_search = 9,
	skill_sensemotive = 9,
	skill_spot = 9,
	skill_survival = 9,
}

--Breath weapon 2d6 fire cone 2 sq Ref DC 13 half, cooldown 5 turns
--1d6 fire on hit; immunity to fire, vulnerability to cold
newEntity{
	define_as = "BASE_NPC_HELL_HOUND",
	type = "outsider",
	display = 'd', color=colors.RED,
	body = { INVEN = 10, BODY = 1 },
	desc = [[A large flame-colored canine.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=13, int=6, wis=10, cha=6, luc=10 },
	combat = { dam= {1,6} },
	movement_speed_bonus = 0.33,
	alignment = "lawful evil",
}

newEntity{
	base = "BASE_NPC_HELL_HOUND",
	name = "hell hound",
	level_range = {5, 15}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 3,
	infravision = 4,
	combat_natural = 5,
	skill_hide = 12,
	skill_jump = 11,
	skill_listen = 7,
	skill_movesilently = 11,
	skill_spot = 7,
	skill_survival = 7,
}

--Imp Crit, Weapon Focus
newEntity{
	base = "BASE_NPC_HELL_HOUND",
	name = "Nessian warhound",
	level_range = {10, 25}, exp_worth = 2700,
	rarity = 20,
	max_life = resolvers.rngavg(110,115),
	hit_die = 12,
	challenge = 9,
	infravision = 4,
	combat_natural = 6,
	skill_hide = 15,
	skill_jump = 11,
	skill_listen = 17,
	skill_movesilently = 19,
	skill_spot = 17,
	skill_survival = 7,
	skill_tumble = 1,
	stats = { str=26, dex=14, con=20, int=4, wis=12, cha=6, luc=10 },
	combat = { dam= {2,6} },
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
	},
}

--Quill DC 16 Ref or -1 to attacks, saves and checks
newEntity{
	define_as = "BASE_NPC_HOWLER",
	type = "outsider",
	display = 'O', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A large creature with a ring of spikes around its neck.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=21, dex=17, con=15, int=6, wis=14, cha=8, luc=12 },
	combat = { dam= {2,8} },
	movement_speed_bonus = 0.88,
	alignment = "chaotic evil",
}

newEntity{
	base = "BASE_NPC_HOWLER",
	name = "howler",
	level_range = {5, 15}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 6,
	challenge = 3,
	infravision = 4,
	combat_natural = 4,
	skill_climb = 8,
	skill_hide = 5,
	skill_listen = 11,
	skill_movesilently = 9,
	skill_search = 11,
	skill_spot = 11,
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}