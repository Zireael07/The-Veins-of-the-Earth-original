--Veins of the Earth
--Zireael 2013-2015

--Dummy to prevent all weapons being at least mwk
newEntity{
	name = "", addon = true,
	level_range = {1, nil},
	cost = 0,
	fake_ego = true,
	rarity = 1,
}

newEntity{
	name = "masterwork ", prefix = true, addon=true,
	keywords = {mwk=true},
	level_range = {1, nil},
	rarity = 2,
	fake_ego = true,
	cost = resolvers.value{silver=150},
	wielder = {
		armor_penalty = -1,
	}
}

newEntity {
	name = " +1", suffix = true, addon=true,
	keywords = {bonus=true},
	level_range = {4, nil},
	rarity = 5,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 1,
	},
}

newEntity {
	name = " +2", suffix = true, addon=true,
	keywords = {bonus=true},
	level_range = {8, nil},
	rarity = 8,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 2,
	},
}

newEntity {
	name = " +3", suffix = true, addon=true,
	keywords = {bonus=true},
	level_range = {12, nil},
	rarity = 18,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 3,
	},
}

newEntity {
	name = " +4", suffix = true, addon=true,
	keywords = {bonus=true},
	level_range = {14, nil},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 4,
	},
}

newEntity {
	name = " +5", suffix = true, addon=true,
	keywords = {bonus=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 15,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "abjuration",
	wielder = {
	combat_magic_shield = 5,
	},
}
