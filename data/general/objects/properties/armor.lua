--Veins of the Earth
--Zireael

local DamageType = require "engine.DamageType"
local Stats = require "engine.interface.ActorStats"

newEntity { define_as = "EGO_PLUS_ONE",
	name = " +1", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "abjuration",
	wielder = {
		combat_magic_armor = 1,
	},
	resolve_data = {
	all = {
	wielder = {
		combat_magic_armor = 1,
	},
	},
},
}

newEntity { define_as = "EGO_PLUS_TWO",
	name = " +2", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "abjuration",
	wielder = {
		combat_magic_armor = 2,
	},
}

newEntity { define_as = "EGO_PLUS_THREE",
	name = " +3", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 8,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	wielder = {
		combat_magic_armor = 3,
	},
}

newEntity { define_as = "EGO_PLUS_FOUR",
	name = " +4", suffix = true,
	keywords = {bonus=true},
	level_range = {10, 20},
	rarity = 10,
	greater_ego = 1,
	school = "abjuration",
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	wielder = {
		combat_magic_armor = 4,
	},
}

newEntity { define_as = "EGO_PLUS_FIVE",
	name = " +5", suffix = true,
	keywords = {bonus=true},
	level_range = {1, 10},
	greater_ego = 1,
	rarity = 15,
	school = "abjuration",
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	wielder = {
	combat_magic_armor = 5,
	},
}

newEntity { define_as = "EGO_MITHRIL",
	name = "mithril ", prefix = true,
	keywords = {mithril=true},
	level_range = {5, nil},
	rarity = 7,
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	wielder = {
		spell_fail = -10,
		max_dex_bonus = 2,
		armor_penalty = -3,
	}
}

newEntity { define_as = "EGO_ADAMANTINE",
	name = "adamantine ", prefix = true,
	keywords = {adamantine=true},
	level_range = {10, nil},
	rarity = 5,
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	wielder = {
		combat_dr = 1,
		armor_penalty = -1,
	}
}

newEntity { define_as = "EGO_DRAGONHIDE",
	name = "dragonhide ", prefix = true,
	keywords = {dragonhide=true},
	level_range = {20, nil},
	rarity = 15,
--	cost = 3500,
	cost = resolvers.value{platinum=350},
	wielder = {
		resists = {
		[DamageType.FIRE] = 20,
	},
		armor_penalty = -1,
	}
}

--Magic properties
newEntity { define_as = "EGO_SHADOW",
	name = " of shadow", suffix = true,
	keywords = {shadow=true},
	level_range = {5, nil},
	rarity = 8,
--	cost = 3750,
	cost = resolvers.value{platinum=375},
	school = "illusion",
	wielder = {
		skill_bonus_hide = 5,
	}
}

newEntity { define_as = "EGO_IMP_SHADOW",
	name = " of improved shadow", suffix = true,
	keywords = {shadow=true},
	level_range = {10, nil},
	greater_ego = 1,
	rarity = 13,
--	cost = 15000,
	cost = resolvers.value{platinum=1500},
	school = "illusion",
	wielder = {
		skill_bonus_hide = 10,
	}
}

