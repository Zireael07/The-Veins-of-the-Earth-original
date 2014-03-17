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

      --If not wielding anything in offhand and wielding a one-handed martial weapon then wield it two-handed
      local twohanded = false

      if not (self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1]) and not weapon.double and not weapon.light then
         twohanded = true
      end
      
      -- add in modifiers
      local attackmod = 0
      local strmod = 1

      --if wielding two-handed, apply 1.5*Str mod
      if twohanded then strmod = 1.5 end
      
      if weapon and weapon.slot_forbid == "OFF_HAND" and not self:knowTalent(self.T_MONKEY_GRIP) then strmod = 1.5 end
      
      --Monkey grip feat
    --  if self:knowTalent(self.T_MONKEY_GRIP) and weapon and weapon.slot_forbid == "OFF_HAND" then
          
      
      --Combat Expertise & Power Attack penalties (Zi)
      if self:isTalentActive(self.T_COMBAT_EXPERTISE) then 
        local d = rng.dice(1,5)
        attackmod = attackmod -d
      end

      if self:isTalentActive(self.T_POWER_ATTACK) then
        attackmod = attackmod - 5
      end 
      
      --Dual-wielding
      if offweapon then
         attackmod = attackmod -6
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
   if weapon and weapon.subtype and self:hasFocus(weapon.subtype) then attack = (attack + 1) end

   -- Stat bonuses
   local stat_used = "str"

   if weapon and weapon.ranged then
      stat_used = "dex"
   end

    -- Finesse
   if self:knowTalent(self.T_FINESSE) and weapon and not weapon.ranged then

      local success = false

        -- hack to get the armour check penalty of the shield.  Returns 4 instead of 10 for tower shields, and does not account for mithril bonuses.
        local shield = self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1] and self:getInven("OFF_HAND")[1].subtype == "shield" and self:getInven("OFF_HAND")[1].wielder.combat_shield

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
        if self:getStat("str") > self:getStat("dex") then
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


    -- Crit check
    local threat = 0 + (weapon and weapon.combat.threat or 0)
    
    --Improved Critical
    if weapon and weapon.subtype and self:hasCritical(weapon.subtype) then combat.weapon.threat = combat.weapon.threat + 2 end

    if hit and d >= 20 - threat then
      -- threatened critical hit confirmation roll
      if not (rng.range(1,20) + attack < ac) then
         crit = true
      end
   end
   
   if hit then

    self:dealDamage(target, weapon, crit) end
end


function _M:dealDamage(target, weapon, crit)
  local dam = rng.dice(weapon.combat.dam[1], weapon.combat.dam[2])

      -- magic damage bonus
      dam = dam + (weapon and weapon.combat.magic_bonus or 0)

      -- Stat damage bonus
      if weapon and weapon.ranged then
         strmod = strmod or 0
      else
         strmod = strmod or 1
      end

      dam = dam + strmod * (self:getStr()-10)/2

      --Power Attack damage bonus (Zireael)
      if self:isTalentActive(self.T_POWER_ATTACK) then dam = dam + 5 end

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

        if not target.dead and self:attr("poison") then
        self:applyPoison(self:attr("poison"), target)
        end
end

_M.poisons = {
  small_centipede = { 11, POISON_SMALL_CENTIPEDE, POISON_SMALL_CENTIPEDE },
  medium_spider = { 14, POISON_1d4STR, POISON_1d4STR },
  large_scorpion = { 18, POISON_1d6STR, POISON_1d6STR },

  nitharit = { 13, nil, POISON_3d6CON },
  sassone = { 16, nil, POISON_1d6CON },
  malyss = { 16, POISON_MALYSS_PRI, POISON_MALYSS_SEC },
  terinav = { 16, POISON_1d6DEX, POISON_TERINAV_SEC },
  blacklotus = { 20, POISON_3d6CON, POISON_3d6CON  },
  dragon = { 26, POISON_DRAGON_BILE, nil },
  toadstool = { 11, POISON_TOADSTOOL_PRI, POISON_TOADSTOOL_SEC },
  arsenic = { 13, POISON_1CON, POISON_ARSENIC_SEC },
  idmoss = { 14, POISON_1d4INT, POISON_MOSS_SEC },
  lichdust = { 17, POISON_2d6STR, POISON_1d6STR },
  darkreaver = { 18, POISON_2d6CON, POISON_DARK_REAVER_SEC },
  ungoldust = { 15, POISON_UNGOL_DUST_PRI, POISON_UNGOL_DUST_SEC },
  insanitymist = { 15, POISON_INSANITY_MIST_PRI, POISON_INSANITY_MIST_SEC },
  burnt_othur = { 18, POISON_1CON, POISON_3d6CON },
  blackadder = { 11, POISON_1d6CON, POISON_1d6CON },
  bloodroot = { 12, nil, POISON_BLOODROOT_SEC },
  greenblood = { 13, POISON_1CON, POISON_GREENBLOOD_SEC },
  whinnis = { 14, POISON_1CON, nil }, -- temporarily until I make unconsciousness work
  shadowessence = { 17, POISON_SHADOW_ESSENCE_PRI, POISON_2d6STR },
  wyvern = { 17, POISON_2d6CON, POISON_2d6CON },
  giantwasp = { 18, POISON_1d6DEX, POISON_1d6DEX },
  deathblade = { 20, POISON_1d6CON, POISON_2d6CON },
  purpleworm = { 24, POISON_1d6STR, POISON_2d6STR },
  }


