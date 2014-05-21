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

local Talents = require "engine.interface.ActorTalents"

local luck = (game.player:getLuc()-10)/2

load("/data/general/objects/armor.lua") -- rarity(-luck))
load("/data/general/objects/shields.lua")

load("/data/general/objects/weapons.lua") --rarity(-luck))
load("/data/general/objects/ranged.lua") --rarity(-luck))
load("/data/general/objects/exotic.lua") --rarity(-luck))
load("/data/general/objects/exoticranged.lua") --, rarity(-luck))
load("/data/general/objects/reach.lua") --rarity(-luck))

load("/data/general/objects/consumables.lua")
load("/data/general/objects/containers.lua")

load("/data/general/objects/wondrous_items.lua") --, rarity(-luck))
load("/data/general/objects/magic_items.lua") -- rarity(-luck))
load("/data/general/objects/poisons.lua")

load("/data/general/objects/pickaxes.lua")
load("/data/general/objects/money.lua") -- rarity(-luck))

--Bones
newEntity{
    define_as = "BONES",
    image = "tiles/bones.png",
    display = "%", color=colors.WHITE,
    encumber = 30,
    name = "bones",
    desc = [[Bones of some dead adventurer.]],
}

--Light sources
newEntity{
    define_as = "BASE_LIGHT",
    slot = "LITE",
    type = "torch", subtype = "lite",
    image = "tiles/torch.png",
    display = "~", color=colors.YELLOW,
    encumber = 0,
    rarity = 10,
    name = "torch",
    desc = [[A torch.]],
}

--Should last 5000 turns
newEntity{
    base = "BASE_LIGHT",
    name = "torch",
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
    level_range = {10, nil},
    cost = 5000,
    wielder = {
    lite=2
  }, 
}

--Should last 7500 turns
newEntity{
    base = "BASE_LIGHT",
    name = "lantern",
    image = "tiles/torch.png",
    level_range = {5,nil},
    cost = 7,
    wielder = {
    lite=3
  }, 
}

--Burnt out torch
newEntity{
    base = "BASE_LIGHT",
    name = "burnt out torch",
    level_range = {1,10},
    cost = 0,
}

--Burnt out lantern
newEntity{
    base = "BASE_LIGHT",
    name = "burnt out lantern",
    image = "tiles/lantern.png",
    level_range = {5,nil},
    cost = 0,
}


--Tools or kits
newEntity{
    define_as = "BASE_TOOL",
    slot = "TOOL",
    type = "tool", subtype = "skill",
    image = "tiles/kit.png",
    display = "^", color=colors.YELLOW,
    encumber = 1,
    rarity = 10,
    name = "tool kit",
    desc = [[tool kit.]],
}

newEntity{
    base = "BASE_TOOL",
    name = "healing kit",
    level_range = {1,10},
    cost = 100,
    wielder = {
    skill_bonus_heal = 2
  }, 
}

newEntity{
    base = "BASE_TOOL",
    name = "lockpicking kit",
    level_range = {1,10},
    cost = 100,
    wielder = {
    skill_bonus_openlock = 2
  }, 
}

newEntity{
    base = "BASE_TOOL",
    name = "survival kit",
    level_range = {1,10},
    cost = 100,
    wielder = {
    skill_bonus_survival = 2
  }, 
}
