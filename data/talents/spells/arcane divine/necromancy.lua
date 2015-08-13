newTalentType{ all_limited=true, type="necromancy_both", name="necromancy",
	description = "Necromancy magic deals with the undead and the life force"
}

newArcaneDivineSpell{
	name = "Cause Fear", short_name = "CAUSE_FEAR",
	type = {"necromancy_both", 1},
	mode = "activated",
	display = { image = "cause_fear.png"},
	level = 1,
	getDuration = function(self, t)
		local dice = rng.dice(1,4)
		if self:isTalentActive(self.T_EXTEND) then return dice*1.5
		else return dice end
	end,
	range = 3,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = t.getDuration(self, t)

		if target:willSave(15) then
			game.log("Target resists the spell!")
			target:setEffect(target.EFF_SHAKEN, 1, {})
		else target:setEffect(target.EFF_FEAR, duration, {}) end

		return true
	end,
	info = function(self, t)
		return ([[Target flees for 1d4 rounds or is shaken for 1 round, depending on the save.]])
	end,
}
