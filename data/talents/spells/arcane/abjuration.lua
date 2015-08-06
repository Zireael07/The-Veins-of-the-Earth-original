newTalentType{
	all_limited=true,
	type="abjuration",
	name="abjuration",
	description = "abjuration blahblah"
}

newArcaneSpell{
	name = "Mage Armor",
	type = {"abjuration", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	range = 1,
	requires_target = true,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end
	--	if core.fov.distance(self.x, self.y, x, y) > 1 then return nil end

		target:setEffect(self.EFF_MAGE_ARMOR, t.getDuration(self, t), {})

		return true
	end,
	info = function(self, t)

		return ([[An invisible but tangible field of force surrounds the target, providing a +4 armor bonus to AC.]])
	end,
}
