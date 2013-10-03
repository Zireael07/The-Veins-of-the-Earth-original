--Shields
newEntity{
    define_as = "BASE_SHIELD",
    slot = "OFF_HAND",
    type = "armor", subtype="shield",
    display = ")", color=colors.SLATE,
    encumber = 5,
    rarity = 5,
    name = "shield",
    desc = "A simple shield. Protects you from attacks.\n\n AC +1. Spell failure chance 5%.",
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
    name = "light wooden shield",
    level_range = {1, 10},
    cost = 3,
    wielder = {
		combat_shield = 1,
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
    name = "heavy wooden shield",
    level_range = {1, 10},
    cost = 7,
    encumber = 10,
    desc = "A heavy shield. Protects you from attacks.\n\n AC +2. Spell failure chance 15%.",
    wielder = {
		combat_shield = 2,
        spell_fail = 15
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield",
    level_range = {1, 10},
    cost = 20,
    encumber = 15,
    desc = "A heavy shield. Protects you from attacks.\n\n AC +2. Spell failure chance 15%.",
    wielder = {
		combat_shield = 2,
        spell_fail = 15
	},
}


newEntity{ base = "BASE_SHIELD",
    name = "tower shield",
    level_range = {1, 10},
    cost = 30,
    encumber = 45,
    desc = "A heavy tower shield. Protects you from attacks.\n\n AC +4. Spell failure chance 30%.",
    egos_chance = { prefix=0, suffix=0},
    wielder = {
		combat_shield = 4,
        spell_fail = 30
	},
}
