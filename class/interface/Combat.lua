-- Veins of the Earth
-- Zireael 2013-2015
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
--local Chat = require "engine.Chat"
local Chat = require "mod.class.patch.Chat"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
    local reaction = self:reactionToward(target)
    if reaction < 0 then
        --TODO: check for move but not attack flag
        return self:attackTarget(target)
    elseif reaction >= 0 then
        -- Talk ?
        if self.player and target.can_talk then
            local chat = Chat.new(target.can_talk, target, self)
            chat:invoke()
      --[[  elseif target.player and self.can_talk then
            local chat = Chat.new(self.can_talk, self, target)
            chat:invoke()]]
        elseif self.move_others then
            self:displace(target)
        end
    end
end

--Lukep's combat patch
function _M:attackTarget(target, noenergy)
   if self.combat then
       --log text
       local attacklog = ""
       local damagelog = ""

      -- returns your weapon if you are armed, or unarmed combat.
      local weapon = (self:getInven("MAIN_HAND") and self:getInven("MAIN_HAND")[1]) or self
      -- returns your offhand weapon (not shield) or your weapon again if it is double
      local offweapon = (self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1] and self:getInven("OFF_HAND")[1].combat and self:getInven("OFF_HAND")[1]) or (weapon and weapon.double and weapon)

      --If not wielding anything in offhand and wielding a one-handed martial weapon then wield it two-handed
      local twohanded = false

      if not (self:getInven("OFF_HAND") and self:getInven("OFF_HAND")[1]) and not weapon.double and not weapon.light then
         twohanded = true
      end

      --No more 'extra-pokey longbows'
      if weapon and weapon.ranged then
        game.logPlayer(self, "You can't use a ranged weapon in melee!")
        return
      end


      -- add in modifiers
      local attackmod = 0
      local strmod = 1

      --if wielding two-handed, apply 1.5*Str mod
      if twohanded then strmod = 1.5 damagelog = damagelog.."two-handed" end

      if weapon and weapon.slot_forbid == "OFF_HAND" and not self:knowTalent(self.T_MONKEY_GRIP) then
          strmod = 1.5 damagelog = damagelog.."two-handed"
      end

      --Dual-wielding (main hand)
      if offweapon then
         attackmod = attackmod -6
         attacklog = attacklog.." dual-wielding"
         if offweapon.light or weapon.double then attackmod = attackmod + 2 attacklog=attacklog.." dual-wielding light" end
         if self:knowTalent(self.T_TWO_WEAPON_FIGHTING) then attackmod = attackmod + 2 attacklog = attacklog.." TWF" end
      end

      self:attackRoll(target, weapon, attackmod, strmod, attacklog, damagelog, false)

      --extra attacks for high BAB, at lower bonuses
      if self.combat_bab >=6 then
         self:attackRoll(target, weapon, attackmod - 5, strmod, attacklog, damagelog, true)
      end
      if self.combat_bab >=11 then
         self:attackRoll(target, weapon, attackmod - 10, strmod, attacklog, damagelog, true)
      end
      if self.combat_bab >=16 then
         self:attackRoll(target, weapon, attackmod - 15, strmod, attacklog, damagelog, true)
      end

      -- offhand/double weapon attacks
      if offweapon then
         strmod = 0.5
         attackmod = -10
         attacklog = " dual-wielding offhand"
         if offweapon.light or weapon.double then attackmod = attackmod + 2 attacklog = " dual-wielding light offhand" end
         if self:knowTalent(self.T_TWO_WEAPON_FIGHTING) then attackmod = attackmod + 6 attacklog = " TWF offhand" end

         self:attackRoll(target, offweapon, attackmod, strmod, attacklog, damagelog, true)

         if self:knowTalent(self.T_IMPROVED_TWO_WEAPON_FIGHTING) then
            self:attackRoll(target, offweapon, attackmod - 5, strmod, attacklog, damagelog, true)
         end
         if self:knowTalent(self.T_GREATER_TWO_WEAPON_FIGHTING) then
            self:attackRoll(target, offweapon, attackmod - 10, strmod, attacklog, damagelog, true)
         end
      end
   end

-- We use up our own energy
  local speed = self:combatSpeed()

   if not noenergy then
      self:useEnergy(game.energy_to_act * speed)
   end
end

