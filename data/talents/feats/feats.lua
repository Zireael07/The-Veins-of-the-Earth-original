newTalentType{ type="class/general", no_tt_req = true, name = "General", description = "General feats" }

--Archery feats
--[[newFeat{
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
--}

newFeat{
    name = "Precise Shot",
    type = {"class/general", 1},
    points = 1,
    mode = "passive",
    is_feat = true,
    fighter = true,
    info = [[This feat allows you to shoot or throw at opponents in melee range without the penalty.]]
}


newFeat{
	name = "Far Shot",
	type = {"class/general", 1},
	require = {
	--	talent = { Talents.T_POINT_BLANK_SHOT },
        talent = { Talents.T_PRECISE_SHOT},
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat increases the range of your bow or crossbow by 1,5.]],
}

newFeat{
	name = "Rapid Shot",
	type = {"class/general", 1},
	require = {
		stat = {dex = 13},
	--	talent = { Talents.T_POINT_BLANK_SHOT },
        talent = { Talents.T_PRECISE_SHOT },
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	fighter = true,
	info = [[This feat lets you make a second shot, but both shots have a -2 penalty.]],
}

newFeat{
	name = "Manyshot",
	type = {"class/general", 1},
	require = {
		stat = {dex = 17},
	--	talent = { Talents.T_POINT_BLANK_SHOT, Talents.T_RAPID_SHOT },
        talent = { Talents.T_PRECISE_SHOT, Talents.T_RAPID_SHOT },
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
	info = [[You fire two arrows at once at the same target, with a -4 penalty. For every five points of BAB above +6, you may add one more arrow, with a cumulative -2 penalty.]],
}

--Various feats
newFeat{
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

newFeat{
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

--Rolled Dodge and Mobility into one
newFeat{
	name = "Mobility",
	type = {"class/general", 1},
	is_perk = true,
	fighter = true,
	points = 1,
--	require = { talent = { Talents.T_DODGE }, },
    require = {
        stat = { dex = 13 }
    },
	mode = "passive",
	info = [[This feat increases your AC by +2.]],
    on_learn = function(self, t)
        self.combat_dodge = (self.combat_dodge or 0) + 2
    end,
    on_unlearn = function(self, t)
    	self.combat_dodge = self.combat_dodge - 2
    end
}


newFeat{
    name = "Toughness",
    type = {"class/general", 1},
    fighter = true,
    points = 1,
    mode = "passive",
    info = [[This feat increases your HP by 10%.]],
    on_learn = function(self, t)
        self.max_life = self.max_life * 1.1
    end,
    on_unlearn = function(self, t)
    	self.max_life = self.max_life * 0.9
    end
}

--Feats from Incursion to increase survivability
newFeat{
    name = "Roll with It",
    type = {"class/general", 1},
    is_feat = true,
    fighter = true,
    points = 1,
    mode = "passive",
    require = {
        stat = {con = 13},
    },
    info = [[This feat reduces the extra damage taken from a critical hit by half.]],
}

newFeat{
    name = "Ignore Wound",
    type = {"class/general", 1},
    is_feat = true,
    fighter = true,
    points = 1,
    mode = "passive",
    require = {
        stat = {con = 13},
        talent = { Talents.T_TOUGHNESS, Talents.T_ROLL_WITH_IT },
    },
    info = [[This feat allows you to ignore one wound which would bring your hp below 0 a day.]],
}

newFeat{
    name = "Resilient",
    short_name = "RESILLIENT",
    type = {"class/general", 1},
    is_feat = true,
    fighter = true,
    points = 1,
    mode = "passive",
    require = {
        stat = {con = 13},
        talent = { Talents.T_TOUGHNESS, Talents.T_ROLL_WITH_IT },
    },
    info = [[If your injuries do not exceed (3 + Con mod)* 5% of your hp, you regenerate one point per 3 turns.]],
}

newFeat{
    name = "Master Craftsman",
    type = {"class/general", 1},
    is_feat = true,
    points = 1,
    mode = "passive",
    require = {
            special = {
            fct = function(self, t, offset)
            --Base attack bonus 1
            if self:attr("skill_craft") and self:attr("skill_craft") >= 5 then return true
            else return false end
            end,
            desc = "5 ranks in Craft skill",
            },
        },
    on_learn = function(self, t)
        self:learnTalentType("arcane/itemcreation", true)
        self.skill_bonus_craft = (self.skill_bonus_craft or 0) + 2
    end,
    on_unlearn = function(self, t)
    --    if not caster then lose access to craft feats
        self:unlearnTalentType("arcane/itemcreation", true)
        self.skill_bonus_craft = self.skill_bonus_craft - 2
    end,
    info = [[You receive a +2 bonus to the Craft skill. You can use the skill to craft magic armor or weapons as though you were a spellcaster.]],
}

--Based on a homebrew OGL feat "Autolife" from http://dnd-wiki.org
newFeat{
    name = "Self Resurrection",
    type = {"class/general", 1},
    is_feat = true,
    points = 1,
    mode = "activated",
    require = {
        talent = { Talents.T_CRAFT_WONDROUS_ITEM }
    },
    action = function(self, t)
        if self.money < 300000 then
            game.logPlayer(self, "You don't have enough gold!")
        return true end
        if self.exp < 1200 then
            game.logPlayer(self, "You don't have enough exp!")
        return true end

        self:incMoney(-300000)
        self:gainExp(-1200)

        local o = game.zone:makeEntityByName(game.level, "object", "RESURRECTION_DIAMOND")
        if o then
            game.zone:addEntity(game.level, o, "object")
            self:addObject(self:getInven("INVEN"), o)
        end

        return true
    end,
    info = [[You can self resurrect with the expense of 30 000 gold and 1200 XP by creating a resurrection diamond.]],
}
