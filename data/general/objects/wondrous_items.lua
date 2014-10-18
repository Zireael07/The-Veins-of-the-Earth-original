-- Veins of the Earth
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"

newEntity{
    define_as = "BASE_MAGITEM",
    level_range = {1,nil},
    identified = false,
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=80},
}


--Amulets
newEntity{ 
    define_as = "BASE_AMULET",
    slot = "AMULET",
    type = "amulet", subtype = "amulet",
    image = "tiles/amulet_natural.png",
    display = "♂", color=colors.RED,
    encumber = 0,
    rarity = 10,
    level_range = {1,nil},
    identified = false,
    unided_name = "an amulet",
    name = "an amulet",
    desc = [[A beautiful amulet.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}


--Rings
newEntity{
    define_as = "BASE_RING",
    slot = "RING",
    type = "ring", subtype = "ring",
    display = "σ", color=colors.RED,
    image = "tiles/ring.png",
    encumber = 0,
    rarity = 10,
    level_range = {1,nil},
    identified = false,
    name = "a ring",
    desc = [[A pretty ring.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}


--[[newEntity{
    base = "BASE_RING",
    name = "ring of darkvision +2",
    unided_name = "a ring",
    identified = false,
    level_range = {10,20},
    cost = 8000,
    wielder = {
    infravision=2
  }, 
}]]

--Bracers
newEntity{
    define_as = "BASE_BRACERS",
    slot = "GLOVES",
    type = "bracer", subtype = "bracer",
    image = "tiles/newtiles/bracers.png",
    display = "Ξ", color=colors.RED,
    encumber = 1,
    rarity = 8,
    level_range = {1,nil},
    identified = false,
    name = "bracers",
    unided_name = "bracers",
    desc = [[A set of bracers.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}

--Cloaks
newEntity{
    define_as = "BASE_CLOAK",
    slot = "CLOAK",
    type = "cloak", subtype = "cloak",
    image = "tiles/cloak.png",
    display = "♠", color=colors.RED,
    moddable_tile = resolvers.moddable_tile("cloak"),
    encumber = 0,
    rarity = 10,
    name = "a cloak",
    desc = [[A beautiful cloak.]],
}

newEntity{
    base = "BASE_CLOAK",
    unided_name = "a cloak",
    identified = false,
    level_range = {1,nil},
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}

--[[newEntity{
    base = "BASE_CLOAK",
    name = "cloak of elvenkind",
    unided_name = "a cloak",
    image = "tiles/elven_cloak.png",
    display = "♠", color=colors.GREEN,
    identified = false,
    level_range = {1,10},
    cost = 2500,
    wielder = {
    skill_hide=5
  }, 
}]]

--Boots
newEntity{ 
    define_as = "BASE_BOOTS",
    slot = "BOOTS",
    type = "boots", subtype = "boots",
    image = "tiles/boots.png",
    display = "ω", color=colors.RED,
    encumber = 1,
    rarity = 5,
    name = "boots",
    desc = [[A pair of boots.]],
    resolvers.flavored(),
}

newEntity{
    base = "BASE_BOOTS",
    name = "boots of striding and springing",
    unided_name = "boots",
    identified = false,
    level_range = {5,15},
    cost = 5500,
    wielder = {
    skill_jump=5,
    movement_speed = 1.33
  }, 
}

--[[newEntity{
    base = "BASE_BOOTS",
    name = "boots of elvenkind",
    unided_name = "boots",
    identified = false,
    level_range = {1,10},
    cost = 2500,
    wielder = {
    skill_movesilently=5
  }, 
}]]

newEntity{
    base = "BASE_BOOTS",
    name = "boots of dodging",
    unided_name = "boots",
    identified = false,
    level_range = {10,20},
    cost = 5500,
    wielder = {
    learn_talent = { 
    [Talents.T_DODGE] = 1,
    [Talents.T_MOBILITY] = 1,
    },
  }, 
}

--Belts
newEntity{
    define_as = "BASE_BELT",
    slot = "BELT",
    type = "belt", subtype = "belt",
    image = "tiles/newtiles/belt.png",
    display = "=", color=colors.RED,
    encumber = 1,
    rarity = 15,
    identified = false,
    level_range = {1,nil},
    name = "a belt",
    unided_name = "a belt",
    desc = [[A sturdy belt.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}
