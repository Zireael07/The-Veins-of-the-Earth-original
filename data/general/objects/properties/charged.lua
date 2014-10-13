--Veins of the Earth
--Zireael 2014

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

--ID
newEntity{
	name = " of identify", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "divination",
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

--Targeted spells
newEntity{
	name = " of magic missile", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "evocation",
    use_simple = { name = "magic missile",
    use = function(self, who)
        local tg = {type="bolt", range=5, display={display='*',color=colors.ORCHID}}
        local x, y = who:getTarget(tg)
        local _ _, _, _, x, y = who:canProject(tg, x, y)
        if not x or not y then return nil end

        local damage = rng.dice(1,4)+1

        who:projectile(tg, x, y, DamageType.FORCE, {dam=damage})    
        game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
end
},
}


--Buffs
newEntity{
	name = " of bear endurance", suffix = true,
	level_range = {1, 10},
	rarity = 5,
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "bear endurance",
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
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "bull strength",
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
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "cat grace",
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
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "fox cunning",
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
--	cost = 4500,
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "owl wisdom",
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
    cost = resolvers.value{platinum=450},
    school = "transmutation",
    use_simple = { name = "eagle splendor",
    use = function(self, who)
    who:setEffect(who.EFF_BEAR_ENDURANCE, 5, {})
    game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}