function _M:attackRoll(target, weapon, atkmod, strmod, attacklog, damagelog, no_sneak)
   local d = rng.range(1,20)
   local hit = true
   local crit = false
    local attack

    --log
    local attacklog = attacklog or ""
    local damagelog = damagelog or ""

    --First things first!
    self:breakStealth()

   attack, attacklog = self:combatAttack(weapon)

   local ac = target:getAC()

   -- Hit check
    if self:isConcealed(target) and rng.chance(self:isConcealed(target)) then
        self:logCombat(target, ("%s misses the target wildly!"):format(self:getLogName():capitalize()))
        hit = false
    elseif d == 1 then hit = false
    elseif d == 20 then hit = true
    elseif d + attack < ac then hit = false
    end

   -- log message
    if hit then

    local chance = rng.dice(1,3)
      if chance == 1 then
          self:logCombat(target, ("%s strikes low, #GOLD#hitting#LAST# the enemy! %d + %d = %d vs AC %d".." "..attacklog):format(self:getLogName():capitalize(), d, attack, d+attack, ac))
      elseif chance == 2 then
          self:logCombat(target, ("%s strikes center, #GOLD#hitting#LAST# the enemy! %d + %d = %d vs AC %d".." "..attacklog):format(self:getLogName():capitalize(), d, attack, d+attack, ac))
      else
          self:logCombat(target, ("%s strikes low, #GOLD#hitting#LAST# the enemy! %d + %d = %d vs AC %d".." "..attacklog):format(self:getLogName():capitalize(), d, attack, d+attack, ac))
      end

    else

    local chance = rng.dice(1,3)
      if chance == 1 then
          self:logCombat(target, ("%s strikes low, #DARK_BLUE#missing#LAST# the enemy! %d + %d = %d vs AC %d".." "..attacklog):format(self:getLogName():capitalize(), d, attack, d+attack, ac))
      elseif chance == 2 then
          self:logCombat(target, ("%s strikes center, #DARK_BLUE#missing#LAST# the enemy! %d + %d = %d vs AC %d".." "..attacklog):format(self:getLogName():capitalize(), d, attack, d+attack, ac))
      else
        self:logCombat(target, ("%s strikes high, #DARK_BLUE#missing#LAST# the enemy! %d + %d = %d vs AC %d".." "..attacklog):format(self:getLogName():capitalize(), d, attack, d+attack, ac))
      end

    end


    -- Crit check
    local threat = 0 + (weapon and weapon.combat.threat or 0)

    --Improved Critical
    if weapon and weapon.subtype and self:hasCritical(weapon.subtype) then combat.weapon.threat = (combat.weapon.threat or 0) + 2 end

    if hit and d >= 20 - threat then
      -- threatened critical hit confirmation roll
      if not (rng.range(1,20) + attack < ac) then
         crit = true
      else
          self:logCombat(target, "Critical confirmation roll failed")
      end
   end

   if hit then
    --reactive damage (spikes, fire shield etc.)
    for typ, dam in pairs(target.on_melee_hit) do
      if type(dam) == "number" then if dam > 0 then DamageType:get(typ).projector(target, self.x, self.y, typ, dam) end
    --account for randomly determined damage
      elseif type(dam) == "table" then
      local actual_dam = rng.dice(dam[1], dam[2])
        if actual_dam > 0 then DamageType:get(typ).projector(target, self.x, self.y, typ, {dam=actual_dam}) end
      elseif dam.dam and dam.dam > 0 then DamageType:get(typ).projector(target, self.x, self.y, typ, dam)
      end
    end


    --Actually deal damage
    if not no_sneak then self:dealDamage(target, weapon, crit, true)
    else
    self:dealDamage(target, weapon, crit, false) end
  end
end


