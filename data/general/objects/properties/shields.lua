--Veins of the Earth
--Zireael 2013-2015

local DamageType = require "engine.DamageType"

load("data/general/objects/properties/bonus_shields.lua")
load("data/general/objects/properties/materials_shields.lua")

--Resistances
newEntity {
	name = " of fire resistance", suffix = true,
	keywords = {fireres=true},
	level_range = {14, nil},
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
	level_range = {17, nil},
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
	level_range = {19, nil},
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
	level_range = {14, nil},
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
	level_range = {17, nil},
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
	level_range = {19, nil},
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
	level_range = {14, nil},
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
	level_range = {17, nil},
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
	level_range = {19, nil},
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
	level_range = {14, nil},
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
	level_range = {17, nil},
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
	level_range = {19, nil},
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
	level_range = {14, nil},
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
	level_range = {17, nil},
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
	level_range = {19, nil},
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
