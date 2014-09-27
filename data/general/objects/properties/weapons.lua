--Veins of the Earth
--Zireael

newEntity {
	name = " +1", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 1000,
	cost = resolvers.value{platinum=100},
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
	combat = {
	magic_bonus = 5,
	},
}

--Curses
newEntity {
	name = " -1", suffix = true,
	keywords = {cursed=true},
	level_range = {1, 10},
	rarity = 8,
	cursed = true,
	cost = 0,
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
	combat = {
	magic_bonus = -4,
	},
}
