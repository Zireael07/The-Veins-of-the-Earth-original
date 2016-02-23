-- Veins of the Earth
-- Zireael 2013-2016
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
	define_as = "BASE_NPC_HUMANOID",
	type = "humanoid",
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	ai = "humanoid_level", ai_state = { talent_in=3, ai_move="move_astar", },
	combat = { dam= {1,6} },
	open_door = true,
	show_portrait = true,
	emote_anger = "I will kill you!",
	resolvers.wounds(),
	resolvers.talents{ [Talents.T_SHOOT]=1,
	--assume all humanoids have at least warrior NPC class if not better
	[Talents.T_SIMPLE_WEAPON_PROFICIENCY]=1,
	[Talents.T_MARTIAL_WEAPON_PROFICIENCY]=1,
	},
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_LIZARDFOLK",
	subtype = "reptilian",
	image = "tiles/mobiles/lizardfolk.png",
	display = 'h', color=colors.DARK_GREEN,
	desc = [[A scaly reptilian humanoid.]],
	specialist_desc = [[Lizardfolk shamans usually serve their tribal leaders as advisors, rather than ruling themselves.]],
	uncommon_desc = [[Lizardfolk are hunter/gatherers and scavengers. While common and blackscale lizardfolk are proud warriors, poison dusk lizardfolk prefer stealth. Poison dusk lizardfolk poison their weapons and can camouflage their scales like chameleons. Lizardfolk society is patriarchal, with rule going to the most powerful males. On occasion a lizardfolk tribe may serve a more powerful reptilian master, such as a dragon. Lizardfolk are distrustful of other races, and will go to great lengths to ensure the survival of their own kind.]],
	common_desc = [[Lizardfolk tend to be fiercely territorial, savage, and somewhat slow-witted, but they are not generally malevolent. Lizardfolk usually rely on their crude weapons, but they can also fall back on sharp claws and bites when they must. A typical specimen can hold its breath for over five minutes. A lizardfolk’s long, thick tails help it keep its balance and swim quickly. Lizardfolk also encompass several subraces, including the hulking blackscale lizardfolk and the smaller, far more cunning poison dusk lizardfolk.]],
	base_desc = "This crocodilian humanoid is one of the lizardfolk, a primitive race that roams the hearts of vast swamps.  Lizardfolk speak Draconic, but clever individuals who have somehow been exposed to other cultures often know Common as well.",

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=13, dex=10, con=13, int=9, wis=10, cha=10, luc=10 },
	infravision = 3,
	combat_natural = 5,
	hit_die = 2,
	npc_egos = "/data/general/npcs/templates/humanoid.lua", egos_chance = { suffix=50},
}

newEntity{
	base = "BASE_NPC_LIZARDFOLK",
	name = "lizardfolk",
	level_range = {1, nil}, exp_worth = 400,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	challenge = 1,
	skill_balance = 4,
	skill_jump = 4,
	skill_swim = 1,
	resolvers.equip{
		full_id=true,
		{ name = "studded leather", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
		{ name = "heavy metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "club", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "javelin", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
	{ name = "food ration" },
	},
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_KOBOLD",
	subtype = "reptilian",
	image = "tiles/mobiles/kobold.png",
	display = "k", color=colors.WHITE,
    desc = [[Ugly and green!]],
	specialist_desc = [[Kobolds hate most humanoids and fey, but they particularly despise gnomes and sprites. They often protect their warrens with clever mechanical traps. Some folk claim that kobolds are distantly related to dragons.]],
	uncommon_desc = [[Kobolds are rather pettily malevolent. They are omnivores, and live in dark places, usually dense forests or underground. They are talented miners and can see in the dark, but their eyes are sensitive to bright light.]],
	common_desc = [[Kobolds are not known for their bravery or ferocity in battle. However, they can be cunning, and usually attack only when they have overwhelming odds in their favor.]],
	base_desc = "This spindly little humanoid lizard is a kobold. Kobolds speak Draconic.",

	stats = { str=9, dex=13, con=10, int=10, wis=9, cha=8, luc=12 },
	infravision = 3,
	alignment = "Lawful Evil",
	skill_hide = 4,
	skill_listen = 1,
	skill_spot = 1,
	skill_search = 1,
	skill_movesilently = 1,
	hit_die = 4,
	emote_anger = "Kobold kill you!",
}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "kobold", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 200,
	rarity = 6,
	max_life = resolvers.rngavg(5,9),
	challenge = 1/2,
	emote_anger = "Me kill you!",
	resolvers.equip{
		full_id=true,
		{ name = "short spear", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "shortbow", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
	},
	npc_egos = "/data/general/npcs/templates/humanoid.lua", egos_chance = { prefix=50, suffix=80},
}
