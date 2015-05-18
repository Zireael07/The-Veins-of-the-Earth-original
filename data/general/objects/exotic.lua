--Veins of the Earth
--Zireael 2013-2015

local Talents = require "engine.interface.ActorTalents"

--Exotic melee weapons
newEntity {
    define_as = "BASE_EXOTIC",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon",
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}

newEntity{
    define_as = "BASE_EXOTIC_TWOHANDED",
    slot = "MAIN_HAND", slot_forbid = "OFF_HAND",
    type = "weapon",
    exotic = true,
    require = { talent = { Talents.T_EXOTIC_WEAPON_PROFICIENCY }, },
    egos = "/data/general/objects/properties/weapons.lua", egos_chance = { prefix=30, suffix=70},
}


newEntity{ base = "BASE_EXOTIC",
    define_as = "BASE_BASTARDSWORD",
    type = "weapon", subtype="sword",
    image = "tiles/object/longsword.png",
    display = "/", color=colors.SLATE,
    encumber = 6,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "A normal bastard sword, which can be wielded in one or two hands.\n\n",
    name = "bastard sword",
    level_range = {1, 10},
--    cost = 35,
    cost = resolvers.value{silver=250},
    combat = {
        dam = {1,10},
        threat = 1,
    },
    wielder = {
        combat_parry = 3,
    },
}

newEntity{ base = "BASE_EXOTIC",
    define_as = "BASE_WARAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/object/battleaxe.png",
    display = "/", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("axe"),
    encumber = 6,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "A normal dwarven waraxe.\n\n",
    name = "dwarven waraxe",
    level_range = {1, 10},
--    cost = 35,
    cost = resolvers.value{silver=300},
    combat = {
        dam = {1,10},
        critical = 3,
    },
    wielder = {
        combat_parry = 2,
    },
}

--A reach weapon
newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_SPIKEDCHAIN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="flail",
    image = "tiles/object/spiked_chain.png",
    display = "/", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("spiked_chain"),
    encumber = 10,
    rarity = 10,
    reach = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = [[A length of chain studded with large, wicked blades, the spiked chain is exceedingly lethal -- both to its victims and to anyone who has not mastered its use fully.]],
    name = "spiked chain",
    level_range = {1, 10},
--    cost = 25,
    cost = resolvers.value{silver=410},
    combat = {
        dam = {2,4},
    },
    wielder = {
        combat_parry = 7,
    },
}


--Double weapons
newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_DAXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/new/doubleaxe.png",
    display = "/", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("double_axe"),
    encumber = 15,
    rarity = 10,
    double = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An exotic orc double axe.\n\n",
    name = "orc double axe",
    level_range = {1, 10},
--    cost = 60,
    cost = resolvers.value{platinum=3},
    combat = {
        dam = {1,8},
        critical = 3,
    },
    wielder = {
        combat_parry = 3,
    },
}

newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_DSWORD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sword",
    image = "tiles/new/doublesword.png",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    double = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },

    desc = "An exotic double sword.\n\n",
    name = "two-bladed sword",
    level_range = {1, 10},
--    cost = 100,
    cost = resolvers.value{silver=710},
    combat = {
        dam = {1,8},
        threat = 1,
    },
    wielder = {
        combat_parry = 4,
    },
}


--1d8 one head, 1d6 the other
newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_URGROSH",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/new/urgrosh.png",
    display = "/", color=colors.SLATE,
    moddable_tile = resolvers.moddable_tile("double_axe"),
    encumber = 12,
    rarity = 12,
    double = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An exotic dwarven urgrosh.\n\n",
    name = "dwarven urgrosh",
    level_range = {1, 10},
--    cost = 50,
    cost = resolvers.value{silver=500},
    combat = {
        dam = {1,8},
        critical = 3,
    },
}
