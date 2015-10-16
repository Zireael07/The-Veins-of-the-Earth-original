-- Veins of the Earth
-- Zireael 2013-2015
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
	--	egos = "/data/general/npcs/templates/humanoid.lua", egos_chance = { suffix=50},
}

--Playable races
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_DROW",
	subtype = "drow",
	image = "tiles/mobiles/drow.png",
	display = 'h', color=colors.BLACK,

	desc = [[A dark silhouette.]],
	specialist_desc = [[Drow do not sleep or dream, and are immune to sleep effects. Instead, they refresh themselves by entering a meditative reverie for a few hours a night. Drow are resistant to magic, but once per day they can use spell-like abilities to create dancing lights, darkness, and faerie fire, which they use to disorient their foes.]],
	uncommon_desc = [[A drow’s sharp senses are attuned to life underground. Drow can see so well in the dark that sudden exposure to bright light can blind them.]],
	common_desc = [[Drow are known for their evil natures, matriarchal cultures, and zealous worship of malign, arachnid gods. They are more delicate than humans, but also more dextrous and more cunning. Drow are talented spellcasters, with drow women holding all divine roles. Culturally, drow train their children with the rapier, short sword, and hand crossbow, and they often poison their weapons.]],
	base_desc = [[This lithe, ebon-skinned humanoid is a dark elf, also known as a drow. These subterranean elves speak both Elven and Undercommon, and typically also speak Common. Some drow also learn other racial languages or a form of sign language known only to them.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=13, dex=13, con=10, int=12, wis=9, cha=10, luc=10 },
	infravision = 6,
	alignment = "Chaotic Evil",
	skill_hide = 1,
	skill_movesilently = 1,
	skill_listen = 2,
	skill_search = 3,
	skill_spot = 2,
	hit_die = 1,
	resolvers.specialnpc(),
	resolvers.templates(),
--	resolvers.class()
}

newEntity{
	base = "BASE_NPC_DROW",
	name = "drow", color=colors.BLACK,
	level_range = {1, nil}, exp_worth = 400,
	rarity = 3,
	max_life = resolvers.rngavg(3,5),
	challenge = 1,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_DARKNESS_INNATE]=1,
	[Talents.T_FAERIE_FIRE_INNATE]=1
	},
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "chain shirt", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "light metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "rapier", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "hand crossbow", not_properties={"cursed"}  },
	{ name = "spider bread"},
	},
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_HUMAN",
	subtype = "human",
	image = "tiles/mobiles/human.png",
	display = 'h', color=colors.WHITE,
	desc = [[A lost human.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=11, dex=11, con=12, int=11, wis=9, cha=9, luc=10 },
	combat = { dam= {1,6} },
--	lite = 3,
	hit_die = 1,
	alignment = "Neutral Good",
	resolvers.specialnpc(),
	resolvers.templates(),
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_HUMAN",
	name = "human", color=colors.WHITE,
	level_range = {1, 5}, exp_worth = 400,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	challenge = 1,
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "chain mail", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
		{ name = "light metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
		{ name = "long sword", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="npc", veins_level=1, },
		{ name = "torch", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "shortbow", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_DWARF",
	subtype = "dwarf",
	image = "tiles/mobiles/mobiles/npc/dwarf_fighter.png",
	display = 'h', color=colors.BROWN,
	desc = [[A lost dwarf.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=13, dex=11, con=14, int=10, wis=9, cha=6, luc=10 },
	hit_die = 1,
	resolvers.specialnpc(),
	resolvers.templates(),
--	resolvers.class()
}

newEntity{
	base = "BASE_NPC_DWARF",
	name = "dwarf", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 400,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	challenge = 1,
	infravision = 3,
	alignment = "Lawful Good",
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_EXOTIC_WEAPON_PROFICIENCY]=1, --stopgap measure for now
	},
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "scale mail", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "heavy metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "dwarven waraxe", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "shortbow", not_properties={"cursed"} },
	{ name = "food ration" },
	},
	uncommon_desc = [[Dwarves come off as gruff or even rude, but they are an extremely determined and honorable people. They look down upon those who flaunt their wealth and usually wear only one or two pieces of finery themselves, although dwarven jewelry tends to be exceedingly beautiful and well-crafted.]],
	common_desc = [[Dwarves build their kingdoms underground, carving them straight into the stone of mountainsides. They are naturally adept at working stone, and spend their days mining gems and precious metals from beneath the earth.]],
	base_desc = [[This short, stocky humanoid is a dwarf. It can see in the dark.]],
}

