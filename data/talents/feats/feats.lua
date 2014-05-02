newTalentType{ type="class/general", no_tt_req = true, name = "general", description = "General feats" }

load("data/talents/feats/focus.lua")

--Proficiency feats
newTalent{
	name = "Light Armor Proficiency",
	type = {"class/general", 1},
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in light armors.]],
}

newTalent{
	name = "Medium Armor Proficiency",
	type = {"class/general", 1},
	require = { talent = { Talents.T_LIGHT_ARMOR_PROFICIENCY }, },
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in medium armors.]],
}

newTalent{
	name = "Heavy Armor Proficiency",
	type = {"class/general", 1},
	require = { talent = { Talents.T_MEDIUM_ARMOR_PROFICIENCY }, },
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in heavy armors.]],
}

newTalent{
	name = "Shield Proficiency",
	type = {"class/general", 1},
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in shields.]],
}


newTalent{
	name = "Simple Weapon Proficiency",
	type = {"class/general", 1},
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in simple weapons.]],
}

newTalent{
	name = "Martial Weapon Proficiency",
	type = {"class/general", 1},
	require = { talent = { Talents.T_SIMPLE_WEAPON_PROFICIENCY }, },
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in martial weapons.]],
}

newTalent{
	name = "Exotic Weapon Proficiency",
	type = {"class/general", 1},
	require = {
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 1
			if self:attr("combat_bab") and self:attr("combat_bab") >= 1 then return true
			else return false end 
			end,
			desc = "Base attack bonus 1",
		}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat makes you proficient in exotic weapons.]],
}

--Combat feats
newTalent{
	name = "Finesse",
	type = {"class/general", 1},
	require = {
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 1
			if self:attr("combat_bab") and self:attr("combat_bab") >= 1 then return true
			else return false end
			end,
			desc = "Base attack bonus 1",
		}
	},
	is_feat = true,
	fighter = true,
	points = 1,
	mode = "passive",
	info = [[With a light weapon, rapier, whip, or spiked chain made for a creature of your size category, you may use your Dexterity modifier instead of your Strength modifier on attack rolls. If you carry a shield, its armor check penalty applies to your attack rolls.]],
}

newTalent{
	name = "Monkey Grip",
	type = {"class/general", 1},
	points = 1,
	mode = "passive",
	require = {
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 1
			if self:attr("combat_bab") and self:attr("combat_bab") >= 1 then return true
			else return false end
			end,
			desc = "Base attack bonus 1",		 
		}
	},
	is_feat = true,
	fighter = true,
	info = [[This feat allows you to wield a two-handed weapon in one hand, albeit at a -2 penalty.]],
}

--Taken from Incursion
newTalent{
	name = "Shield Focus",
	type = {"class/general", 1},
	require = {
		talent = { Talents.T_SHIELD_PROFICIENCY },
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[When wielding a shield, you gain a +2 bonus to AC in addition to the shield's bonus.]],
}

newTalent{
	name = "Armor Optimisation",
	type = {"class/general", 1},
	require = {
		talent = { Talents.T_HEAVY_ARMOR_PROFICIENCY },
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[Your armor check penalty is reduced by 1/3.]],
}

--Archery feats
--[[newTalent{
	name = "Point Blank Shot",
	type = {"class/general", 1},
	require = {
		stat = {dex = 13}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,]]
--	info = [[This feat makes you better at shooting at close range, adding a +1 bonus.]],
--[[}

newTalent{
	name = "Far Shot",
	type = {"class/general", 1},
	require = {
		talent = { Talents.T_POINT_BLANK_SHOT },
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,]]
--	info = [[This feat increases the range of your bow or crossbow by 1,5.]],
--[[}

newTalent{
	name = "Rapid Shot",
	type = {"class/general", 1},
	require = {
		stat = {dex = 13},
		talent = { Talents.T_POINT_BLANK_SHOT },
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,]]
--	info = [[This feat lets you make a second shot, but both shots have a -2 penalty.]],
--[[}

newTalent{
	name = "Manyshot",
	type = {"class/general", 1},
	require = {
		stat = {dex = 17},
		talent = { Talents.T_POINT_BLANK_SHOT, Talents.T_RAPID_SHOT },
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 6
			if self:attr("combat_bab") and self:attr("combat_bab") >= 6 then return true
			else return false end
			end,
			desc = "Base attack bonus 6",		 
		}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,]]
--	info = [[This feat lets you make a second shot, but both shots have a -2 penalty.]],
--}

--TWF feats
newTalent{
	name = "Two Weapon Fighting",
	type = {"class/general", 1},
	require = {
		stat = {dex = 15}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat makes you proficient in fighting with two weapons, reducing the penalties.]],
}

newTalent{
	name = "Two Weapon Defense",
	type = {"class/general", 1},
	require = {
		stat = {dex = 15},
		talent = { Talents.T_TWO_WEAPON_FIGHTING },
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat gives you a +1 shield bonus to AC when fighting with two weapons.]],
}

newTalent{
	name = "Improved Two Weapon Fighting",
	type = {"class/general", 1},
	require = {
		stat = {dex = 17},
		talent = { Talents.T_TWO_WEAPON_FIGHTING },
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 6
			if self:attr("combat_bab") and self:attr("combat_bab") >= 6 then return true
			else return false end
			end,
			desc = "Base attack bonus 6",		 
		}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat gives you an additional offhand attack when fighting with two weapons.]],
}

newTalent{
	name = "Greater Two Weapon Fighting",
	type = {"class/general", 1},
	require = {
		stat = {dex = 19},
		talent = { Talents.T_TWO_WEAPON_FIGHTING, Talents.T_IMPROVED_TWO_WEAPON_FIGHTING },
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 11
			if self:attr("combat_bab") and self:attr("combat_bab") >= 11 then return true
			else return false end
			end,
			desc = "Base attack bonus 11",		 
		}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat gives you a third offhand attack when fighting with two weapons.]],
}


