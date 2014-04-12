newTalentType{ 
	all_limited=true,
	spell_list="arcane",
	type="evocation",
	name="evocation",
	description = "the evocation school harnesses the elements, using them to cause great damage"
}

newTalent{	
	name = "Light",
	type = {"evocation", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
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

		local duration = 5

		game.level.map:addEffect(self,
			x, y, duration,
			DamageType.LITE, 0,
			1.5,
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


newTalent{	
	name = "Magic Missile", --image="talents/magic_missile.png",
	type = {"evocation", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
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
			local damage = rng.dice(1,4)+1
			if x and y and tg then
				self:projectile(tg, x, y, DamageType.FORCE, {dam=damage})
			end
		end

		return true
	end,
	info = function(self, t)
		local missiles = t.num_targets(self, t)
		--local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
		return ([[%d missiles of magical energy darts forth from your fingertip and strike their targets, dealing 1d4+1 points of force damage.

			The number of missiles is one plus half your caster level]]):format(missiles)
	end,
}

newTalent{	
	name = "Burning Hands",
	type = {"evocation", 1},
	mode = 'activated',
	level = 1,
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

newTalent{	
	name = "Darkness",
	type = {"evocation", 1},
	mode = 'activated',
	level = 2,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
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

		local duration = 5

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


newTalent{
	name = "Fireball",
	type = {"evocation", 1},
	display = { image = "fireball.png"},
	mode = 'activated',
	level = 3,
	points = 1,
	cooldown = 20,
--	tactical = { BUFF = 2 },
	range = 0,
	radius = function(self, t)
		return 4
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

		who:project(tg, x, y, DamageType.FIRE, damage, {type=explosion})

	return true
	end,

	info = function(self, t)
		return ([[You cause a fireball to erupt around the target - the amount of damage is 3d6.]])
	end,	
}