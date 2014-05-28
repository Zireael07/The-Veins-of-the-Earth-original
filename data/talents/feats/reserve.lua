newTalentType{ type="magic/reserve", no_tt_req = true, name = "reserve", description = "Reserve feats" }

newFeat{
	name = "Fiery Burst",
	type = {"magic/reserve", 1},
	require = {
	},
	tactical = { ATTACK = 1 },
	range = 5,
	on_pre_use = function(self, t, silent)
		return self:highestSpellDescriptor("fire") and true or false
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), talent=t, display={display='*',color=colors.RED}}
	end,
	action = function(self, t)
		local bt = self:highestSpellDescriptor("fire")
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		if not x then return nil end

		local damage = rng.dice(bt.level, 6)
		self:project(tg, x, y, DamageType.FIRE, {dam=damage})

		return true
	end,
	info = function(self, t)
		local t = self:highestSpellDescriptor("fire")
		return ([[As long as you have a fire spell of available to cast, you can create a burst of fire at range 5 that
		deals 1d6 damage per levels of the highest fire spell available (currently %dd6)]]):format(t and t.level or 0)
	end,
}
