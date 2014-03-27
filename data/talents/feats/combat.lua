newTalentType{ type="combat/general", no_tt_req = true, name = "combat gen", description = "General combat feats" }

-- Active combat feats
newTalent{
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
        return true
    end,
    deactivate = function(self, t)
        return true
    end,
	info = [[You can substract a number from your base attack bonus and add it to damage bonus.]],
}

newTalent{
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

        self:addTemporaryValue("combat_untyped", d)
        return true
    end,
    deactivate = function(self, t)
        self:removeTemporaryValue("combat_untyped", d)

        return true
    end,
	info = [[You can substract a number up to -5 from your attack and add it to your AC as a dodge bonus.]],
}
