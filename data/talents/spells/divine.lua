newTalentType{ all_limited=true, spell_list = "divine", type="divine", name="divine", description="Divine Spells" }

newDivineSpell{
	name = "Create Food and Water",
	type = {"divine", 1},
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
--[[newDivineSpell{
	name = "Cure Light Wounds",
	type = {"divine", 1},
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

	info = function(self, t)]]
--		return ([[You heal yourself - the amount of damage healed is equal to 1d8 + 1 per caster level (max 5).]])
--	end,
--}

newDivineSpell{
	name = "Cure Moderate Wounds",
	type = {"divine", 1},
	image = "talents/cure_light_wounds.png",
	mode = 'activated',
	--require = ,
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
	type = {"divine", 1},
	mode = 'activated',
	image = "talents/cure_light_wounds.png",
	--require = ,
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
	type = {"divine", 1},
	image = "talents/cure_light_wounds.png",
	mode = 'activated',
	--require = ,
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

--Empower & Maximize don't apply!
newDivineSpell{
	name = "Heal Light Wounds",
	type = {"divine", 1},
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
	type = {"divine", 1},
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
	type = {"divine", 1},
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
	type = {"divine", 1},
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

--Inflict spells
newDivineSpell{
	name = "Inflict Light Wounds",
	type = {"divine",1},
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 8
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(1,8)*1.5)
		else return rng.dice(1,8) end
	end,
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

		local damage = t.getDamage(self, t)

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 1d8 damage to a single target within range.]])
	end,
}

newDivineSpell{
	name = "Inflict Moderate Wounds",
	type = {"divine",1},
	image = "inflict_light_wounds.png",
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 0,
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 16
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(2,8)*1.5)
		else return rng.dice(2,8) end
	end,
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

		local damage = t.getDamage(self, t)

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 2d8 damage to a single target within range.]])
	end,
}

newDivineSpell{
	name = "Inflict Serious Wounds",
	type = {"divine",1},
	image = "inflict_light_wounds.png",
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 3,
	points = 1,
	cooldown = 0,
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 24
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(3,8)*1.5)
		else return rng.dice(3,8) end
	end,
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

		local damage = t.getDamage(self, t)

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 3d8 damage to a single target within range.]])
	end,
}

newDivineSpell{
	name = "Inflict Critical Wounds",
	type = {"divine",1},
	image = "inflict_light_wounds.png",
	display = { image = "inflict_light_wounds.png"},
	mode = "activated",
	level = 4,
	points = 1,
	cooldown = 0,
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 32
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(4,8)*1.5)
		else return rng.dice(4,8) end
	end,
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

		local damage = t.getDamage(self, t)

		self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
		return true
	end,
	info = function(self, t)
		return ([[You deal 4d8 damage to a single target within range.]])
	end,
}

newDivineSpell{
	name = "Faerie Fire",
	type = {"divine", 1},
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
	name = "Detect Evil",
	type = {"divine", 1},
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

		local duration = t,getDuration(self, t)

	--	self:project(tg, x, y, DamageType.DETECT_EVIL, damage, {type="evil"})
		self:project(tg, x, y, DamageType.DETECT_EVIL, damage)

		return true
	end,
	info = function(self, t)

		return ([[You detect presence or absence of evil in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Detect Good",
	type = {"divine", 1},
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

	--	self:project(tg, x, y, DamageType.DETECT_GOOD, damage, {type="good"})
		self:project(tg, x, y, DamageType.DETECT_GOOD, damage)

		return true
	end,
	info = function(self, t)

		return ([[You detect presence or absence of good in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Detect Chaos",
	type = {"divine", 1},
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

	--	self:project(tg, x, y, DamageType.DETECT_CHAOS, damage, {type="chaos"})
		self:project(tg, x, y, DamageType.DETECT_CHAOS, damage)

		return true
	end,
	info = function(self, t)

		return ([[You detect presence or absence of chaos in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Detect Law",
	type = {"divine", 1},
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

	--	self:project(tg, x, y, DamageType.DETECT_LAW, damage, {type="evil"})
		self:project(tg, x, y, DamageType.DETECT_LAW, damage)

		return true
	end,
	info = function(self, t)

		return ([[You detect presence or absence of law in a 60 ft. cone.]])
	end,
}

newDivineSpell{
	name = "Deathwatch",
	type = {"divine", 1},
	mode = 'activated',
	level = 1,
	range = 1,
--	requires_target = false,
	radius = 5,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	action = function(self, t)
		self:setEffect(self.EFF_DEATHWATCH, t.getDuration(self, t), {})
		return true
	end,
--[[	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
        local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)

	--	self:project(tg, x, y, DamageType.DETECT_LAW, damage, {type="evil"})
		self:project(tg, x, y, DamageType.DETECT_LAW, damage)

		return true
	end,]]
	info = function(self, t)
		return ([[You can determine the condition of creatures around you.]])
	end,
}

newDivineSpell{
	name = "Divine Favor",
	type = {"divine", 1},
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

newDivineSpell{
	name = "Entropic Shield",
	type = {"divine", 1},
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
	name = "Doom",
	type = {"divine", 1},
	mode = "activated",
	level = 1,
	range = 5,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = t.getDuration(self, t)

		if target:willSave(15) then game.log("Target resists the spell!")
		else target:setEffect(target.EFF_SHAKEN, duration, {})
		end

		return true
	end,

	info = function(self, t)
		return ([[The target is afflicted with a feeling of doom, having a -2 penalty on attacks, saving throws and checks.]])
	end,
}

newDivineSpell{
	name = "Shield of Faith",
	type = {"divine", 1},
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


--"Animal buff" spells
--[[newDivineSpell{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE",
	type = {"divine", 1},
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

	info = function(self, t)]]
--		return ([[You increase your Constitution by +4.]])
--	end,
--}

--[[newDivineSpell{
	name = "Bull's Strength", short_name = "BULL_STRENGTH",
	type = {"divine", 1},
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

	info = function(self, t)]]
--		return ([[You increase your Strength by +4.]])
--	end,
--}

--[[newDivineSpell{
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR",
	type = {"divine", 1},
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

	info = function(self, t)]]
--		return ([[You increase your Charisma by +4.]])
--	end,
--}

--[[newDivineSpell{
	name = "Owl's Wisdom", short_name = "OWL_WISDOM",
	type = {"divine", 1},
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

	info = function(self, t)]]
--		return ([[You increase your Wisdom by +4.]])
--	end,
--}
