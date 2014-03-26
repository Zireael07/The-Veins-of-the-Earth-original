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
	type = "humanoid", subtype = "reptilian",
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

	encounter_escort = {
	{chance = 80, type="humanoid", name="kobold", number=3, no_subescort = true},
  	},
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
		{ name = "arrows" },
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
		{ name = "arrows" },
        { name = "shortbow" },
        { name = "leather armor"},
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	{ name = "short spear" },
	},
}

newEntity{
	define_as = "BASE_NPC_ORC",
	type = "humanoid", subtype = "orc",
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
	
	encounter_escort = {
	{chance = 50, type="humanoid", name="orc", number=1, no_subescort = true},
  	},
  	resolvers.class()
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
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_GOBLIN",
	type = "humanoid", subtype = "goblinoid",
	image = "tiles/goblin.png",
	display = 'g', color=colors.GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dirty goblin.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=13, con=12, int=10, wis=9, cha=6, luc=8 },
	combat = { dam= {1,6} },
	infravision = 3,
	skill_hide = 4,
	skill_movesilently = 4,
	skill_listen = 2,
	skill_spot = 1,
	encounter_escort = {
	{chance = 80, type="humanoid", name="kobold", number=2, no_subescort = true},
  	},
--	resolvers.class()
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
	type = "humanoid", subtype = "drow",
	image = "tiles/drow.png",
	display = 'h', color=colors.BLACK,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dark silhouette.]],
	specialist_desc = [[Drow do not sleep or dream, and are immune to sleep effects. Instead, they refresh themselves by entering a meditative reverie for a few hours a night. Drow are resistant to magic, but once per day they can use spell-like abilities to create dancing lights, darkness, and faerie fire, which they use to disorient their foes.]],
	uncommon_desc = [[A drow’s sharp senses are attuned to life underground. Drow can see so well in the dark that sudden exposure to bright light can blind them.]],
	common_desc = [[Drow are known for their evil natures, matriarchal cultures, and zealous worship of malign, arachnid gods. They are more delicate than humans, but also more dextrous and more cunning. Drow are talented spellcasters, with drow women holding all divine roles. Culturally, drow train their children with the rapier, short sword, and hand crossbow, and they often poison their weapons.]],
	base_desc = [[This lithe, ebon-skinned humanoid is a dark elf, also known as a drow. These suberttanean elves speak both Elven and Undercommon, and typically also speak Common. Some drow also learn oher racial languages or a form of sign language known only to them.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=10, int=12, wis=9, cha=10, luc=10 },
	combat = { dam= {1,6} },
	infravision = 6,
	skill_hide = 1,
	skill_movesilently = 1,
	skill_listen = 2,
	skill_search = 3,
	skill_spot = 2,

	encounter_escort = {
	{chance = 80, type="humanoid", name="drow", faction = "enemies", number=3, no_subescort = true},
  	},
	resolvers.class()
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
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
	{ name = "hand crossbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_HUMAN",
	type = "humanoid", subtype = "human",
	image = "tiles/human.png",
	display = 'h', color=colors.WHITE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost human.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=11, con=12, int=11, wis=9, cha=9, luc=10 },
	combat = { dam= {1,6} },
	lite = 3,
	resolvers.class()
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
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_DWARF",
	type = "humanoid", subtype = "dwarf",
	image = "tiles/npc/dwarf_fighter.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost dwarf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=11, con=14, int=10, wis=9, cha=6, luc=10 },
	combat = { dam= {1,6} },
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_DWARF",
	name = "dwarf", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	infravision = 3,
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	[Talents.T_EXOTIC_WEAPON_PROFICIENCY]=1, --stopgap measure for now
	},
	resolvers.equip{
		full_id=true,
		{ name = "scale mail" },
		{ name = "heavy metal shield" },
		{ name = "dwarven waraxe" },
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
	uncommon_desc = [[ Dwarves come off as gruff or even rude, but they are an extremely determined and honorable people. They look down upon those who flaunt their wealth and usually wear only one or two pieces of finery themselves, although dwarven jewelry tends to be exceedingly beautiful and well-crafted.]],
	common_desc = [[Dwarves build their kingdoms underground, carving them straight into the stone of mountainsides. They are naturally adept at working stone, and spend their days mining gems and precious metals from beneath the earth.]],
	base_desc = [[This short, stocky humanoid is a dwarf. It can see in the dark.]],
}

