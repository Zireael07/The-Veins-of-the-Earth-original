newTalentType{
	all_limited=true,
	type="abjuration_divine",
	name="abjuration",
	description = "abjuration blahblah"
}

newDivineSpell{
	name = "Entropic Shield",
	type = {"abjuration_divine", 1},
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
		self:setEffect(self.EFF_ENTROPIC_SHIELD, t.getDuration(self, t), {})

		return true
	end,

	info = function(self, t)
		return ([[All ranged attacks, including magical effects such as magic missiles and acid arrows, have a 20% miss chance.]])
	end,
}

newDivineSpell{
	name = "Shield of Faith",
	type = {"abjuration_divine", 1},
	mode = "activated",
	level = 1,
	tactical = { BUFF = 2 },
	range = 0,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_SHIELD_OF_FAITH, t.getDuration(self, t), {})

		return true
	end,

	info = function(self, t)
		return ([[You gain a +2 deflection bonus to AC.]])
	end,
}
