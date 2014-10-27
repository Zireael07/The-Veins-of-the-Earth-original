newTalentType{ type="combat/general", no_tt_req = true, name = "Active combat", description = "General combat feats" }

-- Active combat feats
newFeat{
	name = "Power Attack",
	type = {"combat/general", 1},
	require = {
		stat = {str = 13}
	},
	is_feat = true,
    fighter = true,
	points = 1,
	mode = "sustained",
	cooldown = 0,
    tactical = { ATTACK = 1 },
    on_pre_use = function(self, t, silent)
        local weapon = self:getInven("MAIN_HAND")[1]

        if weapon and not weapon.ranged then
            return true
        else
            if not silent then
                game.log("You need a melee weapon to use this")
            end
            return false
        end
    end,
    activate = function(self, t) 
    local res = {
        attack = self:addTemporaryValue("combat_attack", -5)
}
        return res
    end,
    deactivate = function(self, t, p)
        self:removeTemporaryValue("combat_attack", p.attack)
        return true
    end,
	info = [[You can substract a number from your base attack bonus and add it to damage bonus.]],
}

newFeat{
	name = "Combat Expertise",
	type = {"combat/general", 1},
	require = {
		stat = { int = 13 }
	},
	is_feat = true,
    fighter = true,
	points = 1,
	mode = "sustained",
	cooldown = 0,
    tactical = { ATTACK = 1 },
    on_pre_use = function(self, t, silent)
        local weapon = self:getInven("MAIN_HAND")[1]

        if weapon then
            return true
        else
            if not silent then
                game.log("You need a weapon to use this")
            end
            return false
        end
    end,
    activate = function(self, t)
        local d = rng.dice(1,5)
        local res = {
        ac = self:addTemporaryValue("combat_untyped", d),
        attack = self:addTemporaryValue("combat_attack", -d)
    }
    
        return res
    end,
    deactivate = function(self, t, p)
        self:removeTemporaryValue("combat_untyped", p.ac)
        self:removeTemporaryValue("combat_attack", p.attack)

        return true
    end,
	info = [[You can substract a number up to -5 from your attack and add it to your AC as a dodge bonus.]],
}

newTalent{
    name = "Stunning Fist", -- image = "talents/lay_on_hands.png",
    type = {"combat/general", 1},
    mode = 'activated',
    is_feat = true,
    fighter = true,
    require = {
        stat = { int = 13, wis = 13 },
        special = {
            fct = function(self, t, offset) 
            --Base attack bonus 1
            if self:attr("combat_bab") and self:attr("combat_bab") >= 8 then return true
            else return false end
            end,
            desc = "Base attack bonus 8",
        }
    },
    level = 1,
    points = 1,
    cooldown = 20,
--    tactical = { BUFF = 2 },
    range = 1,
    target = function(self, t)
        local tg = {type="hit", range=self:getTalentRange(t), nolock = true, radius=self:getTalentRadius(t), talent=t}
        return tg
    end,
    action = function(self, t)
        local weapon = self:getInven("MAIN_HAND")[1]
        if weapon then
            game.logSeen(self, "You need to be unarmed for stunning fist to work.")
            return nil end
        
        local tg = self:getTalentTarget(t)
        local x, y, target = self:getTarget(tg)
        if not x or not y or not target then return nil end

        --DC 10 + 1/2 level + Wis mod
        if target:fortitudeSave(15) then
            game.logSeen(target, "The target resists the stunning!")
        else
            if target:canBe("stun") then target:setEffect(target.EFF_STUN, 1, {}) end
        end

        return true
        end,
    info = function(self, t)
        return ([[You can stun enemies for a round.]])
    end,    
}