--Veins of the Earth
--Zireael

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"


newEntity {
	name = " of natural armor +1", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 2000,
	wielder = {
		combat_natural = 1,
	},
}

newEntity {
	name = " of natural armor +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 8000,
	wielder = {
		combat_natural = 2,
	},
}

newEntity {
	name = " of natural armor +3", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 16000,
	wielder = {
		combat_natural = 3,
	},
}

newEntity {
	name = " of natural armor +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 20},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
		combat_natural = 4,
	},
}

newEntity {
	name = " of natural armor +5", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 50000,
	wielder = {
		combat_natural = 5,
	},
}

newEntity {
	name = " of protection +1", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 2000,
	wielder = {
		combat_protection = 1,
	},
}

newEntity {
	name = " of protection +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 8000,
	wielder = {
		combat_protection = 2,
	},
}

newEntity {
	name = " of protection +3", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 16000,
	wielder = {
		combat_protection = 3,
	},
}

newEntity {
	name = " of protection +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 20},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
		combat_protection = 4,
	},
}

newEntity {
	name = " of protection +5", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 50000,
	wielder = {
		combat_protection = 5,
	},
}


-- Armor AC
newEntity {
	name = " of armor +1", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 2000,
	wielder = {
		combat_armor = 1,
	},
}

newEntity {
	name = " of armor +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 8000,
	wielder = {
		combat_armor = 2,
	},
}

newEntity {
	name = " of armor +3", suffix = true,
--	keywords = {bonus=true},
	level_range = {1, 10},
	rarity = 5,
	cost = 16000,
	wielder = {
		combat_armor = 3,
	},
}

newEntity {
	name = " of armor +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 20},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
		combat_armor = 4,
	},
}

newEntity {
	name = " of armor +5", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 50000,
	wielder = {
		combat_armor = 5,
	},
}


--Stat boosts
newEntity {
	name = " of ogre strength +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 2, },
  }, 
}

newEntity {
	name = " of giant strength +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 4, },
  }, 
}

newEntity {
	name = " of giant strength +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 6, },
  }, 
}

newEntity {
	name = " of Dexterity +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = 2, },
  }, 
}

newEntity {
	name = " of Dexterity +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = 4, },
  }, 
}

newEntity {
	name = " of Dexterity +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = 6, },
  }, 
}

newEntity {
	name = " of health +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_CON] = 2, },
  }, 
}

newEntity {
	name = " of health +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_CON] = 4, },
  }, 
}

newEntity {
	name = " of health +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_CON] = 6, },
  }, 
}

newEntity {
	name = " of Intelligence +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_INT] = 2, },
  }, 
}

newEntity {
	name = " of Intelligence +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_INT] = 4, },
  }, 
}

newEntity {
	name = " of Intelligence +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_INT] = 6, },
  }, 
}

newEntity {
	name = " of Wisdom +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_WIS] = 2, },
  }, 
}

newEntity {
	name = " of Wisdom +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_WIS] = 4, },
  }, 
}

newEntity {
	name = " of Wisdom +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_WIS] = 6, },
  }, 
}

newEntity {
	name = " of Charisma +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_CHA] = 2, },
  }, 
}

newEntity {
	name = " of Charisma +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_CHA] = 4, },
  }, 
}

newEntity {
	name = " of Charisma +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_CHA] = 6, },
  }, 
}

newEntity {
	name = " of Providence +2", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 4000,
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 2, },
  }, 
}

newEntity {
	name = " of Providence +4", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 4, },
  }, 
}

newEntity {
	name = " of Providence +6", suffix = true,
--	keywords = {bonus=true},
	level_range = {10, 30},
	greater_ego = 1,
	rarity = 5,
	cost = 32000,
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 6, },
  }, 
}


--Curses
newEntity{
	name = "of clumsiness", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
     inc_stats = { [Stats.STAT_DEX] = -4, },
     spell_fail = 20,
  }, 
}

newEntity{
	name = "of fumbling -2", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = -2, },
  }, 
}

newEntity{
	name = "of defenselessness -1", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    combat_armor=-1
  }, 
}

newEntity{
	name = "of defenselessness -2", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    combat_armor=-2
  }, 
}

newEntity{
	name = "of defenselessness -3", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    combat_armor=-3
  }, 
}

newEntity{
	name = "of defenselessness -4", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    combat_armor=-4
  }, 
}

newEntity{
	name = "of defenselessness -5", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    combat_armor=-5
  }, 
}