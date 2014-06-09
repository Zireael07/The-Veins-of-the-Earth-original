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
	frag = "healing",
	vert = nil,
	args = {
		tex = { texture = 0 },
		time_factor = time_factor or 1000,
		beamColor1 = beamColor1 or {0x50/255, 0x9e/255, 0x01/255, 1.0},
		beamColor2 = beamColor2 or {0xa7/255, 0xe8/255, 0x01/255, 1.0},
		circleColor = circleColor or {1.0, 1.0, 1.0, 1.0},
		circleRotationSpeed = circleRotationSpeed or 1,
		circleDescendSpeed = circleDescendSpeed or 0,
		beamsCount = beamsCount or 20,
		noup = noup or 0,
	},
	resetargs = circleDescendSpeed and {
		tick_start = function() return core.game.getFrameTime() end,
	},
	clone = false,
}
