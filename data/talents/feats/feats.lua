newTalentType{ type="class/general", name = "general", description = "General feats" }

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
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in light armors.]],
}

newTalent{
	name = "Heavy Armor Proficiency",
	type = {"class/general", 1},
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in light armors.]],
}


newTalent{
	name = "Exotic Weapon Proficiency",
	type = {"class/general", 1},
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Base attack bonus 1",		 -- Should be base attack bonus of 1
		}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in exotic weapons.]],
}



newTalent{
	name = "Toughness",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your HP by 10% and your Fort save by +3.]],
    on_learn = function(self, t)
	    self.fortitude_save = self.fortitude_save + 3
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
        self.combat_def = self.combat_def + 3
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
	info = [[This feat increases your power by 10% and your Will save by +3.]],
  	on_learn = function(self, t)
		self.will_save = self.will_save + 3       
	end
}

newTalent{
	name = "Finesse",
	type = {"class/general", 1},
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Base attack bonus 1",		 -- Should be base attack bonus of 1
		}
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[With a light weapon, rapier, whip, or spiked chain made for a creature of your size category, you may use your Dexterity modifier instead of your Strength modifier on attack rolls. If you carry a shield, its armor check penalty applies to your attack rolls.]],
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
	name = "Improved Critical",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Base attack bonus 8",		 -- Should be base attack bonus of 8
		}
	},
	is_feat = true,
	info = [[This feat increases your power by 10% and your Will save by +3.]],
      	on_learn = function(self, t)
		combat.weapon.threat = combat.weapon.threat + 2       
end
}

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
--	require = { T.DODGE },
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your AC by +4.]],
    on_learn = function(self, t)
        self.combat_def = self.combat_def + 4
    end
}

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