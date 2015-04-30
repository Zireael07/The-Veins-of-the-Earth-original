--Veins of the Earth
--Zireael 2013-2015

local Talents = require("engine.interface.ActorTalents")

local plant_desc = [[It is immune to mind-affecting effects such as charms, compulsions, phantasms. It is immune to critical hits, poison, sleep effects, paralysis, polymorph and stunning. It breathes and eats, but does not sleep.]]

newEntity{
	define_as = "BASE_NPC_PLANT",
	type = "plant",
	body = { INVEN = 10 },
	ai = "animal_level", ai_state = { talent_in=3, },
	combat = { dam= {1,6} },
	resolvers.wounds()
}


--Constrict, entangle; camouflage, immunity to electricity
newEntity{ base = "BASE_NPC_PLANT",
	define_as = "BASE_NPC_ASSAVINE",
	display = 'P', color=colors.DARK_GREEN,
	desc = [[A crawling vine.]],
	specialist_desc = [[Though lacking visual organs, assassin vines can detect nearby foes by sound, scent and vibration. As they look like normal plants when at rest, they can be difficult to spot before they attack. Subterranean versions of these creatures are known to exist, looking much like mineral deposits to the untrained eye.]],
	uncommon_desc = [[Perhaps the most dangerous aspect of the assassin vine is its ability to animate all nearby plants. These plants entangle and trap victims within their range, allowing the assassin vine the luxury of finishing off one foe before having to deal with others. These creatures are also very resilient to extremes of temperature.]],
	common_desc = [[Though unable to move at any great speed, these plants have a large reach and are dangerous enemies. As well as being capable of dealing nasty blows with the trunk of their vine, the construction of these vines allow them to grab and strangle their victims with ease.]],
	base_desc = "This creature is an assassin vine, a semimobile plant that collects its own grisly fertilizer."..plant_desc.."",

	stats = { str=20, dex=10, con=16, int=1, wis=13, cha=9, luc=10 },
	name = "assasin vine",
	level_range = {5, 15}, exp_worth = 900,
	rarity = 20,
	max_life = resolvers.rngavg(28,32),
	hit_die = 4,
	challenge = 3,
	combat_natural = 6,
--	movement_speed_bonus = -0.88,
	movement_speed = 0.22,
	resists = {
        [DamageType.FIRE] = 10,
        [DamageType.COLD] = 10,
    },
}

newEntity{ base = "BASE_NPC_PLANT",
	define_as = "BASE_NPC_FUNGI",
	display = 'F', color=colors.WHITE,
	stats = { str=1, dex=1, con=13, int=1, wis=2, cha=1, luc=10 },
	level_range = {1, nil}, exp_worth = 900,
	combat_natural = 4,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	alignment = "Neutral",
}

--Shriek 1d3 rounds;
newEntity{ base = "BASE_NPC_FUNGI",
	define_as = "BASE_NPC_SHRIEKER",
	image = "tiles/shrieker.png",
	color=colors.DARK_BLUE,
	desc = [[A purple fungus.]],
	name = "shrieker",
	rarity = 8,
	exp_worth = 400,
	max_life = resolvers.rngavg(10,15),
	hit_die = 2,
	challenge = 1,
	combat_natural = 3,
--	movement_speed_bonus = -0.66,
	movement_speed = 0.33,
	alignment = "Neutral",
	--Immobile!!!
	never_move_but_attack = 1,
}

--Poison 1d4 STR & 1d4 CON pri & sec
newEntity{ base = "BASE_NPC_FUNGI",
	define_as = "BASE_NPC_VIOLET_FUNGI",
	image = "tiles/violet_fungi.png",
	display = 'F', color=colors.VIOLET,
	desc = [[A violet fungus.]],
	stats = { str=14, dex=8, con=16, int=1, wis=11, cha=9, luc=10 },
	name = "violet fungus",
	rarity = 10,
	max_life = resolvers.rngavg(15,20),
	hit_die = 2,
	challenge = 3,
	infravision = 1,
--	movement_speed_bonus = -0.66,
	movement_speed = 0.33,
	alignment = "Neutral",
}

--Constant greater invisibility
newEntity{ base = "BASE_NPC_FUNGI",
	define_as = "BASE_NPC_PHANTOM_FUNGI",
	image = "tiles/fungi_phantom.png",
	color=colors.VIOLET,
	desc = [[A greenish silhouette of a fungus.]],
	stats = { str=14, dex=10, con=16, int=2, wis=11, cha=9, luc=10 },
	name = "phantom fungus",
	rarity = 15,
	max_life = resolvers.rngavg(13,17),
	hit_die = 2,
	challenge = 3,
	infravision = 1,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	skill_listen = 4,
	skill_movesilently = 6,
	skill_spot = 4,
}

--Swim 20 ft.; improved grab, constrict 2d6, immunity to electricity; Weapon Focus
newEntity{ base = "BASE_NPC_PLANT",
	define_as = "BASE_NPC_SHAMBLING_MOUND",
	display = 'P', color=colors.UMBER,
	desc = [[A shambling mass of rotting vegetation.]],

	stats = { str=21, dex=10, con=17, int=7, wis=10, cha=9, luc=10 },
	combat = { dam= {2,6} },
	name = "shambling mound",
	level_range = {5, 15}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(58,62),
	hit_die = 8,
	challenge = 6,
	infravision = 4,
	combat_natural = 10,
	skill_hide = 3,
	skill_listen = 8,
	skill_movesilently = 8,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	alignment = "Neutral",
	resists = { [DamageType.FIRE] = 10 },
	resolvers.talents{ [Talents.T_IRON_WILL]=1,
--	[Talents.T_POWER_ATTACK]=1,
	},
	uncommon_desc = [[Shambling mounds become incredibly active during powerful thunderstorms and can survive direct strikes from lightning.]],
	common_desc = [[ Shambling mounds are immune to electricity and resistant to fire. They are virtually silent and invisible in their natural environment.]],
	base_desc = "This animated mound of vegetation is a shambling mound. "..plant_desc.."",
}

--Regeneration 10; improved grab, swallow whole
newEntity{ base = "BASE_NPC_PLANT",
	define_as = "BASE_NPC_TENDRICULOS",
	display = 'P', color=colors.VIOLET,
	desc = [[A shambling mass of rotting vegetation.]],

	stats = { str=28, dex=9, con=22, int=3, wis=8, cha=3, luc=10 },
	combat = { dam= {2,8} },
	name = "tendriculos",
	level_range = {5, nil}, exp_worth = 1800,
	rarity = 15,
	max_life = resolvers.rngavg(90,95),
	hit_die = 9,
	challenge = 6,
	infravision = 1,
	combat_natural = 7,
	skill_hide = 10,
	skill_listen = 2,
	skill_movesilently = 2,
	skill_spot = 2,
--	movement_speed_bonus = -0.33,
	movement_speed = 0.66,
	alignment = "Neutral",
	resolvers.talents{ [Talents.T_IRON_WILL]=1,
--	[Talents.T_POWER_ATTACK]=1,
	[Talents.T_ALERTNESS]=1,
	[Talents.T_STEALTHY]=1
	},
}
