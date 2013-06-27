--Armors
newEntity{
    define_as = "BASE_LIGHT_ARMOR",
    slot = "BODY",
    type = "armor", subtype="light",
    display = "[", color=colors.BROWN,
    encumber = 10,
    rarity = 5,
    name = "light armor",
    desc = [[A simple padded armor. Doesn't protect from much.]],
    }

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor",
    level_range = {1, 10},
    cost = 5,
    wielder = {
		combat_def = 1
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor",
    level_range = {1, 10},
    cost = 10,
    wielder = {
		combat_def = 2
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    level_range = {1, 10},
    cost = 25,
    wielder = {
		combat_def = 3
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    level_range = {1, 10},
    cost = 2025,
    wielder = {
        combat_def = 4
    },
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt",
    level_range = {1, 10},
    cost = 100,
    wielder = {
		combat_def = 4
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt +1",
    level_range = {1, 10},
    cost = 2100,
    wielder = {
        combat_def = 5
    },
}

newEntity{
    define_as = "BASE_HEAVY_ARMOR",
    slot = "BODY",
    type = "armor", subtype="heavy",
    display = "[", color=colors.SLATE,
    encumber = 40,
    rarity = 2,
    name = "heavy armor",
    desc = [[A suit of armour made of mail.]],
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "chain mail",
    level_range = {1, 10},
    cost = 150,
    wielder = {
		combat_def = 5
	},
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "chain mail +1",
    level_range = {1, 10},
    cost = 2150,
    wielder = {
        combat_def = 6
    },
}