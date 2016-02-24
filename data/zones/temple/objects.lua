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

load("/data/general/objects/objects.lua")

--Lore
for i = 1, 7 do
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
