-- Veins of the Earth
-- Zireael
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

require "engine.class"
local Base = require "engine.interface.ActorLife"

--- Handles actors life and death
module(..., package.seeall, class.inherit(Base))

function _M:init(t)
	self.max_life = t.max_life or 100
	self.life = t.life or self.max_life
	self.life_regen = t.life_regen or 0
	self.die_at = t.die_at or -10
end

--- Heal some
function _M:heal(value, src)
	if self.onHeal then value = self:onHeal(value, src) end
	self.life = util.bound(self.life + value, self.die_at, self.max_life)
	self.changed = true
end

--- Remove some HP from an actor
-- If HP is reduced to 0 then remove from the level and call the die method.<br/>
-- When an actor dies its dead property is set to true, to wait until garbage collection deletes it
-- @return true/false if the actor died and the actual damage done
function _M:takeHit(value, src, death_note)
	if self.onTakeHit then value = self:onTakeHit(value, src) end
	self.life = self.life - value
	self.changed = true
	if self.life <= self.die_at and not self.dead then
		if src.on_kill and src:on_kill(self) then return false, value end
		game.logSeen(self, "#{bold}#%s killed %s!#{normal}#", src.name:capitalize(), self.name)
		return self:die(src, death_note), value
	end
	return false, value
end

--- Called when died
function _M:die(src, death_note)
	if game.level:hasEntity(self) then game.level:removeEntity(self) end
	self.dead = true
	self.changed = true

	self:check("on_die", src, death_note)

	return true
end