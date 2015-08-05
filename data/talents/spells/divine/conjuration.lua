newTalentType{ all_limited=true, type="conjuration_divine", name="conjuration",
description = "Conjuration magic deals with the creation magical creatures and substances"
}

newDivineSpell{
	name = "Create Food and Water",
	type = {"conjuration_divine", 1},
	display = { image = "talents/create_food_and_water.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
		if not self then return nil end
		local food = game.zone:makeEntity(game.level, "object", {name="food rations", ego_chance=-1000}, 1, true)
		local water = game.zone:makeEntity(game.level, "object", {name="flask of water", ego_chance=-1000}, 1, true)

	if food then
		game.zone:addEntity(game.level, food, "object")
		self:addObject(game.player:getInven("INVEN"), food)
		food.pseudo_id = true
	end

	if water then
		game.zone:addEntity(game.level, water, "object")
		self:addObject(game.player:getInven("INVEN"), water)
		water.pseudo_id = true
	end

		return true
	end,
	info = function(self, t)
		return ([[You create some food and drink for yourself.]])
	end,

}

--Cure spells
newDivineSpell{
	name = "Cure Moderate Wounds",
	type = {"conjuration_divine", 1},
	image = "talents/cure_light_wounds.png",
	mode = 'activated',
	level = 2,
	points = 1,
	tactical = { BUFF = 2 },
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 16
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(2,8)*1.5)
		else return rng.dice(2,8) end
	end,
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
		if not self then return nil end
		d = t.getDamage(self, t)
		self:heal(d) --+ caster_bonus)
		game.logSeen(self,("%s heals %d damage"):format(self.name:capitalize(), d))
		return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 2d8 + 1 per caster level (max 5).]])
	end,
}

newDivineSpell{
	name = "Cure Serious Wounds",
	type = {"conjuration_divine", 1},
	mode = 'activated',
	image = "talents/cure_light_wounds.png",
	level = 3,
	points = 1,
	tactical = { BUFF = 2 },
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 24
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(3,8)*1.5)
		else return rng.dice(3,8) end
	end,
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self, t)
		if not self then return nil end
		d = t.getDamage(self, t)
		self:heal(d) --+ caster_bonus)
		game.logSeen(self,( "%s heals %d damage"):format(self.name:capitalize(), d))
		return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 3d8 + 1 per caster level (max 5).]])
	end,
}

newDivineSpell{
	name = "Cure Critical Wounds",
	type = {"conjuration_divine", 1},
	image = "talents/cure_light_wounds.png",
	mode = 'activated',
	level = 4,
	points = 1,
	tactical = { BUFF = 2 },
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 32
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(4,8)*1.5)
		else return rng.dice(4,8) end
	end,
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self, t)
		if not self then return nil end
		d = t.getDamage(self, t)
		self:heal(d) --+ caster_bonus)
		game.logSeen(self, ("%s heals %d damage"):format(self.name:capitalize(), d))
		return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 4d8 + 1 per caster level (max 5).]])
	end,
}

newDivineSpell{
	name = "Delay Poison",
	type = {"conjuration_divine", 1},
	mode = "activated",
	level = 2,
	tactical = { BUFF = 2 },
	range = 0,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 960
		else return 600 end --1 hr
	end,
	action = function(self, t)
		if not self then return nil end
		self:setEffect(self.EFF_DELAY_POISON, t.getDuration(self, t), {})

		return true
	end,

	info = function(self, t)
		return ([[You delay poison's onset.]])
	end,
}


--Empower & Maximize don't apply!
newDivineSpell{
	name = "Heal Light Wounds",
	type = {"conjuration_divine", 1},
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 4,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self, t)
		if not self then return nil end
		d = (self.max_life/10)*1
		self:heal(d)
		game.logSeen(self,("%s heals %d damage"):format(self.name:capitalize(), d))
	return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 10% of your max health.]])
	end,
}

newDivineSpell{
	name = "Heal Moderate Wounds",
	type = {"conjuration_divine", 1},
	image = "heal_light_wounds.png",
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 5,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self, t)
		if not self then return nil end
		d = (self.max_life/10)*3
		self:heal(d)
		game.logSeen(self, ("%s heals %d damage"):format(self.name:capitalize(), d))
		return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 30% of your max health.]])
	end,
}

newDivineSpell{
	name = "Heal Serious Wounds",
	type = {"conjuration_divine", 1},
	image = "heal_light_wounds.png",
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 6,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self, t)
		if not self then return nil end
		d = (self.max_life/10)*5
		self:heal(d)
		game.logSeen(self, ("%s heals %d damage"):format(self.name:capitalize(), d))
		return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 50% of your max health.]])
	end,
}

newDivineSpell{
	name = "Heal Critical Wounds",
	type = {"conjuration_divine", 1},
	image = "heal_light_wounds.png",
	display = { image = "heal_light_wounds.png"},
	mode = 'activated',
	level = 7,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self, t)
		if not self then return nil end
		d = (self.max_life/10)*7
		self:heal(d)
		game.logSeen(self, ("%s heals %d damage"):format(self.name:capitalize(), d))
		return true
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 70% of your max health.]])
	end,
}