newEntity{
	base = "BASE_NPC_DWARF",
	name = "duergar", color=colors.DARK_GRAY,
	level_range = {1, 15}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	infravision = 5,
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	},
	resolvers.equip{
		full_id=true,
		{ name = "chain mail" },
		{ name = "heavy metal shield" },
		{ name = "warhammer" },
		{ name = "bolts" },
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
	type = "humanoid", subtype = "goblinoid",
	image = "tiles/goblin.png",
	display = 'g', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dirty hairy bugbear.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=12, con=13, int=10, wis=10, cha=9, luc=8 },
	combat = { dam= {1,6} },
	infravision = 3,
	skill_climb = 1,
	skill_hide = 3,
	skill_movesilently = 5,
	skill_listen = 4,
	skill_spot = 4,
	uncommon_desc = [[Bugbears tend to live in small tribal units, with the biggest and meanest of them the tribal leader by default. They tend to have but two goals in life: food and treasure, and a group of adventures would be considered a great source of both.]],
	common_desc = [[As well as being considerably stronger, healthier and more light footed than the average human, bugbears have an affinity for moving quietly despite their bulk. Combined with their natural darkvision, these qualities add up to a creature very well suited for raids on camp sites in the dead of night.]],
	base_desc = [[This muscular humanoid is a bugbear, the biggest and strongest of the common goblinoids. Bugbears speak Goblin and Common. It is proficient in simple weapons and needs to eat, breathe and sleep.]],
}

newEntity{
	base = "BASE_NPC_BUGBEAR",
	name = "bugbear",
	level_range = {1, 10}, exp_worth = 600,
	rarity = 5,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 2,
	infravision = 3,
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
	encounter_escort = {
	{chance = 20, type="humanoid", name="bugbear", number=1, no_subescort = true},
	{chance = 60, type="humanoid", name="goblin", number=2, no_subescort = true},
  	},
}

newEntity{
	define_as = "BASE_NPC_GNOLL",
	type = "humanoid", subtype = "gnoll",
	image = "tiles/gnoll.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A dog-headed humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=15, dex=10, con=13, int=8, wis=11, cha=8, luc=8 },
	combat = { dam= {1,6} },
	infravision = 3,
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
	infravision = 3,
	alignment = "chaotic evil",
	resolvers.talents{ [Talents.T_SHOOT]=1, 
	[Talents.T_POWER_ATTACK]= 1
	},
	resolvers.equip{
		full_id=true,
		{ name = "leather armor" },
		{ name = "heavy steel shield" },
		{ name = "battleaxe" },
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "shortbow" },
	{ name = "fresh corpse" }
	},
}

