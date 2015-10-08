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

local Talents = require "engine.interface.ActorTalents"

load("/data/general/objects/armor.lua")
load("/data/general/objects/shields.lua")

load("/data/general/objects/weapons.lua")
load("/data/general/objects/ranged.lua")
load("/data/general/objects/exotic.lua")
load("/data/general/objects/exoticranged.lua")
load("/data/general/objects/reach.lua")
load("/data/general/objects/thrown.lua")

load("/data/general/objects/consumables.lua")
load("/data/general/objects/containers.lua")

load("/data/general/objects/wondrous_items.lua")
load("/data/general/objects/magic_items.lua")
load("/data/general/objects/poisons.lua")

load("/data/general/objects/pickaxes.lua")
load("/data/general/objects/lite.lua")
load("/data/general/objects/tools.lua")

load("/data/general/objects/specific_items.lua")

--Lore
load("/data/general/objects/lore.lua")

if config.settings.veins.money_weight then
    load("/data/general/objects/variant/money_weight.lua")
else
    load("/data/general/objects/money.lua")
end


--Lore
newEntity{ base = "BASE_LORE",
    define_as = "NOTE1",
    lore = "start-1",
    desc = [[A paper scrap, left by an adventurer.]],
    rarity = false,
    encumber = 0,
}


for i = 2, 8 do
newEntity{ base = "BASE_LORE",
    define_as = "NOTE"..i,
    name = "tattered paper scrap", lore="misc-"..i,
    desc = [[A paper scrap, left by an adventurer.]],
    rarity = false,
    encumber = 0,
}
end


--Bones
newEntity{
    define_as = "BONES",
    image = "tiles/bones.png",
    display = "%", color=colors.WHITE,
    encumber = 30,
    name = "bones",
    desc = [[Bones of some dead adventurer.]],
}
