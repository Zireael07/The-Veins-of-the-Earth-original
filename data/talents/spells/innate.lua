newTalentType{ type="innate/innate", name = "innate", description = "Spell-like abilities" }

--Racial spell-likes
newTalent{
	name = "Darkness", short_name = "DARKNESS_INNATE",
	type = {"innate/innate", 1},
	image = "talents/darkness.png",
	display = { image = "talents/darkness.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 15,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = false,
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

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.DARKNESS, 0,
			1.5,
			5, nil,
			engine.Entity.new{alpha=100, display='', color_br=50, color_bg=50, color_bb=50},
			nil, true
		)

		return true
	end,
	info = function(self, t)

		return ([[You create a sphere of magical darkness, giving all creatures in it 20% concealment.]])
	end,
}

newTalent{
	name = "Faerie Fire", short_name = "FAERIE_FIRE_INNATE",
	type = {"innate/innate", 1},
	mode = 'activated',
	image = "talents/faerie_fire.png",
	display = { image = "talents/faerie_fire.png"},
	level = 1,
	points = 1,
	cooldown = 15,
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

newTalent{
	name = "Invisibility", short_name = "INVISIBILITY_INNATE",
	type = {"innate/innate", 1},
	image = "talents/invisibility.png",
	display = { image = "talents/invisibility.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 15,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_INVISIBLE, 5, {})
		return true
	end,

	info = function(self, t)
		return ([[You turn invisible.]])
	end,
}

--Feat-enabled racial spell-like
newTalent{
	name = "Levitate", short_name = "LEVITATE_INNATE",
	type = {"innate/innate", 1},
	display = { image = "talents/levitate.png"},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 15,
	tactical = { BUFF = 2 },
	range = 0,
	action = function(self)
	if not self then return nil end
		self:setEffect(self.EFF_LEVITATE, 10, {})
		return true
	end,

	info = function(self, t)
		return ([[You start levitating.]])
	end,
}


--Arcane spell-likes
newTalent{
	name = "Acid Splash", short_name = "ACID_SPLASH_INNATE",
	type = {"innate/innate", 1},
	image = "talents/acid_splash.png",
	display = { image = "talents/acid_splash.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 15,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = true,
	target = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(1,3)

		self:projectile(tg, x, y, DamageType.ACID, {dam=damage})

		return true
	end,
	info = function(self, t)
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}

newTalent{
	name = "Grease", short_name = "GREASE_INNATE",
	type = {"innate/innate", 1},
	image = "talents/grease.png",
	display = { image = "talents/grease.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 15,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = false,
	radius = 1.5,
	target = function(self, t)
		local tg = {type="ball", range=self:getTalentRange(t), nolock = true, radius=self:getTalentRadius(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = 5

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.GREASE, {dc=10},
			1.5,
			5, nil,
			engine.Entity.new{alpha=100, display='', color_br=200, color_bg=190, color_bb=30},
			nil, true
		)

		return true
	end,
	info = function(self, t)
		return ([[You cover the floor in grease, causing monsters to fall.]])
	end,
}

newTalent{
	name = "Magic Missile", short_name = "MM_INNATE",
	type = {"innate/innate", 1},
	image = "talents/magic_missile.png",
	display = { image = "talents/magic_missile.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 15,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = true,
	proj_speed = 3,
	num_targets = function(self, t)
		local caster_level = self.level or 1
		return 1 + math.min(math.floor(caster_level / 2, 5))
	end,
	target = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t), talent=t, display={display='*',color=colors.ORCHID}}
		return tg
	end,
	action = function(self, t)
		local targets = {}
		for i=1, t.num_targets(self, t) do
			local tg = self:getTalentTarget(t)
			local x, y = self:getTarget(tg)
			if x and y then
				targets[i] = {x,y,tg}
			end
		end

		for i,v in ipairs(targets) do
			x, y, tg = unpack(v)
			local damage = rng.dice(1,4)+1
			if x and y and tg then
				self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
			end
		end

		return true
	end,
	info = function(self, t)
		local missiles = t.num_targets(self, t)
		return ([[%d missiles of magical energy darts forth from your fingertip and strike their targets, dealing 1d4+1 points of force damage.

			The number of missiles is one plus half your caster level]]):format(missiles)
	end,
}

newTalent{
	name = "Burning Hands", short_name = "BURNING_HANDS_INNATE",
	type = {"innate/innate", 1},
	image = "talents/burning_hands.png",
	display = { image = "talents/burning_hands.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 5,
	tactical = { BUFF = 2 },
	range = 0,
	requires_target = true,
	radius = 3,
	num_dice = function(self, t)
		return math.min(self.level or 1, 5)
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local level = t.num_dice(self,t)
		local damage = 0
		for i=1, level do
			damage = damage + rng.dice(1,4)
		end
		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc = 15})
		return true
	end,
	info = function(self, t)
		local dice = t.num_dice(self, t)
		return ([[A cone of searing flame shoots from your fingertips. Any creature in the area of the flames takes %dd4 points of fire damage.

		The damage is equal to 1d4 per caster level (maximum 5d4).]]):format(dice)
	end,
}

newTalent{
	name = "Sleep", short_name = "SLEEP_INNATE",
	type = {"innate/innate",1},
	image = "talents/sleep.png",
	display = { image = "talents/sleep.png"},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 15,
	range = 0,
	radius = 4,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	get_max_hd = function(self, t)
		return 8
	end,
	action = function(self, t)
	local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		-- Find potential targets in the area

		local targets = {}
		local grids = self:project(tg, x, y, function(px, py)
			local actor = game.level.map(px, py, Map.ACTOR)
			if actor then targets[#targets+1] = actor end
		end)

		-- Take the creatures with the weakest hd and discard the rest

		table.sort(targets, function(a,b) return a.hit_die > b.hit_die end)
		local final_targets = {}
		local max_hd = t.get_max_hd(self, t)
		local i = 1
		local stop = false

		while not stop do
			local t = targets[i]
			if t and t.hit_die <= max_hd then --and target:canBe("sleep")
				final_targets[#final_targets+1] = t
				max_hd = max_hd - t.hit_die
				i = i + 1
			else
				stop = true
			end
		end

		local duration = 5
		-- Apply sleep
		for i, target in ipairs(final_targets) do
			if not target:willSave(15) then -- @todo: do real dc
				target:setEffect(target.EFF_SLEEP, duration, {})
			else
				game.logSeen(target, "%s resist the sleep!", target.name)
			end
		end
		return true
	end,


	info = function(self, t)
		return ([[You put weak creatures to sleep.]])
	end,

}


newTalent{
	name = "Fireball", short_name = "FIREBALL_INNATE",
	type = {"innate/innate", 1},
	image = "talents/fireball.png",
	display = { image = "talents/fireball.png"},
	mode = 'activated',
	--require = ,
	level = 3,
	points = 1,
	cooldown = 15,
--	tactical = { BUFF = 2 },
	range = 5,
	radius = 3,
	target = function(self, t)
		return {type="ball", range=self:getTalentRange(t), radius=self:getTalentRadius(t)}
	end,
	action = function(self, t)
	local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(3,6)

		who:project(tg, x, y, DamageType.FIRE, damage, {type=explosion})

	return true
	end,

	info = function(self, t)
		return ([[You cause a fireball to erupt around the target - the amount of damage is 3d6.]])
	end,
}

--innate versions of buff spells
newTalent{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE_INNATE",
	type = {"innate/innate", 1},
	image = "talents/bear_endurance.png",
	display = { image = "talents/bear_endurance.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Bull's Strength", short_name = "BULL_STRENGTH_INNATE",
	type = {"innate/innate", 1},
	image = "talents/bull_strength.png",
	display = { image = "talents/bull_strength.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Eagle's Splendor", short_name = "EAGLE_SPLENDOR_INNATE",
	type = {"innate/innate", 1},
	image = "talents/eagle_splendor.png",
	display = { image = "talents/eagle_splendor.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Owl's Wisdom", short_name = "OWL_WISDOM_INNATE",
	type = {"innate/innate", 1},
	image = "talents/owl_wisdom.png",
	display = { image = "talents/owl_wisdom.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Cat's Grace", short_name = "CAT_GRACE_INNATE",
	type = {"innate/innate", 1},
	image = "talents/cat_grace.png",
	display = { image = "talents/cat_grace.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Fox's Cunning", short_name = "FOX_CUNNING_INNATE",
	type = {"innate/innate", 1},
	image = "talents/fox_cunning.png",
	display = { image = "talents/fox_cunning.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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

--Divine innate spell-likes
newTalent{
	name = "Cure Light Wounds", short_name = "CLW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 15,
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
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 1d8 + 1 per caster level (max 5).]])
	end,
}

newTalent{
	name = "Cure Moderate Wounds", short_name = "CMW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Cure Serious Wounds", short_name = "CSW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 3,
	points = 1,
	cooldown = 15,
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
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 3d8 + 1 per caster level (max 5).]])
	end,
}

newTalent{
	name = "Cure Critical Wounds", short_name = "CCW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/cure_light_wounds.png",
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	level = 4,
	points = 1,
	cooldown = 15,
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
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 4d8 + 1 per caster level (max 5).]])
	end,
}

newTalent{
	name = "Heal Light Wounds", short_name = "HLW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 4,
	points = 1,
	cooldown = 15,
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
	name = "Heal Moderate Wounds", short_name = "HEAL_MODERATE_WOUNDS_INNATE",
	type = {"innate/innate", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 5,
	points = 1,
	cooldown = 15,
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
	name = "Heal Serious Wounds", short_name = "HSW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 6,
	points = 1,
	cooldown = 15,
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
	name = "Heal Critical Wounds", short_name = "HCW_INNATE",
	type = {"innate/innate", 1},
	image = "talents/heal_light_wounds.png",
	display = { image = "talents/heal_light_wounds.png"},
	mode = 'activated',
	level = 7,
	points = 1,
	cooldown = 15,
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
	name = "Inflict Light Wounds", short_name = "INFLICT_LIGHT_WOUNDS_INNATE",
	type = {"innate/innate",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 15,
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
	name = "Inflict Moderate Wounds", short_name = "INFLICT_MODERATE_WOUNDS_INNATE",
	type = {"innate/innate",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 15,
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
	name = "Inflict Serious Wounds", short_name = "INFLICT_SERIOUS_WOUNDS_INNATE",
	type = {"innate/innate",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 3,
	points = 1,
	cooldown = 15,
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
	name = "Inflict Critical Wounds", short_name = "INFLICT_CRITICAL_WOUNDS_INNATE",
	type = {"innate/innate",1},
	image = "talents/inflict_light_wounds.png",
	display = { image = "talents/inflict_light_wounds.png"},
	mode = "activated",
	level = 4,
	points = 1,
	cooldown = 15,
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
