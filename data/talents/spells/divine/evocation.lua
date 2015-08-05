newTalentType{
	all_limited=true,
	type="evocation_divine",
	name="evocation",
	description = "the evocation school harnesses the elements, using them to cause great damage"
}

newDivineSpell{
	name = "Faerie Fire",
	type = {"evocation_divine", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 10,
	radius = 1.5,
	target = function(self, t)
		local tg = {type="ball", range=self:getTalentRange(t), nolock = true, radius=self:getTalentRadius(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
        local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)

		self:project(tg, x, y, DamageType.FAERIE, damage, {type="faerie"})

		return true
	end,
	info = function(self, t)

		return ([[You create a sphere of magical light.]])
	end,
}


newDivineSpell{
	name = "Divine Favor",
	type = {"evocation_divine", 1},
	mode = 'activated',
	level = 1,
	tactical = { BUFF = 2 },
	range = 0,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_DIVINE_FAVOR, t.getDuration(self, t), {})

		return true
	end,

	info = function(self, t)
		return ([[You gain a +1 bonus to attack and damage per 3 caster levels (minimum 1).]])
	end,
}
