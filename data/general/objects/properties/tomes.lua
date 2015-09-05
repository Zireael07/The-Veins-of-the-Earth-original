--Veins of the Earth
--2015 Zireael

local Stats = require "engine.interface.ActorStats"

newEntity{
	name = " of Gainful Exercise +1", suffix = true, addon=true,
	level_range = {15, nil},
	rarity = 5,
	cost = resolvers.value{platinum=2750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_STR, 1)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Gainful Exercise +2", suffix = true, addon=true,
	level_range = {17, nil},
	rarity = 10,
	cost = resolvers.value{platinum=5500},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_STR, 2)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Gainful Exercise +3", suffix = true, addon=true,
	level_range = {19, nil},
	rarity = 15,
	cost = resolvers.value{platinum=8250},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_STR, 3)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Gainful Exercise +4", suffix = true, addon=true,
	level_range = {20, nil},
	rarity = 20,
	cost = resolvers.value{platinum=11000},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_STR, 4)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Gainful Exercise +5", suffix = true, addon=true,
	level_range = {21, nil},
	rarity = 25,
	cost = resolvers.value{platinum=13750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_STR, 5)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Bodily Health +1", suffix = true, addon=true,
	level_range = {15, nil},
	rarity = 5,
	cost = resolvers.value{platinum=2750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CON, 1)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Bodily Health +2", suffix = true, addon=true,
	level_range = {17, nil},
	rarity = 10,
	cost = resolvers.value{platinum=5500},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CON, 2)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Bodily Health +3", suffix = true, addon=true,
	level_range = {19, nil},
	rarity = 15,
	cost = resolvers.value{platinum=8250},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CON, 3)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Bodily Health +4", suffix = true, addon=true,
	level_range = {20, nil},
	rarity = 20,
	cost = resolvers.value{platinum=11000},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CON, 4)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Bodily Health +5", suffix = true, addon=true,
	level_range = {21, nil},
	rarity = 25,
	cost = resolvers.value{platinum=13750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CON, 5)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Quickness of Action +1", suffix = true, addon=true,
	level_range = {15, nil},
	rarity = 5,
	cost = resolvers.value{platinum=2750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_DEX, 1)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Quickness of Action +2", suffix = true, addon=true,
	level_range = {17, nil},
	rarity = 10,
	cost = resolvers.value{platinum=5500},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_DEX, 2)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Quickness of Action +3", suffix = true, addon=true,
	level_range = {19, nil},
	rarity = 15,
	cost = resolvers.value{platinum=8250},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_DEX, 3)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Quickness of Action +4", suffix = true, addon=true,
	level_range = {20, nil},
	rarity = 20,
	cost = resolvers.value{platinum=11000},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_DEX, 4)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Quickness of Action +5", suffix = true, addon=true,
	level_range = {21, nil},
	rarity = 25,
	cost = resolvers.value{platinum=13750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_DEX, 5)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Understanding +1", suffix = true, addon=true,
	level_range = {15, nil},
	rarity = 5,
	cost = resolvers.value{platinum=2750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_WIS, 1)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Understanding +2", suffix = true, addon=true,
	level_range = {17, nil},
	rarity = 10,
	cost = resolvers.value{platinum=5500},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_WIS, 2)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Understanding +3", suffix = true, addon=true,
	level_range = {19, nil},
	rarity = 15,
	cost = resolvers.value{platinum=8250},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_WIS, 3)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Understanding +4", suffix = true, addon=true,
	level_range = {20, nil},
	rarity = 20,
	cost = resolvers.value{platinum=11000},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_WIS, 4)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Understanding +5", suffix = true, addon=true,
	level_range = {21, nil},
	rarity = 25,
	cost = resolvers.value{platinum=13750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_WIS, 5)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Clear Thought +1", suffix = true, addon=true,
	level_range = {15, nil},
	rarity = 5,
	cost = resolvers.value{platinum=2750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_INT, 1)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Clear Thought +2", suffix = true, addon=true,
	level_range = {17, nil},
	rarity = 10,
	cost = resolvers.value{platinum=5500},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_INT, 2)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Clear Thought +3", suffix = true, addon=true,
	level_range = {19, nil},
	rarity = 15,
	cost = resolvers.value{platinum=8250},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_INT, 3)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Clear Thought +4", suffix = true, addon=true,
	level_range = {20, nil},
	rarity = 20,
	cost = resolvers.value{platinum=11000},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_INT, 4)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Clear Thought +5", suffix = true, addon=true,
	level_range = {21, nil},
	rarity = 25,
	cost = resolvers.value{platinum=13750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_INT, 5)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Leadership and Influence +1", suffix = true, addon=true,
	level_range = {15, nil},
	rarity = 5,
	cost = resolvers.value{platinum=2750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CHA, 1)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Leadership and Influence +2", suffix = true, addon=true,
	level_range = {17, nil},
	rarity = 10,
	cost = resolvers.value{platinum=5500},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CHA, 2)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Leadership and Influence +3", suffix = true, addon=true,
	level_range = {19, nil},
	rarity = 15,
	cost = resolvers.value{platinum=8250},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CHA, 3)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Leadership and Influence +4", suffix = true, addon=true,
	level_range = {20, nil},
	rarity = 20,
	cost = resolvers.value{platinum=11000},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CHA, 4)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}

newEntity{
	name = " of Leadership and Influence +5", suffix = true, addon=true,
	level_range = {21, nil},
	rarity = 25,
	cost = resolvers.value{platinum=13750},
    use_simple = { name = "read",
    use = function(self, who)
        who:incStat(Stats.STAT_CHA, 5)
       game.logSeen(who, "%s uses %s!", who.name:capitalize(), self:getName())
    return {used = true, destroy = true}
end
},
}
