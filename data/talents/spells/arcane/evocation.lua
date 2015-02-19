newTalentType{ 
	all_limited=true,
	type="evocation",
	name="evocation",
	description = "the evocation school harnesses the elements, using them to cause great damage"
}

newArcaneSpell{	
	name = "Light",
	type = {"evocation", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(self.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 5,
	requires_target = false,
	radius = 3,
	target = function(self, t)
		local tg = {type="ball", range=self:getTalentRange(t), nolock = true, radius=self:getTalentRadius(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
        local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.LITE, 0,
			3,
			5, nil,
			engine.Entity.new{alpha=100, display='', color_br=255, color_bg=255, color_bb=0},
			nil, true
		)

		return true
	end,
	info = function(self, t)

		return ([[You create a sphere of magical light.]])
	end,
}


newArcaneSpell{	
	name = "Magic Missile", --image="talents/magic_missile.png",
	type = {"evocation", 1}, descriptors = {force=true},
	mode = 'activated',
	level = 1,
	range = 5,
	requires_target = true,
	proj_speed = 3,
	num_targets = function(self, t)
		return 1 + math.min(math.floor(self:casterLevel(t) / 2, 5))
	end,
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 5
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max((rng.dice(1,4)+1)*1.5)
		else return rng.dice(1,4)+1 end
	end,
	target = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t), talent=t, display={display='*',color=colors.ORCHID}}
		return tg
	end,
	action = function(self, t)
		local targets = {}
		for i=1, t.num_targets(self, t) do
			local tg = self:getTalentTarget(t)
			local x, y = self:getTarget(tg)
			if x and y then
				targets[i] = {x,y,tg}
            		else
                		return nil
			end
		end

		for i,v in ipairs(targets) do
			x, y, tg = unpack(v)
			local damage = t.getDamage(self, t)
			if x and y and tg then
				self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
			end
		end

		return true
	end,
	info = function(self, t)
		local missiles = t.num_targets(self, t)
		return ([[%d missiles of magical energy darts forth from your fingertip and strike their targets, dealing 1d4+1 points of force damage.

			The number of missiles is one plus half your caster level]]):format(missiles)
	end,
}

newArcaneSpell{	
	name = "Burning Hands",
	type = {"evocation", 1}, descriptors = {fire=true},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	num_dice = function(self, t)
		return math.min(self:casterLevel(t) or 1, 5)
	end,
	getDamage = function(self, t)
		--dice per caster level
		local level = t.num_dice(self,t)
		local damage = 0
		for i=1, level do
			damage = damage + rng.dice(1,4)
		end

		if self:isTalentActive(self.T_MAXIMIZE) then return level*4
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(damage*1.5)
		else return damage end

	end,
	range = 0,
	requires_target = true,
	radius = 3,
	
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local level = t.num_dice(self,t)
		local damage = 0
		for i=1, level do
			damage = damage + rng.dice(1,4)
		end
		self:project(tg, x, y, DamageType.FIRE, {dam=damage, save=true, save_dc = 15})
		return true
	end,
	info = function(self, t)
		local dice = t.num_dice(self, t) 
		return ([[A cone of searing flame shoots from your fingertips. Any creature in the area of the flames takes %dd4 points of fire damage.

		The damage is equal to 1d4 per caster level (maximum 5d4).]]):format(dice)
	end,
}

newArcaneSpell{	
	name = "Darkness",
	type = {"evocation", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)  
		if self:isTalentActive(self.T_EXTEND) then return 8 
		else return 5 end
	end,
	range = 5,
	requires_target = false,
	radius = 1.5,
	target = function(self, t)
		local tg = {type="ball", range=self:getTalentRange(t), nolock = true, radius=self:getTalentRadius(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
        local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local duration = t.getDuration(self, t)

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.DARKNESS, 0,
			1.5,
			5, nil,
			engine.Entity.new{alpha=100, display='', color_br=50, color_bg=50, color_bb=50},
			nil, true
		)

		return true
	end,
	info = function(self, t)

		return ([[You create a sphere of magical darkness, giving all creatures in it 20% concealment.]])
	end,
}

newArcaneSpell{	
	name = "Ignizarr's fire", short_name = "IGNIZZAR_FIRE",
	type = {"evocation", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 18
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(3,6)*1.5)
		else return rng.dice(3,6) end
	end,
	range = 5,
	requires_target = true,
	target = function(self, t)
		return {type="bolt", range=self:getTalentRange(t), nolock = true, selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		local level = t.num_dice(self,t)
		local damage = rng.dice(3,6)

		self:project(tg, x, y, DamageType.FIRE, {dam=t.getDamage(self, t), save=true, save_dc = 15})
		return true
	end,
	info = function(self, t)
		return ([[A line of searing flame shoots from your fingertips. Any creature caught in it takes 3d6 points of fire damage.]])
	end,
}


newArcaneSpell{
	name = "Fireball",
	type = {"evocation", 1}, descriptors = {fire=true},
	display = { image = "fireball.png"},
	mode = 'activated',
	level = 3,
	points = 1,
	cooldown = 20,
--	tactical = { BUFF = 2 },
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 18
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(3,6)*1.5)
		else return rng.dice(3,6) end
	end,
	range = 0,
	radius = function(self, t)
		return 3
	end,
	target = function(self, t)
		return {type="ball", range=self:getTalentRange(t), radius=self:getTalentRadius(t)}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = rng.dice(3,6)
		self:project(tg, x, y, DamageType.FIRE, {dam=t.getDamage(self, t), save=true, save_dc = 15})
		return true
	end,

	info = function(self, t)
		return ([[You cause a fireball to erupt around the target - the amount of damage is 3d6.]])
	end,	
}