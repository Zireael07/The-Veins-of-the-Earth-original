newTalentType{ all_limited=true, type="divination_both", name="divination", description = "divination blahblah"
}

--Basic detects
newArcaneDivineSpell{
	name = "Detect Magic",
	type = {"divination_both", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	range = 1,
	requires_target = true,
	radius = 5,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
        local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)

		self:project(tg, x, y, DamageType.DETECT_MAGIC, damage, {type="magic"})

		return true
	end,
	info = function(self, t)

		return ([[You detect presence or absence of magic in a 60 ft. cone.]])
	end,
}

newArcaneDivineSpell{
	name = "Detect Poison",
	type = {"divination_both", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	range = 1,
	requires_target = true,
	radius = 5,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y = self:getTarget(tg)
        local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)

		self:project(tg, x, y, DamageType.DETECT_POISON, damage)

		return true
	end,
	info = function(self, t)

		return ([[You detect presence or absence of poison in a single creature or object.]])
	end,
}
