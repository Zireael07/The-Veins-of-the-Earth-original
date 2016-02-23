--Veins of the Earth
--Zireael 2013-2016

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

newEntity{ base = "BASE_EGO",
    name = "very young ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 10,

    challenge = 2,
    hit_die = 3,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {1,6} },
}

newEntity{ base = "BASE_EGO",
    name = "young ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 10,

    challenge = 3,
    hit_die = 6,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {1,8} },
}

--Rend
newEntity{ base = "BASE_EGO",
    name = "juvenile ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 10,

    challenge = 4,
    hit_die = 9,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {1,8} },
}

--NOTE: From here onwards, adult images
--frightful presence DC 21; Rend
newEntity{ base = "BASE_EGO",
    name = "young adult ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 10,

    challenge = 6,
    hit_die = 12,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,6} },
}

--frightful presence DC 24; Rend
newEntity{ base = "BASE_EGO",
    name = "adult ", prefix = true, instant_resolve = true,
    level_range = {5, nil},
	rarity = 10,

    challenge = 8,
    hit_die = 15,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}

--NOTE: logical consequence of Inc's templates
--frightful presence DC 26; Rend
newEntity{ base = "BASE_EGO",
    name = "mature adult ", prefix = true, instant_resolve = true,
    level_range = {10, nil},
	rarity = 15,

    challenge = 10,
    hit_die = 18,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}

--frightful presence DC 29; Rend
newEntity{ base = "BASE_EGO",
    name = "old ", prefix = true, instant_resolve = true,
    level_range = {10, nil},
	rarity = 15,

    challenge = 12,
    hit_die = 21,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}

--frightful presence DC 31; Rend
newEntity{ base = "BASE_EGO",
    name = "very old ", prefix = true, instant_resolve = true,
    level_range = {15, nil},
	rarity = 20,

    challenge = 14,
    hit_die = 24,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}

--frightful presence DC 34; Rend
newEntity{ base = "BASE_EGO",
    name = "ancient ", prefix = true, instant_resolve = true,
    level_range = {15, nil},
	rarity = 25,

    challenge = 16,
    hit_die = 27,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}

--frightful presence DC 35; Rend
newEntity{ base = "BASE_EGO",
    name = "wyrm ", prefix = true, instant_resolve = true,
    level_range = {15, nil},
	rarity = 30,

    challenge = 20,
    hit_die = 30,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}

--frightful presence DC 38; Rend
newEntity{ base = "BASE_EGO",
    name = "great wyrm ", prefix = true, instant_resolve = true,
    level_range = {15, nil},
	rarity = 10,

    challenge = 22,
    hit_die = 33,
    resolvers.talents{
        [Talents.T_POWER_ATTACK]=1,
	},
    combat = { dam= {2,8} },
}
