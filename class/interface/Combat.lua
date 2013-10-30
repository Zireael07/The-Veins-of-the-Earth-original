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
    local hit = true
    local crit = false
    local weapon = self:getInven("MAIN_HAND") and self:getInven("MAIN_HAND")[1]

    local stat_used = "str"

    if weapon and weapon.ranged then
        stat_used = "dex"
    end

    local attack = (self.combat_bab or 0) + (self.combat_attack or 0)

    local offweapon = self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1]

    --I don't know how to differentiate between main hand and offhand at this point, so I made the penalties identical for both
    if weapon and offweapon and offweapon.light and not self:knowTalent(self.T_TWO_WEAPON_FIGHTING) then attack = (attack -6)
        elseif weapon and offweapon and not self:knowTalent(self.T_TWO_WEAPON_FIGHTING) then attack = (attack -8) 
        elseif weapon and offweapon and offweapon.light then attack = (attack - 2)
        elseif weapon and offweapon then attack = (attack -4)
        else attack = attack end

    --Proficiencies
    if weapon and weapon.simple and not self:knowTalent(self.T_SIMPLE_WEAPON_PROFICIENCY) then attack = (attack -4) 
        else attack = attack end
    if weapon and weapon.martial and not self:knowTalent(self.T_MARTIAL_WEAPON_PROFICIENCY) then attack = (attack -4) 
        else attack = attack end

    --Feat bonuses
    if self:knowTalent(self.T_WEAPON_FOCUS) and weapon and weapon.subtype == self.weapon_type then attack = (attack + 1) end

    if self:knowTalent(self.T_FINESSE) and weapon and not weapon.ranged then
        --Is the weapon light, or usable for finesse?
        local success = false
        if not weapon.light then
            local a = {"rapier", "whip", "spiked chain"}
            for _, w in pairs(a) do
                if weapon.subtype == w then
                    success = true
                    break
                end
            end
        else
            success = true
        end
        if success then
            stat_used = "dex"
        end
    end
    attack = attack + (self.weapon and self.weapon.combat.magic_bonus or 0) + (self:getStat(stat_used)-10)/2 or 0


    local ac = target:getAC()

    -- Hit check
    if self:isConcealed(target) and rng.chance(self:isConcealed(target)) then hit = false
    elseif d == 0 then hit = false
    elseif d == 20 then hit = true
    elseif d + attack < ac then hit = false
    end

    if hit then
        game.log(("%s hits the enemy! Dice roll %d + bonus %d = %d vs AC %d"):format(self.name:capitalize(), d, attack, d+attack, ac))
    else
        game.log(("%s misses the enemy! Dice roll %d + bonus %d = %d vs AC %d"):format(self.name:capitalize(), d, attack, d+attack, ac))
    end

    -- Crit check
    local threat = 0 + (self.weapon and self.weapon.combat.threat or 0)
    if d >= 20 - threat then if rng.range(1,20) + attack > ac then crit = true end end -- if we qualify for a threat, check if its critical damage
    return hit, crit
end

--- Makes the death happen!
function _M:attackTarget(target, noenergy)
    if self.combat then
        

        local hit, crit = self:attackRoll(target)
      
        if hit then
            local dam = rng.dice(self.combat.dam[1],self.combat.dam[2]) + (self.weapon and self.weapon.combat.magic_bonus or 0) + (self:getStr()-10)/2

            if self:knowTalent(self.T_FAVORED_ENEMY) then
                if target.type ~= "humanoid" then 
                    if target.type == self.favored_enemy then dam = dam + 2 end
                else 
                    if target.subtype == self.favored_enemy then dam = dam + 2 end
                end
            end        
            
            --Minimum 1 point of damage unless Damage Reduction works
            dam = math.max(1, dam)
            dam = dam - target.combat_dr or 0

            if dam and crit then
                game.log(("%s makes a critical attack!"):format(self.name:capitalize()))
                dam = dam * (self.weapon and self.weapon.combat.critical or 2)
            end
            target:takeHit(dam, self)
            game.log(("%s deals %d damage to %s!"):format(self.name:capitalize(), dam, target.name:capitalize()))
        end
        
        local iterate = 0
        --Iterative attacks
        if self.more_attacks and self.more_attacks > 0 and iterate == 0 then 
            self:attackRoll(target)
            iterate = iterate + 1
        end
        --Offhand attacks
        local offhand_attacks = 0
        if offhand_attacks == 0 then
        
            
            local offweapon = self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1]
            if offweapon then
                self:attackRoll(target) 
                offhand_attacks = offhand_attacks + 1
            elseif weapon and weapon.double then
                self:attackRoll(target) 
                offhand_attacks = offhand_attacks + 1
            end
        end
    end
    -- We use up our own energy
    if not noenergy then
        self:useEnergy(game.energy_to_act)
    end
--    offhand_attacks = 0
end
