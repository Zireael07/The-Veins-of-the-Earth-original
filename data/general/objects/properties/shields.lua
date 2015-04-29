--Veins of the Earth
--Zireael 2013-2015

local DamageType = require "engine.DamageType"

newEntity {
	name = " +1", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 1,
	},
}

newEntity {
	name = " +2", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 2,
	},
}

newEntity {
	name = " +3", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	wielder = {
		combat_magic_shield = 3,
	},
}

newEntity {
	name = " +4", suffix = true,
	keywords = {bonus=true},
	level_range = {10, 20},
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
	name = " +5", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	greater_ego = 1,
	rarity = 15,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "abjuration",
	wielder = {
	combat_magic_shield = 5,
	},
}



newEntity {
	name = "mithril ", prefix = true,
	keywords = {mithril=true},
	level_range = {5, nil},
	rarity = 20, --5% chance
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	wielder = {
		spell_fail = -10,
		max_dex_bonus = 2,
		armor_penalty = -3,
	}
}

newEntity {
	name = "adamantine ", prefix = true,
	keywords = {adamantine=true},
	level_range = {10, nil},
	rarity = 20, --5% chance
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	wielder = {
		combat_dr = 1,
		armor_penalty = -1,
	}
}

newEntity {
	name = "dragonhide ", prefix = true,
	keywords = {dragonhide=true},
	level_range = {20, nil},
	rarity = 35,
	greater_ego = 1,
--	cost = 3500,
	cost = resolvers.value{platinum=350},
	wielder = {
		resists = {
		[DamageType.FIRE] = 20,
	},
		armor_penalty = -1,
	}
}

--Resistances
newEntity {
	name = " of fire resistance", suffix = true,
	keywords = {fireres=true},
	level_range = {10, nil},
	rarity = 10,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.FIRE] = 10,
	},
	}
}

newEntity {
	name = " of improved fire resistance", suffix = true,
	keywords = {fireres=true},
	level_range = {15, nil},
	rarity = 15,
	greater_ego = 1,
--	cost = 42000,
	cost = resolvers.value{platinum=4200},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.FIRE] = 20,
	},
	}
}

newEntity {
	name = " of greater fire resistance", suffix = true,
	keywords = {fireres=true},
	level_range = {18, nil},
	rarity = 20,
	greater_ego = 1,
--	cost = 66000,
	cost = resolvers.value{platinum=6600},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.FIRE] = 30,
	},
	}
}


newEntity {
	name = " of acid resistance", suffix = true,
	keywords = {acidres=true},
	level_range = {10, nil},
	rarity = 10,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.ACID] = 10,
	},
	}
}

newEntity {
	name = " of improved acid resistance", suffix = true,
	keywords = {acidres=true},
	level_range = {15, nil},
	rarity = 15,
	greater_ego = 1,
--	cost = 42000,
	cost = resolvers.value{platinum=4200},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.ACID] = 20,
	},
	}
}

newEntity {
	name = " of greater acid resistance", suffix = true,
	keywords = {acidres=true},
	level_range = {18, nil},
	rarity = 20,
	greater_ego = 1,
--	cost = 66000,
	cost = resolvers.value{platinum=6600},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.ACID] = 30,
	},
	}
}

newEntity {
	name = " of cold resistance", suffix = true,
	keywords = {coldres=true},
	level_range = {10, nil},
	rarity = 10,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.COLD] = 10,
	},
	}
}

newEntity {
	name = " of improved cold resistance", suffix = true,
	keywords = {coldres=true},
	level_range = {15, nil},
	rarity = 15,
	greater_ego = 1,
--	cost = 42000,
	cost = resolvers.value{platinum=4200},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.COLD] = 20,
	},
	}
}

newEntity {
	name = " of greater cold resistance", suffix = true,
	keywords = {coldres=true},
	level_range = {18, nil},
	rarity = 20,
	greater_ego = 1,
--	cost = 66000,
	cost = resolvers.value{platinum=6600},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.COLD] = 30,
	},
	}
}

newEntity {
	name = " of electricity resistance", suffix = true,
	keywords = {electres=true},
	level_range = {10, nil},
	rarity = 10,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.ELECTRIC] = 10,
	},
	}
}

newEntity {
	name = " of improved electricity resistance", suffix = true,
	keywords = {electres=true},
	level_range = {15, nil},
	rarity = 15,
	greater_ego = 1,
--	cost = 42000,
	cost = resolvers.value{platinum=4200},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.ELECTRIC] = 20,
	},
	}
}

newEntity {
	name = " of greater electricity resistance", suffix = true,
	keywords = {electres=true},
	level_range = {18, nil},
	rarity = 20,
	greater_ego = 1,
--	cost = 66000,
	cost = resolvers.value{platinum=6600},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.ELECTRIC] = 30,
	},
	}
}

newEntity {
	name = " of sonic resistance", suffix = true,
	keywords = {sonicres=true},
	level_range = {10, nil},
	rarity = 10,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.SONIC] = 10,
	},
	}
}

newEntity {
	name = " of improved sonic resistance", suffix = true,
	keywords = {sonicres=true},
	level_range = {15, nil},
	rarity = 15,
	greater_ego = 1,
--	cost = 42000,
	cost = resolvers.value{platinum=4200},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.SONIC] = 20,
	},
	}
}

newEntity {
	name = " of greater sonic resistance", suffix = true,
	keywords = {sonicres=true},
	level_range = {18, nil},
	rarity = 20,
	greater_ego = 1,
--	cost = 66000,
	cost = resolvers.value{platinum=6600},
	school = "abjuration",
	wielder = {
		resists = {
		[DamageType.SONIC] = 30,
	},
	}
}
--Shields only material

newEntity {
	name = "darkwood ", prefix = true,
	keywords = {darkwood=true},
	level_range = {10, nil},
	rarity = 5,
--	cost = 500,
	cost = resolvers.value{gold=500},
	wielder = {
		armor_penalty = -2,
	}
}

--Spikes!!
newEntity {
	name = "spiked ", prefix = true,
	keywords = {spiked=true},
	level_range = {1, nil},
	rarity = 5,
--	cost = 10,
	cost = resolvers.value{silver=150},
	encumber = 5,
	wielder = {
		on_melee_hit={
			[DamageType.PHYSICAL] = {1, 6}
		}
	}
}
