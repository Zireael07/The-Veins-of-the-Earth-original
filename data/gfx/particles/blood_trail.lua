-- Veins of the Earth
-- Copyright (C) 2014 Zireael
--
-- based on
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

local nb = 0

return { generator = function()
    local sizea = 0.05

	return {
		trail = 1,
		life = rng.range(7, 14),
		size = 3, sizev = 0, sizea = sizea,

		x = rng.range(-engine.Map.tile_w / 3, engine.Map.tile_w / 3), xv = 0, xa = -sizea,
		y = rng.range(-engine.Map.tile_h / 3, engine.Map.tile_h / 3), yv = 0, ya = -sizea,
		dir = 0, dirv = 0, dira = 0,
		vel = 0, velv = 0, vela = 0,

        r = rng.range(10, 30)/255, rv = rng.range(0, 10)/100, ra = 0,
        g = 0, gv = 0, ga = 0,
        b = 0,  bv = 0, ba = 0,
        a = rng.range(70, 255)/255, av = -0.05, aa = 0,
	}
end, },
function(self)
	if nb < 1 then
		self.ps:emit(10)
	end
	nb = nb + 1
end,
40

