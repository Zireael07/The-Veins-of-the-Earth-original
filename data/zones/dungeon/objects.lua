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

