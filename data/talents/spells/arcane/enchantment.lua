newTalentType{ 
	all_limited=true,
	spell_list="arcane",
	type="enchantment",
	name="enchantment",
	description = "enchantment blahblah"
}

--Arcane versions of buff spells
newTalent{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE_ARCANE",
	type = {"enchantment", 1},
	display = { image = "bear_endurance.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_BEAR_ENDURANCE, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Constitution by +4.]])
	end,	
}

newTalent{
	name = "Bull's Strength", short_name = "BULL_STRENGTH_ARCANE",
	type = {"enchantment", 1},
	display = { image = "bull_strength.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_BULL_STRENGTH, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Strength by +4.]])
	end,	
}

newTalent{
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR_ARCANE",
	type = {"enchantment", 1},
	display = { image = "eagle_splendor.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_EAGLE_SPLENDOR, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Charisma by +4.]])
	end,	
}

newTalent{
	name = "Owl's Wisdom", short_name = "OWL_WISDOM_ARCANE",
	type = {"enchantment", 1},
	display = { image = "owl_wisdom.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_OWL_WISDOM, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Wisdom by +4.]])
	end,	
}

newTalent{
	name = "Cat's Grace",
	type = {"enchantment", 1},
	display = { image = "cat_grace.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_CAT_GRACE, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Dexterity by +4.]])
	end,	
}

newTalent{
	name = "Fox's Cunning",
	type = {"enchantment", 1},
	display = { image = "fox_cunning.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self:setEffect(self.EFF_FOX_CUNNING, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You increase your Intelligence by +4.]])
	end,	
}
