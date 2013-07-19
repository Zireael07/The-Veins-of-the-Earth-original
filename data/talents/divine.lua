newTalentType{ type="divine/divine", name="divine", description="Divine Spells" }

newTalent{
	name = "Heal Light Wounds",
	type = {"divine/divine", 1},
	mode = 'activated',
	--require = ,
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	--caster.bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
	if not self then return nil end
	---local level = caster.bonus(self)	
	--for i=1, level do
	self:heal(rng.dice(1,8)) --+ caster.bonus)
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 1d8 + 1 per caster level (max 5).]])
	end,	
}