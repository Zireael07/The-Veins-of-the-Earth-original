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
local Chat = require "engine.Chat"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
    local reaction = self:reactionToward(target)
    if reaction < 0 then
        return self:attackTarget(target)
    elseif reaction >= 0 then
        -- Talk ?
        if self.player and target.can_talk then
            local chat = Chat.new(target.can_talk, target, self)
            chat:invoke()
        elseif target.player and self.can_talk then
            local chat = Chat.new(self.can_talk, self, target)
            chat:invoke()
        elseif self.move_others then
            -- Displace
            game.level.map:remove(self.x, self.y, Map.ACTOR)
            game.level.map:remove(target.x, target.y, Map.ACTOR)
            game.level.map(self.x, self.y, Map.ACTOR, target)
            game.level.map(target.x, target.y, Map.ACTOR, self)
            self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
        end
    end
end

--Lukep's combat patch
function _M:attackTarget(target, noenergy)
   if self.combat then
      -- returns your weapon if you are armed, or unarmed combat.
      local weapon = (self:getInven("MAIN_HAND") and self:getInven("MAIN_HAND")[1]) or self
      -- returns your offhand weapon (not shield) or your weapon again if it is double
      local offweapon = (self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1] and self:getInven("OFF_HAND")[1].combat and self:getInven("OFF_HAND")[1]) or (weapon and weapon.double and weapon)

      local twohanded = false

      if not (self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1]) and not weapon.double and not weapon.light then
         twohanded = true
      end


      -- add in modifiers for dualwielding, etc.
      local attackmod = 0
      local strmod = 1

      if twohanded then strmod = 1.5 end

      if offweapon then
         attackmod = -6
         if offweapon.light or weapon.double then attackmod = attackmod + 2 end
         if self:knowTalent(self.T_TWO_WEAPON_FIGHTING) then attackmod = attackmod + 2 end
      end

      self:attackRoll(target, weapon, attackmod, strmod)

      --extra attacks for high BAB, at lower bonuses
      if self.combat_bab >=6 then
         self:attackRoll(target, weapon, attackmod - 5, strmod)
      end
      if self.combat_bab >=11 then
         self:attackRoll(target, weapon, attackmod - 10, strmod)
      end
      if self.combat_bab >=16 then
         self:attackRoll(target, weapon, attackmod - 15, strmod)
      end
      
      -- offhand/double weapon attacks
      if offweapon then
         strmod = 0.5
         attackmod = -10
         if offweapon.light or weapon.double then attackmod = attackmod + 2 end
         if self:knowTalent(self.T_TWO_WEAPON_FIGHTING) then attackmod = attackmod + 6 end

         self:attackRoll(target, offweapon, attackmod, strmod)

         if self:knowTalent(self.T_IMPROVED_TWO_WEAPON_FIGHTING) then
            self:attackRoll(target, offweapon, attackmod - 5, strmod)
         end
         if self:knowTalent(self.T_GREATER_TWO_WEAPON_FIGHTING) then
            self:attackRoll(target, offweapon, attackmod - 10, strmod)
         end
      end
   end

-- We use up our own energy
   if not noenergy then
      self:useEnergy(game.energy_to_act)
   end
end

function _M:attackRoll(target, weapon, atkmod, strmod)
   local d = rng.range(1,20)
   local hit = true
   local crit = false
    local attack = (self.combat_bab or 0) + (self.combat_attack or 0)

   -- Proficiency penalties
    if weapon and weapon.simple and not self:knowTalent(self.T_SIMPLE_WEAPON_PROFICIENCY) then
        attack = (attack -4)
    end

   if weapon and weapon.martial and not self:knowTalent(self.T_MARTIAL_WEAPON_PROFICIENCY) then
      attack = (attack -4)
   end

   -- Feat bonuses
   if self:knowTalent(self.T_WEAPON_FOCUS) and weapon and weapon.subtype == self.weapon_type then
      attack = (attack + 1)
   end

   -- Stat bonuses
   local stat_used = "str"

   if weapon and weapon.ranged then
      stat_used = "dex"
   end

    -- Finesse
   if self:knowTalent(self.T_FINESSE) and weapon and not weapon.ranged then

      local success = false

        -- hack to get the armour check penalty of the shield.  Returns 4 instead of 10 for tower shields, and does not account for mithril bonuses.
        local shield = self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1] and self:getInven("OFF_HAND")[1].subtype == shield and self:getInven("OFF_HAND")[1].wielder.combat_shield

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

        -- final check if Finesse improves attack
        if self:getStat("dex") > self:getStat("str") + shield * 2 then
            success = false
        end

        if success then
            stat_used = "dex"
        end
   end

   attack = attack + (atkmod or 0) + (weapon and weapon.combat.magic_bonus or 0) + (self:getStat(stat_used)-10)/2 or 0

   local ac = target:getAC()

   -- Hit check
    if self:isConcealed(target) and rng.chance(self:isConcealed(target)) then hit = false
    elseif d == 1 then hit = false
    elseif d == 20 then hit = true
    elseif d + attack < ac then hit = false
    end

   -- log message
    if hit then
        game.log(("%s hits the enemy! %d + %d = %d vs AC %d"):format(self.name:capitalize(), d, attack, d+attack, ac))
    else
        game.log(("%s misses the enemy! %d + %d = %d vs AC %d"):format(self.name:capitalize(), d, attack, d+attack, ac))
    end


    -- Crit check TODO Improved Critical
    local threat = 0 + (weapon and weapon.combat.threat or 0)
    if hit and d >= 20 - threat then
      -- threatened critical hit confirmation roll
      if not (rng.range(1,20) + attack < ac) then
         crit = true
      end
   end
   
   if hit then
      local dam = rng.dice(weapon.combat.dam[1],weapon.combat.dam[2])

      -- magic damage bonus
      dam = dam + (weapon and weapon.combat.magic_bonus or 0)

      -- Stat damage bonus
      if weapon and weapon.ranged then
         strmod = strmod or 0
      else
         strmod = strmod or 1
      end

      dam = dam + strmod * (self:getStr()-10)/2

      if crit then
            game.log(("%s makes a critical attack!"):format(self.name:capitalize()))
         dam = dam * (weapon and weapon.combat.critical or 2)
      end


      if self:knowTalent(self.T_FAVORED_ENEMY) then
            if target.type ~= "humanoid" then
                if target.type == self.favored_enemy then dam = dam + 2 end
            else
                if target.subtype == self.favored_enemy then dam = dam + 2 end
            end
        end   

      --Minimum 1 point of damage unless Damage Reduction works
        dam = math.max(1, dam)
        dam = dam - (target.combat_dr or 0)

        target:takeHit(dam, self)
        game.log(("%s deals %d damage to %s!"):format(self.name:capitalize(), dam, target.name:capitalize()))
   end
end