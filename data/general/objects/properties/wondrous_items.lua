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

newEntity{
	name = " of resistance +1", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 1000,
	wielder = {
		fortitude_save = 1,
		reflex_save = 1,
		will_save = 1,
	},
}

newEntity{
	name = " of resistance +2", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 4000,
	wielder = {
		fortitude_save = 2,
		reflex_save = 2,
		will_save = 2,
	},
}

newEntity{
	name = " of resistance +3", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 9000,
	wielder = {
		fortitude_save = 3,
		reflex_save = 3,
		will_save = 3,
	},
}

newEntity{
	name = " of resistance +4", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 16000,
	greater_ego = 1,
	wielder = {
		fortitude_save = 4,
		reflex_save = 4,
		will_save = 4,
	},
}

newEntity{
	name = " of resistance +5", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 25000,
	greater_ego = 1,
	wielder = {
		fortitude_save = 5,
		reflex_save = 5,
		will_save = 5,
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

--For completeness
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

--Based on Incursion
newEntity{
	name = " of the Endless Wave", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 32000,
	wielder = {
		skill_bonus_swim = 5,
		--immune to drowning, neutral to water critters
},
}

newEntity{
	name = " of Detection", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_search = 5,
		skill_bonus_survival = 5,
		--Sharp Senses (detect secret doors)
	},
}


newEntity{
	name = " of the Eagle", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_spot = 5,
		--double vision range, neutral birds
},
}

newEntity{
	name = " of the Soul", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_intimidate = 5,
		will_save = 5,
	},
}

newEntity{
	name = " of the Mantis", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_jump = 5,
		--Mantis Leap feat
	},
}

newEntity{
	name = "of the Spur", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_handleanimal = 5,
		--skill_bonus_ride = 5,
		--Overrun feat
	},
}

newEntity{
	name = " of Stability", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_balance = 5,
		--immune to polymorph
	},
}

newEntity{
	name = " of Contortion", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 16000,
	wielder = {
		skill_bonus_escapeartist = 5,
		skill_bonus_tumble = 5,
		--Featherfoot feat
	},
}

newEntity{
	name = " of Magical Aptitude", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 7500,
	wielder = {
		skill_bonus_concentration = 5,
		skill_bonus_usemagic = 5,
	},
}


--Originally cloaks only
newEntity{ 
	name = " of arachnida", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 14000,
	wielder = {
		skill_bonus_climb = 10,
		fortitude_save = 2,
		--neutral spiders, doesn't get stuck in webs, cast web 1/day
	},
}
newEntity{
	name = " of Elvenkind", suffix = true,
	image = "tiles/elven_cloak.png",
    display = "♠", color=colors.GREEN,
	level_range = {10, 30},
	rarity = 5,
	cost = 2500,
	wielder = {
		skill_bonus_hide = 5,
	},
}

newEntity{
	name = "of the Bat", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 26000,
	wielder = {
		skill_bonus_hide = 5,
		--polymorph into a bat
	},
}

newEntity{
	name = " of spell resistance 21", suffix = true,
	level_range = {10, 30},
	rarity = 5,
	cost = 90000,
	wielder = {
		spell_resistance = 21,
	},

}


--Casting spells
newEntity {
	name = " of identify", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 4500,
	multicharge = 50,
    use_simple = { name = "identify",
    use = function(self, who)
        local inven = game.player:getInven("INVEN")
        local d d = who:showInventory("Identify which item?", inven, function(o) return not o.identified end, function(o, item)
            if o.identified == false then o.identified = true end
        end)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}


--Curses
newEntity{
	name = " of clumsiness", suffix = true,
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
	name = " of fumbling -2", suffix = true,
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
	name = " of defenselessness -1", suffix = true,
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
	name = " of defenselessness -2", suffix = true,
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
	name = " of defenselessness -3", suffix = true,
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
	name = " of defenselessness -4", suffix = true,
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
	name = " of defenselessness -5", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
    combat_armor=-5
  }, 
}

newEntity{
	name = " of Frostbite", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
		--increase cold damage by 50%
	},
}

newEntity{
	name = " of Fireburn", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	wielder = {
		--increase fire damage by 25%
	},
}