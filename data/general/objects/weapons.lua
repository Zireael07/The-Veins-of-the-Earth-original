newEntity{
    define_as = "BASE_BATTLEAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="battleaxe",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic battleaxe",
    desc = [[A normal battleaxe.]],
}

newEntity{ base = "BASE_BATTLEAXE",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,6},
    },
}

newEntity{
    define_as = "BASE_SWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic sword",
    desc = [[A trusty sword.]],
}

newEntity{ base = "BASE_SWORD",
    name = "long sword",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_DAGGER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="dagger",
    display = "/", color=colors.SLATE,
    encumber = 3,
    rarity = 8,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dagger",
    desc = [[A normal trusty dagger.]],
}

newEntity{ base = "BASE_DAGGER",
    name = "iron dagger",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,4},
    },
}

newEntity{
    define_as = "BASE_SPEAR",
    slot = "MAIN_HAND", 
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="spear",
    display = "/", color=colors.BROWN,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic spear",
    desc = [[A wooden spear.]],
}

newEntity{ base = "BASE_SPEAR",
    name = "spear",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_MACE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="mace",
    display = "/", color=colors.SLATE,
    encumber = 8,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic mace",
    desc = [[A metal mace.]],
}

newEntity{ base = "BASE_MACE",
    name = "heavy mace",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_STAFF",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="staff",
    display = "/", color=colors.BROWN,
    encumber = 4,
    rarity = 2,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic staff",
    desc = [[A wooden staff.]],
}

newEntity{ base = "BASE_STAFF",
    name = "quarterstaff",
    level_range = {1, 10},
    cost = 0,
    combat = {
        dam = {1,6},
    },
}