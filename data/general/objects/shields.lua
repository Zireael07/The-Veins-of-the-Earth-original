--Shields
newEntity{
    define_as = "BASE_SHIELD",
    slot = "OFF_HAND",
    type = "armor", subtype="shield",
    display = ")", color=colors.SLATE,
    encumber = 5,
    rarity = 5,
    name = "shield",
    desc = [[A simple shield. Protects you from attacks. AC +1. Spell failure chance 5%.]],
    egos = "/data/general/objects/properties/shields.lua", egos_chance = { prefix=30, suffix=70},
    }

newEntity{ base = "BASE_SHIELD",
    name = "buckler",
    level_range = {1, 10},
    cost = 15,
    wielder = {
		combat_shield = 1,
        spell_fail = 5
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "buckler +1",
    unided_name = "buckler",
    identified = false,
    level_range = {1, 10},
    cost = 2015,
    wielder = {
        combat_shield = 2,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "buckler +2",
    unided_name = "buckler",
    identified = false,
    level_range = {1, 10},
    cost = 4015,
    wielder = {
        combat_shield = 3,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "buckler +3",
    unided_name = "buckler",
    identified = false,
    level_range = {1, 10},
    cost = 8015,
    wielder = {
        combat_shield = 4,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "buckler +4",
    unided_name = "buckler",
    identified = false,
    level_range = {1, 10},
    cost = 16015,
    wielder = {
        combat_shield = 5,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "buckler +5",
    unided_name = "buckler",
    identified = false,
    level_range = {1, 10},
    cost = 50015,
    wielder = {
        combat_shield = 6,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield",
    level_range = {1, 10},
    cost = 3,
    wielder = {
		combat_shield = 1,
        spell_fail = 5
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield +1",
    unided_name = "light wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 2003,
    wielder = {
        combat_shield = 2,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield +2",
    unided_name = "light wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 4003,
    wielder = {
        combat_shield = 3,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield +3",
    unided_name = "light wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 8003,
    wielder = {
        combat_shield = 4,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield +4",
    unided_name = "light wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 16003,
    wielder = {
        combat_shield = 5,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield +5",
    unided_name = "light wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 50003,
    wielder = {
        combat_shield = 6,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield",
    level_range = {1, 10},
    cost = 9,
    wielder = {
		combat_shield = 1,
        spell_fail = 5
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield +1",
    unided_name = "light steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 2009,
    wielder = {
        combat_shield = 2,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield +2",
    unided_name = "light steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 4009,
    wielder = {
        combat_shield = 3,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield +3",
    unided_name = "light steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 8009,
    wielder = {
        combat_shield = 4,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield +4",
    unided_name = "light steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 16009,
    wielder = {
        combat_shield = 5,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield +5",
    unided_name = "light steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 50009,
    wielder = {
        combat_shield = 6,
        spell_fail = 5
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield",
    level_range = {1, 10},
    cost = 7,
    encumber = 10,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
		combat_shield = 2,
        spell_fail = 15
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield +1",
    unided_name = "heavy wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 2007,
    encumber = 10,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 3,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield +2",
    unided_name = "heavy wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 4007,
    encumber = 10,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 4,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield +3",
    unided_name = "heavy wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 8007,
    encumber = 10,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 5,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield +4",
    unided_name = "heavy wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 16007,
    encumber = 10,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 6,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield +5",
    unided_name = "heavy wooden shield",
    identified = false,
    level_range = {1, 10},
    cost = 50007,
    encumber = 10,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 7,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield",
    level_range = {1, 10},
    cost = 20,
    encumber = 15,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
		combat_shield = 2,
        spell_fail = 15
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield +1",
    unided_name = "heavy steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 4020,
    encumber = 15,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 3,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield +2",
    unided_name = "heavy steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 8020,
    encumber = 15,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 4,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield +3",
    unided_name = "heavy steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 16020,
    encumber = 15,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 5,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield +4",
    unided_name = "heavy steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 32020,
    encumber = 15,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 6,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield +5",
    unided_name = "heavy steel shield",
    identified = false,
    level_range = {1, 10},
    cost = 50020,
    encumber = 15,
    desc = [[A simple shield. Protects you from attacks. AC +2. Spell failure chance 15%.]],
    wielder = {
        combat_shield = 7,
        spell_fail = 15
    },
}

newEntity{ base = "BASE_SHIELD",
    name = "tower shield",
    level_range = {1, 10},
    cost = 30,
    encumber = 45,
    desc = [[A simple shield. Protects you from attacks. AC +4. Spell failure chance 30%.]],
    wielder = {
		combat_shield = 4,
        spell_fail = 30
	},
}
