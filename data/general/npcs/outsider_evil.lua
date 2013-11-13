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

newEntity{
	define_as = "BASE_NPC_ACHAIERAI",
	type = "outsider",
	display = 'ǒ', color=colors.BLACK,
	body = { INVEN = 10 },
	desc = [[A large bluish-reddish wolf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=19, dex=13, con=14, int=11, wis=14, cha=16, luc=12 },
	combat = { dam= {2,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
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