--Save bonuses feats
newTalent{
	name = "Toughness",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your Fort save by +3 and HP by 10%.]],
    on_learn = function(self, t)
	    self.fortitude_save = self.fortitude_save + 3
	    self.max_life = self.max_life * 1.1
    end,
    on_unlearn = function(self, t)
    	self.fortitude_save = self.fortitude_save - 3
    	self.max_life = self.max_life * 0.9
    end
}

newTalent{
	name = "Dodge",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your AC by +3 and your Ref save by +3.]],
    on_learn = function(self, t)
        self.combat_dodge = (self.combat_dodge or 0) + 3
        self.reflex_save = self.reflex_save + 3
    end,
    on_unlearn = function(self, t)
    	self.combat_dodge = (self.combat_dodge or 0) - 3
    	self.reflex_save = self.reflex_save - 3
    end
}

newTalent{
	name = "Iron Will",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your Will save by +3.]],
  	on_learn = function(self, t)
		self.will_save = self.will_save + 3       
	end,
	on_unlearn = function(self, t)
		self.will_save = self.will_save - 3
	end
}

--Various feats
newTalent{
	name = "Light Sleeper",
	type = {"class/general", 1},
	require = {
		stat = { wis = 13 }
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[The enemy will not get a free attack if you are resting.]],
}

newTalent{
	name = "Loadbearer",
	type = {"class/general", 1},
	require = {
		stat = { str = 13 } 
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[You suffer no penalties for medium load. The penalty for heavy load is halved.]],
}

newTalent{
	name = "Mobility",
	type = {"class/general", 1},
	is_feat = true,
	fighter = true,
	points = 1,
	require = { talent = { Talents.T_DODGE }, },
	mode = "passive",
	info = [[This feat increases your AC by +4.]],
    on_learn = function(self, t)
        self.combat_dodge = (self.combat_dodge or 0) + 4
    end,
    on_unlearn = function(self, t)
    	self.combat_dodge = self.combat_dodge - 4
    end
}

-- Skill enhancer feats
newTalent{
	name = "Acrobatic",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Jump and Tumble skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_jump = (self.skill_bonus_jump or 0) + 2
        self.skill_bonus_tumble = (self.skill_bonus_tumble or 0) + 2
    end,
    on_unlearn = function(self, t)
    	self.skill_bonus_jump = self.skill_bonus_jump - 2
    	self.skill_bonus_tumble = self.skill_bonus_tumble - 2
    end
}

newTalent{
	name = "Agile",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Balance and Escape Artist skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_balance  = (self.skill_bonus_balance or 0) + 2
        self.skill_bonus_escapeartist = (self.skill_bonus_escapeartist or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_balance  = (self.skill_bonus_balance or 0) - 2
        self.skill_bonus_escapeartist = (self.skill_bonus_escapeartist or 0) - 2
    end
}

newTalent{
	name = "Alertness",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Listen and Spot skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_listen = (self.skill_bonus_listen or 0) + 2
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_listen = (self.skill_bonus_listen or 0) - 2
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) - 2
    end
}

