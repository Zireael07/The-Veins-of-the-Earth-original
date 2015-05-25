--Veins of the Earth
--Zireael 2013-2015

newEntity{
	name = "masterwork ", prefix = true,
	keywords = {mwk=true},
	level_range = {1, nil},
	rarity = 2,
	cost = resolvers.value{silver=100},
	wielder = {
	--	combat_armor_ac = 1,
		armor_penalty = -1,
	}
}

newEntity {
	name = " +1", suffix = true,
	keywords = {bonus=true},
	level_range = {4, nil},
	rarity = 5,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "abjuration",
	wielder = {
		combat_magic_armor = 1,
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +2", suffix = true,
	keywords = {bonus=true},
	level_range = {8, nil},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "abjuration",
	wielder = {
		combat_magic_armor = 2,
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +3", suffix = true,
	keywords = {bonus=true},
	level_range = {12, nil},
	rarity = 18,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	wielder = {
		combat_magic_armor = 3,
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +4", suffix = true,
	keywords = {bonus=true},
	level_range = {14, nil},
	rarity = 10,
	greater_ego = 1,
	school = "abjuration",
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	wielder = {
		combat_magic_armor = 4,
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = " +5", suffix = true,
	keywords = {bonus=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 15,
	school = "abjuration",
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	wielder = {
		combat_magic_armor = 5,
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}
