newTalentType{ type="barbarian/barbarian", name="barbarian", description="Barbarian Feats" }

newTalent{
	name = "Rage",
	type = {"barbarian/barbarian", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 20,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self.str = self.str + 4
	self.dex = self.dex + 4
	self.will_save = self.will_save or 0 + 2
	self.combat_def = self.combat_def or 0 - 2
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You fly into a rage - giving you a +4 bonus to Str and Con and a +2 bonus to Will, but a -2 penalty to AC.]])
	end,	
}

newTalent{
	name = "Damage Reduction I",
	type = {"barbarian/barbarian", 1},
	mode = 'passive',
	require = { level = 7 },
	points = 5,
	is_feat = true,

	info = [[The damage you receive is reduced by 1.]],
	on_learn = function(self, t)
        self.combat_armor = self.combat_armor or 0 + 1
        end
}

newTalent{
	name = "Greater rage",
	type = {"barbarian/barbarian", 1},
	mode = 'activated',
	require = { level = 11 },
	points = 1,
	cooldown = 20,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self.str = self.str + 6
	self.dex = self.dex + 6
	self.will_save = self.will_save or 0 + 3
	self.combat_def = self.combat_def or 0 - 2
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You fly into a greater rage - giving you a +6 bonus to Str and Con and a +3 bonus to Will, but a -2 penalty to AC.]])
	end,	
}

newTalent{
	name = "Mighty rage",
	type = {"barbarian/barbarian", 1},
	mode = 'activated',
	require = { level = 20 },
	points = 1,
	cooldown = 20,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	self.str = self.str + 8
	self.dex = self.dex + 8
	self.will_save = self.will_save or 0 + 4
	self.combat_def = self.combat_def or 0 - 2
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You fly into a rage - giving you a +8 bonus to Str and Con and a +4 bonus to Will, but a -2 penalty to AC.]])
	end,	
}