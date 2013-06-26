newTalentType{ type="arcane/arcane", name = "arcane", description = "Arcane Spells" }

newTalent{	
	name = "Acid Splash",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	is_spell = true,
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
	is_spell = true,
	--require = ,
	points = 1,
	cooldown = 20,
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
	name = "Magic Missile", --image="talents/magic_missile.png",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	--require = ,
	points = 1,
	cooldown = 20,
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
		local missiles = t.num_targets(self, t)
		--local dam = damDesc(self, DamageType.ICE, t.getDamage(self, t))
		return ([[%d missiles of magical energy darts forth from your fingertip and strike their targets, dealing 1d4+1 points of force damage.

			The number of missiles is one plus half your caster level]]):format(missiles)
	end,
}

newTalent{	
	name = "Burning Hands",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	is_spell = true,
	--require = ,
	points = 1,
	cooldown = 20,
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
	name = "Summon Creature I",
	type = {"arcane/arcane", 1},
	mode = "activated",
	is_spell = true,
	points = 1,
	cooldown = 20,
	range = 3,
	setCreature = function(t, creature)
		t.creature = creature
	end,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), nolock = true, talent=t}
	end,
	makeCreature = function(self, t)
		local NPC = require "mod.class.NPC"
		local m = NPC.new{
			type = "animal", subtype = "wolf",
			display = "w", color=colors.GREEN,
			name = "summoned wolf", faction = self.faction,
			desc = [[]],
			autolevel = "none",
			ai = "dumb_talented_simple", ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",
			stats = {str=0, dex=0, con=0, cun=0, wil=0, mag=0},
			inc_stats = {
				con = 1,
				str = 1,
				dex = 2,
			},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 20,

			combat_armor = 10, combat_def = 0,
			combat = { dam={1,4}, atk=1, },


			--resolvers.talents{
				--[self.T_TAUNT]=self:getTalentLevelRaw(t),
				--[self.T_SHELL_SHIELD]=self:getTalentLevelRaw(t),
			--},

			summoner = self, summoner_gain_exp=true,
			summon_time = 10,
			ai_target = {actor=target},
		}
		return m
	end,
	action = function(self, t)
		-- Choose creature
		local d = require("mod.dialogs.SummonCreatureI").new(t)

		game:registerDialog(d)
		
		local co = coroutine.running()
		d.unload = function() coroutine.resume(co, t.creature) end --This is currently bugged, only works if the player has already summoned,
		if not coroutine.yield() then return nil end

		local tg = self:getTalentTarget(t)
		local x, y =  self:getTarget(tg)
		local _ _, _, _, x, y = self:canProject(tg, x, y)
		local blocked = game.level.map(x, y, Map.ACTOR)
		if blocked then
			game.logPlayer(self, "You must summon on an empty square!")
			return nil
		end
		if not x or not y then
			game.logPlayer(self, "You cannot summon there") 
			return nil 
		end

		if t.creature then
			game.logPlayer(self,("Player summons a %s!"):format(t.creature))
		else
			game.logPlayer(self,"Player doesnt summon a creature")
		end

		local creature = t:makeCreature(self)
		game.zone:addEntity(game.level, creature, "actor", x, y)
		return true

		
	end,
	info = function(self, t)
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}

newTalent{
	name = "Sleep",
	type = {"arcane/arcane",1},
	mode = "activated",
	is_spell = true,
	points = 1,
	cooldown = 20,
	range = 0,
	radius = 4,
	target = function(self, t)
		return {type="cone", range=self:getTalentRange(t), radius=self:getTalentRadius(t), nolock = true, selffire=false, talent=t}
	end,
	get_max_hd = function(self, t)
		return 8
	end,
	action = function(self, t)
	local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

		if not x or not y then return nil end

		-- Find potential targets in the area

		local targets = {}
		local grids = self:project(tg, x, y, function(px, py)
			local actor = game.level.map(px, py, Map.ACTOR)
			if actor then targets[#targets+1] = actor end
		end)

		-- Take the creatures with the weakest hd and discard the rest

		table.sort(targets, function(a,b) return a.hit_die > b.hit_die end)
		local final_targets = {}
		local max_hd = t.get_max_hd(self, t)
		local i = 1
		local stop = false

		while not stop do
			local t = targets[i]
			if t and t.hit_die <= max_hd then --and target:canBe("sleep")
				final_targets[#final_targets+1] = t
				max_hd = max_hd - t.hit_die
				i = i + 1
			else
				stop = true
			end
		end

		local duration = 5
		-- Apply sleep
		for i, target in ipairs(final_targets) do
			if not target:willSave(30) then -- @todo: do real dc  
				target:setEffect(target.EFF_SLEEP, duration, {})
			else
				game.logSeen(target, "%s resist the sleep!", target.name)
			end
		end
		return true
	end,


	info = function(self, t)
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,

}

newTalent{
	name = "Blindness/Deafness", short_name = "BLINDNESS_DEAFNESS",
	type = {"arcane/arcane",1},
	mode = "activated",
	is_spell = true,
	points = 1,
	cooldown = 20,
	range = 4,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	get_effect = function(self, t)
		local d = require("mod.dialogs.BlindnessDeafness").new(t)

		game:registerDialog(d)
		
		local co = coroutine.running()
		d.unload = function() coroutine.resume(co, t.choice) end --This is currently bugged, only works if the player has already summoned,
		if not coroutine.yield() then return nil end
		return t.choice
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		local choice = t.get_effect(self, t)

		if choice == "Blindness" then
			if target:canBe("blind") then
				target:setEffect(target.EFF_BLIND, 5, {})
			end
		elseif choice == "Deafness" then
			if target:canBe("deaf") then

			end
		else
			return nil
		end

		return true
	end,


	info = function(self, t)
		return ([[You blind the target for 5 turns]])
	end,

}