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

--Potions
newEntity{
    define_as = "BASE_POTION",
    slot = "INVEN",
    type = "potion",
    display = "!", color=colors.RED,
    encumber = 0,
    rarity = 5,
    name = "A potion",
    desc = [[A potion.]],
}

newEntity{
    base = "BASE_POTION",
    name = "a potion",
    level_range = {1,10},
    cost = 50,
    use_simple = { name = "heal light wounds",
    use = function(self,who)
    actor.heal (rng.dice(1,8) + 5)
    return {used = true, destroy = true}
  end
  }, 
}

newEntity{
    base = "BASE_POTION",
    name = "a potion",
    level_range = {4,10},
    cost = 300,
    use_simple = { name = "heal moderate wounds",
    use = function(self,who)
    actor.heal = (rng.dice(2,8) + 5)
    return {used = true, destroy = true}
  end
  }, 
}

--Light sources
newEntity{
    define_as = "BASE_LIGHT",
    slot = "LITE",
    type = "torch",
    display = "t", color=colors.YELLOW,
    encumber = 0,
    rarity = 10,
    name = "A torch",
    desc = [[A torch.]],
}


newEntity{
    base = "BASE_LIGHT",
    name = "a torch",
    level_range = {1,10},
    cost = 0,
    wielder = {
    lite=2
  }, 
}

newEntity{
    base = "BASE_LIGHT",
    name = "a lantern",
    level_range = {1,10},
    cost = 7,
    wielder = {
    lite=3
  }, 
}



--Consumables
newEntity{
    define_as = "BASE_FOOD",
    slot = "INVEN",
    type = "food",
    display = "%", color=colors.WHITE,
    encumber = 0,
    rarity = 8,
    name = "Food",
    desc = [[Some food.]],
}


newEntity{
    base = "BASE_FOOD",
    name = "food rations",
    level_range = {1,10},
    cost = 7,
    --nutrition
}

newEntity{
    base = "BASE_FOOD",
    name = "flask of water",
    level_range = {1,10},
    cost = 7,
    --nutrition
}


newEntity{
    base = "BASE_FOOD",
    name = "stale rations",
    level_range = {1,10},
    cost = 7,
    --no nutrition
}

newEntity{
    base = "BASE_FOOD",
    name = "stale water",
    level_range = {1,10},
    cost = 7,
    --no nutrition
}