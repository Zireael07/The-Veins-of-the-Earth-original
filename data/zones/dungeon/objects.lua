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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

newEntity{
    define_as = "BASE_BATTLEAXE",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="battleaxe",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic battleaxe",
    desc = [[A normal battleaxe.]],
}

newEntity{ base = "BASE_BATTLEAXE",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = rng.dice(1,6),
    },
}

newEntity{
    define_as = "BASE_SWORD",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic sword",
    desc = [[A trusty sword.]],
}

newEntity{ base = "BASE_SWORD",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = rng.dice(1,8),
    },
}

newEntity{
    define_as = "BASE_DAGGER",
    slot = "MAIN_HAND",
    slot_forbid = "OFF_HAND",
    type = "weapon", subtype="battleaxe",
    display = "/", color=colors.SLATE,
    encumber = 3,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dagger",
    desc = [[A normal trusty dagger.]],
}

newEntity{ base = "BASE_BATTLEAXE",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = rng.dice(1,4),
    },
}