function _M:dealDamage(target, weapon, crit, sneak)
    local dam = rng.dice(weapon.combat.dam[1], weapon.combat.dam[2])

    dam = dam + self.combat_damage

    -- magic damage bonus
    dam = dam + (weapon and weapon.combat.magic_bonus or 0)

    -- Stat damage bonus
    if weapon and weapon.ranged then
        strmod = strmod or 0
    else
        strmod = strmod or 1
    end

    dam = dam + strmod * (self:getStr()-10)/2

    --Sneak attack!
    if sneak and self:isTalentActive(self.T_STEALTH) and self.sneak_attack then
        local sneak_dam = rng.dice(self.sneak_attack, 6)
        game.log(("%s makes a sneak attack!"):format(self:getLogName():capitalize()))
        dam = dam + rng.dice(self.sneak_attack, 6)

        --TO DO: fortification
    end

    --Power Attack damage bonus PF style
    if self:isTalentActive(self.T_POWER_ATTACK) then
        if self.combat_bab < 4 then dam = dam + 2
        elseif self.combat_bab > 4 then dam = dam + 4
        elseif self.combat_bab > 8 then dam = dam + 6
        elseif self.combat_bab > 12 then dam = dam + 8
        elseif self.combat_bab > 16 then dam = dam + 10 end
    end

    if crit then
        --No crits on players in easy mode!
        if target == game.player and config.settings.veins.difficulty == "Easy" then
            dam = dam
        return end

        --do the on crit stuff
        if not target.dead and weapon and weapon.combat and weapon.combat.melee_project_on_crit then for typ, dam in pairs(weapon.combat.melee_project_on_crit) do
            if type(dam) == "number" then
                if dam > 0 then
                    DamageType:get(typ).projector(self, target.x, target.y, typ, dam)
                end
            --account for randomly determined damage
            elseif type(dam) == "table" then
              local actual_dam = rng.dice(dam[1], dam[2])
                if actual_dam > 0 then DamageType:get(typ).projector(self, target.x, target.y, typ, {dam=actual_dam}) end
            end
        end end



        if target:canBe("crit") then
            --check fortification first
            if target.fortification and target.fortification > 0 then

                if target.fortification == 1 then
                    local chance = rng.percent(25)
                    if chance then
                        game.log(("%s's armor protects from the critical hit!"):format(target:getLogName():capitalize()))
                        dam = dam
                    else
                        dam = dam * (weapon and weapon.combat.critical or 2)
                    end
                end
                if target.fortification == 3 then
                    local chance = rng.percent(75)
                    if chance then
                        game.log(("%s's armor protects from the critical hit!"):format(target:getLogName():capitalize()))
                        dam = dam
                    else
                        dam = dam * (weapon and weapon.combat.critical or 2)
                    end
                end
                if target.fortification == 5 then
                  game.log(("%s's armor protects from the critical hit!"):format(target:getLogName():capitalize()))
                  dam = dam
                end
            end

            --check Roll with it
          if target:knowTalent(T_ROLL_WITH_IT) then
            game.logSeen()
          --  game.log(("%s makes a critical attack, but the damage is reduced!"):format(self:getLogName():capitalize())) --end
            dam = dam * (weapon and (weapon.combat.critical/2) or 1)
          else
        --  game.log(("%s makes a critical attack!"):format(self:getLogName():capitalize())) --end
          dam = dam * (weapon and weapon.combat.critical or 2)
          end
        else
          --game.log("The target's lack of physiology prevents serious injury.")
          dam = dam
        end
      end --end crit stuff

      --Favored enemy bonus
      if self:favoredEnemy(target) then dam = dam + 2 end

      --Bane weapons
      if weapon and self:isBane(weapon, target) then
          weapon.combat.magic_bonus = (weapon.combat.magic_bonus or 0) + 2
          dam = dam + 2
          dam = dam + rng.dice(2,6)
      end

      --Aligned weapons
      if weapon and self:isAlignedExtra(weapon, target) then
          dam = dam + rng.dice(2,6)
      end

      -- Melee project
  	if not target.dead and weapon and weapon.combat and weapon.combat.melee_project then for typ, dam in pairs(weapon.combat.melee_project) do
          if type(dam) == "number" then
              if dam > 0 then
  			       DamageType:get(typ).projector(self, target.x, target.y, typ, dam)
            end
        --account for randomly determined damage
          elseif type(dam) == "table" then
            local actual_dam = rng.dice(dam[1], dam[2])
              if actual_dam > 0 then DamageType:get(typ).projector(self, target.x, target.y, typ, {dam=actual_dam}) end
        end
  	end end

  	if not target.dead then for typ, dam in pairs(self.melee_project) do
          if type(dam) == "number" then
              if dam > 0 then
  			      DamageType:get(typ).projector(self, target.x, target.y, typ, dam)
            end
        --account for randomly determined damage
          elseif type(dam) == "table" then
            local actual_dam = rng.dice(dam[1], dam[2])
                  if actual_dam > 0 then DamageType:get(typ).projector(self, target.x, target.y, typ, {dam=actual_dam}) end
          end
  	end end

    --Minimum 1 point of damage unless Damage Reduction works
    dam = math.max(1, dam)

    --No negative damage with DR/-
    local reduced_dam = dam - (target.combat_dr or 0)

    --Account for magic weapons piercing DR
    if target.combat_dr and target.combat_dr_tohit then
        if (weapon.combat.magic_bonus or 0) >= target.combat_dr_tohit then
          reduced_dam = dam
          --Repeat the minimum 1 dmg rule
          dam = math.max(1, dam)
        end
    end


    dam = math.max(0, reduced_dam)

    --Player makes Listen checks if s/he can't see it happen
    local visible, srcSeen, tgtSeen = game:logVisible(self, target)
    if not visible then
    local heard_it = false
    local dist = core.fov.distance(game.player.x, game.player.y, self.x, self.y)
    local player = game.player
        if dist < 10 and game.player.skill_listen > 0 then
            if not heard_it then
                if game.player:skillCheck("listen", 10) then
                local dir = game.level.map:compassDirection(self.x - game.player.x, self.y - game.player.y)
                game.log("You hear the sounds of conflict to the %s!", dir)
                heard_it = true
                end
            end
        end
    end




    --Poison target
    if self.poison and not target.dead and target:canBe("poison") then
      local poison = self.poison
      self:applyPoison(poison, target)
      self:logCombat(target, ("%s tries to poison %s"):format(self:getLogName():capitalize(), target.name))
    end

    target:takeHit(dam, self)
    --add a hint regarding DR
    if target.combat_dr and target.combat_dr > 0 then
      self:logCombat(target, ("%s deals %d damage to %s (damage reduction %d)!"):format(self:getLogName():capitalize(), dam, target.name, target.combat_dr))
    else
      self:logCombat(target, ("%s deals %d damage to %s!"):format(self:getLogName():capitalize(), dam, target.name))
    end
