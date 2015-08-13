newTalentType{ all_limited=true, type="transmutation_both", name="transmutation",
	description = "focuses on manipulating matter and bodies"
}

--"Animal buff" spells
newArcaneDivineSpell{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE",
	type = {"transmutation_both", 1},
	display = { image = "bear_endurance.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 0,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_BEAR_ENDURANCE, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Constitution by +4.]])
	end,
}

newArcaneDivineSpell{
	name = "Bull's Strength", short_name = "BULL_STRENGTH",
	type = {"transmutation_both", 1},
	display = { image = "bull_strength.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 0,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_BULL_STRENGTH, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Strength by +4.]])
	end,
}

newArcaneDivineSpell{
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR",
	type = {"transmutation_both", 1},
	display = { image = "eagle_splendor.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 0,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_EAGLE_SPLENDOR, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Charisma by +4.]])
	end,
}

newArcaneDivineSpell{
	name = "Owl's Wisdom", short_name = "OWL_WISDOM",
	type = {"transmutation_both", 1},
	display = { image = "owl_wisdom.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	range = 0,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_OWL_WISDOM, t.getDuration(self, t), {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Wisdom by +4.]])
	end,
}
