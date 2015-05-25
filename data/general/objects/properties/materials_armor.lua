--Veins of the Earth
--Zireael 2013-2015

newEntity {
	name = "mithril ", prefix = true,
	keywords = {mithril=true},
	level_range = {4, nil},
	rarity = 20, --5% chance
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	wielder = {
		spell_fail = -10,
		max_dex_bonus = 2,
		armor_penalty = -3,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = "adamantine ", prefix = true,
	keywords = {adamantine=true},
	level_range = {4, nil},
	rarity = 20, --5% chance
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	wielder = {
		combat_dr = 1,
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}

newEntity {
	name = "dragonhide ", prefix = true,
	keywords = {dragonhide=true},
	level_range = {10, nil},
	rarity = 35,
--	cost = 3500,
	cost = resolvers.value{platinum=350},
	wielder = {
		resists = {
		[DamageType.FIRE] = 20,
	},
		armor_penalty = -1,
	},
	resolvers.creation_cost(),
}
