-- Veins of the Earth
-- Zireael 2013-2015
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
    image = "tiles/object/amulet_natural.png",
    display = "♂", color=colors.RED,
    encumber = 0,
    rarity = 10,
    level_range = {1,nil},
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
    level_range = {1,nil},
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

--Bracers
newEntity{
    define_as = "BASE_BRACERS",
    slot = "GLOVES",
    type = "bracer", subtype = "bracer",
    image = "tiles/new/bracers.png",
    display = "Ξ", color=colors.RED,
    encumber = 1,
    rarity = 8,
    level_range = {1,nil},
    identified = false,
    name = "bracers", short_name = "bracer",
    unided_name = "bracers",
    desc = [[A set of bracers.]],
    resolvers.flavored(),
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
    level_range = {1,nil},
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
    rarity = 5,
    identified = false,
    level_range = {1,nil},
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
    level_range = {1,nil},
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

newEntity{ base = "BASE_MAGITEM",
    define_as = "BASE_HELM",
    slot = "HELM",
    type = "helm", subtype = "helm",
    image = "tiles/object/helmet_metal.png",
    display = "₵", color=colors.RED,
    moddable_tile = resolvers.moddable_tile("helm"),
    encumber = 1,
    rarity = 10,
    name = "helm", short_name = "helm",
    unided_name = "helm",
    desc = [[A helmet.]],
    egos = "/data/general/objects/properties/wondrous_items.lua", egos_chance = { prefix=0, suffix=100},
}

newEntity{ base = "BASE_HELM",
    subtype = "ioun",
    image = "tiles/new/ioun_stone.png",
    display = "*", color=colors.RED,
    rarity = 20,
    name = "ioun stone", short_name = "ioun",
    unided_name = "stone",
    desc = [[A small oblong stone.]],
}

newEntity{ base = "BASE_HELM",
    image = "tiles/object/circlet.png",
    display = "₵", color=colors.SLATE,
    rarity = 15,
    name = "circlet", short_name = "circlet",
    desc = [[A simple circlet.]],
}

newEntity{ base = "BASE_HELM",
    image = "tiles/object/crown_golden.png",
    display = "₵", color=colors.YELLOW,
    rarity = 15,
    name = "crown", short_name = "crown",
    desc = [[A beautiful jewelled crown.]],
}

newEntity{
    type = "book", subtype = "book",
    slot = "INVEN",
    image = "tiles/UT/book.png",
    display = "▣", color=colors.RED,
    rarity = 5,
    level_range = {15,nil}, --equal to lowest ego
    identified = false,
    name = "tome", short_name = "tome",
    unided_name = "book",
    desc = [[A thick book.]],
--    addons = "/data/general/objects/properties/tomes.lua",
    egos = "/data/general/objects/properties/tomes.lua", egos_chance={prefix=0, suffix=100},
}
