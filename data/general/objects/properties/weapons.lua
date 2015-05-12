--Veins of the Earth
--Zireael 2013-2015

local DamageType = require "engine.DamageType"

newEntity {
	name = " +1", suffix = true,
	keywords = {bonus=true},
	level_range = {5, nil},
	rarity = 8,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "evocation",
	combat = {
	magic_bonus = 1,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +2", suffix = true,
	keywords = {bonus=true},
	level_range = {11, nil},
	rarity = 28,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
	magic_bonus = 2,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +3", suffix = true,
	keywords = {bonus=true},
	level_range = {14, nil},
	rarity = 25,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "evocation",
	combat = {
	magic_bonus = 3,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +4", suffix = true,
	keywords = {bonus=true},
	level_range = {16, nil},
	rarity = 30,
	greater_ego = 1,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "evocation",
	combat = {
	magic_bonus = 4,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +5", suffix = true,
	keywords = {bonus=true},
	level_range = {18, nil},
	rarity = 45,
	greater_ego = 1,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "evocation",
	combat = {
	magic_bonus = 5,
	},
	resolvers.creation_cost(),
}

--Elemental
newEntity{
	name = "flaming ", prefix = true,
	keywords = { flame=true},
	level_range = {11, nil},
	rarity = 5,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.FIRE] = {1, 6}
		},
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "frost ", prefix = true,
	keywords = { frost=true},
	level_range = {11, nil},
	rarity = 5,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.COLD] = {1, 6}
		},
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "shock ", prefix = true,
	keywords = { shock=true},
	level_range = {11, nil},
	rarity = 8,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.SONIC] = {1, 6}
		},
	},
	resolvers.creation_cost(),
}

--Elemental burst
newEntity{
	name = "flaming burst", prefix = true,
	keywords = { flame=true},
	level_range = {11, nil},
	rarity = 15,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.FIRE] = {1, 6}
		},
		melee_project_on_crit = {
			[DamageType.FIRE] = resolvers.burstdamage()
		},
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "icy burst", prefix = true,
	keywords = { icy=true},
	level_range = {11, nil},
	rarity = 15,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.COLD] = {1, 6}
		},
		melee_project_on_crit = {
			[DamageType.COLD] = resolvers.burstdamage()
		},
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "shocking burst", prefix = true,
	keywords = { shocking=true},
	level_range = {11, nil},
	rarity = 15,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.ELECTRIC] = {1, 6}
		},
		melee_project_on_crit = {
			[DamageType.ELECTRIC] = resolvers.burstdamage()
		},
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "thundering", prefix = true,
	keywords = { thunder=true},
	level_range = {11, nil},
	rarity = 15,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		melee_project={
			[DamageType.SONIC] = {1, 6}
		},
		melee_project_on_crit = {
			[DamageType.SONIC] = resolvers.burstdamage()
		},
	},
	resolvers.creation_cost(),
}

--Aligned
newEntity{
	name = "anarchic ", prefix = true,
	keywords = {aligned=true},
	level_range = {11, nil},
	rarity = 10,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		aligned_anarchic = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "axiomatic ", prefix = true,
	keywords = {aligned=true},
	level_range = {11, nil},
	rarity = 15,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		aligned_axiomatic = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "holy ", prefix = true,
	keywords = {aligned=true},
	level_range = {1, 10},
	rarity = 15,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		aligned_holy = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "unholy ", prefix = true,
	keywords = {aligned=true},
	level_range = {11, nil},
	rarity = 5,
	cost = resolvers.value{platinum=800},
	school = "evocation",
	combat = {
		aligned_unholy = true,
	},
	resolvers.creation_cost(),
}

--Banes
--Humanoid banes
newEntity{
	name = "human bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_human = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "dwarf bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_dwarf = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "elf bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_elf = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "drow bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_drow = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "gnome bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
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
	level_range = {6, nil},
	rarity = 25,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_halfling = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "aquatic humanoids bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_humanoid_aquatic = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "gnoll bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_gnoll = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "goblinoid bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_goblinoid = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "reptilian bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_reptilian = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "orc bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 15,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_orc = true,
	},
	resolvers.creation_cost(),
}

--Monster type banes
newEntity{
	name = "aberration bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_aberration = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "animal bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_animal = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "construct bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 20,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_construct = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "dragon bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 30,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_dragon = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "fey bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 18,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_fey = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "giant bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_giant = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "magical beast bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_magical_beast = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "monstrous humanoid bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_monstrous_humanoid = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "ooze bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_ooze = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "plant bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 18,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_plant = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "undead bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_undead = true,
	},
	resolvers.creation_cost(),
}

newEntity{
	name = "vermin bane ", prefix = true,
	keywords = {bane=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	combat = {
		bane_vermin = true,
	},
	resolvers.creation_cost(),
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
	level_range = {5, 10},
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
