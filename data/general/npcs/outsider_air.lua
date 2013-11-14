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

--Electricity ray, speed bonuses; immunity to acid, electricity and poison;
newEntity{
	define_as = "BASE_NPC_ARROWHAWK",
	type = "magical beast",
	image = "tiles/eagle.png",
	display = 'e', color=colors.LIGHT_BLUE,
	body = { INVEN = 10 },
	desc = [[A bird with shimmering feathers.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=12, dex=21, con=12, int=10, wis=13, cha=13, luc=12 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
	resists = {
                [DamageType.FIRE] = 10,
                [DamageType.COLD] = 10,
        },
}

newEntity{
	base = "BASE_NPC_ARROWHAWK",
	name = "juvenile arrowhawk", color=colors.LIGHT_BLUE,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 3,
	infravision = 4,
	combat_natural = 4,
	skill_listen = 6,
	skill_movesilently = 6,
	skill_search = 6,
	skill_sensemotive = 6,
	skill_spot = 6,
	skill_survival = 6,
}

newEntity{
	base = "BASE_NPC_ARROWHAWK",
	name = "adult arrowhawk", color=colors.LIGHT_BLUE,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 7,
	challenge = 5,
	stats = { str=14, dex=21, con=12, int=10, wis=13, cha=13, luc=12 },
	combat = { dam= {1,8} },
	infravision = 4,
	combat_natural = 6,
	skill_listen = 10,
	skill_movesilently = 10,
	skill_search = 10,
	skill_sensemotive = 10,
	skill_spot = 10,
	skill_survival = 10,
}

newEntity{
	base = "BASE_NPC_ARROWHAWK",
	name = "elder arrowhawk", color=colors.LIGHT_BLUE,
	level_range = {5, 15}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(110,115),
	hit_die = 15,
	challenge = 8,
	stats = { str=22, dex=21, con=16, int=10, wis=13, cha=13, luc=12 },
	combat = { dam= {2,6} },
	infravision = 4,
	combat_natural = 8,
	skill_listen = 20,
	skill_movesilently = 18,
	skill_search = 18,
	skill_sensemotive = 18,
	skill_spot = 18,
	skill_survival = 18,
}

--Fly 50 ft., smoke form
newEntity{
	define_as = "BASE_NPC_BELKER",
	type = "outsider",
--	image = "tiles/eagle.png",
	display = 'E', color=colors.LIGHT_BLUE,
	body = { INVEN = 10 },
	desc = [[A demonic humanoid composed of smoke.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=14, dex=21, con=13, int=6, wis=11, cha=11, luc=12 },
	combat = { dam= {1,6} },
	--Hack! Monsters drop corpses now
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	base = "BASE_NPC_BELKER",
	name = "belker", color=colors.LIGHT_BLUE,
	level_range = {5, 15}, exp_worth = 1800,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 7,
	challenge = 6,
	infravision = 4,
	combat_natural = 8,
	skill_listen = 7,
	skill_movesilently = 3,
	skill_spot = 7,
}
