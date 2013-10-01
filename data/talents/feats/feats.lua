newTalentType{ type="class/general", name = "general", description = "General feats" }

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
	info = [[This feat makes you proficient in exotic weapons.]],
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
	end
}

--Combat feats
newTalent{
	name = "Power Attack",
	type = {"class/general", 1},
	require = {
		stat = {str = 13}
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[You can substract a number from your base attack bonus and add it to damage bonus.]],
}

newTalent{
	name = "Combat Expertise",
	type = {"class/general", 1},
	require = {
		stat = { int = 13 }
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[You can substract a number up to -5 from your attack and add it to your AC as a dodge bonus.]],
}

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
	points = 1,
	mode = "passive",
	info = [[With a light weapon, rapier, whip, or spiked chain made for a creature of your size category, you may use your Dexterity modifier instead of your Strength modifier on attack rolls. If you carry a shield, its armor check penalty applies to your attack rolls.]],
}

newTalent{
	name = "Weapon Focus",
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
	points = 1,
	mode = "passive",
	info = [[You gain a +1 bonus to attacks made with the chosen weapon.]],
		on_learn = function(self, t)
		local d = require("mod.dialogs.WeaponTypes").new(t)

		game:registerDialog(d)    
end
}



newTalent{
	name = "Improved Critical",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	require = {
		special = {
			fct = function(self, t, offset) 
			--Base attack bonus 8
			if self:attr("combat_bab") and self:attr("combat_bab") >= 8 then return true
			else return false end
			end,
			desc = "Base attack bonus 8",		 
		}
	},
	is_feat = true,
	info = [[This feat increases a chosen weapon's critical range by 2.]],
		on_learn = function(self, t)
		local d = require("mod.dialogs.WeaponTypes").new(t)

		game:registerDialog(d)
      	
      	if weapon.subtype == choice then
		combat.weapon.threat = combat.weapon.threat + 2 end     
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
	points = 1,
	require = { talent = { Talents.T_DODGE }, },
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your AC by +4.]],
    on_learn = function(self, t)
        self.combat_dodge = (self.combat_dodge or 0) + 4
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
        self.skill_jump = (self.skill_jump or 0) + 2
        self.skill_tumble = (self.skill_tumble or 0) + 2
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
        self.skill_balance  = (self.skill_balance or 0) + 2
        self.skill_escapeartist = (self.skill_escapeartist or 0) + 2
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
        self.skill_listen = (self.skill_listen or 0) + 2
        self.skill_spot = (self.skill_spot or 0) + 2
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
        self.skill_handleanimal = (self.skill_handleanimal or 0) + 2
--        self.skill_ride = (self.skill_ride or 0) + 2
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
        self.skill_diplomacy = (self.skill_diplomacy or 0) + 2
--        self.skill_perform = (self.skill_perform or 0) + 2
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
        self.skill_climb  = (self.skill_climb or 0) + 2
        self.skill_swim = (self.skill_swim or 0) + 2
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
        self.skill_concentration = (self.skill_concentration or 0) + 2
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
        self.skill_pickpocket = (self.skill_pickpocket or 0) + 2
--        self.skill_userope = (self.skill_userope or 0) + 2
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
        self.skill_search = (self.skill_search or 0) + 2
--        self.skill_gatherinfo = (self.skill_gatherinfo or 0) + 2
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
        self.skill_spellcraft = (self.skill_spellcraft or 0) + 2
        self.skill_usemagic = (self.skill_usemagic or 0) + 2
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
        self.skill_spellcraft = (self.skill_spellcraft or 0) + 2
        self.skill_knowledge = (self.skill_knowledge or 0) + 2
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
        self.skill_diplomacy = (self.skill_diplomacy or 0) + 2
        self.skill_sensemotive = (self.skill_sensemotive or 0) + 2
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
        self.skill_disabledevice = (self.skill_disabledevice or 0) + 2
        self.skill_openlock = (self.skill_openlock or 0) + 2
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
        self.skill_bluff = (self.skill_bluff or 0) + 2
        self.skill_intimidate = (self.skill_intimidate or 0) + 2
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
        self.skill_heal = (self.skill_heal or 0) + 2
        self.skill_survival = (self.skill_survival or 0) + 2
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
        self.skill_bluff = (self.skill_bluff or 0) + 2
--        self.skill_appraise = (self.skill_appraise or 0) + 2
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
        self.skill_hide = (self.skill_hide or 0) + 2
        self.skill_movesilently = (self.skill_movesilently or 0) + 2
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
        self.skill_spot = (self.skill_spot or 0) + 2
        self.skill_intimidate = (self.skill_intimidate or 0) + 2
    end
}


newTalent{
	name = "Born Hero",
	type = {"class/general", 1},
--	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[This feat increases all your saves and AC by 1.]],
	on_learn = function(self, t)
        self.combat_untyped = (self.combat_untyped or 0) + 1
        self.fortitude_save = (self.fortitude_save or 0) + 2
        self.reflex_save = (self.reflex_save or 0) + 2
        self.will_save = (self.will_save or 0) + 2
    end
}
