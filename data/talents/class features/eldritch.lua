newTalentType{ passive = true, type="eldritch/eldritch", name="eldritch", description="Eldritch Feats" }

--Warlock attack
newTalent{	
	name = "Eldritch Blast", --image="talents/magic_missile.png",
	type = {"eldritch/eldritch", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 3,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = true,
	proj_speed = 3,
	num_targets = function(self, t)
		local caster_level = self.level or 1
		return 1 + math.min(math.floor(caster_level / 2, 5))
	end,
	target = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t), talent=t, display={display='*',color=colors.RED}}
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
		return ([[A blast of eldritch power a warlock wields.]])
	end,
}