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
	level_range = {1, 4}, exp_worth = 100,
	rarity = 3,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1,
}

newEntity{
	define_as = "BASE_NPC_ZOMBIE",
	type = "undead",
	display = 'Z', color=colors.WHITE,
	desc = [[A humanoid zombie.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str = 12, dex=8, con=1, int=1, wis=10, cha=1, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_ZOMBIE",
	name = "kobold zombie", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 100,
	rarity = 6,
	max_life = resolvers.rngavg(14,18),
	hit_die = 2,
	challenge = 1,
}

newEntity{
	base = "BASE_NPC_ZOMBIE",
	name = "humanoid zombie", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 100,
	rarity = 6,
	max_life = resolvers.rngavg(14,18),
	hit_die = 2,
	challenge = 1,
}
