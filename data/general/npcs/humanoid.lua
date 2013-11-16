-- Veins of the Earth
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
	define_as = "BASE_NPC_KOBOLD",
	type = "humanoid", subtype = "humanoid_kobold",
	image = "tiles/kobold.png",
	display = "k", color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
        desc = [[Ugly and green!]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=9, dex=13, con=10, int=10, wis=9, cha=8, luc=12 },
	combat = { dam= {1,6} },
	infravision = 3,
	skill_hide = 4,
	skill_listen = 1,
	skill_spot = 1,
	skill_search = 1,
	skill_movesilently = 1,
        }

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "kobold warrior", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 75,
	rarity = 6,
	max_life = resolvers.rngavg(5,9),
	hit_die = 4,
	challenge = 1/2,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "short spear" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "armoured kobold warrior", color=colors.AQUAMARINE,
	level_range = {6, 10}, exp_worth = 100,
	rarity = 20,
	max_life = resolvers.rngavg(10,12),
	hit_die = 6,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "arrows (20)" },
        { name = "shortbow" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	{ name = "short spear" },
	},
}

newEntity{
	define_as = "BASE_NPC_ORC",
	type = "humanoid", subtype = "humanoid_orc",
	image = "tiles/orc.png",
	display = 'o', color=colors.GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[An ugly orc.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=17, dex=11, con=12, int=8, wis=7, cha=6, luc=10 },
	combat = { dam= {1,4} },
	infravision = 2,
	skill_listen = 2,
	skill_spot = 2,
}

newEntity{
	base = "BASE_NPC_ORC",
	name = "orc warrior", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 150,
	rarity = 8,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "studded leather armor" },
		{ name = "falchion" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_TIEFLING",
	type = "planetouched",
	image = "tiles/human.png",
	display = 'h', color=colors.RED,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A horned tiefling.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=12, int=12, wis=9, cha=6, luc=14 },
	combat = { dam= {1,6} },
	darkvision = 3,
	skill_bluff = 6,
	skill_hide = 4,

}

newEntity{
	base = "BASE_NPC_TIEFLING",
	name = "tiefling", color=colors.RED,
	level_range = {1, 4}, exp_worth = 150,
	rarity = 10,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "studded leather armor" },
		{ name = "rapier" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_GOBLIN",
	type = "humanoid", subtype = "humanoid_goblin",
	image = "tiles/goblin.png",
	display = 'g', color=colors.GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dirty goblin.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=13, con=12, int=10, wis=9, cha=6, luc=8 },
	combat = { dam= {1,6} },
	darkvision = 3,
	skill_hide = 4,
	skill_movesilently = 4,
	skill_listen = 2,
	skill_spot = 1,
}

newEntity{
	base = "BASE_NPC_GOBLIN",
	name = "goblin", color=colors.OLIVE_DRAB,
	level_range = {1, 4}, exp_worth = 50,
	rarity = 3,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1/3,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "leather armor" },
		{ name = "light wooden shield" },
		{ name = "morningstar" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	define_as = "BASE_NPC_DROW",
	type = "humanoid", subtype = "humanoid_drow",
	image = "tiles/drow.png",
	display = 'h', color=colors.BLACK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dark silhouette.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=10, int=12, wis=9, cha=10, luc=10 },
	combat = { dam= {1,6} },
	darkvision = 6,
	skill_hide = 1,
	skill_movesilently = 1,
	skill_listen = 2,
	skill_search = 3,
	skill_spot = 2,
}

newEntity{
	base = "BASE_NPC_DROW",
	name = "drow", color=colors.BLACK,
	level_range = {1, nil}, exp_worth = 150,
	rarity = 3,
	max_life = resolvers.rngavg(3,5),
	hit_die = 1,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
		{ name = "light metal shield" },
		{ name = "rapier" },
		{ name = "bolts (10)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	{ name = "hand crossbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_HUMAN",
	type = "humanoid", subtype = "humanoid_human",
	image = "tiles/human.png",
	display = 'h', color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost human.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=11, con=12, int=11, wis=9, cha=9, luc=10 },
	combat = { dam= {1,6} },
	lite = 3,
}

