-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2016 Nicolas Casalini
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

w = w * 0.90
h = h * 0.90
local hw = w / 2
local hh = h / 2

local corners = {
	{x =  hw, y = -hh, xv= 0, yv= 1,},
	{x =  hw, y =  hh, xv=-1, yv= 0,},
	{x = -hw, y =  hh, xv= 0, yv=-1,},
	{x = -hw, y = -hh, xv= 1, yv= 0,},
}

local nb = 0
local cornerid = 1
local posid = 0

return { blend_mode=core.particles.BLEND_SHINY, generator = function()
	local corner = corners[cornerid]
	cornerid = cornerid + 1
	if cornerid > 4 then cornerid = 1 posid = posid + 1 end
	if posid > 1 then posid = 0 end

	local life = 12
	local size = 9
	local sizev = -0.5 * size / life
	local x, y = corner.x, corner.y
	local speed = w / life
	-- if posid == 1 then
	-- 	size = size + sizev
	-- 	life = life - 1
	-- 	x = x + speed * corner.xv
	-- 	y = y + speed * corner.yv
	-- end

	return {
		trail = 0,
		life = life,
		size = size, sizev = sizev, sizea = 0,

		x = x, xv = speed * corner.xv, xa = 0,
		y = y, yv = speed * corner.yv, ya = 0,
		dir = 0, dirv = 0, dira = 0,
		vel = 0, velv = 0, vela = 0,

		r = rng.range(160, 255)/255,   rv = 0, ra = 0,
		g = rng.range(160, 255)/255,   gv = 0, ga = 0,
		b = rng.range(20, 85)/255,   gv = 0, ga = 0,
		a = rng.float(0.3, 0.7),  av = 0, aa = 0,
	}
end, },
function(self)
	if nb <= 10 then self.ps:emit(4) end
	nb = nb + 1
end,
40, nil, true
