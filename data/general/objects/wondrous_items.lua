-- Veins of the Earth
-- Zireael 2013-2016
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
    level_range = {4,nil}, --equal to lowest ego
    identified = false,
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=80},
}

--New low-level items
newEntity{
    type = "ring", subtype = "ring",
    slot = "RING",
    image = "tiles/object/ring_signet.png",
    display = "σ", color=colors.YELLOW,
    rarity = 5,
    encumber = 0,
    level_range = {1, nil},
    identified = false,
    name = "signet ring", short_name = "ring",
    unided_name = "ring",
    desc = [[A ring with a jewel and a mark of a noble.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=80},
    --addons = "/data/general/objects/properties/"
}

newEntity{
    slot = "AMULET", --this is a slotted version (cheaper)
    type = "amulet", subtype = "amulet",
    image = "tiles/object/amulet_insignia.png",
    display = "♂", color=colors.SLATE,
    encumber = 0,
    rarity = 10,
    level_range = {1,nil},
    identified = false,
    unided_name = "insignia",
    name = "insignia", short_name = "insignia",
    desc = [[An oval flat disk of slate gray stone with markings.]],
    egos = "/data/general/objects/properties/charged.lua", egos_chance = {prefix=0, suffix=80},
}


--Amulets
newEntity{
    define_as = "BASE_AMULET",
    slot = "AMULET",
    type = "amulet", subtype = "amulet",
    image = "tiles/object/amulet_natural.png",
    display = "♂", color=colors.RED,
    encumber = 0,
    rarity = 10,
    level_range = {4,nil},
    identified = false,
    unided_name = "amulet",
    name = "amulet", short_name = "amulet",
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
    image = "tiles/object/ring.png",
    encumber = 0,
    rarity = 10,
    level_range = {4,nil},
    identified = false,
    unided_name = "ring",
    name = "ring", short_name = "ring",
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

--Gloves
newEntity{
    define_as = "BASE_GLOVES",
    slot = "GLOVES",
    type = "gloves", subtype = "gloves",
    image = "tiles/new/bracers.png",
    display = "Ξ", color=colors.RED,
    encumber = 1,
    rarity = 18,
    level_range = {4,nil},
    identified = false,
    name = "gloves", short_name = "glove",
    unided_name = "glove",
    desc = [[A pair of soft gloves.]],
--    resolvers.flavored(),
    egos = "/data/general/objects/properties/bracers.lua", egos_chance = { prefix=0, suffix=100},
}

--Cloaks
newEntity{
    define_as = "BASE_CLOAK",
    slot = "CLOAK",
    type = "cloak", subtype = "cloak",
    image = "tiles/object/cloak.png",
    display = "♠", color=colors.RED,
    moddable_tile = resolvers.moddable_tile("cloak"),
    encumber = 0,
    rarity = 10,
    identified = false,
    level_range = {4,nil},
    name = "cloak", short_name = "cloak",
    unided_name = "cloak",
    desc = [[A beautiful cloak.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}


--[[newEntity{
    base = "BASE_CLOAK",
    name = "cloak of elvenkind",
    unided_name = "a cloak",
    image = "tiles/object/elven_cloak.png",
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
    image = "tiles/object/boots.png",
    display = "ω", color=colors.RED,
    moddable_tile = resolvers.moddable_tile("leather_boots"),
    encumber = 1,
    rarity = 15,
    identified = false,
    level_range = {4,nil},
    name = "boots", short_name = "boots",
    unided_name = "boots",
    desc = [[A pair of boots.]],
    resolvers.flavored(),
    egos = "/data/general/objects/properties/boots.lua", egos_chance = { prefix=0, suffix=100},
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

--Belts
newEntity{
    define_as = "BASE_BELT",
    slot = "BELT",
    type = "belt", subtype = "belt",
    image = "tiles/object/belt_jewel.png",
    display = "=", color=colors.RED,
    encumber = 1,
    rarity = 15,
    identified = false,
    level_range = {4,nil},
    name = "belt", short_name = "belt",
    unided_name = "belt",
    desc = [[A sturdy leather belt studded with jewels.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}

newEntity{ base = "BASE_BELT",
    name = "girdle", short_name = "girdle",
    unided_name = "girdle",
    desc = [[A girdle is a thick leather belt, occasionally enchanted to augment a wearer's hardiness or bestow other primal blessings.]],
    display = "ℸ", color=colors.RED,
    image = "tiles/object/belt.png",
}

--Tomes
newEntity{
    type = "book", subtype = "book",
    slot = "INVEN",
    image = "tiles/UT/book.png",
    display = "▣", color=colors.RED,
    rarity = 25,
    level_range = {15,nil}, --equal to lowest ego
    identified = false,
    name = "tome", short_name = "tome",
    unided_name = "book",
    desc = [[A thick book.]],
--    addons = "/data/general/objects/properties/tomes.lua",
    egos = "/data/general/objects/properties/tomes.lua", egos_chance={prefix=0, suffix=100},
}