function _M:applyPoison(poison, target)
  if not poison then return end
  
  if not target:fortitudeSave(poisons[poison][1]) then
  target.poison_timer = 10
    if poisons[poison][2] then target:setEffect(poisons[poison][2], 2, {}, true) end
  end

  if not target:fortitudeSave(poisons[poison][1]) then
    if target.poison_timer == 0 and poisons[poison][3] then target:setEffect(poisons[poisons][3], 2, {}, true) end
  end


end



_M.focuses = {
  axe = Talents.T_WEAPON_FOCUS_AXE,
  battleaxe = Talents.T_WEAPON_FOCUS_BATTLEAXE,
  bow = Talents.T_WEAPON_FOCUS_BOW,
  club = Talents.T_WEAPON_FOCUS_CLUB,
  crossbow = Talents.T_WEAPON_FOCUS_CROSSBOW,
  dagger = Talents.T_WEAPON_FOCUS_DAGGER,
  falchion = Talents.T_WEAPON_FOCUS_FALCHION,
  flail = Talents.T_WEAPON_FOCUS_FLAIL,
  halberd = Talents.T_WEAPON_FOCUS_HALBERD,
  hammer = Talents.T_WEAPON_FOCUS_HAMMER,
  handaxe = Talents.T_WEAPON_FOCUS_HANDAXE,
  javelin = Talents.T_WEAPON_FOCUS_JAVELIN,
  kukri = Talents.T_WEAPON_FOCUS_KUKRI,
  mace = Talents.T_WEAPON_FOCUS_MACE,
  morningstar = Talents.T_WEAPON_FOCUS_MORNINGSTAR,
  rapier = Talents.T_WEAPON_FOCUS_RAPIER,
  scimitar = Talents.T_WEAPON_FOCUS_SCIMITAR,
  scythe = Talents.T_WEAPON_FOCUS_SCYTHE,
  shortsword = Talents.T_WEAPON_FOCUS_SHORTSWORD,
  spear = Talents.T_WEAPON_FOCUS_SPEAR,
  sling = Talents.T_WEAPON_FOCUS_SLING,
  staff = Talents.T_WEAPON_FOCUS_STAFF,
  sword = Talents.T_WEAPON_FOCUS_SWORD,
  trident = Talents.T_WEAPON_FOCUS_TRIDENT,
}


function _M:hasFocus(type)
  if self:knowTalent(focuses[type]) then return true
  else return false end
end


_M.ImpCrit = {
  axe = Talents.T_IMPROVED_CRIT_AXE,
  battleaxe = Talents.T_IMPROVED_CRIT_BATTLEAXE,
  bow = Talents.T_IMPROVED_CRIT_BOW,
  club = Talents.T_IMPROVED_CRIT_CLUB,
  crossbow = Talents.T_IMPROVED_CRIT_CROSSBOW,
  dagger = Talents.T_IMPROVED_CRIT_DAGGER,
  falchion = Talents.T_IMPROVED_CRIT_FALCHION,
  flail = Talents.T_IMPROVED_CRIT_FLAIL,
  halberd = Talents.T_IMPROVED_CRIT_HALBERD,
  hammer = Talents.T_IMPROVED_CRIT_HAMMER,
  handaxe = Talents.T_IMPROVED_CRIT_HANDAXE,
  javelin = Talents.T_IMPROVED_CRIT_JAVELIN,
  kukri = Talents.T_IMPROVED_CRIT_KUKRI,
  mace = Talents.T_IMPROVED_CRIT_MACE,
  morningstar = Talents.T_IMPROVED_CRIT_MORNINGSTAR,
  rapier = Talents.T_IMPROVED_CRIT_RAPIER,
  scimitar = Talents.T_IMPROVED_CRIT_SCIMITAR,
  scythe = Talents.T_IMPROVED_CRIT_SCYTHE,
  shortsword = Talents.T_IMPROVED_CRIT_SHORTSWORD,
  spear = Talents.T_IMPROVED_CRIT_SPEAR,
  sling = Talents.T_IMPROVED_CRIT_SLING,
  staff = Talents.T_IMPROVED_CRIT_STAFF,
  sword = Talents.T_IMPROVED_CRIT_SWORD,
  trident = Talents.T_IMPROVED_CRIT_TRIDENT,
}


function _M:hasCritical(type)
  if self:knowTalent(ImpCrit[type]) then return true
  else return false end
end