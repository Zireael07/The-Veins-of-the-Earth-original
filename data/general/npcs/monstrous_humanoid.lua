--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_NPC_MON_HUMANOID",
	type = "monstrous_humanoid",
	body = { INVEN = 10, MAIN_HAND = 1, OFF_HAND = 1, BODY = 1, HELM = 1, QUIVER=1 },
	ai = "humanoid_level", ai_state = { talent_in=3, },
	combat = { dam= {1,6} },
	resolvers.wounds()
}

newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_CENTAUR",
	name = "centaur",
	image = "tiles/newtiles/centaur.png",
	display = 'q', color=colors.LIGHT_BROWN,
	desc = [[A proud centaur.]],

	stats = { str=18, dex=14, con=15, int=8, wis=13, cha=11, luc=12 },
	level_range = {1, 5}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(25,30),
	hit_die = 4,
	challenge = 3,
	combat_natural = 2,
	skill_listen = 2,
	skill_movesilently = 2,
	skill_spot = 2,
	skill_survival = 1,
--	movement_speed_bonus = 0.66,
	movement_speed = 1.66,
	combat_attackspeed = 1.66,
	uncommon_desc = [[Centaurs are skilled horticulturists and often cultivate various plants near their lairs. Despite their calm nature, centaurs are known for becoming rowdy and aggressive under the influence of alcohol.]],
	common_desc = [[Although sociable among themselves and generally even-headed, centaurs shun outsiders and are almost always armed.]],
	base_desc = [[This creature, known as a centaur, has the upper body of a humanoid but the lower body of a horse.  It can see in the dark and needs to sleep, eat and breathe.]],
}

--Poison use, immunity to confusion and insanity effects
--Spell-likes: At will—darkness, ghost sound; 1/day— daze (DC 13), sound burst (DC 15). Caster level 3rd
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_DERRO",
	name = "derro",
	image = "tiles/npc/dwarf_fighter.png",
	display = 'h', color=colors.LIGHT_BROWN,
	desc = [[A small twisted creature.]],
	specialist_desc = [[Derro are capable of creating some minor illusory magic and are themselves quite resistant to magic. They are vulnerable to sunlight, but need to stay exposed for hours for this to be damaging to their health. It is possible for derro to be cured of their madness, but only through the use of the most powerful of magics.]],
	uncommon_desc = [[Though their madness-induced high charisma make derro natural spontaneous casters, they are also highly adapted to a life of stealth and subtefuge. They have the ability to take advantage of unaware or distracted foes to place a telling blow much like a rogue does, are natural poison users and suffer no risk of exposing themselves to the toxins they employ, and have a racial knack for staying quiet and hiding from view.]],
	common_desc = [[Derro are afflicted by a form of racial madness that gives them delusions of grandeur and a sadistic streak a mile wide. Of course, though other creatures realise this, no derro is capable of recognizing he is out of his mind. A derro is so confident of himself that this manifests as a defence for magics that attack an individuals willpower, against which their deranged minds would naturally have little defence. Derro speak Common and Undercommon.]],
	base_desc = [[This pale-skinned dwarf-like creature is a derro, a degenerate and evil creature of the underground. It can see in the dark and needs to eat, sleep and breathe.]],

	stats = { str=11, dex=14, con=13, int=10, wis=5, cha=16, luc=6 },
	level_range = {5, nil}, exp_worth = 900,
	rarity = 8,
	max_life = resolvers.rngavg(15,20),
	hit_die = 3,
	challenge = 3,
	spell_resistance = 15,
	combat_natural = 2,
	skill_bluff = 2,
	skill_hide = 8,
	skill_listen = 4,
	skill_movesilently = 4,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	alignment = "chaotic evil",
	resolvers.equip{
		{ name = "studded leather" },
		{ name = "buckler" },
		{ name = "bolts" },
	},
	resolvers.inventory {
	full_id=true,
    { name = "light crossbow" },
	},
}

--Detect thoughts, shapechange; immunity to sleep & charm effects;
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_DOPPELGANGER",
	subtype = "shapechanger",
	name = "doppelganger",
	image = "tiles/doppelganger.png",
	display = 'h', color=colors.LIGHT_SLATE,
	desc = [[A thin grayish humanoid.]],

	stats = { str=12, dex=13, con=12, int=13, wis=12, cha=13, luc=12 },
	level_range = {5, nil}, exp_worth = 900,
	rarity = 15,
	max_life = resolvers.rngavg(20,25),
	hit_die = 4,
	challenge = 3,
	combat_natural = 4,
	skill_bluff = 9, --+14 if shapechanged
	skill_diplomacy = 2,
	skill_intimidate = 2,
	skill_hide = 8,
	skill_listen = 4,
	skill_sensemotive = 4,
	skill_spot = 4,
	alignment = "neutral",
}

