-- Veins of the Earth
-- Copyright (C) 2013 Zireael
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

name = "VotE"
long_name = "The Veins of the Earth"
short_name = "veins"
author = { "Zireael", "x" }
homepage = "https://github.com/Zireael07/The-Veins-of-the-Earth"
version = {0,7,0}
engine = {1,0,4,"te4"}
description = [[
In DarkGod's words, "a fantasy d20-themed dungeon crawler".
]]
starter = "mod.load"

no_get_name = true

show_only_on_cheat = false -- Example modules are not shown to normal players

score_formatters = {
	["Veins"] = {
		alive="#BLUE#{name}#LAST#",
		dead="#BLUE#{name}#LAST#"
	},
}
