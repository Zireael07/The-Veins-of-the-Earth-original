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
	define_as = "BASE_NPC_FLAYER",
	type = "aberration", subtype = "brain flayer",
	display = "f", color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1 },
        desc = [[A horrid thing with tentacles!]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=8, dex=10, con=7, int=14, wis=12, cha=12, luc=12 },
	combat = { dam= {1,8} },
        }

newEntity{ base = "BASE_NPC_FLAYER",
	name = "brain flayer", color=colors.WHITE,
	level_range = {6, 14}, exp_worth = 200,
	rarity = 20,
	max_life = resolvers.rngavg(10,15),
	hit_die = 4,
	challenge = 7,
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}        