--Veins of the Earth
--Zireael 2014

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

--Standard
newEntity{
	name = " of cure light wounds", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 300,
    cost = resolvers.value{gold=300},
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(rng.dice(1,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
	name = " of cure moderate wounds", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 750,
    cost = resolvers.value{gold=750},
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(rng.dice(2,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
	name = " of heal serious wounds", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 1200,
    cost = resolvers.value{gold=120},
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(rng.dice(2,8) + 5)
        return {used = true, destroy = true}
  end
  }, 
}

newEntity{
	name = " of heal moderate wounds", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 900,
    cost = resolvers.value{gold=900},
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(who.max_life*0.5)
        return {used = true, destroy = true}
  end
  }, 
}

--EVIL!!
newEntity{
	name = " of inflict light wounds", suffix = true,
	level_range = {1, 10},
	rarity = 5,
	cost = 0,
    use_simple = { name = "quaff",
    use = function(self,who)
        who:heal(-who.max_life*0.1)
        return {used = true, destroy = true}
  end
  }, 
}


--Buffs
newEntity{
	name = " of bear endurance", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of bull strength", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
       who:setEffect(who.EFF_BULL_STRENGTH, 5, {})
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of cat's grace", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
       who:setEffect(who.EFF_CAT_GRACE, 5, {})
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of fox cunning", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of owl wisdom", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--    cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of eagle splendor", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of mage armor", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{gold=4500},
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_MAGE_ARMOR, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

--Nasty!
newEntity{
	name = " of poison", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = 0,
    use_simple = { name = "quaff",
    use = function(self, who)
    who:setEffect(who.EFF_POISON_SPELL, 6, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}