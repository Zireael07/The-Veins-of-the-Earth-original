newTalentType{ type="monster/monster", name = "Active monster", description = "Monster abilities" }

newTalent{
	name = "Mind Blast",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	--require = ,
	points = 1,
	cooldown = 0,
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

		local damage = rng.dice(1,6)

		self:project(tg, x, y, DamageType.FORCE, {dam=damage, save=true, save_dc = 16})
		return true
	end,
	info = function(self, t)
		return ([[A cone of mind power stuns any creature in the area. The damage equals 1d6).]])
	end,
}

--Dragon turtle
newTalent{
	name = "Cloud of steam", short_name = "STEAM_BREATH",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = 0,
	radius = function(self, t)
		return 5 --average until sizes get done
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local damage = rng.dice(12, 6)
		local dc = 21

		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A cone of superheated steam hits all creatures in range.]])
	end,
}

newTalent{
	name = "Fire breath", short_name = "HELL_HOUND_BREATH",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 5,
	tactical = { ATTACK = 2 },
	range = 0,
	radius = function(self, t)
		return 2 --average until sizes get done
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local damage = rng.dice(2, 6)
		local dc = 13

		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A cone of fire hits all creatures in range.]])
	end,
}


--Dragon breath weapons
--NOTE: Both black dragon and copper dragon get it
newTalent{
	name = "Acid Breath Weapon", short_name = "ACID_BREATH",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = function(self, t)
		return 6 --average until sizes get done
	end,
	target = function(self, t)
		return {type="beam", range=self:getTalentRange(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local dice, dc = self:getBreathWeapon()

		local damage = rng.dice(dice, 8)

		self:project(tg, x, y, DamageType.ACID, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A line of acid hits all creatures in range.]])
	end,
}

--NOTE: Blue and bronze dragons both get it
newTalent{
	name = "Electric Breath Weapon", short_name = "ELECTRIC_BREATH",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = function(self, t)
		return 6 --average until sizes get done
	end,
	target = function(self, t)
		return {type="beam", range=self:getTalentRange(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local dice, dc = self:getBreathWeapon()

		local damage = rng.dice(dice, 8)

		self:project(tg, x, y, DamageType.ELECTRIC, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A line of lightning hits all creatures in range.]])
	end,
}

newTalent{
	name = "Green Dragon Breath Weapon", short_name = "ACID_BREATH_CONE",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = 0,
	radius = function(self, t)
		return 3 --average until sizes get done
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local dice, dc = self:getBreathWeapon()

		local damage = rng.dice(dice, 8)

		self:project(tg, x, y, DamageType.ACID, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A cone of acid hits all creatures in range.]])
	end,
}

--NOTE: Both red and gold dragons get it
newTalent{
	name = "Fire Breath Weapon", short_name = "FIRE_BREATH",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = 0,
	radius = function(self, t)
		return 3 --average until sizes get done
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local dice, dc = self:getBreathWeapon()

		local damage = rng.dice(dice, 8)

		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A cone of fire hits all creatures in range.]])
	end,
}

--NOTE: Both white and silver dragons get it
newTalent{
	name = "Cold Breath Weapon", short_name = "COLD_BREATH",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = 0,
	radius = function(self, t)
		return 3 --average until sizes get done
	end,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local dice, dc = self:getBreathWeapon()

		local damage = rng.dice(dice, 8)

		self:project(tg, x, y, DamageType.COLD, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A cone of cold hits all creatures in range.]])
	end,
}

--Should also be cone of sleep as a secondary
newTalent{
	name = "Brass Dragon Breath Weapon", short_name = "FIRE_BREATH_LINE",
	type = {"monster/monster", 1},
	mode = 'activated',
	is_spell = false,
	points = 1,
	cooldown = 4, --1d4 in SRD
	tactical = { ATTACK = 2 },
	range = function(self, t)
		return 6 --average until sizes get done
	end,
	target = function(self, t)
		return {type="beam", range=self:getTalentRange(t), talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local dice, dc = self:getBreathWeapon()

		local damage = rng.dice(dice, 8)

		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc=dc})

	end,
	info = function(self, t)
		return ([[A line of fire hits all creatures in range.]])
	end,
}