end


function _M:applyPoison(poison, target)

  local poison_dc = { small_centipede = 11, medium_spider = 14, large_scorpion = 18, nitharit = 13, sassone = 16, malyss = 16, terinav = 16, blacklotus = 20, dragon = 26, toadstool = 11, arsenic = 13, idmoss = 14, lichdust = 17, darkreaver = 18, ungoldust = 15, insanitymist = 15, burnt_othur = 18, blackadder = 11, bloodroot = 12, greenblood = 13, whinnis = 14, shadowessence = 17, wyvern = 17, giantwasp = 18, deathblade = 20, purpleworm = 24 }

  if not poison then return end

  if not target:canBe("poison") then
    self:logCombat(target, "Target seems unaffected by poison")
  end

  if target:fortitudeSave(poison_dc[poison]) then
    self:logCombat(target, ("Target resists poison, DC %d"):format(poison_dc[poison]))

  --Failed save, set timer for secondary damage
  else
    target.poison_timer = 10
    if target == game.player then
      game.log("You are poisoned!")
    else game.log("Target is poisoned!") end
      --Failed save, time for primary poison damage
      if poison == "medium_spider" then target:setEffect(target.EFF_POISON_MIDDLING_STR, 10, {}) end
      if poison == "small_centipede" then target:setEffect(target.EFF_POISON_SMALL_CENTIPEDE, 10, {}, true) end
      if poison == "large_scorpion" then target:setEffect(target.EFF_POISON_MEDIUM_STR, 10, {}, true) end
      if poison == "nitharit" then end
      if poison == "sassone" then end
      if poison == "malyss" then target:setEffect(target.EFF_POISON_MALYSS_PRI, 10, {}, true) end
      if poison == "terinav" then target:setEffect(target.EFF_POISON_MEDIUM_DEX, 10, {}, true) end
      if poison == "blacklotus" then target:setEffect(target.EFF_POISON_EXTRASTRONG_CON, 10, {}, true) end
      if poison == "dragon" then target:setEffect(target.EFF_POISON_DRAGON_BILE, 10, {}, true) end
      if poison == "toadstool" then target:setEffect(target.EFF_POISON_TOADSTOOL_PRI, 10, {}, true) end
      if poison == "arsenic" then target:setEffect(target.EFF_POISON_WEAK_CON, 10, {}, true) end
      if poison == "idmoss" then target:setEffect(target.EFF_POISON_MIDDLING_INT, 10, {}, true) end
      if poison == "lichdust" then target:setEffect(target.EFF_POISON_MEDIUM_STR, 10, {}, true) end
      if poison == "darkreaver" then target:setEffect(target.EFF_POISON_MEDIUM_CON, 10, {}, true) end
      if poison == "ungoldust" then target:setEffect(target.EFF_POISON_UNGOL_DUST_PRI, 10, {}, true) end
      if poison == "insanitymist" then target:setEffect(target.EFF_POISON_INSANITY_MIST_PRI, 10, {}, true) end
      if poison == "burnt_othur" then target:setEffect(target.EFF_POISON_WEAK_CON, 10, {}, true) end
      if poison == "blackadder" then target:setEffect(target.EFF_POISON_MEDIUM_CON, 10, {}, true) end
      if poison == "bloodroot" then end
      if poison == "greenblood" then target:setEffect(target.EFF_POISON_WEAK_CON, 10, {}, true) end
      if poison == "whinnis" then target:setEffect(target.EFF_POISON_WEAK_CON, 10, {}, true) end
      if poison == "shadowessence" then target:setEffect(target.EFF_POISON_SHADOW_ESSENCE_PRI, 10, {}, true) end
      if poison == "wyvern" then target:setEffect(target.EFF_POISON_STRONG_CON, 10, {}, true) end
      if poison == "giantwasp" then target:setEffect(target.EFF_POISON_MEDIUM_DEX, 10, {}, true) end
      if poison == "deathblade" then target:setEffect(target.EFF_POISON_MEDIUM_CON, 10, {}, true) end
      if poison == "purpleworm" then target:setEffect(target.EFF_POISON_MEDIUM_STR, 10, {}, true) end
  end

  if target.poison_timer == 0 then
    --Timer's up!
    if target:fortitudeSave(poison_dc[poison]) then game.log(("Target resists poison, DC %d"):format(poison_dc[poison]))
    else
     if target == game.player then --game.flashLog(game.flash.BAD, "You are poisoned!")
        game.log("You are poisoned!")
      else game.log("Target is poisoned!") end
      --Secondary damage hits!
      if poison == "medium_spider" then target:setEffect(target.EFF_POISON_MEDIUM_STR, 10, {}, true) end
      if poison == "small_centipede" then target:setEffect(target.EFF_POISON_SMALL_CENTIPEDE, 10, {}, true) end
      if poison == "large_scorpion" then target:setEffect(target.EFF_POISON_MEDIUM_STR, 10, {}, true) end
      if poison == "nitharit" then target:setEffect(target.EFF_POISON_EXTRASTRONG_CON, 10, {}, true) end
      if poison == "sassone" then target:setEffect(target.EFF_POISON_MEDIUM_CON, 10, {}, true) end
      if poison == "malyss" then target:setEffect(target.EFF_POISON_MALYSS_SEC, 10, {}, true) end
      if poison == "terinav" then target:setEffect(target.EFF_POISON_TERINAV_SEC, 10, {}, true) end
      if poison == "blacklotus" then target:setEffect(target.EFF_POISON_EXTRASTRONG_CON, 10, {}, true) end
      if poison == "dragon" then end
      if poison == "toadstool" then target:setEffect(target.EFF_POISON_TOADSTOOL_SEC, 10, {}, true) end
      if poison == "arsenic" then target:setEffect(target.EFF_POISON_ARSENIC_SEC, 10, {}, true) end
      if poison == "idmoss" then target:setEffect(target.EFF_POISON_MOSS_SEC, 10, {}, true) end
      if poison == "lichdust" then target:setEffect(target.EFF_POISON_MEDIUM_STR, 10, {}, true) end
      if poison == "darkreaver" then target:setEffect(target.EFF_POISON_DARK_REAVER_SEC, 10, {}, true) end
      if poison == "ungoldust" then target:setEffect(target.EFF_POISON_UNGOL_DUST_SEC, 10, {}, true) end
      if poison == "insanitymist" then target:setEffect(target.EFF_POISON_INSANITY_MIST_SEC, 10, {}, true) end
      if poison == "burnt_othur" then target:setEffect(target.EFF_POISON_EXTRASTRONG_CON, 10, {}, true) end
      if poison == "blackadder" then target:setEffect(target.EFF_POISON_MEDIUM_CON, 10, {}, true) end
      if poison == "bloodroot" then target:setEffect(target.EFF_POISON_BLOODROOT_SEC, 10, {}, true) end
      if poison == "greenblood" then target:setEffect(target.EFF_POISON_GREENBLOOD_SEC, 10, {}, true) end
      if poison == "whinnis" then end -- temporarily until I make unconsciousness work
      if poison == "shadowessence" then target:setEffect(target.EFF_POISON_STRONG_STR, 10, {}, true) end
      if poison == "wyvern" then target:setEffect(target.EFF_POISON_STRONG_CON, 10, {}, true) end
      if poison == "giantwasp" then target:setEffect(target.EFF_POISON_MEDIUM_DEX, 10, {}, true) end
      if poison == "deathblade" then target:setEffect(target.EFF_POISON_STRONG_CON, 10, {}, true) end
      if poison == "purpleworm" then target:setEffect(target.EFF_POISON_STRONG_STR, 10, {}, true) end

    end
  end

