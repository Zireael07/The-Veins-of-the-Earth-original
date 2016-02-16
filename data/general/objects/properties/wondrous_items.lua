--Veins of the Earth
--Zireael 2013-2016

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"


newEntity {
	name = " of natural armor +1", suffix = true,
	keywords = {natural =true},
	level_range = {6, nil},
	rarity = 5,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "transmutation",
	wielder = {
		combat_natural = 1,
	},
}

newEntity {
	name = " of natural armor +2", suffix = true,
	keywords = {natural=true},
	level_range = {11, nil},
	rarity = 15,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	school = "transmutation",
	wielder = {
		combat_natural = 2,
	},
}

newEntity {
	name = " of natural armor +3", suffix = true,
	keywords = {natural=true},
	level_range = {14, nil},
	rarity = 15,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		combat_natural = 3,
	},
}

newEntity {
	name = " of natural armor +4", suffix = true,
	keywords = {natural=true},
	level_range = {16, 20},
	greater_ego = 1,
	rarity = 15,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
		combat_natural = 4,
	},
}

newEntity {
	name = " of natural armor +5", suffix = true,
	keywords = {natural=true},
	level_range = {18, 30},
	greater_ego = 1,
	rarity = 15,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "transmutation",
	wielder = {
		combat_natural = 5,
	},
}

newEntity {
	name = " of protection +1", suffix = true,
	keywords = {protect=true},
	level_range = {6, 10},
	rarity = 5,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "abjuration",
	wielder = {
		combat_protection = 1,
	},
}

newEntity {
	name = " of protection +2", suffix = true,
	keywords = {protect=true},
	level_range = {11, nil},
	rarity = 5,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	school = "abjuration",
	wielder = {
		combat_protection = 2,
	},
}

newEntity {
	name = " of protection +3", suffix = true,
	keywords = {protect=true},
	level_range = {14, nil},
	rarity = 15,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	wielder = {
		combat_protection = 3,
	},
}

newEntity {
	name = " of protection +4", suffix = true,
	keywords = {protect=true},
	level_range = {16, 20},
	greater_ego = 1,
	rarity = 15,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "abjuration",
	wielder = {
		combat_protection = 4,
	},
}

newEntity {
	name = " of protection +5", suffix = true,
	keywords = {protect=true},
	level_range = {18, 30},
	greater_ego = 1,
	rarity = 5,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "abjuration",
	wielder = {
		combat_protection = 5,
	},
}


-- Armor AC
newEntity {
	name = " of armor +1", suffix = true,
	keywords = {armor=true},
	level_range = {6, 10},
	rarity = 15,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "conjuration",
	wielder = {
		combat_armor = 1,
	},
}

newEntity {
	name = " of armor +2", suffix = true,
	keywords = {armor=true},
	level_range = {11, nil},
	rarity = 15,
--	cost = 8000,
	cost = resolvers.value{platinum=800},
	school = "conjuration",
	wielder = {
		combat_armor = 2,
	},
}

newEntity {
	name = " of armor +3", suffix = true,
	keywords = {armor=true},
	level_range = {14, nil},
	rarity = 15,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "conjuration",
	wielder = {
		combat_armor = 3,
	},
}

newEntity {
	name = " of armor +4", suffix = true,
	keywords = {armor=true},
	level_range = {16, 20},
	greater_ego = 1,
	rarity = 15,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "conjuration",
	wielder = {
		combat_armor = 4,
	},
}

newEntity {
	name = " of armor +5", suffix = true,
	keywords = {armor=true},
	level_range = {18, 30},
	greater_ego = 1,
	rarity = 15,
--	cost = 50000,
	cost = resolvers.value{platinum=5000},
	school = "conjuration",
	wielder = {
		combat_armor = 5,
	},
}

newEntity{
	name = " of resistance +1", suffix = true,
	keywords = {resist=true},
	level_range = {4, 10},
	rarity = 5,
--	cost = 1000,
	cost = resolvers.value{platinum=100},
	school = "abjuration",
	wielder = {
		fortitude_save = 1,
		reflex_save = 1,
		will_save = 1,
	},
}

newEntity{
	name = " of resistance +2", suffix = true,
	keywords = {resist=true},
	level_range = {8, 10},
	rarity = 5,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "abjuration",
	wielder = {
		fortitude_save = 2,
		reflex_save = 2,
		will_save = 2,
	},
}