newEntity { define_as = "EGO_GREATER_SHADOW",
	name = " of greater shadow", suffix = true,
	keywords = {shadow=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 18,
--	cost = 33750,
	cost = resolvers.value{platinum=3375},
	school = "illusion",
	wielder = {
		skill_bonus_hide = 15,
	}
}

newEntity { define_as = "EGO_SILENT",
	name = " of silent moves", suffix = true,
	keywords = {silent=true},
	level_range = {5, nil},
	rarity = 8,
--	cost = 3750,
	cost = resolvers.value{platinum=375},
	school = "illusion",
	wielder = {
		skill_bonus_movesilently = 5,
	}
}

newEntity { define_as = "EGO_IMP_SILENT",
	name = " of improved silent moves", suffix = true,
	keywords = {silent=true},
	level_range = {10, nil},
	greater_ego = 1,
	rarity = 13,
--	cost = 15000,
	cost = resolvers.value{platinum=1500},
	school = "illusion",
	wielder = {
		skill_bonus_movesilently = 10,
	}
}

newEntity {
	name = " of greater silent moves", suffix = true,
	keywords = {silent=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 18,
--	cost = 33750,
	cost = resolvers.value{platinum=3375},
	school = "illusion",
	wielder = {
		skill_bonus_movesilently = 15,
	}
}

newEntity {
	name = "slick ", prefix = true,
	keywords = {slick=true},
	level_range = {5, nil},
	rarity = 8,
--	cost = 3750,
	cost = resolvers.value{platinum=375},
	school = "conjuration",
	wielder = {
		skill_bonus_escapeartist = 5,
	}
}

newEntity {
	name = "improved slick ", prefix = true,
	keywords = {slick=true},
	level_range = {10, nil},
	greater_ego = 1,
	rarity = 13,
--	cost = 15000,
	cost = resolvers.value{platinum=1500},
	school = "conjuration",
	wielder = {
		skill_bonus_escapeartist = 10,
	}
}

newEntity {
	name = "greater slick ", prefix = true,
	keywords = {slick=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 18,
--	cost = 33750,
	cost = resolvers.value{platinum=3375},
	school = "conjuration",
	wielder = {
		skill_bonus_escapeartist = 15,
	}
}

--Spell resistance
newEntity {
	name = " of spell resistance 13", suffix = true,
	keywords = {spellres=true},
	level_range = {10, nil},
	greater_ego = 1,
	rarity = 15,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	school = "abjuration",
	wielder = {
		spell_resistance = 13
	}
}

newEntity {
	name = " of spell resistance 15", suffix = true,
	keywords = {spellres=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 15,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	wielder = {
		spell_resistance = 15
	}
}

newEntity {
	name = " of spell resistance 17", suffix = true,
	keywords = {spellres=true},
	level_range = {15, nil},
	greater_ego = 1,
	rarity = 17,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "abjuration",
	wielder = {
		spell_resistance = 17
	}
}

newEntity {
	name = " of spell resistance 19", suffix = true,
	keywords = {spellres=true},
	level_range = {20, nil},
	greater_ego = 1,
	rarity = 20,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	wielder = {
		spell_resistance = 19
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
	greater_ego = 1,
	rarity = 15,
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
	greater_ego = 1,
	rarity = 20,
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
	greater_ego = 1,
	rarity = 15,
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
	greater_ego = 1,
	rarity = 20,
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
	greater_ego = 1,
	rarity = 15,
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
	greater_ego = 1,
	rarity = 20,
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
	greater_ego = 1,
	rarity = 15,
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
	greater_ego = 1,
	rarity = 20,
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
	greater_ego = 1,
	rarity = 15,
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

newEntity {
	name = " of light fortification", suffix = true,
	keywords = {fortification=true},
	level_range = {1, nil},
	rarity = 5,
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	school = "abjuration",
	wielder = {
		fortification = 1,
	}
}

newEntity {
	name = " of moderate fortification", suffix = true,
	keywords = {fortification=true},
	level_range = {10, nil},
	rarity = 10,
--	cost = 9000,
	cost = resolvers.value{platinum=9000},
	school = "abjuration",
	wielder = {
		fortification = 2,
	}
}

newEntity {
	name = " of heavy fortification", suffix = true,
	keywords = {fortification=true},
	level_range = {15, nil},
	rarity = 15,
	greater_ego = 1,
--	cost = 25000,
	cost = resolvers.value{platinum=2500},
	school = "abjuration",
	wielder = {
		fortification = 3,
	}
}


--Based on Angband's
newEntity {
	name = "dwarven", prefix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 15,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	wielder = {
		
		infravision = 1,
		
    		inc_stats = { [Stats.STAT_STR] = 2,
    			[Stats.STAT_CON] = 2,
    		},
   
  }, 
}

newEntity{
	name = " of elvenkind", suffix = true,
	level_range = {10, 30},
	rarity = 5,
--	cost = 2500,
	cost = resolvers.value{platinum=250},
	wielder = {
		skill_bonus_hide = 5,
	},
}

--Spikes!!
--[[newEntity {
	name = "spiked ", prefix = true,
	keywords = {spiked=true},
	level_range = {1, nil},
	rarity = 5,
--	cost = 10,
	cost = resolvers.value{silver=250},
	encumber = 5,
	wielder = {
		on_melee_hit={[DamageType.PHYSICAL] = {1, 6}
	}
}
]]
