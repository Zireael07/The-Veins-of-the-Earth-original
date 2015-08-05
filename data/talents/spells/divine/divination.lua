newTalentType{
	all_limited=true,
	type="divination_divine",
	name="divination",
	description = "divination blahblah"
}

newDivineSpell{
	name = "Detect Evil",
	type = {"divination_divine", 1},
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

		self:project(tg, x, y, DamageType.DETECT_EVIL, damage)

		return true
	end,
	info = function(self, t)
		return ([[You detect presence or absence of evil in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Detect Good",
	type = {"divination_divine", 1},
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

		self:project(tg, x, y, DamageType.DETECT_GOOD, damage)

		return true
	end,
	info = function(self, t)
		return ([[You detect presence or absence of good in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Detect Chaos",
	type = {"divination_divine", 1},
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

		self:project(tg, x, y, DamageType.DETECT_CHAOS, damage)

		return true
	end,
	info = function(self, t)
		return ([[You detect presence or absence of chaos in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Detect Law",
	type = {"divination_divine", 1},
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

		self:project(tg, x, y, DamageType.DETECT_LAW, damage)

		return true
	end,
	info = function(self, t)
		return ([[You detect presence or absence of law in a 60 ft. cone.]])
	end,
}
