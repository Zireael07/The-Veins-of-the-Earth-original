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

local side = rng.table{4,6,2,8}
local blur = blur or 0
local first = true
local life
if side == 2 then dir = 90      life = height
elseif side == 8 then dir = 270 life = height
elseif side == 4 then dir = 180 life = width
elseif side == 6 then dir = 0   life = width
end

dir = math.rad(dir)

local first = true

return { generator = function()
	local x, y
	if first then
		x = rng.range(0, width) y = rng.range(0, height)
	else
		if side == 2 then x = rng.range(0, width) y = 0
		elseif side == 8 then x = rng.range(0, width) y = height
		elseif side == 6 then x = 0 y = rng.range(0, height)
		else x = width y = rng.range(0, height)
		end
	end
	local vel = rng.float(vel_min or 0.3, vel_max or 2)

	return {
		life = life / vel,
		size = rng.float(1, 8), sizev = 0, sizea = 0,

		x = x, xv = 0, xa = 0,
		y = y, yv = 0, ya = 0,
		dir = dir, dirv = blur, dira = 0,
		vel = vel, velv = 0, vela = 0,

		r = 1, rv = 0, ra = 0,
		g = 1, gv = 0, ga = 0,
		b = 1, bv = 0, ba = 0,
		a = rng.float(0.5, 1), av = 0, aa = 0,
	}
end, },
function(self)
	if first then
		self.ps:emit(700)
	else
		self.ps:emit(1)
	end
	first = false
end,
1000