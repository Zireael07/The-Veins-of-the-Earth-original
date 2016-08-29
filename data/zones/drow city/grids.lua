-- Veins of the Earth
-- Copyright (C) 2014-2016 Zireael
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


load("/data/general/grids/drow.lua")

--Random houses
newEntity{
    define_as = "HOUSE_ENTRANCE",
    type = "floor", subtype = "floor",
    name = "noble compound entrance",
    image = "tiles/terrain/stairs_up.png",
    display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
    notice = true,
    always_remember = true,
    change_level = 1,
    change_zone = game.state:getRandomHouse(),
}