newEntity{
	base = "BASE_NPC_DWARF",
	name = "duergar", color=colors.DARK_GRAY,
	level_range = {1, 15}, exp_worth = 400,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	hit_die = 1,
	challenge = 1,
	infravision = 5,
	alignment = "Lawful Evil",
	resolvers.equip{
		full_id=true,
		{ name = "chain mail", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "heavy metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "warhammer", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow", not_properties={"cursed"} },
	{ name = "food ration" },
	},

	specialist_desc = [[Duergar are capable of minor spell like abilities once per day such as enlarge person, invisibility. They are immune to poison, paralysis, and many illusions.]],
	uncommon_desc = [[Duergar are not skilled with traditional Dwarven weaponry. They wear drab clothing and jewelry meant to blend in with their environment.]],
	common_desc = [[Duergar can see twice as far as a normal dwarf in darkness, but are sensitive to the point of distraction in bright light. They spend their lives in toil and are at constant war with other dwarves.]],
	base_desc = [[This short grey humanoid that is bald yet has a full beard is in fact a dwarf known as a duergar. They are evil beings that dwell deep underground.]],
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_GNOME",
	subtype = "gnome",
	image = "tiles/mobiles/mobiles/npc/gnome_fighter.png",
	display = 'h', color=colors.BROWN,
	desc = [[A lost gnome.]],
	uncommon_desc = [[Gnomes are renowned for two traits: their sense of humor and their innate talents for arcane illusions. As a spell-like ability, any gnome can speak with burrowing mammals, and talented gnomes can produce dancing lights, ghost sound, and prestidigitation as well.]],
	common_desc = [[Gnomes can see well in dim light and have sharp ears. They have a particular dislike for the more bestial “smallfolk,” such as goblins and kobolds, and are well-versed at evading the ponderous attacks of giants.]],
	base_desc = [[This small, spindly humanoid is a gnome, one of the civilized nonhuman races. Gnomes speak their own language, but also learn Common. Clever gnomes often know other racial languages as well.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=11, dex=11, con=14, int=10, wis=9, cha=8, luc=10 },
	hit_die = 1,
	alignment = "Neutral Good",
	resolvers.specialnpc(),
	resolvers.templates(),
--	resolvers.class()
}

newEntity{
	base = "BASE_NPC_GNOME",
	name = "gnome", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 200,
	rarity = 5,
	max_life = resolvers.rngavg(5,10),
	challenge = 1/2,
	darkvision = 3,
	skill_hide = 3,
	skill_listen = 1,
	skill_spot = 1,
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "chain shirt", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "heavy metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "long sword", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1, },
		{ name = "torch" },
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	{ name = "food ration" },
	},
}

