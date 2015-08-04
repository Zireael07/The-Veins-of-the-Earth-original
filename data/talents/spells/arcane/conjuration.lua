newTalentType{
	all_limited=true,
	type="conjuration",
	name="conjuration",
	description = "Conjuration magic deals with the creation magical creatures and substances"
}

newArcaneSpell{
	name = "Acid Splash",
	type = {"conjuration", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 8,
	tactical = { BUFF = 2 },
	getDamage = function(self, t)
		if self:isTalentActive(self.T_MAXIMIZE) then return 3
		elseif self:isTalentActive(self.T_EMPOWER) then return math.max(rng.dice(1,3)*1.5)
		else return rng.dice(1,3) end
	end,
	range = 5,
	requires_target = true,
	target = function(self, t)
		local tg = {type="bolt", range=self:getTalentRange(t), talent=t}
		return tg
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)
		local _ _, x, y, _, _ = self:canProject(tg, x, y)
		if not x or not y then return nil end

		local damage = t.getDamage(self, t)

		self:projectile(tg, x, y, DamageType.ACID, {dam=damage})

		return true
	end,
	info = function(self, t)
		return ([[You fire a small orb of acid at the target, dealing 1d3 damage]])
	end,
}

newArcaneSpell{
	name = "Grease",
	type = {"conjuration", 1},
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
			DamageType.GREASE, {save_dc=self:getSpellDC(t)},
			1.5,
			5, nil,
			engine.Entity.new{alpha=100, display='', color_br=200, color_bg=190, color_bb=30},
			nil, true
		)

		return true
	end,
	info = function(self, t)

		return ([[You cover the floor in grease, causing monsters to fall.]])
	end,
}

newArcaneSpell{
	name = "Mount", short_name = "MOUNT_SPELL",
	type = {"conjuration", 1},
	image = "talents/mount_spell.png",
	display = { image = "talents/mount_spell.png"},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	range = 3,
	no_npc_use = true,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), nolock = true, talent=t}
	end,
	makeCreature = function(self, t, creature)
		local NPC = require "mod.class.NPC"

		if creature == "light horse" then

		local m = NPC.new{
			type = "animal", subtype = "horse",
			display = "q", color=colors.LIGHT_GREEN,
			image = "tiles/horse_brown.png",
			name = "light horse mount", faction = self.faction,
			desc = [[A peaceful horse.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 14,
				dex = 13,
				con = 15,
				int = 2,
				wis = 12,
				cha = 6,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 19,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,4}, atk=1, },
			movement_speed = 1.66,
			mount = true,

			summoner = self, summoner_gain_exp=true,
			summon_time = 1200, --2 hrs
			ai_target = {actor=target},
		}
		return m
		end

		if creature == "pony" then
			local m = NPC.new{
			type = "animal", subtype = "horse",
			display = "q", color=colors.LIGHT_GREEN,
			image = "tiles/horse_spotted.png",
			name = "pony mount", faction = self.faction,
			desc = [[A large peaceful pony.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 13,
				dex = 13,
				con = 12,
				int = 2,
				wis = 11,
				cha = 4,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 11,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,3}, atk=1, },
			movement_speed = 1.33,
			mount = true,

			summoner = self, summoner_gain_exp=true,
			summon_time = 1200,  --2 hrs
			ai_target = {actor=target},
		}
		return m
		end
	end,
	action = function(self, t)
		-- Choose creature
		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired mount",{
			{name="light horse", desc=""},
			{name="pony", desc=""},
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

		if not result then return nil end

		local tg = self:getTalentTarget(t)
		local x, y =  self:getTarget(tg)
		if not x or not y then return nil end

		local _ _, _, _, x, y = self:canProject(tg, x, y)
		local blocked = game.level.map(x, y, Map.ACTOR)
		if blocked then
			game.logPlayer(self, "You must summon on an empty square!")
			return nil
		end
		if not x or not y then
			game.logPlayer(self, "You cannot summon there.")
			return nil
		end

		game.logPlayer(self, ("Player summons a %s!"):format(result))

		local creature = t.makeCreature(self, t, result)
		game.zone:addEntity(game.level, creature, "actor", x, y)

		return true
	end,
	info = function(self, t)
		return ([[You summon a mount to serve your bidding.]])
	end,
}

