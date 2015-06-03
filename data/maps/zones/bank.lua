-- Veins of the Earth
-- Copyright (C) 2015 Zireael
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


defineTile("#", "WALL_WARDED")
defineTile("+", "DOOR_WARDED")
defineTile(".", "FLOOR")
defineTile("-", "FLOOR")
--defineTile("_", "FLOOR", nil, nil, nil, {no_teleport=true, no_drop=true})
defineTile(":", "WALL_WARDED")
defineTile("_", "FLOOR")

defineTile("b", "FLOOR", nil, "BASE_NPC_DROW_BANK" )


startx = 7
starty = 2

-- ASCII map section
return [[
:::::#:___::::#:#
:#######+#######:
:#...#.---.#...#:
:#.............#:
:#....#...#....#:
:##...........###
:#.............#:
##...#.....#...#:
:#.............#:
:##...........##:
:#....#####....#:
:#......b......#:
:#...#.---.#...#:
:###############:
:::##:#___#::::::]]
