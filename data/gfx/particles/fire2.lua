-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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

return { generator = function()
    local x = rng.range(-20, 20)
    local y = 20 - math.abs(math.sin(x / 20) * 10)
    -- I'm not entirely sure that the "- size / 2" and "- sizea / 2" adjustments
    -- below are correct, but they seem to be...
    local size = rng.range(1, 8)
    local sizea = 0.025

    return {
        trail = 2,
        life = rng.range(7, 14),
        size = size, sizev = 0, sizea = sizea,

        x = x - size / 2, xv = 0, xa = 0 - sizea / 2,
        y = y - size / 2, yv = 0, ya = -0.4 - sizea / 2,
        dir = 0, dirv = 0, dira = 0,
        vel = 0, velv = 0, vela = 0,

        r = rng.range(10, 30)/255, rv = rng.range(0, 10)/100, ra = 0,
        g = 0, gv = 0, ga = 0,
        b = 0, bv = 0, ba = 0,
        a = rng.range(70, 255)/255, av = 0, aa = 0,
    }
end, },
function(self)
    self.ps:emit(20)
end,
80
