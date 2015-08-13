newTalentType{ all_limited=true, type="conjuration_both", name="conjuration",
description = "Conjuration magic deals with the creation magical creatures and substances"
}

--[[newArcaneDivineSpell{
	name = "Cure Light Wounds",
	type = {"conjuration_both", 1},
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

	info = function(self, t)]]
--		return ([[You heal yourself - the amount of damage healed is equal to 1d8 + 1 per caster level (max 5).]])
--	end,
--}
