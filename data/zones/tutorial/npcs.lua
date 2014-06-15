-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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


load("/data/general/npcs/humanoid.lua", rarity(0))
load("/data/general/npcs/vermin.lua", rarity(0))

local Talents = require("engine.interface.ActorTalents")

newEntity{ base = "BASE_NPC_DROW", define_as = "TUTORIAL_NPC_GUIDE", image="tiles/npc/drow_fighter.png",
	name = "Larala", color=colors.LIGHT_GREY,
	level_range = {1, nil}, exp_worth = 1,
--	rarity = 3,
	max_life = resolvers.rngavg(3,5),
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_DARKNESS_INNATE]=1,
	[Talents.T_FAERIE_FIRE_INNATE]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
		{ name = "light metal shield" },
		{ name = "rapier" },
		{ name = "bolts" },
	},
}

newEntity{ base = "BASE_NPC_SPIDER", define_as = "TUTORIAL_NPC_SPIDER",
	name = "tiny spider", color=colors.BROWN,
	desc = [[A tiny spider crawls around. It does not look overly dangerous.]],
	level_range = {1, 4}, exp_worth = 75,
--	rarity = 1,
	max_life = resolvers.rngavg(1,3),
	hit_die = 1,
	challenge = 1/4,
}

newEntity{ base = "BASE_NPC_DROW", define_as = "TUTORIAL_NPC_BOSS",
	name = "Drow scout", color=colors.VIOLET, unique=true,
	desc = [[This lithe, ebon-skinned humanoid is a dark elf, also known as a drow. This one looks quite powerful, beware!]],
	level_range = {1, nil}, exp_worth = 150,
--	rarity = 3,
	max_life = resolvers.rngavg(15,20),
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_DARKNESS_INNATE]=1,
	[Talents.T_FAERIE_FIRE_INNATE]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
		{ name = "light metal shield" },
		{ name = "rapier" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	{ name = "hand crossbow" },
	},
	ai = "dumb_talented_simple", ai_state = { talent_in=4, ai_move="move_astar", },

	on_die = function(self, who)
		game.player:resolveSource():setQuestStatus("tutorial", engine.Quest.COMPLETED)
		local d = require("engine.dialogs.ShowText").new("Tutorial: Finish", "tutorial/done")
		game:registerDialog(d)
	end,
}