newTalent{
	name = "Animal Affinity",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Handle Animal skill by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_handleanimal = (self.skill_bonus_handleanimal or 0) + 2
--        self.skill_bonus_ride = (self.skill_bonus_ride or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_handleanimal = (self.skill_bonus_handleanimal or 0) - 2
--        self.skill_bonus_ride = (self.skill_bonus_ride or 0) - 2
    end
}

newTalent{
	name = "Artist",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Diplomacy skill by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) + 2
--        self.skill_bonus_perform = (self.skill_bonus_perform or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) - 2
--        self.skill_bonus_perform = (self.skill_bonus_perform or 0) - 2
    end
}


newTalent{
	name = "Athletic",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Climb and Swim skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_climb  = (self.skill_bonus_climb or 0) + 2
        self.skill_bonus_swim = (self.skill_bonus_swim or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_climb  = (self.skill_bonus_climb or 0) - 2
        self.skill_bonus_swim = (self.skill_bonus_swim or 0) - 2
    end
}

newTalent{
	name = "Combat Casting",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Concentration skill by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_concentration = (self.skill_bonus_concentration or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_concentration = (self.skill_bonus_concentration or 0) - 2
    end
}

newTalent{
	name = "Deft Hands",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Pickpocket skill by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_pickpocket = (self.skill_bonus_pickpocket or 0) + 2
--        self.skill_bonus_userope = (self.skill_bonus_userope or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_pickpocket = (self.skill_bonus_pickpocket or 0) - 2
--        self.skill_bonus_userope = (self.skill_bonus_userope or 0) + 2
    end
}

newTalent{
	name = "Investigator",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Search skill by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_search = (self.skill_bonus_search or 0) + 2
--        self.skill_bonus_gatherinfo = (self.skill_bonus_gatherinfo or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_search = (self.skill_bonus_search or 0) - 2
--        self.skill_bonus_gatherinfo = (self.skill_bonus_gatherinfo or 0) - 2
    end
}

newTalent{
	name = "Magical Aptitude",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Spellcraft and Use Magic Device skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) + 2
        self.skill_bonus_usemagic = (self.skill_bonus_usemagic or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) - 2
        self.skill_bonus_usemagic = (self.skill_bonus_usemagic or 0) - 2
    end
}

newTalent{
	name = "Magical Talent",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Spellcraft and Knowledge skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) + 2
        self.skill_bonus_knowledge = (self.skill_bonus_knowledge or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_spellcraft = (self.skill_bonus_spellcraft or 0) - 2
        self.skill_bonus_knowledge = (self.skill_bonus_knowledge or 0) - 2
    end
}

newTalent{
	name = "Negotiator",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Diplomacy and Sense Motive skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) + 2
        self.skill_bonus_sensemotive = (self.skill_bonus_sensemotive or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_diplomacy = (self.skill_bonus_diplomacy or 0) - 2
        self.skill_bonus_sensemotive = (self.skill_bonus_sensemotive or 0) - 2
    end
}

newTalent{
	name = "Nimble Fingers",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Disable Device and Open Lock skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_disabledevice = (self.skill_bonus_disabledevice or 0) + 2
        self.skill_bonus_openlock = (self.skill_bonus_openlock or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_disabledevice = (self.skill_bonus_disabledevice or 0) - 2
        self.skill_bonus_openlock = (self.skill_bonus_openlock or 0) - 2
    end
}

newTalent{
	name = "Persuasive",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Bluff and Intimidate skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) + 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) - 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) - 2
    end
}

newTalent{
	name = "Self-sufficient",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Heal and Survival skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_heal = (self.skill_bonus_heal or 0) + 2
        self.skill_bonus_survival = (self.skill_bonus_survival or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_heal = (self.skill_bonus_heal or 0) - 2
        self.skill_bonus_survival = (self.skill_bonus_survival or 0) - 2
    end
}

newTalent{
	name = "Silver Palm",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Bluff skill by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) + 2
--        self.skill_bonus_appraise = (self.skill_bonus_appraise or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_bluff = (self.skill_bonus_bluff or 0) - 2
--        self.skill_bonus_appraise = (self.skill_bonus_appraise or 0) - 2
    end
}

newTalent{
	name = "Stealthy",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Hide and Move Silently skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_hide = (self.skill_bonus_hide or 0) + 2
        self.skill_bonus_movesilently = (self.skill_bonus_movesilently or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_hide = (self.skill_bonus_hide or 0) - 2
        self.skill_bonus_movesilently = (self.skill_bonus_movesilently or 0) - 2
    end
}

newTalent{
	name = "Thug",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Spot and Intimidate skills by +2.]],
	on_learn = function(self, t)
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) + 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) + 2
    end,
    on_unlearn = function(self, t)
        self.skill_bonus_spot = (self.skill_bonus_spot or 0) - 2
        self.skill_bonus_intimidate = (self.skill_bonus_intimidate or 0) - 2
    end
}