newEntity{
	base = "BASE_NPC_GNOME",
	name = "deep gnome", color=colors.WHITE,
	level_range = {1, 15}, exp_worth = 400,
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
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "banded mail", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "buckler", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "long sword", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	{ name = "food ration" },
	},

	specialist_desc = [[Several varieties of gnome exist. Although the svirfneblin have adapted to life underground, their more common kin keep near the surface. These include rock gnomes, who are most common by far; forest gnomes, who can blend into woodlands; and whisper gnomes who, like the svirfneblin, are known for their stealthy and suspicious natures.]],
	uncommon_desc = [[Deep gnomes are particularly talented illusionists and alchemists, and they possess a variety of innate magical talents. A svirfneblin is protected by a continuous nondetection effect, and once per day, a deep gnome can produce blindness/deafness, blur, and disguise self as spell-like abilities. Deep gnomes live in large cities which they keep well hidden from their foes. They despise the deadly subterranean races that prey upon them, particularly drow, kuo-toa, and mind flayers.]],
	common_desc = [[Svirfneblin are somewhat heartier and more agile than common rock gnomes, but far less extroverted. They have sharp senses in general and can see exceptionally well in pitch darkness. Svirfneblin are particularly stealthy and nimble in combat, seldom pausing long enough for foes to land a solid blow. Like rock gnomes, they train in special offensive tactics which are particularly effective against goblinoids and kobolds.]],
	base_desc = [[This wiry, miniscule humanoid with rock-hued skin is a svirfneblin, better known among surface races as a deep gnome. Svirfneblin are closely related to other gnome races, but they live far underground and are hardened by this subterranean existence. Most deep gnomes speak Gnome, Common, and Undercommon.]],
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_HALFLING",
	subtype = "halfling",
	image = "tiles/mobiles/mobiles/npc/halfling_fighter.png",
	display = 'h', color=colors.LIGHT_BROWN,
	desc = [[A lost halfling.]],
	uncommon_desc = [[Desipite their small stature, halflings are generally brave and good-natured. These nomadic smallfolk are widely traveled.]],
	common_desc = [[Halflings use their small size and nimble physique to escape notice, evade the ponderous attacks of larger creatures, and slip into places where they are not necessarily invited.]],
	base_desc = [[This childlike humanoid is a halfling. Halflings have their own tongue, but also speak the local language. Clever halflings may know other racial languages as well.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=11, dex=13, con=12, int=10, wis=9, cha=8, luc=12 },
	hit_die = 1,
	alignment = "Chaotic Good",
	resolvers.specialnpc(),
	resolvers.templates(),
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_HALFLING",
	name = "halfling",
	level_range = {1, 5}, exp_worth = 200,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	challenge = 1/2,
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "studded leather", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "light metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "long sword", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1,  },
		{ name = "torch" },
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	{ name = "food ration" },
	},
}


--On the fence
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
	resolvers.class(),
--	resolvers.specialnpc(),
	resolvers.templates()
--	egos = "/data/general/npcs/templates/humanoid.lua", egos_chance = { suffix=50},
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
	emote_anger = "Me kill you!",