end


_M.fav_enemies = {
  aberration = Talents.T_FAVORED_ENEMY_ABERRATION,
  animal = Talents.T_FAVORED_ENEMY_ANIMAL,
  construct = Talents.T_FAVORED_ENEMY_CONSTRUCT,
  dragon = Talents.T_FAVORED_ENEMY_DRAGON,
  elemental = Talents.T_FAVORED_ENEMY_ELEMENTAL,
  fey = Talents.T_FAVORED_ENEMY_FEY,
  giant = Talents.T_FAVORED_ENEMY_GIANT,
  magical_beast = Talents.T_FAVORED_ENEMY_MAGBEAST,
  monstrous_humanoid = Talents.T_FAVORED_ENEMY_MONSTROUS_HUMANOID,
  ooze = Talents.T_FAVORED_ENEMY_OOZE,
  plant = Talents.T_FAVORED_ENEMY_PLANT,
  undead = Talents.T_FAVORED_ENEMY_UNDEAD,
  vermin = Talents.T_FAVORED_ENEMY_VERMIN,
  dwarf = Talents.T_FAVORED_ENEMY_HUMANOID_DWARF,
  gnome = Talents.T_FAVORED_ENEMY_HUMANOID_GNOME,
  drow = Talents.T_FAVORED_ENEMY_HUMANOID_DROW,
  elf = Talents.T_FAVORED_ENEMY_HUMANOID_ELF,
  human = Talents.T_FAVORED_ENEMY_HUMANOID_HUMAN,
  halfling = Talents.T_FAVORED_ENEMY_HUMANOID_HALFLING,
  planetouched = Talents.T_FAVORED_ENEMY_HUMANOID_PLANETOUCHED,
  humanoid_aquatic = Talents.T_FAVORED_ENEMY_HUMANOID_AQUATIC,
  goblinoid = Talents.T_FAVORED_ENEMY_HUMANOID_GOBLINOID,
  gnoll = Talents.T_FAVORED_ENEMY_HUMANOID_GNOLL,
  reptilian = Talents.T_FAVORED_ENEMY_HUMANOID_REPTILIAN,
  orc = Talents.T_FAVORED_ENEMY_HUMANOID_ORC,
  air = Talents.T_FAVORED_ENEMY_OUTSIDER_AIR,
  earth = Talents.T_FAVORED_ENEMY_OUTSIDER_EARTH,
  evil = Talents.T_FAVORED_ENEMY_OUTSIDER_EVIL,
  fire = Talents.T_FAVORED_ENEMY_OUTSIDER_FIRE,
  good = Talents.T_FAVORED_ENEMY_OUTSIDER_GOOD,
  water = Talents.T_FAVORED_ENEMY_OUTSIDER_WATER,
}

