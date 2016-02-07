--Veins of the Earth
--Zireael 2014-2016

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

--Standard
newEntity{
	name = " of cure light wounds", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = rng.dice(1,8) + 5
        who:heal(d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), d))
        return {used = true, destroy = true}
  end
  },
}

newEntity{
	name = " of cure moderate wounds", suffix = true, addon=true,
	level_range = {2, 10},
	rarity = 10,
--	cost = 300,
    cost = resolvers.value{gold=750},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = rng.dice(2,8) + 5
        who:heal(d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), d))
        return {used = true, destroy = true}
  end
  },
}

--Heal a percentage
newEntity{
	name = " of heal light wounds", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 25,
--	cost = 900,
    cost = resolvers.value{gold=900},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = who.max_life*0.1
        who:heal(d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), d))
        return {used = true, destroy = true}
  end
  },
}

newEntity{
	name = " of heal moderate wounds", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 25,
--	cost = 900,
    cost = resolvers.value{gold=900},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = who.max_life*0.3
        who:heal(d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), d))
        return {used = true, destroy = true}
  end
  },
}

newEntity{
	name = " of heal serious wounds", suffix = true, addon=true,
	level_range = {5, 10},
	rarity = 15,
--	cost = 1200,
    cost = resolvers.value{gold=1200},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = who.max_life*0.5
        who:heal(d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), d))
        return {used = true, destroy = true}
  end
  },
}

--EVIL!!
newEntity{
	name = " of inflict light wounds", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
	cost = 0,
    school = "necromancy",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = rng.dice(1,8) + 5
        who:heal(-d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), -d))
        return {used = true, destroy = true}
  end
  },
}

newEntity{
	name = " of inflict moderate wounds", suffix = true, addon=true,
	level_range = {5, 15},
	rarity = 10,
	cost = 0,
    school = "necromancy",
    use_simple = { name = "quaff",
    use = function(self,who)
		local d = rng.dice(2,8) + 5
        who:heal(-d)
		game.logSeen(who, ("%s heals %d damage"):format(who.name:capitalize(), -d))
        return {used = true, destroy = true}
  end
  },
}

--Buffs
newEntity{
	name = " of bear endurance", suffix = true, addon=true,
	level_range = {3, 10},
	rarity = 15,
--	cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of bull strength", suffix = true, addon=true,
	level_range = {3, 10},
	rarity = 15,
--	cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
       who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of cat's grace", suffix = true, addon=true,
	level_range = {3, 10},
	rarity = 15,
--	cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
       who:setEffect(who.EFF_CAT_GRACE, 5, {})
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of fox cunning", suffix = true, addon=true,
	level_range = {3, 10},
	rarity = 15,
--	cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of owl wisdom", suffix = true, addon=true,
	level_range = {3, 10},
	rarity = 15,
--    cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of eagle splendor", suffix = true, addon=true,
	level_range = {3, 10},
	rarity = 15,
--	cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of mage armor", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_MAGE_ARMOR, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of delay poison", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "conjuration",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_DELAY_POISON, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from evil", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_EVIL, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from good", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_GOOD, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from chaos", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_CHAOS, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from law", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_LAW, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from acid", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_ACID, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from cold", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_COLD, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from fire", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_FIRE, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from electric", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_ELECTRIC, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of protection from sonic", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 50,
    cost = resolvers.value{gold=50},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_PROTECT_SONIC, 5, {power=3})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of levitation", suffix = true, addon=true,
    level_range = {2, 10},
    rarity = 15,
--  cost = 300,
    cost = resolvers.value{gold=300},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_LEVITATE, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of flying", suffix = true, addon=true,
    level_range = {4, 10},
    rarity = 25,
--  cost = 750,
    cost = resolvers.value{gold=750},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_FLY, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of haste", suffix = true, addon=true,
    level_range = {3, 10},
    rarity = 25,
--  cost = 750,
    cost = resolvers.value{gold=750},
    school = "transmutation",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_HASTE, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

--Nasty!
newEntity{
	name = " of poison", suffix = true, addon=true,
	level_range = {1, 10},
	rarity = 5,
    cost = 0,
    school = "necromancy",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_POISON_SPELL, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of sleep", suffix = true, addon=true,
    level_range = {1, 10},
    rarity = 5,
    cost = 0,
    school = "enchantment",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_SLEEP, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
    name = " of hold", suffix = true, addon=true,
    level_range = {2, 10},
    rarity = 5,
    cost = 0,
    school = "enchantment",
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_HOLD, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}
