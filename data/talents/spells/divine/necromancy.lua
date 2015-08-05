newTalentType{
	all_limited=true,
	type="necromancy_divine",
	name="necromancy",
	description = "Necromancy magic deals with the undead and the life force"
}

--Inflict spells
newDivineSpell{
	name = "Inflict Light Wounds",
	type = {"necromancy_divine",1},
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
	type = {"necromancy_divine",1},
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
	type = {"necromancy_divine",1},
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
	type = {"necromancy_divine",1},
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
	name = "Deathwatch",
	type = {"necromancy_divine", 1},
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

		self:project(tg, x, y, DamageType.DETECT_LAW, damage)

		return true
	end,]]
	info = function(self, t)
		return ([[You can determine the condition of creatures around you.]])
	end,
}

newDivineSpell{
	name = "Doom",
	type = {"necromancy_divine", 1},
	mode = "activated",
	level = 1,
	range = 5,
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 8
		else return 5 end
	end,
	getSave = function(self, t)
		return self:getSpellDC(t)
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = t.getDuration(self, t)
		local save = t.getSave(self, t)

		if target:willSave(save) then game.log("Target resists the spell!")
		else target:setEffect(target.EFF_SHAKEN, duration, {})
		end

		return true
	end,

	info = function(self, t)
		return ([[The target is afflicted with a feeling of doom, having a -2 penalty on attacks, saving throws and checks.]])
	end,
}
