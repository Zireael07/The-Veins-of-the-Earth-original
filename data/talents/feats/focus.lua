newTalent{
	short_name = "T_WEAPON_FOCUS_AXE",
	name = "Weapon Focus (axe)",
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
	info = [[You gain a +1 bonus to attacks made with axes.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_BATTLEAXE",
	name = "Weapon Focus (battleaxe)",
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
	info = [[You gain a +1 bonus to attacks made with battleaxes.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_BOW",
	name = "Weapon Focus (bow)",
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
	info = [[You gain a +1 bonus to attacks made with bows.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_CLUB",
	name = "Weapon Focus (club)",
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
	info = [[You gain a +1 bonus to attacks made with clubs.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_CROSSBOW",
	name = "Weapon Focus (crossbow)",
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
	info = [[You gain a +1 bonus to attacks made with crossbows.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_DAGGER",
	name = "Weapon Focus (dagger)",
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
	info = [[You gain a +1 bonus to attacks made with daggers.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_FALCHION",
	name = "Weapon Focus (falchion)",
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
	info = [[You gain a +1 bonus to attacks made with falchions.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_FLAIL",
	name = "Weapon Focus (flail)",
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
	info = [[You gain a +1 bonus to attacks made with flails.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_HALBERD",
	name = "Weapon Focus (halberd)",
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
	info = [[You gain a +1 bonus to attacks made with halberds.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_HAMMER",
	name = "Weapon Focus (hammer)",
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
	info = [[You gain a +1 bonus to attacks made with hammers.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_HANDAXE",
	name = "Weapon Focus (handaxe)",
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
	info = [[You gain a +1 bonus to attacks made with handaxes.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_JAVELIN",
	name = "Weapon Focus (javelin)",
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
	info = [[You gain a +1 bonus to attacks made with javelins.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_KUKRI",
	name = "Weapon Focus (kukri)",
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
	info = [[You gain a +1 bonus to attacks made with kukris.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_MACE",
	name = "Weapon Focus (mace)",
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
	info = [[You gain a +1 bonus to attacks made with maces.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_MORNINGSTAR",
	name = "Weapon Focus (morningstar)",
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
	info = [[You gain a +1 bonus to attacks made with morningstars.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_RAPIER",
	name = "Weapon Focus (rapier)",
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
	info = [[You gain a +1 bonus to attacks made with rapiers.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_SCIMITAR",
	name = "Weapon Focus (scimitar)",
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
	info = [[You gain a +1 bonus to attacks made with scimitars.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_SCYTHE",
	name = "Weapon Focus (scythe)",
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
	info = [[You gain a +1 bonus to attacks made with scythes.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_SHORTSWORD",
	name = "Weapon Focus (short sword)",
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
	info = [[You gain a +1 bonus to attacks made with short swords.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_SLING",
	name = "Weapon Focus (sling)",
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
	info = [[You gain a +1 bonus to attacks made with slings.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_SPEAR",
	name = "Weapon Focus (spear)",
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
	info = [[You gain a +1 bonus to attacks made with spears.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_STAFF",
	name = "Weapon Focus (staff)",
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
	info = [[You gain a +1 bonus to attacks made with staves.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_SWORD",
	name = "Weapon Focus (sword)",
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
	info = [[You gain a +1 bonus to attacks made with swords.]],
}

newTalent{
	short_name = "T_WEAPON_FOCUS_TRIDENT",
	name = "Weapon Focus (trident)",
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
	info = [[You gain a +1 bonus to attacks made with tridents.]],
}


--Improved Criticals
newTalent{
	short_name = "T_IMPROVED_CRIT_AXE",
	name = "Improved Critical (axe)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_AXE },
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
	info = [[This feat increases your axes' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_BATTLEAXE",
	name = "Improved Critical (battleaxe)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_BATTLEAXE },
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
	info = [[This feat increases your battleaxes' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_BOW",
	name = "Improved Critical (bow)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_BOW },
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
	info = [[This feat increases your bows' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_CLUB",
	name = "Improved Critical (club)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_CLUB },
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
	info = [[This feat increases your clubs' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_CROSSBOW",
	name = "Improved Critical (crossbow)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_CROSSBOW },
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
	info = [[This feat increases your crossbows' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_DAGGER",
	name = "Improved Critical (dagger)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_DAGGER },
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
	info = [[This feat increases your daggers' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_FALCHION",
	name = "Improved Critical (falchion)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_FALCHION },
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
	info = [[This feat increases your falchions' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_FLAIL",
	name = "Improved Critical (flail)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_FLAIL },
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
	info = [[This feat increases your flails' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_HALBERD",
	name = "Improved Critical (halberd)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_HALBERD },
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
	info = [[This feat increases your halberds' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_HAMMER",
	name = "Improved Critical (hammer)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_HAMMER },
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
	info = [[This feat increases your hammers' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_HANDAXE",
	name = "Improved Critical (handaxe)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_HANDAXE },
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
	info = [[This feat increases your handaxes' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_JAVELIN",
	name = "Improved Critical (javelin)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_JAVELIN },
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
	info = [[This feat increases your javelins' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_KUKRI",
	name = "Improved Critical (kukri)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_KUKRI },
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
	info = [[This feat increases your kukris' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_MACE",
	name = "Improved Critical (mace)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_MACE },
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
	info = [[This feat increases your maces' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_MORNINGSTAR",
	name = "Improved Critical (morningstar)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_MORNINGSTAR },
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
	info = [[This feat increases your morningstars' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_RAPIER",
	name = "Improved Critical (rapier)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_RAPIER },
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
	info = [[This feat increases your rapiers' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_SCIMITAR",
	name = "Improved Critical (scimitar)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_SCIMITAR },
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
	info = [[This feat increases your scimitars' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_SCYTHE",
	name = "Improved Critical (scythe)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_SCYTHE },
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
	info = [[This feat increases your scythes' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_SHORTSWORD",
	name = "Improved Critical (short sword)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_SHORTSWORD },
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
	info = [[This feat increases your short swords' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_SLING",
	name = "Improved Critical (sling)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_SLING },
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
	info = [[This feat increases your slings' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_SPEAR",
	name = "Improved Critical (spear)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_SPEAR },
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
	info = [[This feat increases your spears' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_STAFF",
	name = "Improved Critical (staff)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_STAFF },
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
	info = [[This feat increases your staves' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_SWORD",
	name = "Improved Critical (sword)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_SWORD },
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
	info = [[This feat increases your swords' critical range by 2.]],
}

newTalent{
	short_name = "T_IMPROVED_CRIT_TRIDENT",
	name = "Improved Critical (trident)",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	require = {
		talent = { Talents.T_WEAPON_FOCUS_TRIDENT },
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
	info = [[This feat increases your tridents' critical range by 2.]],
}