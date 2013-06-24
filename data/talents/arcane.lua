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
		local _ _, _, _, x, y = self:canProject(tg, x, y)
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
	radius = 1.5,
	target = function(self, t)
		local tg = {type="ball", range=self:getTalentRange(t), radius=self:getTalentRadius(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = 5

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.GREASE, {dc=10},
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

newTalent{	
	name = "Magic Missile",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 8,
	tactical = { BUFF = 2 },
	range = 5,
	requires_target = true,
	proj_speed = 3,
	num_targets = function(self, t)
		local caster_level = self.level or 1
		return 1 + math.min(math.floor(caster_level / 2, 5))
	end,
	target = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t), talent=t, display={display='*',color=colors.ORCHID}}
		return tg
	end,
	action = function(self, t)
		local targets = {}
		for i=1, t:num_targets(self) do
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
				self:projectile(tg, x, y, DamageType.FORCE, damage)
			end
		end

		return true
	end,
	info = function(self, t)
		--local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}

newTalent{	
	name = "Burning Hands",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 8,
	tactical = { BUFF = 2 },
	range = 0,
	requires_target = true,
	radius = 3,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		if not x or not y then return nil end

		local level = math.min(self.level or 1, 5)
		local damage = 0
		for i=1, level do
			damage = damage + rng.dice(1,4)
		end
		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc = 15})
		return true
	end,
	info = function(self, t)
		--local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}