newEntity{
	base = "BASE_NPC_HUMAN",
	name = "human", color=colors.WHITE,
	level_range = {1, 5}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	hit_die = 1,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "chain mail" },
		{ name = "light metal shield" },
		{ name = "longsword" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_DWARF",
	type = "humanoid", subtype = "humanoid_dwarf",
	image = "tiles/dwarf_fighter.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost dwarf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=11, con=14, int=10, wis=9, cha=6, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_DWARF",
	name = "dwarf", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	darkvision = 3,
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	[Talents.T_EXOTIC_WEAPON_PROFICIENCY]=1, --stopgap measure for now
	},
	resolvers.equip{
		full_id=true,
		{ name = "scale mail" },
		{ name = "heavy metal shield" },
		{ name = "dwarven waraxe" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{
	base = "BASE_NPC_DWARF",
	name = "duergar", color=colors.DARK_GRAY,
	level_range = {1, 15}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	darkvision = 5,
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	},
	resolvers.equip{
		full_id=true,
		{ name = "chain mail" },
		{ name = "heavy metal shield" },
		{ name = "warhammer" },
		{ name = "bolts (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

--Scent
newEntity{
	define_as = "BASE_NPC_BUGBEAR",
	type = "humanoid", subtype = "humanoid_goblin",
	image = "tiles/goblin.png",
	display = 'g', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dirty hairy bugbear.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=12, con=13, int=10, wis=10, cha=9, luc=8 },
	combat = { dam= {1,6} },
	darkvision = 3,
	skill_climb = 1,
	skill_hide = 3,
	skill_movesilently = 5,
	skill_listen = 4,
	skill_spot = 4,
}

newEntity{
	base = "BASE_NPC_BUGBEAR",
	name = "bugbear",
	level_range = {1, 10}, exp_worth = 600,
	rarity = 5,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 2,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "leather armor" },
		{ name = "light wooden shield" },
		{ name = "morningstar" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" }
	},
}

newEntity{
	define_as = "BASE_NPC_GNOLL",
	type = "humanoid", subtype = "humanoid_gnoll",
--	image = "tiles/goblin.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dog-headed humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=10, con=13, int=8, wis=11, cha=8, luc=8 },
	combat = { dam= {1,6} },
	darkvision = 3,
	skill_listen = 3,
	skill_spot = 2,
}

newEntity{
	base = "BASE_NPC_GNOLL",
	name = "gnoll",
	level_range = {1, 10}, exp_worth = 600,
	rarity = 5,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 2,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	[Talents.T_POWER_ATTACK]= 1
	},
	resolvers.equip{
		full_id=true,
		{ name = "leather armor" },
		{ name = "heavy steel shield" },
		{ name = "battleaxe" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "shortbow" },
	{ name = "fresh corpse" }
	},
}

newEntity{
	define_as = "BASE_NPC_GNOME",
	type = "humanoid", subtype = "humanoid_gnome",
	image = "tiles/gnome_fighter.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost gnome.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=11, con=14, int=10, wis=9, cha=8, luc=10 },
	combat = { dam= {1,6} },
}

newEntity{
	base = "BASE_NPC_GNOME",
	name = "gnome", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1/2,
	darkvision = 3,
	skill_hide = 3,
	skill_listen = 1,
	skill_spot = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1 },
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
		{ name = "heavy metal shield" },
		{ name = "longsword" },
		{ name = "bolts (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

newEntity{
	base = "BASE_NPC_GNOME",
	name = "deep gnome", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 300,
	rarity = 8,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	darkvision = 6,
	combat_untyped = 4,
	spell_resistance = 12,
	skill_hide = 3,
	skill_listen = 1,
	skill_spot = 1,
	stats = { str=11, dex=13, con=12, int=10, wis=11, cha=4, luc=10 },
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_TOUGHNESS]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "banded mail" },
		{ name = "buckler" },
		{ name = "longsword" },
		{ name = "bolts (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

--Shopkeepers
newEntity{
	base = "BASE_NPC_DROW",
	name = "drow", color=colors.BLACK,
	image = "tiles/newtiles/drow_shop.png",
	level_range = {1, nil}, exp_worth = 150,
	rarity = 3,
	max_life = resolvers.rngavg(3,5),
	hit_die = 1,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "chain shirt" },
		{ name = "light metal shield" },
		{ name = "rapier" },
		{ name = "bolts (10)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	{ name = "hand crossbow" },
	},
	can_talk = "shop",
	faction = "neutral",
}

newEntity{
	base = "BASE_NPC_HUMAN",
	name = "human", color=colors.WHITE,
	image = "tiles/newtiles/human_shop.png",
	level_range = {1, 5}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	hit_die = 1,
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "chainmail" },
		{ name = "light metal shield" },
		{ name = "longsword" },
		{ name = "arrows (20)" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
	can_talk = "shop",
	faction = "neutral",
}