newEntity{
	name = " of resistance +3", suffix = true,
	keywords = {resist=true},
	level_range = {12, nil},
	rarity = 15,
--	cost = 9000,
	cost = resolvers.value{platinum=900},
	school = "abjuration",
	wielder = {
		fortitude_save = 3,
		reflex_save = 3,
		will_save = 3,
	},
}

newEntity{
	name = " of resistance +4", suffix = true,
	keywords = {resist=true},
	level_range = {14, nil},
	rarity = 15,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "abjuration",
	greater_ego = 1,
	wielder = {
		fortitude_save = 4,
		reflex_save = 4,
		will_save = 4,
	},
}

newEntity{
	name = " of resistance +5", suffix = true,
	keywords = {resist=true},
	level_range = {15, nil},
	rarity = 15,
--	cost = 25000,
	cost = resolvers.value{platinum=2500},
	school = "abjuration",
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
	keywords = {Str=true},
	level_range = {8, 30},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 2, },
  },
}

newEntity {
	name = " of giant strength +4", suffix = true,
	keywords = {Str=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 4, },
  },
}

newEntity {
	name = " of giant strength +6", suffix = true,
	keywords = {Str=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 15,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 6, },
  },
}

newEntity {
	name = " of Dexterity +2", suffix = true,
	keywords = {Dex=true},
	level_range = {8, 30},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = 2, },
  },
}

newEntity {
	name = " of Dexterity +4", suffix = true,
	keywords = {Dex=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = 4, },
  },
}

newEntity {
	name = " of Dexterity +6", suffix = true,
	keywords = {Dex=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_DEX] = 6, },
  },
}

newEntity {
	name = " of health +2", suffix = true,
	keywords = {Con=true},
	level_range = {8, 30},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_CON] = 2, },
  },
}

newEntity {
	name = " of health +4", suffix = true,
	keywords = {Con=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_CON] = 4, },
  },
}

newEntity {
	name = " of health +6", suffix = true,
	keywords = {Con=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_CON] = 6, },
  },
}

newEntity {
	name = " of Intelligence +2", suffix = true,
	keywords = {Int=true},
	level_range = {8, 30},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_INT] = 2, },
  },
}

newEntity {
	name = " of Intelligence +4", suffix = true,
	keywords = {Int=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_INT] = 4, },
  },
}

newEntity {
	name = " of Intelligence +6", suffix = true,
	keywords = {Int=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_INT] = 6, },
  },
}

newEntity {
	name = " of Wisdom +2", suffix = true,
	keywords = {Wis=true},
	level_range = {8, 30},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_WIS] = 2, },
  },
}

newEntity {
	name = " of Wisdom +4", suffix = true,
	keywords = {Wis=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_WIS] = 4, },
  },
}

newEntity {
	name = " of Wisdom +6", suffix = true,
	keywords = {Wis=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_WIS] = 6, },
  },
}

newEntity {
	name = " of Charisma +2", suffix = true,
	keywords = {Cha=true},
	level_range = {8, 30},
	rarity = 10,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_CHA] = 2, },
  },
}

newEntity {
	name = " of Charisma +4", suffix = true,
	keywords = {Cha=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_CHA] = 4, },
  },
}

newEntity {
	name = " of Charisma +6", suffix = true,
	keywords = {Cha=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_CHA] = 6, },
  },
}

--For completeness
newEntity {
	name = " of Providence +2", suffix = true,
	keywords = {Luck=true},
	level_range = {8, 30},
	rarity = 20,
--	cost = 4000,
	cost = resolvers.value{platinum=400},
	school = "evocation",  --per luckstone and Luckblade
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 2, },
  },
}

newEntity {
	name = " of Providence +4", suffix = true,
	keywords = {Luck=true},
	level_range = {14, 30},
	rarity = 20,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "evocation",  --per luckstone and Luckblade
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 4, },
  },
}

newEntity {
	name = " of Providence +6", suffix = true,
	keywords = {Luck=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 20,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "evocation",  --per luckstone and Luckblade
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 6, },
  },
}

--Pathfinder
--ignores difficult terrain when charging, bull rushing etc.
newEntity {
	name = "minotaur ", prefix = true,
	keywords = {minotaur=true},
	level_range = {10, 30},
	rarity = 10,
	cost = resolvers.value{platinum=1100},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 2, },
  },
}

