--Veins of the Earth
--Zireael 2014


newEntity{
	define_as = "BASE_NPC_ENCOUNTER",
	type = "encounter",
	rarity = 2,
	display = "!", color=colors.WHITE,
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "drow couple",
	challenge = 2,
	encounter_escort = {
	{ type="humanoid", name="drow", faction = "enemies", number=2},
  	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "drow ambush party",
	challenge = 3,
	encounter_escort = {
	{ type="humanoid", name="drow", faction = "enemies", number=3},
  	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "kobold band",
	challenge = 3,
	encounter_escort = {
	{ type="humanoid", name="kobold", number=3},
  	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "goblin band",
	challenge = 1,
	encounter_escort = {
	{ type="humanoid", name="goblin", number=3},
  	},
}

newEntity{ base = "BASE_NPC_ENCOUNTER",
	name = "mixed goblinoid warband",
	challenge = 2,
	encounter_escort = {
	{ type="humanoid", name="goblin", number=3},
	{ type="humanoid", name="orc warrior", number=1},
  	},
}