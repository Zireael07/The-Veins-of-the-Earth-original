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
	fake_ego = true,
	rarity = 5,
	cost = resolvers.value{silver=100},
	combat = {
		magic_bonus = 1,
	},
}

newEntity {
	name = " +1", suffix = true, addon=true,
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
	name = " +2", suffix = true, addon=true,
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
	name = " +3", suffix = true, addon=true,
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
	name = " +4", suffix = true, addon=true,
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
	name = " +5", suffix = true, addon=true,
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
