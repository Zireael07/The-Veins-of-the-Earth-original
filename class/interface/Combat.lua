-- Underdark
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
--


require "engine.class"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
	local reaction = self:reactionToward(target)
	if reaction < 0 then
		return self:attackTarget(target)
	elseif reaction >= 0 then
		if self.move_others then
			-- Displace
			game.level.map:remove(self.x, self.y, Map.ACTOR)
			game.level.map:remove(target.x, target.y, Map.ACTOR)
			game.level.map(self.x, self.y, Map.ACTOR, target)
			game.level.map(target.x, target.y, Map.ACTOR, self)
			self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
		end
	end
end

--- Did we hit? Did we crit?
-- Returns (bool hit, bool crit)
function _M:attackRoll(target)
    local d = rng.range(1,20)
    if d == 0 then return false, false end
end

--- Makes the death happen!
function _M:attackTarget(target, mult)
    if self.combat then
        local miss = false --did we miss from misc statuses?

        local dice = rng.dice(1,20)    
        local dam = rng.dice(self.combat.dam[1],self.combat.dam[2]) + (self:getStr()-10)/2 - target.combat_armor or 0
        --Random d20 for attack
        local attack = dice + self.combat_attack or 0 + (self:getStr()-10)/2 or 0
        --AC
        local ac = target.combat_def + (target:getDex()-10)/2 or 0

        --If the target is concealed, we might miss
        local concealed = self:isConcealed(target)
        if self:isConcealed(target) and rng.chance(self:isConcealed(target)) then miss = true end

        --Attack must beat AC to hit
        if not miss and attack > ac then
            target:takeHit(dam, self)
            game.log(("%s hits the enemy! d20 is %d and the attack is %d vs. AC %d"):format(self.name:capitalize(), dice, attack, ac))
        --Misses!
        else
            game.log(("%s misses the enemy! d20 is %d and the attack is %d vs. AC %d"):format(self.name:capitalize(), dice, attack, ac))
        end    
    end
    -- We use up our own energy
    self:useEnergy(game.energy_to_act)
end