newEntity{
	define_as = "BASE_NPC_GNOME",
	type = "humanoid", subtype = "gnome",
	image = "tiles/npc/gnome_fighter.png",
	display = 'h', color=colors.BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost gnome.]],
	uncommon_desc = [[Gnomes are renowned for two traits: their sense of humor and their innate talents for arcane illusions. As a spell-like ability, any gnome can speak with burrowing mammals, and talented gnomes can produce dancing lights, ghost sound, and prestidigitation as well.]],
	common_desc = [[Gnomes can see well in dim light and have sharp ears. They have a particular dislike for the more bestial “smallfolk,” such as goblins and kobolds, and are well-versed at evading the ponderous attacks of giants.]],
	base_desc = [[This small, spindly humanoid is a gnome, one of the civilized nonhuman races. Gnomes speak their own language, but also learn Common. Clever gnomes often know other racial languages as well.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=11, con=14, int=10, wis=9, cha=8, luc=10 },
	combat = { dam= {1,6} },
	resolvers.class()
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
		{ name = "bolts" },
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
	infravision = 6,
	combat_untyped = 4,
	spell_resistance = 12,
	skill_hide = 3,
	skill_listen = 1,
	skill_spot = 1,
	stats = { str=11, dex=13, con=12, int=10, wis=11, cha=4, luc=10 },
	resolvers.talents{ [Talents.T_SHOOT]=1,
--	[Talents.T_TOUGHNESS]=1
	},
	resolvers.equip{
		full_id=true,
		{ name = "banded mail" },
		{ name = "buckler" },
		{ name = "longsword" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_HALFLING",
	type = "humanoid", subtype = "halfling",
	image = "tiles/npc/halfling_fighter.png",
	display = 'h', color=colors.LIGHT_BROWN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A lost halfling.]],
	uncommon_desc = [[Desipite their small stature, halflings are generally brave and good-natured. These nomadic smallfolk are widely traveled.]],
	common_desc = [[Halflings use their small size and nimble physique to escape notice, evade the ponderous attacks of larger creatures, and slip into places where they are not necessarily invited.]],
	base_desc = [[This childlike humanoid is a halfling. Halflings have their own tongue, but also speak the local language. Clever halflings may know other racial languages as well.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=11, dex=13, con=12, int=10, wis=9, cha=8, luc=12 },
	combat = { dam= {1,6} },
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_HALFLING",
	name = "halfling",
	level_range = {1, 5}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	hit_die = 1,
	challenge = 1/2,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "studded leather" },
		{ name = "light metal shield" },
		{ name = "longsword" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

newEntity{
	define_as = "BASE_NPC_HOBGOBLIN",
	type = "humanoid", subtype = "goblinoid",
	image = "tiles/goblin.png",
	display = 'g', color=colors.RED,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A brutish goblinoid garbed in red, with reddish skin and dark hair.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=14, int=10, wis=9, cha=8, luc=10 },
	combat = { dam= {1,6} },
	infravision = 3,
	encounter_escort = {
	{chance = 80, type="humanoid", name="hobgoblin", number=1},
  	},
}

newEntity{
	base = "BASE_NPC_HOBGOBLIN",
	name = "hobgoblin",
	level_range = {1, 5}, exp_worth = 150,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	hit_die = 1,
	challenge = 1/2,
	skill_movesilently = 4,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "studded leather" },
		{ name = "light metal shield" },
		{ name = "longsword" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "javelin" },
	},
}

newEntity{
	define_as = "BASE_NPC_LIZARDFOLK",
	type = "humanoid", subtype = "reptilian",
	image = "tiles/lizardfolk.png",
	display = 'h', color=colors.DARK_GREEN,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A scaly reptilian humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=10, con=13, int=9, wis=10, cha=10, luc=10 },
	combat = { dam= {1,6} },
	infravision = 3,
	combat_natural = 5,
}

newEntity{
	base = "BASE_NPC_LIZARDFOLK",
	name = "lizardfolk",
	level_range = {1, nil}, exp_worth = 300,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	skill_balance = 4,
	skill_jump = 4,
	skill_swim = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "studded leather" },
		{ name = "heavy metal shield" },
		{ name = "club" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "javelin" },
	},
}

--Swim 60 ft.
newEntity{
	define_as = "BASE_NPC_LOCATHAH",
	type = "humanoid", subtype = "humanoid_aquatic",
	image = "tiles/triton.png",
	display = 'h', color=colors.DARK_BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A scaly fish-like humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=12, con=10, int=13, wis=13, cha=11, luc=10 },
	combat = { dam= {1,6} },
	infravision = 3,
	combat_natural = 3,
}

newEntity{
	base = "BASE_NPC_LOCATHAH",
	name = "locathah",
	level_range = {1, 15}, exp_worth = 150,
	rarity = 15,
	max_life = resolvers.rngavg(5,10),
	hit_die = 2,
	challenge = 1/2,
	skill_listen = 5,
	skill_spot = 5,
	skill_swim = 8,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "light crossbow" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "longspear" },
	},
}