newEntity {
	name = " of physical perfection +2", suffix = true,
	keywords = {physperf=true},
	level_range = {10, 30},
	rarity = 20,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 2,
    		[Stats.STAT_DEX] = 2,
    		[Stats.STAT_CON] = 2,
    	},
  },
}

newEntity {
	name = " of physical perfection +4", suffix = true,
	keywords = {physperf=true},
	level_range = {15, 30},
	rarity = 25,
	cost = resolvers.value{platinum=6400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 4,
    		[Stats.STAT_DEX] = 4,
    		[Stats.STAT_CON] = 4,
    	},
  },
}

newEntity {
	name = " of physical perfection +6", suffix = true,
	keywords = {physperf=true},
	level_range = {20, 30},
	rarity = 40,
	cost = resolvers.value{platinum=14400},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_STR] = 6,
    		[Stats.STAT_DEX] = 6,
    		[Stats.STAT_CON] = 6,
    	},
  },
}

--Based on Incursion
newEntity{
	name = " of the Endless Wave", suffix = true,
	keywords = {Wave=true},
	level_range = {16, 30},
	rarity = 5,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
		skill_bonus_swim = 5,
		--immune to drowning, neutral to water critters
},
}

newEntity{
	name = " of Detection", suffix = true,
	keywords = {Detect=true},
	level_range = {14, 30},
	rarity = 5,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_search = 5,
		skill_bonus_survival = 5,
		--Sharp Senses (detect secret doors)
	},
}


newEntity{
	name = " of the Eagle", suffix = true,
	keywords = {Eagle=true},
	level_range = {14, 30},
	rarity = 5,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_spot = 5,
		--double vision range, neutral birds
},
}

newEntity{
	name = " of the Soul", suffix = true,
	keywords = {Soul=true},
	level_range = {14, 30},
	rarity = 13,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_intimidate = 5,
		will_save = 5,
	},
}

newEntity{
	name = " of the Mantis", suffix = true,
	keywords = {Mantis=true},
	level_range = {14, 30},
	rarity = 5,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_jump = 5,
		--Mantis Leap feat
	},
}

newEntity{
	name = " of the Spur", suffix = true,
	keywords = {Spur=true},
	level_range = {14, 30},
	rarity = 7,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_handleanimal = 5,
		skill_bonus_ride = 5,
		--Overrun feat
	},
}

newEntity{
	name = " of Stability", suffix = true,
	keywords = {Stable=true},
	level_range = {14, 30},
	rarity = 5,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_balance = 5,
		--immune to polymorph
	},
}

newEntity{
	name = " of Contortion", suffix = true,
	keywords = {Contort=true},
	level_range = {14, 30},
	rarity = 10,
--	cost = 16000,
	cost = resolvers.value{platinum=1600},
	school = "transmutation",
	wielder = {
		skill_bonus_escapeartist = 5,
		skill_bonus_tumble = 5,
		--Featherfoot feat
	},
}

newEntity{
	name = " of Magical Aptitude", suffix = true,
	keywords = {Magapt=true},
	level_range = {11, 30},
	rarity = 5,
--	cost = 7500,
	cost = resolvers.value{platinum=750},
	school = "transmutation",
	wielder = {
		skill_bonus_concentration = 5,
		skill_bonus_usemagic = 5,
	},
}

newEntity {
	name = " of the Winterlands", suffix = true,
	keywords = {Winter=true},
	level_range = {14, nil},
	rarity = 10,
--	cost = 18000,
	cost = resolvers.value{platinum=1800},
	school = "transmutation",
	wielder = {
		resists = {
		[DamageType.COLD] = 5,
		--no slipping on ice
	},
	}
}

newEntity {
	name = " of the Druid", suffix = true,
	keywords = {Druid=true},
	level_range = {14, 30},
	rarity = 15,
--	cost = 14000,
	cost = resolvers.value{platinum=1400},
	school = "transmutation",
	wielder = {
		--neutral sylvans, doesn't get stuck in webs, trees
	},
}

--Originally cloaks only
newEntity{
	name = " of arachnida", suffix = true,
	keywords = {arach=true},
	level_range = {14, 30},
	rarity = 15,
--	cost = 14000,
	cost = resolvers.value{platinum=1400},
	school = "transmutation",
	wielder = {
		skill_bonus_climb = 10,
		fortitude_save = 2,
		--neutral spiders, doesn't get stuck in webs, cast web 1/day
	},
}

