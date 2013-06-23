newTalentType{ type="arcane/arcane", name = "arcane", description = "Arcane Spells" }

newTalent{	
	name = "Acid Splash",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 8,
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
		if not x or not y then return nil end

		local damage = rng.dice(1,3)

		self:projectile(tg, x, y, DamageType.ACID, damage)



		return true
	end,
	info = function(self, t)
		--local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}

newTalent{	
	name = "Grease",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 8,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = false,
	target = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		if not x or not y then return nil end

		local duration = 5

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.GREASE, {},
			1.5,
			5, nil,
			engine.Entity.new{alpha=100, display='', color_br=200, color_bg=190, color_bb=30},
			nil, true
		)



		return true
	end,
	info = function(self, t)
		--local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}