-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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
local Map = require "engine.Map"
require "engine.Generator"
local Random = require "mod.class.generator.actor.Random"

--- Very specialized generator that puts sandworms in interesting spots to dig tunnels
module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level, spots)
	engine.Generator.init(self, zone, map, level, spots)
	self.data = level.data.generator.actor

	self.random = Random.new(zone, map, level, spots)
end

function _M:generate()
	-- Make the random generator place normal actors
	self.random:generate()

	-- Now place sandworm tunnelers
	local used= {}
	for i = 1, self.data.nb_tunnelers do
		local s, idx = rng.table(self.spots)
		while used[idx] do s, idx = rng.table(self.spots) end
		used[idx] = true

		self:placeWorm(s)
	end

	-- Always add one near the stairs
	self:placeWorm(self.level.default_up)
	self:placeWorm(self.level.default_down)
end

function _M:placeWorm(s)
	if not s.x or not s.y then return end
	local m = self.zone:makeEntityByName(self.level, "actor", "XORN_TUNNELER")
	if m then
		local x, y = util.findFreeGrid(s.x, s.y, 5, true, {[Map.ACTOR]=true})
		if x and y then
			m.no_decay = true
			self.zone:addEntity(self.level, m, "actor", x, y)
		end
	end
end