function _M:favoredEnemy(target)
    if target.type ~= "humanoid" and target.type ~= "outsider" then
        if self:knowTalent(fav_enemies[target.type]) then return true
        else return false end
    else
        if self:knowTalent(fav_enemies[target.subtype]) then return true
        else return false end
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

function _M:isBane(weapon, target)
    if target.type ~= "humanoid" and target.type ~= "outsider" then
        if weapon.combat["bane_"..target.type] then return true
        else return false end
    else
        if weapon.combat["bane_"..target.subtype] then return true
        else return false end
    end
end


function _M:isAlignedExtra(weapon, target)
    if target:isLawful() and weapon.combat.aligned_anarchic then return true end
    if target:isChaotic() and weapon.combat.aligned_axiomatic then return true end
    if target:isEvil() and weapon.combat.aligned_holy then return true end
    if target:isGood() and weapon.combat.aligned_unholy then return true end

    return false
end

--Combat speeds code
--- Computes movement speed
function _M:combatMovementSpeed(x, y)
  local mult = 1

  local movement_speed = self.movement_speed

  movement_speed = math.max(movement_speed, 0.1)
  return mult * (self.base_movement_speed or 1) / movement_speed
end

--- Gets the weapon speed
function _M:combatSpeed(weapon)
  weapon = weapon or self.combat or {}