--Fly 60 ft.; Toughness
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_GARGOYLE",
	name = "gargoyle",
	image = "tiles/UT/gargoyle.png",
	display = 'Y', color=colors.GRAY,
	desc = [[A winged stone statue with a hideous snout.]],
	stats = { str=15, dex=14, con=18, int=6, wis=11, cha=7, luc=12 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 1200,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 4,
	challenge = 4,
	combat_natural = 4,
	skill_hide = 12, --including stone bonus
	skill_listen = 4,
	skill_spot = 4,
	combat_dr = 10,
	combat_dr_tohit = 1,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	alignment = "chaotic evil",
}

--Swim 60 ft. instead of fly
newEntity{
	base = "BASE_NPC_GARGOYLE",
	name = "kapoacinth",
	color=colors.BLUE,
}

--Blind (immune to gaze attacks, visual effects, illusions); blindsight 4 squares; scent
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_GRIMLOCK",
	name = "grimlock",
	image = "tiles/human.png",
	display = 'h', color=colors.DARK_GRAY,
	desc = [[A dull gray humanoid with a flat skin on its face.]],
	stats = { str=15, dex=13, con=13, int=10, wis=8, cha=6, luc=8 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 400,
	rarity = 8,
	max_life = resolvers.rngavg(10,15),
	hit_die = 1,
	challenge = 1,
	combat_natural = 4,
	skill_climb = 2,
	skill_hide = 12, --including stone bonus
	skill_listen = 6,
	skill_spot = 4,
	resolvers.talents{ [Talents.T_ALERTNESS]=1, },
	resolvers.equip{
	full_id=true,
		{ name = "studded leather" },
		{ name = "battleaxe" },
	},
}

--Swim 60 ft., rake 1d4, blindsense 30 ft, light sensitivity
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_SAHUAGIN",
	subtype = "aquatic",
	name = "sahuagin",
	image = "tiles/merfolk.png",
	display = 'h', color=colors.DARK_BLUE,
	desc = [[A blue-green scaly creature with a humanoid build and a shark's head.]],
	stats = { str=14, dex=13, con=12, int=14, wis=13, cha=9, luc=10 },
	combat = { dam= {1,4} },

	level_range = {5, nil}, exp_worth = 600,
	rarity = 15,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 2,
	combat_natural = 5,
	skill_handleanimal = 3,
	skill_hide = 5,
	skill_listen = 5,
	skill_spot = 5,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_RAGE]=1
	},
	alignment = "lawful evil",
	resolvers.equip{
	full_id=true,
		{ name = "trident" },
		{ name = "bolts" },
	},
	resolvers.inventory {
--	full_id=true,
	{ name = "heavy crossbow" },
	},
}

newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_HAG",
	image = "tiles/hag.png",
	display = 'u', color=colors.BLUE,
	body = { INVEN = 10 },
	desc = [[A twisted crone bent in two.]],
	stats = { str=25, dex=12, con=14, int=13, wis=13, cha=10, luc=8 },
	infravision = 3,
	alignment = "chaotic evil",
}

--Improved grab, rake 1d6, rend 2d6, DR 2/bludgeon; Blind-Fight
--Spell-likes: disguise self, fog cloud
newEntity{
	base = "BASE_NPC_HAG",
	name = "annis hag", color=colors.BLUE,
	level_range = {5, 20}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(45,50),
	hit_die = 7,
	challenge = 6,
	spell_resistance = 19,
	combat_natural = 9,
	skill_bluff = 8,
	skill_diplomacy = 2,
	skill_hide = 4,
	skill_intimidate = 2,
	skill_listen = 9,
	skill_spot = 9,
--	movement_speed_bonus = 0.33,
	movement_speed = 1.33,
	combat_attackspeed = 1.33,
	resolvers.talents{ [Talents.T_ALERTNESS]=1 },
}

--Swim 30 ft.; 2d4 STR damage Fort DC 16
--Spell-likes: At will—dancing lights, disguise self, ghost sound (DC 12), invisibility, pass without trace, tongues, water breathing.
newEntity{
	base = "BASE_NPC_HAG",
	name = "green hag", color=colors.DARK_GREEN,
	level_range = {5, 20}, exp_worth = 1500,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 9,
	challenge = 5,
	infravision = 6,
	spell_resistance = 18,
	combat_natural = 11,
	skill_concentration = 6,
	skill_hide = 8,
	skill_knowledge = 6,
	skill_swim = 8,
	skill_listen = 10,
	skill_spot = 10,
	stats = { str=19, dex=12, con=12, int=13, wis=13, cha=14, luc=8 },
	combat = { dam= {1,4} },
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	[Talents.T_COMBAT_CASTING]=1
	},
}

