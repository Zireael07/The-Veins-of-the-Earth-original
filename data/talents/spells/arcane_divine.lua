newTalentType{ all_limited=true, spell_list = "arcane_divine", type="arcane_divine", name="arcane_divine", description="Arcane and Divine Spells" }

newArcaneDivineSpell{
	name = "Cure Light Wounds",
	type = {"divine", 1},
	display = { image = "talents/cure_light_wounds.png"},
	mode = 'activated',
	--require = ,
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 8
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(1,8)*1.5)
		else return rng.dice(1,8) end
	end,
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
		return ([[You heal yourself - the amount of damage healed is equal to 1d8 + 1 per caster level (max 5).]])
	end,
}

newArcaneDivineSpell{
	name = "Cause Fear", short_name = "CAUSE_FEAR",
	type = {"divine", 1},
	mode = "activated",
	display = { image = "cause_fear.png"},
	level = 1,
	getDuration = function(self, t)
		local dice = rng.dice(1,4)
		if self:isTalentActive(self.T_EXTEND) then return dice*1.5
		else return dice end
	end,
	range = 3,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function (self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local duration = t.getDuration(self, t)

		if target:willSave(15) then
			game.log("Target resists the spell!")
			target:setEffect(target.EFF_SHAKEN, 1, {})
		else target:setEffect(target.EFF_FEAR, duration, {}) end

		return true
	end,
	info = function(self, t)
		return ([[Target flees for 1d4 rounds or is shaken for 1 round, depending on the save.]])
	end,
}


--"Animal buff" spells
newArcaneDivineSpell{
	name = "Bear's Endurance", short_name = "BEAR_ENDURANCE",
	type = {"divine", 1},
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
	type = {"divine", 1},
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
	type = {"divine", 1},
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
	type = {"divine", 1},
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
