newTalentType{ all_limited=true, type="divine/divine", name="divine", description="Divine Spells" }

newTalent{
	name = "Cure Light Wounds",
	type = {"divine/divine", 1},
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	--require = ,
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
	if not self then return nil end
	d = rng.dice(1,8)
	self:heal(d) --+ caster_bonus)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 1d8 + 1 per caster level (max 5).]])
	end,	
}

newTalent{
	name = "Cure Moderate Wounds",
	type = {"divine/divine", 1},
	image = "talents/cure_light_wounds.png",
	mode = 'activated',
	--require = ,
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
	if not self then return nil end
	d = rng.dice(2,8)
	self:heal(d) --+ caster_bonus)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 2d8 + 1 per caster level (max 5).]])
	end,	
}

newTalent{
	name = "Cure Serious Wounds",
	type = {"divine/divine", 1},
	mode = 'activated',
	image = "talents/cure_light_wounds.png",
	--require = ,
	level = 3,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
	if not self then return nil end
	d = rng.dice(3,8)
	self:heal(d) --+ caster_bonus)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 3d8 + 1 per caster level (max 5).]])
	end,	
}

newTalent{
	name = "Cure Critical Wounds",
	type = {"divine/divine", 1},
	image = "talents/cure_light_wounds.png",
	mode = 'activated',
	--require = ,
	level = 4,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
	if not self then return nil end
	d = rng.dice(4,8)
	self:heal(d) --+ caster_bonus)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 4d8 + 1 per caster level (max 5).]])
	end,	
}

newTalent{
	name = "Heal Light Wounds",
	type = {"divine/divine", 1},
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 4,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	d = (self.max_life/10)*1
	self:heal(d)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 10% of your max health.]])
	end,	
}

newTalent{
	name = "Heal Moderate Wounds",
	type = {"divine/divine", 1},
	image = "heal_light_wounds.png",
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 5,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	d = (self.max_life/10)*3
	self:heal(d)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 30% of your max health.]])
	end,	
}

newTalent{
	name = "Heal Serious Wounds",
	type = {"divine/divine", 1},
	image = "heal_light_wounds.png",
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 6,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	d = (self.max_life/10)*5
	self:heal(d)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 50% of your max health.]])
	end,	
}

newTalent{
	name = "Heal Critical Wounds",
	type = {"divine/divine", 1},
	image = "heal_light_wounds.png",
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 7,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
	d = (self.max_life/10)*7
	self:heal(d)
	game.log(("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 70% of your max health.]])
	end,	
}

--Inflict spells
newTalent{
	name = "Inflict Light Wounds",
	type = {"divine/divine",1},
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	range = 4,
	target = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
		return tg
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(1,8)

		self:projectile(tg, x, y, DamageType.FORCE, damage)
		return true
	end,
	info = function(self, t)
		return ([[You deal 1d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Inflict Moderate Wounds",
	type = {"divine/divine",1},
	image = "inflict_light_wounds.png",
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 0,
	range = 4,
	target = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
		return tg
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(2,8)

		self:projectile(tg, x, y, DamageType.FORCE, damage)
		return true
	end,
	info = function(self, t)
		return ([[You deal 2d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Inflict Serious Wounds",
	type = {"divine/divine",1},
	image = "inflict_light_wounds.png",
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 3,
	points = 1,
	cooldown = 0,
	range = 4,
	target = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
		return tg
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(3,8)

		self:projectile(tg, x, y, DamageType.FORCE, damage)
		return true
	end,
	info = function(self, t)
		return ([[You deal 3d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Inflict Critical Wounds",
	type = {"divine/divine",1},
	image = "inflict_light_wounds.png",
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 4,
	points = 1,
	cooldown = 0,
	range = 4,
	target = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
		return tg
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(4,8)

		self:projectile(tg, x, y, DamageType.FORCE, damage)
		return true
	end,
	info = function(self, t)
		return ([[You deal 4d8 damage to a single target within range.]])
	end,	 
}


--"Animal buff" spells
newTalent{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE",
	type = {"divine/divine", 1},
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
	name = "Bull's Strength", short_name = "BULL_STRENGTH",
	type = {"divine/divine", 1},
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
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR",
	type = {"divine/divine", 1},
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
	name = "Owl's Wisdom", short_name = "OWL_WISDOM",
	type = {"divine/divine", 1},
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