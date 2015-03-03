newTalentType{ type="arcane/reserve", no_tt_req = true, name = "Reserve", description = "Reserve feats" }

newFeat{
	name = "Force Bolt",
	type = {"arcane/reserve", 1},
	require = {
	},
	tactical = { ATTACK = 1 },
	range = 5,
	on_pre_use = function(self, t, silent)
		return self:highestSpellDescriptor("force") and true or false
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), talent=t, display={display='*',color=colors.RED}}
	end,
	action = function(self, t)
		local bt = self:highestSpellDescriptor("force")
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		if not x then return nil end

		local damage = rng.dice(bt.level, 4)
		self:project(tg, x, y, DamageType.FORCE, {dam=damage})

		return true
	end,
	info = function(self, t)
		local t = self:highestSpellDescriptor("force")
		return ([[As long as you have a force spell available to cast, you can create a bolt of force at range 5 that
		deals 1d4 damage per level of the highest force spell available (currently %dd4)]]):format(t and t.level or 0)
	end,
}