--Swim 50 ft.
newEntity{
	define_as = "BASE_NPC_MERFOLK",
	type = "humanoid", subtype = "humanoid_aquatic",
	image = "tiles/merfolk.png",
	display = 'h', color=colors.DARK_BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A scaly fish-like humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=14, int=10, wis=9, cha=10, luc=10 },
	combat = { dam= {1,6} },
	infravision = 1,
	movement_speed_bonus = 0.90,
}

newEntity{
	base = "BASE_NPC_MERFOLK",
	name = "merfolk",
	level_range = {1, 15}, exp_worth = 150,
	rarity = 15,
	max_life = resolvers.rngavg(5,10),
	hit_die = 2,
	challenge = 1/2,
	skill_listen = 5,
	skill_spot = 5,
	skill_swim = 8,

	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_POLEARM]=1,
	[Talents.T_ALERTNESS]=1,
	},
	resolvers.equip{
		full_id=true,
		{ name = "leather armor" },
		{ name = "heavy crossbow" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "trident" },
	},
}

--stench 3 sq Fort DC 13 or sickened; Multiattack, Weapon Focus
newEntity{
	define_as = "BASE_NPC_TROG",
	type = "humanoid", subtype = "reptilian",
	image = "tiles/goblin.png",
	display = 'h', color=colors.DARK_UMBER,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A scaly reptilian humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=10, dex=9, con=14, int=8, wis=10, cha=10, luc=6 },
	combat = { dam= {1,4} },
	infravision = 5,
	combat_natural = 6,
	alignment = "chaotic evil",
}

newEntity{
	base = "BASE_NPC_TROG",
	name = "troglodyte",
	level_range = {1, nil}, exp_worth = 300,
	rarity = 10,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	skill_hide = 6,
	skill_listen = 3,
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "club" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "javelin" },
	},
}


--Planetouched
--Darkness
newEntity{
	define_as = "BASE_NPC_TIEFLING",
	type = "humanoid", subtype = "planetouched",
	image = "tiles/human.png",
	display = 'h', color=colors.RED,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A horned tiefling.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=13, con=12, int=12, wis=9, cha=6, luc=14 },
	combat = { dam= {1,6} },
	infravision = 3,
	skill_bluff = 6,
	skill_hide = 4,
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_TIEFLING",
	name = "tiefling", color=colors.RED,
	level_range = {1, nil}, exp_worth = 150,
	rarity = 10,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1/2,
	resist = { [DamageType.FIRE] = 5,
	[DamageType.ELECTRIC] = 5,
	[DamageType.COLD] = 5,
	},
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "studded leather armor" },
		{ name = "rapier" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "light crossbow" },
	},
}

--Daylight
newEntity{
	define_as = "BASE_NPC_AASIMAR",
	type = "humanoid", subtype = "planetouched",
	image = "tiles/human.png",
	display = 'h', color=colors.GOLD,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A beautiful humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=13, dex=11, con=12, int=10, wis=11, cha=10, luc=14 },
	combat = { dam= {1,6} },
	infravision = 3,
	skill_knowledge = 1,
	skill_heal = 4,
	skill_listen = 2,
	skill_spot = 2,
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_AASIMAR",
	name = "aasimar",
	level_range = {1, 10}, exp_worth = 150,
	rarity = 10,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1/2,
	resist = { [DamageType.ACID] = 5,
	[DamageType.ELECTRIC] = 5,
	[DamageType.COLD] = 5,
	},
	resolvers.talents{ [Talents.T_SHOOT]=1, },
	resolvers.equip{
		full_id=true,
		{ name = "scale mail" },
		{ name = "longsword" },
		{ name = "heavy metal shield" },
		{ name = "bolts" },
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
		{ name = "bolts" },
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
		{ name = "arrows" },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "fresh corpse" },
    { name = "shortbow" },
	},
	can_talk = "shop",
	faction = "neutral",
}
