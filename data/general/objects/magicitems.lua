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

--Amulets
newEntity{
    define_as = "BASE_AMULET",
    slot = "AMULET",
    type = "amulet", subtype = "amulet",
    display = "0", color=colors.RED,
    encumber = 0,
    rarity = 5,
    name = "An amulet",
    desc = [[An amulet.]],
}

newEntity{
    base = "BASE_AMULET",
    name = "amulet of natural armor +1",
    unided_name = "an amulet",
    level_range = {1,10},
    cost = 2000,
    wielder = {
    combat_def=1
  }, 
}

newEntity{
    base = "BASE_AMULET",
    name = "amulet of natural armor +2",
    unided_name = "an amulet",
    level_range = {1,10},
    cost = 8000,
    wielder = {
    combat_def=2
  }, 
}

newEntity{
    base = "BASE_AMULET",
    name = "amulet of natural armor +3",
    unided_name = "an amulet",
    level_range = {1,10},
    cost = 18000,
    wielder = {
    combat_def=3
  }, 
}

newEntity{
    base = "BASE_AMULET",
    name = "amulet of natural armor +4",
    unided_name = "an amulet",
    level_range = {1,10},
    cost = 32000,
    wielder = {
    combat_def=4
  }, 
}

newEntity{
    base = "BASE_AMULET",
    name = "amulet of natural armor +5",
    unided_name = "an amulet",
    level_range = {10,30},
    cost = 50000,
    wielder = {
    combat_def=5
  }, 
}

--Rings
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
    base = "BASE_RING",
    name = "ring of protection +1",
    unided_name = "a ring",
    level_range = {1,10},
    cost = 2000,
    wielder = {
    combat_def=1
  }, 
}

newEntity{
    base = "BASE_RING",
    name = "ring of protection +2",
    unided_name = "a ring",
    level_range = {1,10},
    cost = 8000,
    wielder = {
    combat_def=2
  }, 
}

newEntity{
    base = "BASE_RING",
    name = "ring of protection +3",
    unided_name = "a ring",
    level_range = {1,10},
    cost = 18000,
    wielder = {
    combat_def=3
  }, 
}

newEntity{
    base = "BASE_RING",
    name = "ring of protection +4",
    unided_name = "a ring",
    level_range = {1,10},
    cost = 32000,
    wielder = {
    combat_def=4
  }, 
}

newEntity{
    base = "BASE_RING",
    name = "ring of protection +5",
    unided_name = "a ring",
    level_range = {1,10},
    cost = 50000,
    wielder = {
    combat_def=5
  }, 
}

--Wands
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

--Scrolls
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

--Tattoos
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