--2d6 STR damage in FOV; Toughness
newEntity{
	base = "BASE_NPC_HAG",
	name = "sea hag", color=colors.LIGHT_BLUE,
	level_range = {5, 20}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(50,55),
	hit_die = 3,
	challenge = 4,
	spell_resistance = 14,
	combat_natural = 3,
	skill_hide = 3,
	skill_knowledge = 3,
	skill_swim = 8,
	skill_listen = 5,
	skill_spot = 5,
	stats = { str=19, dex=12, con=12, int=10, wis=13, cha=14, luc=8 },
	combat = { dam= {1,4} },
	resolvers.talents{ [Talents.T_ALERTNESS]=1,
	},
}

--captivating song
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_HARPY",
	name = "harpy",
	display = 'B', color=colors.DARK_GRAY,
	desc = [[A winged creature with an ugly face.]],
	specialist_desc = [[While not particularly intelligent, harpies are smart enough to set up ambushes. They often ally themselves with more powerful creatures.]],
	uncommon_desc = [[The song of a harpy can captivate living creatures and cause them to approach it. Creatures within 5 feet do nothing, even as the harpy rends them apart.]],
	common_desc = [[Harpies can fly with average maneuverability and can make flyby attacks.]],
	base_desc = [[This filthy, wretched creature is a harpy. It can see in the dark and needs to eat, sleep and breathe.]],

	stats = { str=10, dex=15, con=10, int=7, wis=12, cha=17, luc=10 },
	combat = { dam= {1,3} },
	level_range = {5, nil}, exp_worth = 1200,
	rarity = 15,
	max_life = resolvers.rngavg(30,35),
	infravision = 3,
	hit_die = 7,
	challenge = 4,
	combat_natural = 1,
	skill_bluff = 8,
	skill_intimidate = 4,
	skill_listen = 6,
	skill_spot = 2,
	alignment = "chaotic evil",
	fly = true,
--	movement_speed_bonus = 1.33,
	movement_speed = 2.33,
	combat_attackspeed = 2.33,
	resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_PERSUASIVE]=1
	},
	resolvers.equip{
	full_id=true,
		{ name = "club" },
	},
}

--Petrifying gaze 3 sq Fort DC 15; poison 1d6 STR pri & 2d6 STR sec Fort DC 14
--Point Blank Shot, Precise Shot feats
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_MEDUSA",
	name = "medusa",
	display = 'h', color=colors.LIGHT_BROWN,
	desc = [[A female humanoid hiding her face behind a veil.]],
	specialist_desc = [[Medusas are skilled at lying and keeping their appearance hidden. They use these skills to lure victims into believing the situation is safe before using their abilities.]],
	uncommon_desc = [[Medusas have snakes for hair that inflict powerful poison when they successfully bite.]],
	common_desc = [[The gaze of a medusa turns its victims permanently into stone.]],
	base_desc = [[This horrific humanoid is a medusa. It can see in the dark and needs to eat, sleep and breathe.]],

	stats = { str=10, dex=15, con=12, int=12, wis=13, cha=15, luc=12 },
	combat = { dam= {1,4} },

	level_range = {10, 25}, exp_worth = 2000,
	rarity = 18,
	max_life = resolvers.rngavg(30,35),
	hit_die = 6,
	challenge = 7,
	combat_natural = 3,
	skill_bluff = 6,
	skill_diplomacy = 2,
	skill_intimidate = 2,
	skill_movesilently = 5,
	skill_spot = 7,
	resolvers.talents{ [Talents.T_SHOOT]=1,
	[Talents.T_FINESSE]=1,
	},
	resolvers.equip{
	full_id=true,
		{ name = "shortbow" },
		{ name = "arrows" },
	},
}

--Powerful charge 4d6
newEntity{ base = "BASE_NPC_MON_HUMANOID",
	define_as = "BASE_NPC_MINOTAUR",
	name = "minotaur",
	image = "tiles/minotaur.png",
	display = 'h', color=colors.BROWN,
	desc = [[A giant horned minotaur.]],
	stats = { str=19, dex=10, con=15, int=7, wis=10, cha=8, luc=12 },
	combat = { dam= {1,8} },

	level_range = {5, nil}, exp_worth = 1200,
	rarity = 10,
	max_life = resolvers.rngavg(35,40),
	hit_die = 6,
	challenge = 4,
	combat_natural = 5,
	skill_intimidate = 3,
	skill_listen = 7,
	skill_search = 4,
	skill_spot = 7,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1 },
	resolvers.equip{
	full_id=true,
		{ name = "greataxe" },
	},
}
