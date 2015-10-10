-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2015 Nicolas Casalini
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

local first = true
base_size = 32
local r = 255
local g = 0
local b = 0
if color then r, g, b = color.r, color.g, color.b end

return { generator = function()
	local size = rng.range(18, 28)
	local x = rng.range(-8, 8)
	local y = rng.range(-8, 8)

	return {
		life = 5,
		size = size, sizev = 0, sizea = 0,

		x = x, xv = 0, xa = 0,
		y = y, yv = 0, ya = 0,
		dir = 0, dirv = 0, dira = 0,
		vel = 0, velv = 0, vela = 0,

		r = r, rv = 0, ra = 0,
		g = g, gv = 0, ga = 0,
		b = b, bv = 0, ba = 0,
		a = rng.float(0.6, 1), av = 0.1, aa = 0,
	}
end, },
function(self)
	if first then
		self.ps:emit(1)
		first = false
	end
end,
--1, ("particles_images/attack_%02d"):format(rng.range(1, 19))
1, ("particles_images/attack")
