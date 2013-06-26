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

newEntity{
    define_as = "BASE_BATTLEAXE",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="battleaxe",
    display = "/", color=colors.SLATE,
    encumber = 12,
    rarity = 3,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic battleaxe",
    desc = [[A normal battleaxe.]],
}

newEntity{ base = "BASE_BATTLEAXE",
    name = "iron battleaxe",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,6},
    },
}

newEntity{
    define_as = "BASE_SWORD",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="sword",
    display = "/", color=colors.SLATE,
    encumber = 10,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic sword",
    desc = [[A trusty sword.]],
}

newEntity{ base = "BASE_SWORD",
    name = "long sword",
    level_range = {1, 10},
    cost = 15,
    combat = {
        dam = {1,8},
    },
}

newEntity{
    define_as = "BASE_DAGGER",
    slot = "MAIN_HAND", offslot = "OFF_HAND",
    type = "weapon", subtype="dagger",
    display = "/", color=colors.SLATE,
    encumber = 3,
    rarity = 8,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic dagger",
    desc = [[A normal trusty dagger.]],
}

newEntity{ base = "BASE_DAGGER",
    name = "iron dagger",
    level_range = {1, 10},
    cost = 5,
    combat = {
        dam = {1,4},
    },
}

newEntity{
    define_as = "BASE_LIGHT_ARMOR",
    slot = "BODY",
    type = "armor", subtype="light",
    display = "[", color=colors.SLATE,
    encumber = 10,
    rarity = 5,
    name = "light armor",
    desc = [[A simple padded armor. Doesn't protect from much.]],
    }

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "padded armor",
    level_range = {1, 10},
    cost = 5,
    wielder = {
		combat_def = 1
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "leather armor",
    level_range = {1, 10},
    cost = 10,
    wielder = {
		combat_def = 2
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "studded leather",
    level_range = {1, 10},
    cost = 25,
    wielder = {
		combat_def = 3
	},
}

newEntity{ base = "BASE_LIGHT_ARMOR",
    name = "chain shirt",
    level_range = {1, 10},
    cost = 100,
    wielder = {
		combat_def = 4
	},
}

newEntity{
    define_as = "BASE_HEAVY_ARMOR",
    slot = "BODY",
    type = "armor", subtype="heavy",
    display = "[", color=colors.SLATE,
    encumber = 40,
    rarity = 2,
    name = "heavy armor",
    desc = [[A suit of armour made of mail.]],
}

newEntity{ base = "BASE_HEAVY_ARMOR",
    name = "chain mail",
    level_range = {1, 10},
    cost = 150,
    wielder = {
		combat_def = 5
	},
}

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
    actor.life = actor.life + rng.dice(1,8) + 5
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
    actor.life = actor.life + rng.dice(2,8) + 5
    return {used = true, destroy = true}
  end
  }, 
}