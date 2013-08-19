-- Underdark
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

local Talents = require "engine.interface.ActorTalents"

load("/data/general/objects/armor.lua")
load("/data/general/objects/weapons.lua")
load("/data/general/objects/ranged.lua")
load("/data/general/objects/exotic.lua")
load("/data/general/objects/exoticranged.lua")
load("/data/general/objects/shields.lua")
load("/data/general/objects/consumables.lua")
load("/data/general/objects/magicitems.lua")



--Light sources
newEntity{
    define_as = "BASE_LIGHT",
    slot = "LITE",
    type = "torch", subtype = "lite",
    display = "~", color=colors.YELLOW,
    encumber = 0,
    rarity = 10,
    name = "A torch",
    desc = [[A torch.]],
}

--Should last 5000 turns
newEntity{
    base = "BASE_LIGHT",
    name = "a torch",
    level_range = {1,10},
    cost = 0,
    wielder = {
    lite=2
  }, 
}
 
--Unlimited
newEntity{
    base = "BASE_LIGHT",
    name = "everlasting torch",
    level_range = {1,10},
    cost = 5000,
    wielder = {
    lite=2
  }, 
}

--Should last 7500 turns
newEntity{
    base = "BASE_LIGHT",
    name = "a lantern",
    level_range = {1,10},
    cost = 7,
    wielder = {
    lite=3
  }, 
}



newEntity{
    define_as = "BASE_RING",
    slot = "RING",
    type = "ring", subtype = "ring",
    display = "=", color=colors.RED,
    encumber = 0,
    rarity = 5,
    name = "A ring",
    desc = [[A ring.]],
}

newEntity{
    define_as = "BASE_WAND",
    slot = "INVEN", 
    type = "wand", subtype = "wand",
    display = "-", color=colors.RED,
    encumber = 0,
    rarity = 50,
    name = "A wand",
    desc = [[A wand.]],
}

newEntity{
    define_as = "BASE_SCROLL",
    slot = "INVEN", 
    type = "scroll", subtype = "scroll",
    display = "?", color=colors.WHITE,
    encumber = 0,
    rarity = 50,
    name = "A scroll",
    desc = [[A scroll.]],
}

newEntity{
    define_as = "BASE_TATTOO",
    slot = "INVEN", 
    type = "scroll", subtype = "tattoo",
    display = "?", color=colors.RED,
    encumber = 0,
    rarity = 50,
    name = "A tattoo",
    desc = [[A tattoo.]],
}