newArcaneSpell{
	name = "Summon Creature I",
	type = {"conjuration", 1},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	range = 3,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), nolock = true, talent=t}
	end,
	makeCreature = function(self, t, creature)
		local NPC = require "mod.class.NPC"
		if creature == "pony" then
			local m = NPC.new{
			type = "animal", subtype = "horse",
			display = "q", color=colors.LIGHT_GREEN,
			image = "tiles/horse_spotted.png",
			name = "pony mount", faction = self.faction,
			desc = [[A large peaceful pony.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 13,
				dex = 13,
				con = 12,
				int = 2,
				wis = 11,
				cha = 4,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 11,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,3}, atk=1, },
			movement_speed = 1.33,
			mount = true,

			summoner = self, summoner_gain_exp=true,
			summon_time = 10,
			ai_target = {actor=target},
		}
		return m
		end
		if creature == "dire rat" then
			local m = NPC.new{
			type = "animal", subtype = "rat",
			display = "r", color=colors.LIGHT_GREEN,
			image = "tiles/rat.png",
			name = "dire rat", faction = self.faction,
			desc = [[A large peaceful rat.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 10,
				dex = 17,
				con = 12,
				int = 1,
				wis = 12,
				cha = 4,
				luc = 2,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 7,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,3}, atk=1, },

			summoner = self, summoner_gain_exp=true,
			summon_time = 10,
			ai_target = {actor=target},
		}
		return m
		end
		if creature == "medium spider" then
			local m = NPC.new{
			type = "vermin", subtype = "spider",
			display = "r", color=colors.LIGHT_GREEN,
			image = "tiles/spider.png",
			name = "small spider", faction = self.faction,
			desc = [[A large peaceful spider.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 11,
				dex = 17,
				con = 10,
				int = 1,
				wis = 10,
				cha = 2,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 7,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,6}, atk=1, },
			poison = "medium_spider",

			summoner = self, summoner_gain_exp=true,
			summon_time = 10,
			ai_target = {actor=target},
		}
		return m
		end
	end,
	action = function(self, t)

		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired summon",{
			{name="pony", desc=""},
			{name="dire rat", desc=""},
			{name="medium spider", desc=""},
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

		if not result then return nil end

		local tg = self:getTalentTarget(t)
		local x, y =  self:getTarget(tg)
		if not x or not y then return nil end

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

		game.logPlayer(self, ("Player summons a %s!"):format(result))

		local creature = t.makeCreature(self, t, result)
		game.zone:addEntity(game.level, creature, "actor", x, y)
		return true
	end,
	info = function(self, t)
		return ([[You summon a single creature to do your bidding.]])
	end,
}

newArcaneSpell{
	name = "Mage Armor",
	type = {"conjuration", 1},
	mode = 'activated',
	level = 1,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	getDuration = function(self, t)
		if self:isTalentActive(self.T_EXTEND) then return 15
		else return 10 end
	end,
	range = 1,
	requires_target = true,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = {type="hit", range=self:getTalentRange(t), nowarning=true}
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end
	--	if core.fov.distance(self.x, self.y, x, y) > 1 then return nil end

		target:setEffect(self.EFF_MAGE_ARMOR, t.getDuration(self, t), {})

		return true
	end,
	info = function(self, t)

		return ([[An invisible but tangible field of force surrounds the target, providing a +4 armor bonus to AC.]])
	end,
}

newArcaneSpell{
	name = "Summon Creature II",
	type = {"conjuration", 1},
	mode = "activated",
	level = 2,
	points = 1,
	cooldown = 0,
	range = 3,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), nolock = true, talent=t}
	end,
	makeCreature = function(self, t, creature)
		local NPC = require "mod.class.NPC"
		if creature == "light horse" then

		local m = NPC.new{
			type = "animal", subtype = "horse",
			display = "q", color=colors.LIGHT_GREEN,
			image = "tiles/horse_brown.png",
			name = "light horse mount", faction = self.faction,
			desc = [[A peaceful horse.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 14,
				dex = 13,
				con = 15,
				int = 2,
				wis = 12,
				cha = 6,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 19,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,4}, atk=1, },
			movement_speed = 1.66,
			mount = true,

			summoner = self, summoner_gain_exp=true,
			summon_time = 10,
			ai_target = {actor=target},
		}
		return m
		end

		if creature == "wolf" then
		local m = NPC.new{
			type = "animal", subtype = "wolf",
			display = "q", color=colors.LIGHT_GREEN,
			name = "summoned wolf", faction = self.faction,
			desc = [[A large peaceful wolf.]],
			--autolevel = "none",
			never_anger = true,

			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",

			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 13,
				dex = 15,
				con = 15,
				int = 2,
				wis = 12,
				cha = 6,
				luc = 10,
			},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 20,

			combat_base_ac = 10, combat_dr = 0,
			combat = { dam={1,4}, atk=1, },

			summoner = self, summoner_gain_exp=true,
			summon_time = 10,
			ai_target = {actor=target},
		}
		return m
		end
	end,
	action = function(self, t)

		local result = self:talentDialog(require('mod.dialogs.GetChoice').new("Choose the desired summon",{
			{name="wolf", desc=""},
			{name="light horse", desc=""},
		}, function(result)
			self:talentDialogReturn(result)
			game:unregisterDialog(self:talentDialogGet())
		end))

		if not result then return nil end

		local tg = self:getTalentTarget(t)
		local x, y =  self:getTarget(tg)
		if not x or not y then return nil end

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

		game.logPlayer(self, ("Player summons a %s!"):format(result))

		local creature = t.makeCreature(self, t, result)
		game.zone:addEntity(game.level, creature, "actor", x, y)
		return true
	end,
	info = function(self, t)
		return ([[You summon a single creature to do your bidding.]])
	end,
}


newArcaneSpell{
	name = "Dimension Door",
	type = {"conjuration", 1},
	mode = 'activated',
	level = 4,
	points = 1,
	cooldown = 0,
	tactical = { BUFF = 2 },
	range = 20,
	requires_target = true,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local target = self

		local tg = self:getTalentTarget(t)
		local x, y = self:getTarget(tg)

	--	local _ _, x, y = self:canProject(tg, x, y)

		if not x then return nil end

	--	game.level.map:particleEmitter(target.x, target.y, 1, "teleport")
		target:teleportRandom(x, y, 2)
	--	game.level.map:particleEmitter(target.x, target.y, 1, "teleport")


	--	local x, y = self.x, self.y

		return true
	end,
	info = function(self, t)

		return ([[Allows you to teleport.]])
	end,
}
