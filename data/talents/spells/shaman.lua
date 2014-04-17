newTalentType{ type="shaman/shaman", name="shaman", description="Divine Spells" }

newTalent{
	name = "Cure Light Wounds", short_name = "CLW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 5,
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
	name = "Cure Moderate Wounds", short_name = "CMW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 5,
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
	name = "Cure Serious Wounds", short_name = "CSW_SHAMAN",
	type = {"shaman/shaman", 1},
	mode = 'activated',
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	level = 3,
	points = 1,
	cooldown = 5,
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
	name = "Cure Critical Wounds", short_name = "CCW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 4,
	points = 1,
	cooldown = 5,
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
	name = "Heal Light Wounds", short_name = "HLW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 4,
	points = 1,
	cooldown = 5,
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
	name = "Heal Moderate Wounds", short_name = "HMW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 5,
	points = 1,
	cooldown = 5,
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
	name = "Heal Serious Wounds", short_name = "HSW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 6,
	points = 1,
	cooldown = 5,
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
	name = "Heal Critical Wounds", short_name = "HCW_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 7,
	points = 1,
	cooldown = 5,
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
	name = "Inflict Light Wounds", short_name = "ILW_SHAMAN",
	type = {"shaman/shaman",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 5,
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

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 1d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Inflict Moderate Wounds", short_name = "IMW_SHAMAN",
	type = {"shaman/shaman",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 5,
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

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 2d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Inflict Serious Wounds", short_name = "ISW_SHAMAN",
	type = {"shaman/shaman",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 3,
	points = 1,
	cooldown = 5,
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

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 3d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Inflict Critical Wounds", short_name = "ICW_SHAMAN",
	type = {"shaman/shaman",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 4,
	points = 1,
	cooldown = 5,
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

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 4d8 damage to a single target within range.]])
	end,	 
}

newTalent{
	name = "Faerie Fire", short_name = "FAERIE_FIRE_SHAMAN",
	image = "talents/faerie_fire.png",
	display = { image = "talents/faerie_fire.png"},
	type = {"shaman/shaman", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 5,
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

		local duration = 5

		self:project(tg, x, y, DamageType.FAERIE, damage, {type="faerie"})

		return true
	end,
	info = function(self, t)

		return ([[You create a sphere of magical light.]])
	end,
}


--"Animal buff" spells
newTalent{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/bear_endurance.png",
	display = { image = "talents/bear_endurance.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 5,
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
	name = "Bull's Strength", short_name = "BULL_STRENGTH_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/bull_strength.png",
	display = { image = "talents/bull_strength.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 5,
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
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/eagle_splendor.png",
	display = { image = "talents/eagle_splendor.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 5,
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
	name = "Owl's Wisdom", short_name = "OWL_WISDOM_SHAMAN",
	type = {"shaman/shaman", 1},
	image = "talents/owl_wisdom.png",
	display = { image = "talents/owl_wisdom.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 5,
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