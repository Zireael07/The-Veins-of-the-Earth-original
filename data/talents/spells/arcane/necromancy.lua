newTalentType{
	all_limited=true, type="necromancy", name="necromancy",
	description = "Necromancy magic deals with the undead and the life force"
}

newArcaneSpell{
	name = "Ghoul Touch",
	type = {"necromancy",1},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 0,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 6
		else return 4 end --1d6+2
	end,
	range = 4,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	getSave = function(self, t)
		return self:getSpellDC(t)
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = t.getDuration(self, t)
		local save = t.getSave(self, t)

		if target:fortitudeSave(save) then game.log("Target resists the spell!")
		else
			if target:canBe("paralysis") then target:setEffect(target.EFF_GHOUL_TOUCH, duration, {}) end
		end
		return true
	end,
	info = "The target you touch is afflicted with a terrible ailment.",
}
