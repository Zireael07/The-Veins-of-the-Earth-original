--Veins of the Earth
--Zireael

--Exotic melee weapons
newEntity{
    define_as = "BASE_BASTARDSWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "/", color=colors.SLATE,
    encumber = 6,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic bastard sword",
    desc = [[A normal bastard sword, which can be wielded in one or two hands. Damage 1d10. Threat range 19-20.]],
}

newEntity{ base = "BASE_BASTARDSWORD",
    name = "bastard sword",
    level_range = {1, 10},
    cost = 35,
    combat = {
        dam = {1,10},
        threat = 1,
    },
}

newEntity{
    define_as = "BASE_WARAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="axe",
    display = "/", color=colors.SLATE,
    encumber = 6,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dwarven waraxe",
    desc = [[A normal dwarven waraxe. Damage 1d10. Critical x3.]],
}

newEntity{ base = "BASE_WARAXE",
    name = "dwarven waraxe",
    level_range = {1, 10},
    cost = 35,
    combat = {
        dam = {1,10},
        critical = 3,
    },
}

newEntity{
    define_as = "BASE_SPIKEDCHAIN",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="flail",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic spiked chain",
    desc = [[A normal spiked chain. Damage 2d4.]],
}
--Range weapon
newEntity{ base = "BASE_SPIKEDCHAIN",
    name = "spiked chain",
    level_range = {1, 10},
    cost = 25,
    combat = {
        dam = {2,4},
    },
}


--Double weapons
newEntity{
    define_as = "BASE_DAXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    display = "/", color=colors.SLATE,
    encumber = 15,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic orc double axe",
    desc = [[A normal orc double axe. Damage 1d8. Critical x3.]],
}

newEntity{ base = "BASE_DAXE",
    name = "orc double axe",
    level_range = {1, 10},
    cost = 60,
    combat = {
        dam = {1,8},
        critical = 3,
    },
}

newEntity{
    define_as = "BASE_DSWORD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 10,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic double sword",
    desc = [[A normal double sword. Damage 1d8. Threat range 19-20.]],
}

newEntity{ base = "BASE_DSWORD",
    name = "two-bladed sword",
    level_range = {1, 10},
    cost = 100,
    combat = {
        dam = {1,8},
        threat = 1,
    },
}

--1d8 one head, 1d6 the other
newEntity{
    define_as = "BASE_URGROSH",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="axe",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 12,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dwarven urgrosh",
    desc = [[A normal dwarven urgrosh. Damage 1d8. Critical x3.]],
}

newEntity{ base = "BASE_URGROSH",
    name = "dwarven urgrosh",
    level_range = {1, 10},
    cost = 50,
    combat = {
        dam = {1,8},
        critical = 3,
    },
}