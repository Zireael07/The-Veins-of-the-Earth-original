--Veins of the Earth
--Zireael 2015

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

load("data/general/objects/properties/wondrous_items.lua")

--From Incursion
newEntity{
    name = " of powerful grip", suffix = true,
    level_range = {10, nil},
    rarity = 10,
    cost = resolvers.value{platinum=500},
    school = "transmutation",
    wielder = {
        learn_talent = {
            [Talents.T_MONKEY_GRIP] = 1,
            [Talents.T_POWER_ATTACK] = 1,
        },
    },
}

newEntity{
    name = " of the Dervish", suffix = true,
    level_range = {10, nil},
    rarity = 15,
    cost = resolvers.value{platinum=500},
    school = "transmutation",
    wielder = {
        learn_talent = {
            [Talents.T_TWO_WEAPON_FIGHTING] = 1,
            [Talents.T_POWER_ATTACK] = 1,
        },
    },
}

newEntity{
    name = " of neutralization", suffix = true,
    level_range = {15, nil},
    cost = resolvers.value{platinum=5000}, --eyeballed
    school = "transmutation",
    wielder = {
        learn_talent = {
            [Talents.T_ACID_IMMUNITY] = 1,
        },
    },
}

newEntity{
    name = " of grounding", suffix = true,
    level_range = {15, nil},
    cost = resolvers.value{platinum=5000}, --eyeballed
    school = "transmutation",
    wielder = {
        learn_talent = {
            [Talents.T_ELECTRIC_IMMUNITY] = 1,
        },
    },
}
