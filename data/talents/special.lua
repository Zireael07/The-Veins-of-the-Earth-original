newTalentType{ type="special/special", name = "special", description = "Special" }

newTalent{
	name = "Show Spellbook", image = "talents/spellbook.png",
	type = {"special/special",1},
	mode = "activated",
	points = 1,
	cooldown = 0,
	range = 0,
	action = function(self, t)
		local book = require("mod.dialogs.SpellBook").new(self)
		game:registerDialog(book)
		return nil
	end,
	info = function(self, t )
		return "Shows your spellbook"
	end,
}



	
	

newTalent{     
    name = "Shoot", image = "talents/shoot.png",
    type = {"special/special", 1},
    mode = 'activated',
    --require = ,
    points = 1,
    cooldown = 8,
    tactical = { ATTACK = 1 },
    requires_target = true,
--      on_pre_use = function(self, t, silent) if not self:hasArcheryWeapon() then if not silent then game.logPlayer(self, "You require a rangede weapon to shoot") end return false end return true end,
--      range = function(self, t) local weapon = self:getInven("MAIN_HAND")[1] return weapon.combat.range end,
    target = function(self, t) return  {type="bolt", range=self:getInven("MAIN_HAND")[1].combat.range, talent=t} end,
    archery_hit = function(tx, ty, tg, self, tmp) --This is called when the projectile hits
        local DamageType = require "engine.DamageType"
        local damtype = DamageType.PHYSICAL
        game.log("Damtype is: "..damtype)
        
        local target = game.level.map(tx, ty, Map.ACTOR)
        local weapon = self:getInven("MAIN_HAND")[1]
        local ammo = self:getInven("QUIVER")[1]


        if target then
            --do we hit?
            local hit, crit = self:attackRoll(target)
            if hit then
                local damage = rng.dice(weapon.combat.dam[1],  weapon.combat.dam[2])
                if crit then damage = damage * 1.5 end --TODO: make it use crit damage
                
                DamageType:get(damtype).projector(self, target.x, target.y, damtype, math.max(0, damage), tmp)
            end
        end
    end,
    action = function(self, t)
            local weapon = self:getInven("MAIN_HAND")[1]
            local ammo = self:getInven("QUIVER")[1]

            if not self:getInven("MAIN_HAND")[1].combat.range then game.log(("You need a ranged weapon to shoot")) return nil end
            if not weapon or not weapon.ranged then game.log("You need a ranged weapon to shoot with!") return nil end
            if weapon.ammo_type and not ammo then game.log("Your weapon requires ammo!") return nil end
            if not weapon.ammo_type == ammo.archery_ammo then game.log("You have the wrong ammo type equipped!") return nil end
            if ammo.combat.capacity <= 0 then game.log("You're out of ammo!") return nil end

            --We can shoot!

            local tg = self:getTalentTarget(t)
           
            local x, y = self:getTarget(tg)
            local _ _, _, _, x, y = self:canProject(tg, x, y)
            if not x or not y then return nil end
            self:projectile(tg, x, y, t.archery_hit)

            --self:getInven("QUIVER")[1].combat.capacity = self:getInven("QUIVER")[1].combat.capacity - 1
            return true
    end,
    info = function(self, t)
            --local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
            return ([[You shoot at the target.]])
    end,
}
