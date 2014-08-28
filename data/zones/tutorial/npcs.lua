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

newEntity{ define_as = "TUTORIAL_NPC_BOSS",
    type = "humanoid",
    body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
    ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_astar", },
    combat = { dam= {1,6} },

	name = "drow scout", color=colors.VIOLET, unique=true,
	type = "humanoid", subtype = "drow",
	image = "tiles/npc/drow_fighter.png",
	display = 'h', color=colors.BLACK,
	level_range = {1, nil}, exp_worth = 150,
--	rarity = 3,
	max_life = resolvers.rngavg(15,20),
	stats = { str=13, dex=13, con=10, int=12, wis=9, cha=10, luc=10 },
	infravision = 6,
	skill_hide = 1,
	skill_movesilently = 1,
	skill_listen = 2,
	skill_search = 3,
	skill_spot = 2,
	hit_die = 1,

	desc = [[This lithe, ebon-skinned humanoid is a dark elf, also known as a drow. This one looks quite powerful, beware!]],
	
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

	on_die = function(self, who)
	--	game.player:resolveSource():setQuestStatus("tutorial", engine.Quest.COMPLETED)
		local d = require("engine.dialogs.ShowText").new("Tutorial: Finish", "tutorial/done")
		game:registerDialog(d)
		game:changeLevel(1, "tunnels")
	end,
}