newEntity{
	name = " of Elvenkind", suffix = true,
	keywords = {Elven=true},
	shader = "dual_hue", shader_args = {hue_color1={0,1,0,1}, hue_color2={0,0.5,0,1}},
--	image = "tiles/elven_cloak.png",
--    display = "♠",
	 color=colors.GREEN,
	level_range = {7, 30},
	rarity = 15,
--	cost = 2500,
	cost = resolvers.value{platinum=250},
	school = "illusion",
	wielder = {
		skill_bonus_hide = 5,
	},
}

newEntity{
	name = " of the Bat", suffix = true,
	keywords = {Bat=true},
	level_range = {16, 30},
	rarity = 25,
--	cost = 26000,
	cost = resolvers.value{platinum=2600},
	school = "transmutation",
	wielder = {
		skill_bonus_hide = 5,
		--polymorph into a bat
	},
}

newEntity{
	name = " of spell resistance 21", suffix = true,
	keywords = {SR=true},
	level_range = {20, 30},
	rarity = 8,
--	cost = 90000,
	cost = resolvers.value{platinum=9000},
	school = "abjuration",
	wielder = {
		spell_resistance = 21,
	},

}

newEntity {
	name = " of the Hin", suffix = true,
	keywords = {Hin=true},
	level_range = {16, 30},
	greater_ego = 1,
	rarity = 10,
--	cost = 32000,
	cost = resolvers.value{platinum=3200},
	school = "transmutation",
	wielder = {
    inc_stats = { [Stats.STAT_LUC] = 1,
    		[Stats.STAT_DEX] = 1,
    		--resist ability damage
    	},
  },
}

--From PF, two ways to increase carrying capacity
newEntity{
	name = "muleback ", prefix = true,
	keywords = {mule=true},
	level_range = {4, nil},
	rarity = 4,
	cost = resolvers.value{platinum=1000},
	school = "transmutation",
	wielder = {
		muleback = 1,
	},
}

newEntity{
	name = " of heavyload", suffix = true,
	keywords = {load=true},
	level_range = {6, nil},
	rarity = 10,
	cost = resolvers.value{platinum=2000},
	school = "transmutation",
	wielder = {
		ant_haul = 1,
	},
}


--Casting spells
newEntity {
	name = " of identify", suffix = true,
	keywords = {ID=true},
	level_range = {1, 10},
	rarity = 15,
--	cost = 4500,
	cost = resolvers.value{platinum=450},
	school = "divination",
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

--Based on Angband
newEntity {
	name = " of brightness", suffix = true,
	keywords = {bright=true},
	level_range = {6, 10},
	rarity = 8,
--	cost = 2000,
	cost = resolvers.value{platinum=200},
	school = "evocation",
	wielder = {
		lite = 1,
	},
}

--Halves nutrition loss rate
newEntity{
	name = " of slow digestion", suffix = true,
	keywords = {slowdigest=true},
	level_range = {5, 10},
	rarity = 5,
	cost = resolvers.value{platinum=200},
	school = "transmutation", --a wild guess
	wielder = {
		slow_digest = 1,
	}
}


--Curses
newEntity{
	name = " of clumsiness", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "transmutation",
	wielder = {
     inc_stats = { [Stats.STAT_DEX] = -4, },
     spell_fail = 20,
  },
}

newEntity{
	name = " of weakness -2", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "transmutation",
	wielder = {
     inc_stats = { [Stats.STAT_STR] = -2, },
  },
}

newEntity{
	name = " of weakness -4", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "transmutation",
	wielder = {
     inc_stats = { [Stats.STAT_STR] = -4, },
  },
}

newEntity{
	name = " of fumbling -2", suffix = true,
	keywords = {cursed=true},
	level_range = {1,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "transmutation",
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
	school = "transmutation",
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
	school = "transmutation",
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
	school = "transmutation",
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
	school = "transmutation",
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
	school = "transmutation",
	wielder = {
    combat_armor=-5
  },
}

newEntity{
	name = " of Frostbite", suffix = true,
	keywords = {cursed=true},
	level_range = {3,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "abjuration",
	wielder = {
		--increase cold damage by 50%
		resists = {
		[DamageType.COLD] = -50,
		},
	},
}

newEntity{
	name = " of Fireburn", suffix = true,
	keywords = {cursed=true},
	level_range = {3,10},
	rarity = 8,
	cursed = true,
	cost = 0,
	school = "abjuration",
	wielder = {
		--increase fire damage by 25%
		resists = {
		[DamageType.COLD] = -25,
		},
	},
}
