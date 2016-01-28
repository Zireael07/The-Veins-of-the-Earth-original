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

require "engine.class"
local Particles = require "engine.Particles"

module(..., package.seeall, class.make)

function _M:init()
	self.particles = {}
end

function _M:activate()
end

function _M:resizeIconsHotkeysToolbar()
end

function _M:getMapSize()
	local w, h = core.display.size()
	return 0, 0, w, h
end

function _M:display(nb_keyframes)
	-- Now the map, if any
	--game:displayMap(nb_keyframes)
	if next(self.particles) then
		for p, pos in pairs(self.particles) do
			if p.ps:isAlive() then
				p.ps:toScreen(pos.x, pos.y, true, 1)
			else
				self.particles[p] = nil
			end
		end
	end
end

function _M:setupMouse(mouse)
end

function _M:toggleUI()
	self.no_ui = not self.no_ui
end

function _M:checkGameOption(name)
	return true
end

function _M:handleResolutionChange(w, h, ow, oh)
	return false
end

function _M:getMainMenuItems()
	return {}
end

function _M:isLocked()
	return true
end

function _M:addParticle(x, y, name, args)
	local p = Particles.new(name, 1, args)
	self.particles[p] = {x=x, y=y}
end
