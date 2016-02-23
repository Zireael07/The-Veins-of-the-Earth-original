--Veins of the Earth
--2013-2016

local Talents = require "engine.interface.ActorTalents"

--Stuff that we're not modifying but needs to be explicitly set to zero to avoid getting OP
newEntity{ define_as = "BASE_EGO",
	max_life = 0,
	stats = { str = 0, dex = 0, con = 0, int = 0, wis = 0, cha = 0},
	defense = 0,
	size = 0,
	life_rating = 0,
	movement_speed = 0,
	combat_attackspeed = 0,
}

--Incursion's special templates
-- +2 Str
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

--+4 Str +4 Con
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