--	resolvers.specialnpc(),
	resolvers.templates()
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
}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "kobold warrior", color=colors.AQUAMARINE,
	level_range = {6, 10}, exp_worth = 400,
	rarity = 20,
	max_life = resolvers.rngavg(10,12),
	hit_die = 6,
	challenge = 1,
	resolvers.equip{
		full_id=true,
        { name = "shortbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
        { name = "leather armor", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "short spear", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_ORC",
	subtype = "orc",
	image = "tiles/mobiles/orc.png",
	display = 'o', color=colors.GREEN,
	desc = [[An ugly orc.]],
	uncommon_desc = [[Orcs are tribal by nature with most tribes separated by the deity that they pick as their patron.
	Orcs do have one weakness - a sensitivity to bright light that can dazzle these naturally noctunal creatures. Orc leaders are traditionally warriors of one kind or another, often from the Barbarian tradition. Although rare, orc spellcasters are typically ruthlessly ambitious, and the rivalries between warrior and spellcaster factions can sometimes tear a tribe apart. Orc society is usually patriarchal, with females seen as prized possesions at best and chattel at worst.]],
	common_desc = [[Orcs are considerably stronger than the average human, though this is countered by a general lack of the more cerebral traits. A warlike people who believe that to survive they must conquer as much territory as they can, they are often at odds with those they encounter (including other tribes of their own kind) and are a generally hated race for this reason. Their warlike culture does however mean that all of their kind are well trained in the use of weaponry, and many prefer large, two-handed weapons that deal as much damage as quickly as possible.]],
	base_desc = "This primitive looking creature is an orc, one of the most prolific and agressive of the humanoid races. Orcs speak their own language, and the more intelligent of their kind often learn Goblin or Giant. ",

	stats = { str=17, dex=11, con=12, int=8, wis=7, cha=6, luc=10 },
	infravision = 2,
	alignment = "Chaotic Evil",
	skill_listen = 2,
	skill_spot = 2,
	hit_die = 1,
--	resolvers.specialnpc(),
--	resolvers.templates(),
--  	resolvers.class()
}

newEntity{
	base = "BASE_NPC_ORC",
	name = "orc", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 400,
	rarity = 8,
	max_life = resolvers.rngavg(4,7),
	challenge = 1,
	resolvers.equip{
		full_id=true,
		{ name = "studded leather armor", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "falchion", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "shortbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	emote_anger = "Me kill you!",
}

--Planetouched
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_TIEFLING",
	subtype = "planetouched",
	image = "tiles/mobiles/human.png",
	display = 'h', color=colors.RED,
	desc = [[A horned tiefling.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=13, dex=13, con=12, int=12, wis=9, cha=6, luc=14 },
	infravision = 3,
	skill_bluff = 6,
	skill_hide = 4,
--	resolvers.specialnpc(),
--	resolvers.templates(),
	resolvers.class()
}

newEntity{
	base = "BASE_NPC_TIEFLING",
	name = "tiefling", color=colors.RED,
	level_range = {1, nil}, exp_worth = 200,
	rarity = 10,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1/2,
	alignment = "Neutral",
	resist = { [DamageType.FIRE] = 5,
	[DamageType.ELECTRIC] = 5,
	[DamageType.COLD] = 5,
	},
	resolvers.talents{ [Talents.T_SHOOT]=1,
		[Talents.T_DARKNESS_INNATE]=1,
	},
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "studded leather armor", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "rapier", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	{ name = "food ration" },
	},
}

--Daylight
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_AASIMAR",
	subtype = "planetouched",
	image = "tiles/mobiles/human.png",
	display = 'h', color=colors.GOLD,
	desc = [[A beautiful humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=1, ai_move="move_complex", },
	stats = { str=13, dex=11, con=12, int=10, wis=11, cha=10, luc=14 },
	infravision = 3,
	alignment = "Neutral Good",
	skill_knowledge = 1,
	skill_heal = 4,
	skill_listen = 2,
	skill_spot = 2,
--[[	resolvers.specialnpc(),
	resolvers.templates(),]]
	resolvers.class(),
}

newEntity{
	base = "BASE_NPC_AASIMAR",
	name = "aasimar",
	level_range = {1, 10}, exp_worth = 200,
	rarity = 10,
	max_life = resolvers.rngavg(4,7),
	hit_die = 1,
	challenge = 1/2,
	resist = { [DamageType.ACID] = 5,
	[DamageType.ELECTRIC] = 5,
	[DamageType.COLD] = 5,
	},
	resolvers.equipnoncursed{
		full_id=true,
		{ name = "scale mail", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "long sword", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "heavy metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1,},
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	{ name = "food ration" },
	},
}


--Clearly enemies
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_GOBLIN",
	subtype = "goblinoid",
	image = "tiles/mobiles/goblin.png",
	display = 'g', color=colors.GREEN,
	desc = [[A dirty goblin.]],
	specialist_desc = [[Goblins have a natural affinity for worgs, which they use as mounts and guardians.]],
	uncommon_desc = [[Goblins are talented makers of traps, which they use to mark their territory and guard their burrows. They are cowardly creatures, and attack only when their victims are helpless or they have overwhelming numbers on their side.]],
	common_desc = [[Goblins are nomadic scavengers that live in large, violent tribes. They are also malicious and petty, and enjoy raiding the isolated homes of civilized humanoids for food and supplies. Goblins can see in the dark.]],
	base_desc = [[This ugly, stunted humanoid is a goblin, the most common of all goblinoid breeds. Goblins have their own guttural language, though a few clever individuals may also learn Common.]],

	stats = { str=11, dex=13, con=12, int=10, wis=9, cha=6, luc=8 },
	infravision = 3,
	alignment = "Chaotic Evil",
	skill_hide = 4,
	skill_movesilently = 4,
	skill_listen = 2,
	skill_spot = 1,
	hit_die = 1,
--	resolvers.specialnpc(),
--	resolvers.templates()
--	resolvers.class()
}

newEntity{
	base = "BASE_NPC_GOBLIN",
	name = "goblin", color=colors.OLIVE_DRAB,
	level_range = {1, 4}, exp_worth = 135,
	rarity = 3,
	max_life = resolvers.rngavg(4,7),
	challenge = 1/3,
	resolvers.equip{
		full_id=true,
		{ name = "leather armor", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "light wooden shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "morningstar", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	anger_emote = "Me kill you!",
}


--Scent
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_BUGBEAR",
	subtype = "goblinoid",
	image = "tiles/mobiles/goblin.png",
	display = 'g', color=colors.BROWN,
	desc = [[A dirty hairy bugbear.]],

	stats = { str=15, dex=12, con=13, int=10, wis=10, cha=9, luc=8 },
	infravision = 3,
	alignment = "Chaotic Evil",
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
	resolvers.equip{
		full_id=true,
		{ name = "leather armor", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "light wooden shield", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
		{ name = "morningstar", not_properties={"cursed"}, veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
	},
	anger_emote = "Me kill you!",
--	resolvers.specialnpc(),
	resolvers.templates()
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_GNOLL",
	subtype = "gnoll",
	image = "tiles/mobiles/gnoll.png",
	display = 'h', color=colors.BROWN,
	desc = [[A dog-headed humanoid.]],
	specialist_desc = [[Gnolls tend to form loose tribes that are ruled by their strongest member, who uses fear, intimidation and strength to remain in power. They revere the gnoll-like demon Yeenoghu, though gnollish clerics are often worshipers of Erythnul, deity of slaughter.]],
	uncommon_desc = [[Gnolls prefer combat where they can relly on their physical strength and sheer numbers of fellow attackers to overpower those they fight with ease. They have little discipline in a fight, but typically choose clever ambush locations to give them the upper hand in the first few seconds of combat.]],
	common_desc = [[Gnolls are nocturnal carnivores, driven by hunger and little else. They dislike giants and most humanoids, but will sometimes make alliances with such creatures so long as it means a plentiful supply of food.]],
	base_desc = [[This muscular hyena-headed humanoid is a gnoll, an evil race of creatures that typically prefer intelligent beings for food because they scream more. Gnolls usually only speak their own language.]],

	stats = { str=15, dex=10, con=13, int=8, wis=11, cha=8, luc=8 },
	infravision = 3,
	skill_listen = 3,
	skill_spot = 2,
	hit_die = 2,
--	resolvers.specialnpc(),
--	resolvers.templates()
}

newEntity{
	base = "BASE_NPC_GNOLL",
	name = "gnoll",
	level_range = {1, 10}, exp_worth = 600,
	rarity = 5,
	max_life = resolvers.rngavg(10,15),
	challenge = 2,
	infravision = 3,
	alignment = "Chaotic Evil",
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_POWER_ATTACK]= 1
	},
	resolvers.equip{
		full_id=true,
		{ name = "leather armor", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "heavy steel shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "battleaxe", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "arrows", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
	{ name = "shortbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	anger_emote = "Me kill you!",
}

newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_HOBGOBLIN",
	subtype = "goblinoid",
	image = "tiles/mobiles/goblin.png",
	display = 'g', color=colors.RED,
	desc = [[A brutish goblinoid garbed in red, with reddish skin and dark hair.]],
	uncommon_desc = [[Hobgoblins are braver and more militaristic than their common kin, but are still bullies at heart and favor stealth over a fair fight. Unlike common goblins, they keep their weapons and armor in good repair. Hobgoblins often rule goblin tribes.]],
	common_desc = [[On average, a hobgoblin is physically more powerful than a human, and is capable of surprisingly sophisticated battle tactics. Hobgoblins can see in the dark.]],
	base_desc = "This ugly, man-sized humanoid is a hobgoblin, a larger cousin of the common goblin. Hobgoblins speak Goblin, and a few clever individuals may also learn Common.",

	stats = { str=13, dex=13, con=14, int=10, wis=9, cha=8, luc=10 },
	infravision = 3,
	alignment = "Lawful Evil",
	hit_die = 1,
--	resolvers.specialnpc(),
--	resolvers.templates()
}

newEntity{
	base = "BASE_NPC_HOBGOBLIN",
	name = "hobgoblin",
	level_range = {1, 5}, exp_worth = 200,
	rarity = 5,
	max_life = resolvers.rngavg(5,8),
	challenge = 1/2,
	skill_movesilently = 4,
	resolvers.equip{
		full_id=true,
		{ name = "studded leather", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "light metal shield", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "long sword", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "javelin", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	anger_emote = "Me kill you!",
}

--stench 3 sq Fort DC 13 or sickened; Multiattack, Weapon Focus
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_TROG",
	subtype = "reptilian",
	image = "tiles/mobiles/goblin.png",
	display = 'h', color=colors.DARK_UMBER,
	desc = [[A scaly reptilian humanoid.]],
	uncommon_desc = [[ Any methods used to protect against or neutralize poison are also effective against the stench of troglodyte musk. Troglodytes live in fierce tribes, ruled by the most powerful among them. They often purposefully lair near more civilized humanoid settlements, preying upon their inhabitants and livestock and stealing steel tools and weapons, which troglodytes prize highly but cannot forge for themselves.]],
	common_desc = [[Troglodytes either wield crude weapons or rely on their claws and sharp teeth in battle. However, their greatest weapon is their vile stench. When excited, a troglodyte secretes an oily musk that most living creatures find absolutely sickening.]],
	base_desc = "This slender, humanoid lizard is a troglodyte. As individuals, these primitive creatures are not particularly fearsome, but they are remarkably malevolent. Troglodytes speak Draconic.",

	stats = { str=10, dex=9, con=14, int=8, wis=10, cha=10, luc=6 },
	combat = { dam= {1,4} },
	infravision = 5,
	combat_natural = 6,
	alignment = "Chaotic Evil",
	hit_die = 2,
--	resolvers.specialnpc()
--	resolvers.templates()
}

newEntity{
	base = "BASE_NPC_TROG",
	name = "troglodyte",
	level_range = {1, nil}, exp_worth = 400,
	rarity = 10,
	max_life = resolvers.rngavg(10,15),
	challenge = 1,
	skill_hide = 6,
	skill_listen = 3,
	resolvers.equip{
		full_id=true,
		{ name = "club", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "javelin", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	anger_emote = "Me kill you!",
}


--Aquatic humanoids
--Swim 60 ft.
newEntity{
	define_as = "BASE_NPC_LOCATHAH",
	type = "humanoid", subtype = "humanoid_aquatic",
	image = "tiles/mobiles/triton.png",
	display = 'h', color=colors.DARK_BLUE,
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER = 1 },
	desc = [[A scaly fish-like humanoid.]],

	ai = "dumb_talented_simple", ai_state = { talent_in=3, ai_move = "move_astar", },
	stats = { str=10, dex=12, con=10, int=13, wis=13, cha=11, luc=10 },
	combat = { dam= {1,6} },
	infravision = 3,
	combat_natural = 3,
	resolvers.wounds()
}

newEntity{
	base = "BASE_NPC_LOCATHAH",
	name = "locathah",
	level_range = {1, 15}, exp_worth = 200,
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
		{ name = "light crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=1, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "long spear", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
}

--Swim 50 ft.
newEntity{ base = "BASE_NPC_HUMANOID",
	define_as = "BASE_NPC_MERFOLK",
	subtype = "humanoid_aquatic",
	image = "tiles/mobiles/merfolk.png",
	display = 'h', color=colors.DARK_BLUE,
	desc = [[A scaly fish-like humanoid.]],
	uncommon_desc = [[Merfolk also fashion crossbows that remain particularly effective underwater. Merfolk establish their communities in choice fishing grounds. Curiosity sometimes draws merfolk to nautical surface dwellers, but these liaisons do not always end well.]],
	common_desc = [[Merfolk are playful and mischievous, neither particularly malevolent nor benevolent. They can breathe in both air and water, and enjoy sunning themselves on surf-beaten rocks. They typically wield tridents and similar weapons to defend themselves.]],
	base_desc = [[This strange creature is one of the merfolk: seemingly an attractive human from the waist up, but a scaly fish from the waist down.]],

	stats = { str=13, dex=13, con=14, int=10, wis=9, cha=10, luc=10 },
	infravision = 1,
--	movement_speed_bonus = 0.90,
	movement_speed = 1.9,
	combat_attackspeed = 1.9,
	hit_die = 2,
	open_door = true,
--	resolvers.specialnpc(),
--	resolvers.templates()
}

newEntity{
	base = "BASE_NPC_MERFOLK",
	name = "merfolk",
	level_range = {1, 15}, exp_worth = 200,
	rarity = 15,
	max_life = resolvers.rngavg(5,10),
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
		{ name = "leather armor", veins_drops="npc", veins_level=resolvers.npc_drops_level,  },
		{ name = "heavy crossbow", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
		{ name = "bolts", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
	resolvers.inventory {
	full_id=true,
    { name = "trident", veins_drops="npc", veins_level=resolvers.npc_drops_level, },
	},
}
