--Veins of the Earth
--2013-2016

local Talents = require "engine.interface.ActorTalents"

--Stuff that we're not modifying but needs to be explicitly set to zero to avoid getting OP
newEntity{ define_as = "BASE_EGO",
--	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,
	movement_speed = 0,
	combat_attackspeed = 0,
}

--Incursion's special templates
-- +2 Str -2 Cha
newEntity{ base = "BASE_EGO",
	name = "bandit ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	challenge = 2,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
	[Talents.T_MARTIAL_WEAPON_PROFICIENCY]=1,
	[Talents.T_LIGHT_ARMOR_PROFICIENCY]=1,
	[Talents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
}

--+2 Dex -2 Cha; Deft Opportunist, Expertise
newEntity{ base = "BASE_EGO",
    name = "outlaw ", prefix = true, instant_resolve = true,
    keywords = {special=true},
    level_range = {5, nil},
    rarity = 12,

    challenge = 1,
    hit_die = 1,
    resolvers.talents{ [Talents.T_DODGE]=1,
	[Talents.T_LIGHT_ARMOR_PROFICIENCY]=1,
	[Talents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
}

--+2 Dex -2 Cha; Endurance
newEntity{ base = "BASE_EGO",
    name = "brigand ", prefix = true, instant_resolve = true,
    keywords = {special=true},
    level_range = {5, nil},
    rarity = 15,

    challenge = 1,
    hit_die = 2,
    resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
	[Talents.T_LIGHT_ARMOR_PROFICIENCY]=1,
	[Talents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
}

--+4 Str +4 Con; doubled HD; magic items guaranteed
newEntity{ base = "BASE_EGO",
	name = "chieftain ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	challenge = 2,
	combat_attack = 2,
	resolvers.talents{ [Talents.T_POWER_ATTACK]=1,
	[Talents.T_CLEAVE]=1,
	},
}

--+4 Wis; potions, wands
newEntity{ base= "BASE_EGO",
    name = "shaman ", prefix = true, instant_resolve = true,
    keywords = {special=true},
	level_range = {5, nil},
	rarity = 8,

    challenge = 2,
    hit_die = 2,
    resolvers.talents{
        [Talents.T_COMBAT_CASTING]=1,
	},
}

--+1 to all attributes
newEntity{ base = "BASE_EGO",
	name = "skilled ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	hit_die = 1,
	combat_attack = 1,
	challenge = 1,
}

--+2 to all attributes
newEntity{ base = "BASE_EGO",
	name = "experienced ", prefix = true, instant_resolve = true,
	keywords = {special=true},
	level_range = {5, nil},
	rarity = 10,

	challenge = 2,
	combat_attack = 2,
}

--+2 Str +3 others
newEntity{ base = "BASE_EGO",
    name = "veteran ", prefix = true, instant_resolve = true,
    keywords = {special=true},
	level_range = {8, nil},
	rarity = 15,

    challenge = 4,
    combat_attack = 4,
    hit_die = 4,
}

--+2 Str +4 others
newEntity{ base = "BASE_EGO",
    name = "elite ", prefix = true, instant_resolve = true,
    keywords = {special=true},
	level_range = {10, nil},
	rarity = 20,

    challenge = 5,
    combat_attack = 6,
    hit_die = 8,
}

--+2 Str +4 others
newEntity{ base = "BASE_EGO",
    name = "master ", prefix = true, instant_resolve = true,
    keywords = {special=true},
	level_range = {15, nil},
	rarity = 25,

    challenge = 7,
    combat_attack = 8,
    hit_die = 12,
}

--+2 Str +4 others
newEntity{ base = "BASE_EGO",
    name = "paragon ", prefix = true, instant_resolve = true,
    keywords = {special=true},
	level_range = {18, nil},
	rarity = 30,

    challenge = 9,
    combat_attack = 10,
    hit_die = 15,
}

--+2 Str +4 others
newEntity{ base = "BASE_EGO",
    name = "legendary ", prefix = true, instant_resolve = true,
    keywords = {special=true},
	level_range = {18, nil},
	rarity = 40,

    challenge = 12,
    combat_attack = 14,
    hit_die = 20,
}