--Taken from Incursion
newTalent{
	name = "Improved Strength",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Strength by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_STR] = (self.inc_stats[self.STAT_STR] or 0) + 1
  		self:onStatChange(self.STAT_STR, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_STR] = (self.inc_stats[self.STAT_STR] or 0) - 1
  		self:onStatChange(self.STAT_STR, -1)
	end
}

newTalent{
	name = "Improved Dexterity",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Dexterity by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_DEX] = (self.inc_stats[self.STAT_DEX] or 0) + 1
  		self:onStatChange(self.STAT_DEX, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_DEX] = (self.inc_stats[self.STAT_DEX] or 0) - 1
  		self:onStatChange(self.STAT_DEX, -1)
	end
}

newTalent{
	name = "Improved Constitution",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Constitution by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_CON] = (self.inc_stats[self.STAT_CON] or 0) + 1
  		self:onStatChange(self.STAT_CON, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_DEX] = (self.inc_stats[self.STAT_CON] or 0) - 1
  		self:onStatChange(self.STAT_CON, -1)
	end
}

newTalent{
	name = "Improved Intelligence",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Intelligence by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_INT] = (self.inc_stats[self.STAT_INT] or 0) + 1
  		self:onStatChange(self.STAT_INT, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_INT] = (self.inc_stats[self.STAT_INT] or 0) - 1
  		self:onStatChange(self.STAT_INT, -1)
	end
}

newTalent{
	name = "Improved Wisdom",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Wisdom by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_WIS] = (self.inc_stats[self.STAT_WIS] or 0) + 1
  		self:onStatChange(self.STAT_WIS, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_WIS] = (self.inc_stats[self.STAT_WIS] or 0) - 1
  		self:onStatChange(self.STAT_WIS, -1)
	end
}

newTalent{
	name = "Improved Charisma",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Charisma by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_CHA] = (self.inc_stats[self.STAT_CHA] or 0) + 1
  		self:onStatChange(self.STAT_CHA, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_CHA] = (self.inc_stats[self.STAT_CHA] or 0) - 1
  		self:onStatChange(self.STAT_CHA, -1)
	end
}

newTalent{
	name = "Improved Luck",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases your Luck by +1.]],
	on_learn = function(self, t)
		self.inc_stats[self.STAT_LUC] = (self.inc_stats[self.STAT_LUC] or 0) + 1
  		self:onStatChange(self.STAT_LUC, 1)
	end,
	on_unlearn = function(self, t)
		self.inc_stats[self.STAT_LUC] = (self.inc_stats[self.STAT_LUC] or 0) - 1
  		self:onStatChange(self.STAT_LUC, -1)
	end
}

--More stuff from Incursion
newTalent{
	name = "Lore of Acid",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases the acid damage done by your spells by 20%.]],
    on_learn = function(self, t)
	    self.inc_damage = { [engine.DamageType.ACID] = 20 }
    end,
    on_unlearn = function(self, t)
    	self.inc_damage = nil
    end
}

newTalent{
	name = "Lore of Flames",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases the fire damage done by your spells by 20%.]],
    on_learn = function(self, t)
	    self.inc_damage = { [engine.DamageType.FIRE] = 20 }
    end,
    on_unlearn = function(self, t)
    	self.inc_damage = nil
    end
}

newTalent{
	name = "Lore of Rime",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases the cold damage done by your spells by 20%.]],
    on_learn = function(self, t)
	    self.inc_damage = { [engine.DamageType.COLD] = 20 }
    end,
    on_unlearn = function(self, t)
    	self.inc_damage = nil
    end
}

newTalent{
	name = "Lore of Storms",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases the lightning damage done by your spells by 20%.]],
    on_learn = function(self, t)
	    self.inc_damage = { [engine.DamageType.LIGHTNING] = 20 }
    end,
    on_unlearn = function(self, t)
    	self.inc_damage = nil
    end
}
