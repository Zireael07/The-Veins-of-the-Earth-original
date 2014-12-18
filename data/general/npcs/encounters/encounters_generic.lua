--Veins of the Earth
-- Zireael 2014

newEntity{
	define_as = "BASE_NPC_ENCOUNTER",
	type = "encounter",
	level_range = {1, 4},
	display = "!", color=colors.WHITE,
}

--Typed generic encounters
newEntity{
    base = "BASE_NPC_ENCOUNTER",
    name = "mixed vermin 1/4",
    challenge = 1,
    rarity = 1,
    encounter_escort = {
    { challenge = 1/4, type="vermin", number = 4 },
    }
}

newEntity{
	base = "BASE_NPC_ENCOUNTER",
	name = "mixed vermin 1/2",
	challenge = 1,
	rarity = 2,
	encounter_escort = {
    { challenge = 1/2, type="vermin", number = 2 },
    }
}

newEntity{
	base = "BASE_NPC_ENCOUNTER",
	name = "more mixed vermin 1/2",
	challenge = 2,
	rarity = 3,
	encounter_escort = {
    { challenge = 1/2, type="vermin", number = 4 },
    }
}

--Totally generic encounters
newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 1/3 monster",
	challenge = 1,
	rarity = 2,
	encounter_escort = {
	{ challenge = 1/3, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 1/2 monster",
	challenge = 1,
	rarity = 2,
	encounter_escort = {
	{ challenge = 1/2, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 1/4 monster",
	challenge = 1,
	rarity = 2,
	encounter_escort = {
	{ challenge = 1/4, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 1 monster",
	challenge = 1,
	rarity = 2,
	encounter_escort = {
	{ challenge = 1, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 2 monster",
	challenge = 2,
	rarity = 2,
	encounter_escort = {
	{ challenge = 2, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 3 monster",
	challenge = 3,
	rarity = 6,
	encounter_escort = {
	{ challenge = 3, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 4 monster",
	challenge = 4,
	rarity = 8,
	encounter_escort = {
	{ challenge = 4, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 5 monster",
	challenge = 5,
	rarity = 10,
	encounter_escort = {
	{ challenge = 5, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 6 monster",
	challenge = 6,
	rarity = 12,
	encounter_escort = {
	{ challenge = 6, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 7 monster",
	challenge = 7,
	rarity = 15,
	encounter_escort = {
	{ challenge = 7, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 8 monster",
	challenge = 8,
	rarity = 18,
	encounter_escort = {
	{ challenge = 8, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 9 monster",
	challenge = 9,
	rarity = 20,
	encounter_escort = {
	{ challenge = 9, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "random CR 10 monster",
	challenge = 10,
	rarity = 25,
	encounter_escort = {
	{ challenge = 10, number = 1 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "2 random CR 1 monsters",
	challenge = 2,
	rarity = 5,
	encounter_escort = {
	{ challenge = 1, number = 2 },
	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "3 random CR 1 monsters",
	challenge = 3,
	rarity = 5,
	encounter_escort = {
	{ challenge = 1, number = 3 },
	},
}