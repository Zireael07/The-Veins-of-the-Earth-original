local Talents = require "engine.interface.ActorTalents"

--Shields
newEntity{
    define_as = "BASE_SHIELD",
    slot = "OFF_HAND",
    type = "armor", subtype="shield",
    display = ")", color=colors.SLATE,
    require = { talent = { Talents.T_SHIELD_PROFICIENCY }, },
    moddable_tile = resolvers.moddable_tile("shield"),
    encumber = 5,
    name = "shield",
    desc = "A simple shield. Protects you from attacks.\n\n AC +1. Spell failure chance 5%.",
    egos = "/data/general/objects/properties/shields.lua", egos_chance = { prefix=30, suffix=70},
    }

newEntity{ base = "BASE_SHIELD",
    name = "buckler",
    image = "tiles/shield_buckler.png",
    rarity = 5,
    level_range = {1, 10},
--    cost = 15,
    cost = resolvers.value{silver=50},
    wielder = {
		combat_shield = 1,
        spell_fail = 5
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "light wooden shield",
    image = "tiles/shield_medium.png",
    rarity = 6,
    level_range = {1, 10},
--    cost = 3,
    cost = resolvers.value{silver=150},
    wielder = {
		combat_shield = 1,
        spell_fail = 5
	},
}


newEntity{ base = "BASE_SHIELD",
    name = "light steel shield",
    image = "tiles/shield_medium.png",
    rarity = 4,
    level_range = {1, 10},
--    cost = 9,
    cost = resolvers.value{silver=175},
    wielder = {
		combat_shield = 1,
        spell_fail = 5
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy wooden shield",
    image = "tiles/shield_medium.png",
    rarity = 8,
    level_range = {1, 10},
--    cost = 7,
    cost = resolvers.value{silver=300},
    encumber = 10,
    desc = "A heavy shield. Protects you from attacks.\n\n AC +2. Spell failure chance 15%.",
    wielder = {
		combat_shield = 2,
        spell_fail = 15
	},
}

newEntity{ base = "BASE_SHIELD",
    name = "heavy steel shield",
    image = "tiles/shield_medium.png",
    rarity = 10,
    level_range = {1, 10},
--    cost = 20,
    cost = resolvers.value{silver=450},
    encumber = 15,
    desc = "A heavy shield. Protects you from attacks.\n\n AC +2. Spell failure chance 15%.",
    wielder = {
		combat_shield = 2,
        spell_fail = 15
	},
}


newEntity{ base = "BASE_SHIELD",
    name = "tower shield",
    image = "tiles/shield_tower.png",
    rarity = 20,
    level_range = {1, 10},
    cost = resolvers.value{silver=580},
--    cost = 30,
    encumber = 45,
    desc = "A heavy tower shield. Protects you from attacks.\n\n AC +4. Spell failure chance 30%.",
    egos_chance = { prefix=0, suffix=0},
    wielder = {
		combat_shield = 4,
        spell_fail = 30
	},
}
