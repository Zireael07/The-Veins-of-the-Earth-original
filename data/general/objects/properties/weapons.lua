--Veins of the Earth
--Zireael

newEntity {
	name = " +1", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "evocation",
	combat = {
	magic_bonus = 1,
	},
}

newEntity {
	name = " +2", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
	magic_bonus = 2,
	},
}

newEntity {
	name = " +3", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "evocation",
	combat = {
	magic_bonus = 3,
	},
}

newEntity {
	name = " +4", suffix = true,
	keywords = {bonus=true},
	level_range = {10, 20},
	rarity = 10,
	greater_ego = 1,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "evocation",
	combat = {
	magic_bonus = 4,
	},
}

newEntity {
	name = " +5", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 15,
	greater_ego = 1,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "evocation",
	combat = {
	magic_bonus = 5,
	},
}

--Banes
--Humanoid banes
newEntity{
	name = "human bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_human = true,
	}
}

newEntity{
	name = "dwarf bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_dwarf = true,
	}
}

newEntity{
	name = "elf bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_elf = true,
	}
}

newEntity{
	name = "drow bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_drow = true,
	}
}

newEntity{
	name = "gnome bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 25,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_gnome = true,
	}
}

newEntity{
	name = "halfling bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 25,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_halfling = true,
	}
}

newEntity{
	name = "aquatic humanoids bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_humanoid_aquatic = true,
	}
}

newEntity{
	name = "gnoll bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_gnoll = true,
	}
}

newEntity{
	name = "goblinoid bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_goblinoid = true,
	}
}

newEntity{
	name = "reptilian bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_reptilian = true,
	}
}

newEntity{
	name = "orc bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_orc = true,
	}
}

--Monster type banes
newEntity{
	name = "aberration bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_aberration = true,
	}
}

newEntity{
	name = "animal bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_animal = true,
	}
}

newEntity{
	name = "construct bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_construct = true,
	}
}

newEntity{
	name = "dragon bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 20,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_dragon = true,
	}
}

newEntity{
	name = "fey bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_fey = true,
	}
}

newEntity{
	name = "giant bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_giant = true,
	}
}

newEntity{
	name = "magical beast bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_magical_beast = true,
	}
}

newEntity{
	name = "monstrous humanoid bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_monstrous_humanoid = true,
	}
}

newEntity{
	name = "ooze bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_ooze = true,
	}
}

newEntity{
	name = "plant bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_plant = true,
	}
}

newEntity{
	name = "undead bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_undead = true,
	}
}

newEntity{
	name = "vermin bane ", prefix = true,
	keywords = {bane=true},
	level_range = {1, 10},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_vermin = true,
	}
}

--Curses
newEntity {
	name = " -1", suffix = true,
	keywords = {cursed=true},
	level_range = {1, 10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "evocation",
	combat = {
	magic_bonus = -1,
	},
}

newEntity {
	name = " -2", suffix = true,
	keywords = {cursed=true},
	level_range = {1, 10},
	rarity = 10,
	cursed = true,
	cost = 0,
	school = "evocation",
	combat = {
	magic_bonus = -2,
	},
}

newEntity {
	name = " -3", suffix = true,
	keywords = {cursed=true},
	level_range = {1, 10},
	rarity = 14,
	cursed = true,
	cost = 0,
	school = "evocation",
	combat = {
	magic_bonus = -3,
	},
}

newEntity {
	name = " -4", suffix = true,
	keywords = {cursed=true},
	level_range = {10, 20},
	rarity = 18,
	cursed = true,
	cost = 0,
	school = "evocation",
	combat = {
	magic_bonus = -4,
	},
}
