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