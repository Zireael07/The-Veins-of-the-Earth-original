-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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

name = "Underdark"
long_name = "An Underdark roguelike"
short_name = "underdark"
author = { "Zireael", "x" }
homepage = "x"
version = {0,0,0}
engine = {1,0,4,"te4"}
description = [[
An Underdark roguelike, vaguely d20-based.
]]
starter = "mod.load"

show_only_on_cheat = false -- Example modules are not shown to normal players

score_formatters = {
	["???"] = {
		alive="#LIGHT_GREEN#{score} : #BLUE#{name}#LAST# the #LIGHT_RED#level {level} {subrace} {subclass}#LAST# is still alive and well on #GREEN#{where}#LAST##WHITE#",
		dead="{score} : #BLUE#{name}#LAST# the #LIGHT_RED#level {level} {subrace} {subclass}#LAST# died on #GREEN#{where}#LAST#, killed by a #RED#{killedby}#LAST#"
	},
}