--  return (weapon.attackspeed or 1) / math.max(self.combat_attackspeed, 0.1)
  return math.max(self.combat_attackspeed, 0.1)
end

--Taken from ToME 4
-- Display Combat log messages, highlighting the player and taking LOS and visibility into account
-- #source#|#Source# -> <displayString> self.name|self.name:capitalize()
-- #target#|#Target# -> target.name|target.name:capitalize()
function _M:logCombat(target, style, ...)
  if not game.uiset or not game.uiset.logdisplay then return end
  local visible, srcSeen, tgtSeen = game:logVisible(self, target)  -- should a message be displayed?
  if visible then game.uiset.logdisplay(game:logMessage(self, srcSeen, target, tgtSeen, style, ...)) end
end

--Attacks of opportunity
--All opponents in range get an AoO
function _M:provokeAoO(x, y)
--    if not self.x then end
    if self.dead then end
	for i, act in ipairs(self.fov.actors_dist) do
        dist = core.fov.distance(x, y, act.x, act.y)
        if act ~= self and act:reactionToward(self) < 0 and not act.dead and not self.dead then
            --NOTE: needs to be 2 to trigger even though it doesn't seem logical
        	if dist <= 2 and not act.madeAoO then --TODO: or 3 and wielding a polearm
                local weapon = (act:getInven("MAIN_HAND") and act:getInven("MAIN_HAND")[1]) or self
                if not weapon.ranged then
                    act:logCombat(self, ("%s makes an attack of opportunity!"):format(act:getLogName():capitalize()))
                    act:attack(self, true)
                    act.madeAoO = true
                end
        	else end
    	end
    end
end

--For (future) bull rush or grappling
function _M:provokeSingleAoO(target)
    if not self.x then end
    if self.dead then end

    target:attack(self, true)
end

--Get attack mods for the character sheet
function _M:combatAttack(weapon)
    --log
    local attacklog = attacklog or ""

    local attack = (self.combat_bab or 0) + (self.combat_attack or 0)
    if self.combat_bab and self == game.player then
        attacklog = attacklog.." "..self.combat_bab.." BAB"
    end

    -- Proficiency penalties
     if weapon and weapon.simple and not self:knowTalent(self.T_SIMPLE_WEAPON_PROFICIENCY) then
         attack = (attack -4)
         attacklog = attacklog.."-4 not proficient in simple weapons"
     end

    if weapon and weapon.martial and not self:knowTalent(self.T_MARTIAL_WEAPON_PROFICIENCY) then
       attack = (attack -4)
       attacklog = attacklog.."-4 not proficient in martial weapons"
    end

    -- Feat bonuses
    if weapon and weapon.subtype and self:hasFocus(weapon.subtype) then
        attack = (attack + 1)
        attacklog = attacklog.."+1 weapon focus"
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
             local dex = math.floor((self:getStat("dex")-10)/2)
             attacklog = attacklog.." "..dex.." Finesse"
             stat_used = "dex"
         end
    end

    if stat_used == "str" then
        local str = math.floor((self:getStat("str")-10)/2)
        attacklog = attacklog.." "..str.." Str"
    end

    attack = attack + (atkmod or 0) + (weapon and weapon.combat.magic_bonus or 0) + (self:getStat(stat_used)-10)/2 or 0

    return attack, attacklog
end
