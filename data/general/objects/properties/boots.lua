--Veins of the Earth
--Zireael 2015

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

load("data/general/objects/properties/wondrous_items.lua")

newEntity{
    name = " of striding and springing", suffix = true,
    level_range = {1, 10},
    rarity = 10,
    cost = resolvers.value{platinum=500},
    school = "transmutation",
    wielder = {
        skill_jump=5,
        movement_speed = 1.33
    },
}

newEntity{
    name = " of dodging", suffix = true,
    level_range = {1, 10},
    rarity = 10,
    cost = resolvers.value{platinum=500},
    school = "transmutation",
    wielder = {
        learn_talent = {
            [Talents.T_DODGE] = 1,
            [Talents.T_MOBILITY] = 1,
        },
    },
}
