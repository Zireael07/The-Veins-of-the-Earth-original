--Veins of the Earth
--Zireael

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
    image = "tiles/longsword.png",
    display = "/", color=colors.SLATE,
    encumber = 6,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "A normal bastard sword, which can be wielded in one or two hands.\n\n Damage 1d10. Threat range 19-20.",
    name = "bastard sword",
    level_range = {1, 10},
--    cost = 35,
    cost = resolvers.value{silver=250},
    combat = {
        dam = {1,10},
        threat = 1,
    },
}

newEntity{ base = "BASE_EXOTIC",
    define_as = "BASE_WARAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/battleaxe.png",
    display = "/", color=colors.SLATE,
    encumber = 6,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "A normal dwarven waraxe.\n\n Damage 1d10. Critical x3.",
    name = "dwarven waraxe",
    level_range = {1, 10},
--    cost = 35,
    cost = resolvers.value{silver=300},
    combat = {
        dam = {1,10},
        critical = 3,
    },
}

--A reach weapon
newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_SPIKEDCHAIN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="flail",
    image = "tiles/spiked_chain.png",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    reach = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "A normal spiked chain.\n\n Damage 2d4.",
    name = "spiked chain",
    level_range = {1, 10},
--    cost = 25,
    cost = resolvers.value{silver=410},
    combat = {
        dam = {2,4},
    },
}


--Double weapons
newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_DAXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/newtiles/doubleaxe.png",
    display = "/", color=colors.SLATE,
    encumber = 15,
    rarity = 10,
    double = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An exotic orc double axe.\n\n Damage 1d8. Critical x3.",
    name = "orc double axe",
    level_range = {1, 10},
--    cost = 60,
    cost = resolvers.value{platinum=3},
    combat = {
        dam = {1,8},
        critical = 3,
    },
}

newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_DSWORD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sword",
    image = "tiles/newtiles/doublesword.png",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    double = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    
    desc = "An exotic double sword.\n\n Damage 1d8. Threat range 19-20.",
    name = "two-bladed sword",
    level_range = {1, 10},
--    cost = 100,
    cost = resolvers.value{silver=710},
    combat = {
        dam = {1,8},
        threat = 1,
    },
}


--1d8 one head, 1d6 the other
newEntity{ base = "BASE_EXOTIC_TWOHANDED",
    define_as = "BASE_URGROSH",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    image = "tiles/newtiles/urgrosh.png",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 12,
    double = true,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    desc = "An exotic dwarven urgrosh.\n\n Damage 1d8. Critical x3.",
    name = "dwarven urgrosh",
    level_range = {1, 10},
--    cost = 50,
    cost = resolvers.value{silver=500},
    combat = {
        dam = {1,8},
        critical = 3,
    },
}