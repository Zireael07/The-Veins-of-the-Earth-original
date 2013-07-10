--Shields
newEntity{
    define_as = "BASE_SHIELD",
    slot = "OFF_HAND",
    type = "armor", subtype="shield",
    display = ")", color=colors.SLATE,
    encumber = 5,
    rarity = 5,
    name = "shield",
    desc = [[A simple shield. Protects you from attacks.]],
    }

    newEntity{ base = "BASE_SHIELD",
    name = "buckler",
    level_range = {1, 10},
    cost = 15,
    wielder = {
		combat_def = 1
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield",
    level_range = {1, 10},
    cost = 3,
    wielder = {
		combat_def = 1
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "light steel shield",
    level_range = {1, 10},
    cost = 9,
    wielder = {
		combat_def = 1
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield",
    level_range = {1, 10},
    cost = 7,
    encumber = 10,
    wielder = {
		combat_def = 2
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield",
    level_range = {1, 10},
    cost = 20,
    encumber = 15,
    wielder = {
		combat_def = 2
	},
}

--Cannot cast spells
newEntity{ base = "BASE_SHIELD",
    name = "tower shield",
    level_range = {1, 10},
    cost = 30,
    encumber = 45,
    wielder = {
		combat_def = 4
	},
}
