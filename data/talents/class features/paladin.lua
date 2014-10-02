newTalentType{ passive=true, type="paladin/paladin", name="paladin", description="Paladin Feats" }

newTalent{
	name = "Summon Mount",
	type = {"paladin/paladin", 1},
	mode = "activated",
	level = 1,
	points = 1,
	cooldown = 0,
	range = 1,
	no_npc_use = true,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), nolock = true, talent=t}
	end,
	makeCreature = function(self, t, creature)
		local NPC = require "mod.class.NPC"

		if creature == "heavy warhorse" then

		local m = NPC.new{
			type = "animal", subtype = "horse",
			display = "q", color=colors.LIGHT_GREEN,
			image = "tiles/horse_brown.png",
			name = "war horse mount", faction = self.faction,
			desc = [[A large peaceful war horse.]],
			--autolevel = "none",
			never_anger = true,
			
			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",
			
			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 18,
				dex = 13,
				con = 17,
				int = 2, 
				wis = 13,
				cha = 6,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 30,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 3,
			combat = { dam={1,4}, atk=1, },
			movement_speed_bonus = 0.66,
			mount = true,

			summoner = self, summoner_gain_exp=true,
			summon_time = 1200, --2 hrs
			ai_target = {actor=target},
		}
		return m
		end
		
		if creature == "war pony" then
			local m = NPC.new{
			type = "animal", subtype = "horse",
			display = "q", color=colors.LIGHT_GREEN,
			image = "tiles/horse_spotted.png",
			name = "war pony mount", faction = self.faction,
			desc = [[A large peaceful war pony.]],
			--autolevel = "none",
			never_anger = true,
			
			ai = "ally",
			ai_state = { talent_in=1, ally_compassion=10},
			ai_tactic = resolvers.tactic"default",
			
			stats = {str=0, dex=0, con=0, int=0, wis=0, cha=0, luc=0},
			inc_stats = {
				str = 15,
				dex = 13,
				con = 14,
				int = 2, 
				wis = 13,
				cha = 6,
				luc = 10,
					},
			level_range = {self.level, self.level}, exp_worth = 0,

			max_life = 15,

			combat_base_ac = 10, combat_dr = 0, combat_natural = 2,
			combat = { dam={1,6}, atk=1, },
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
			{name="heavy warhorse", desc=""},
			{name="war pony", desc=""},
			},
        function(result)
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
