-- ToME - Tales of Maj'Eyal
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

return {
	frag = "funky_bubbles",
	vert = nil,
	args = {
		color1 = color1 or {0.2, 0.1, 0.6, 1.0},
		color2 = color2 or {0.09, 0.7, 0.0, 1.0},
		time_factor = time_factor or 7000,
		zoom = zoom or 3,
		npow = npow or 0.3,
		xy = xy or {0, 0},
	},
	clone = false,
}
