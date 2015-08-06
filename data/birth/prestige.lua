--Prestige classes!
newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Shadowdancer',
	getSkillPoints = function(self, t)
		return 6
	end,
    desc = function(self, t)
        local d
        local desc = "#ORANGE#Skilled rogues who can summon shades and hide in plain sight.#LAST#\n"
        local skills = t.getSkillPoints(self, t)
        d = "Requires Move Silently 8 ranks and Hide 10 ranks.\n"
        d = d..desc.."\n\n"
        d = d.."BAB +0.5, Ref +2, Will +0, Fort +0 at first level. \n BAB +0.5, Ref +0.5, Fort +0.33, Will +0.33 per level."
        d = d..skills.." skill points per level.\n\n"

		return d
    end,
	can_level = function(actor)
		if actor.classes and actor.classes["Shadowdancer"] and actor.classes["Shadowdancer"] >= 10 then return false end
		if actor.skill_move_silently >= 8 and actor.skill_hide >= 10 then return true end

		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
		actor:attr("reflex_save", 2)
		actor:attr("combat_bab", 0.5)
	--	actor:attr("fortitude_save", 0.5)
	--	actor:attr("will_save", 0.5)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--Any level higher than 1
		else

		--Level-specific bonuses
		if level == 2 then
			--grant hide in plain sight
			-- only if he doesn't have better infravision already
			if actor.infravision and actor.infravision > 3 then
				actor:attr("infravision", 1)
			else
				actor.infravision = 3
			end
		end


		--Level >1, generic bonuses
		actor:attr("reflex_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("fortitude_save", 0.33)
		actor:attr("will_save", 0.33)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Assassin',
	getSkillPoints = function(self, t)
		return 6
	end,
    desc = function(self, t)
        local d
        local desc = "#ORANGE#Evil backstabbers who want to kill just for the fun of it#LAST#\n"
        local skills = t.getSkillPoints(self, t)
        d = "Requires Move Silently 8 ranks and Hide 8 ranks.\n"
        d = d..desc.."\n\n"
        d = d.."BAB +0.5, Ref +2, Will +0, Fort +0 at first level. \n BAB +0.5, Ref +0.5, Fort +0.33, Will +0.33 per level."
        d = d..skills.." skill points per level.\n\n"

		return d
    end,
	can_level = function(actor)
		if actor.classes and actor.classes["Assassin"] and actor.classes["Assassin"] >= 10 then return false end
	--	if player.descriptor.alignment == "Neutral Evil" or player.descriptor.alignment == "Lawful Evil" or player.descriptor.alignment == "Chaotic Evil" then

		if actor.skill_move_silently >= 8 and actor.skill_hide >= 8 then return true end

		return false

	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("reflex_save", 2)
			actor:attr("sneak_attack", 1)

		actor:attr("combat_bab", 0.5)
	--	actor:attr("fortitude_save", 0.5)
	--	actor:attr("will_save", 0.5)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--Any level higher than 1
		else

		--Level-specific bonuses
		if level == 3 then actor:attr("sneak_attack", 1) end
		if level == 5 then actor:attr("sneak_attack", 1) end
		if level == 7 then actor:attr("sneak_attack", 1) end
		if level == 9 then actor:attr("sneak_attack", 1)end

		--Level >1, generic bonuses
		actor:attr("reflex_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("fortitude_save", 0.33)
		actor:attr("will_save", 0.33)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)
		end

	end,
}

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Blackguard',
	getSkillPoints = function(self, t)
		return 6
	end,
    desc = function(self, t)
        local d
        local desc = "#ORANGE#Worshippers of evil powers.#LAST#\n"
        local skills = t.getSkillPoints(self, t)
        d = "Requires BAB +6. Hide 6 ranks, Knowledge 2 ranks.\n"
        d = d..desc.."\n\n"
        d = d.."BAB +0.5, Fort +2, Will +0, Ref +0 at first level. \n BAB +0.5, Fort +0.5, Ref +0.33, Will +0.33 per level."
        d = d..skills.." skill points per level.\n\n"

		return d
    end,
	can_level = function(actor)
        --to do: enable Power Attack requirement
		if actor.classes and actor.classes["Blackguard"] and actor.classes["Blackguard"] >= 10 then return false end
	--	if player.descriptor.alignment == "Neutral Evil" or player.descriptor.alignment == "Lawful Evil" or player.descriptor.alignment == "Chaotic Evil" then
	-- 	if actor:knowTalent(actor.T_POWER_ATTACK) then
		if actor.skill_move_silently >= 6 and actor.skill_knowledge >= 2 and actor.combat_bab >= 6 then return true end

		return false

	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("fortitude_save", 2)
			actor:attr("sneak_attack", 1)

		actor:attr("combat_bab", 0.5)
	--	actor:attr("reflex_save", 0.5)
	--	actor:attr("will_save", 0.5)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--Any level higher than 1
		else

		--Level-specific bonuses
		if level == 4 then actor:attr("sneak_attack", 1) end
		if level == 7 then actor:attr("sneak_attack", 1) end
		if level == 10 then actor:attr("sneak_attack", 1) end

		--Level >1, generic bonuses
		actor:attr("fortitude_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("will_save", 0.33)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)
		end

	end,
}

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Arcane archer',
	getSkillPoints = function(self, t)
		return 4
	end,
    desc = function(self, t)
        local d
        local desc = "#ORANGE#Elven archers who fuel their arrows with magic.#LAST#\n"
        local skills = t.getSkillPoints(self, t)
        d = "Requires BAB +6."
        d = d..desc.."\n\n"
        d = d.."BAB +0.5, Fort + 2, Ref +2, Will +0 at first level. \n BAB +0.5, Ref +0.5, Fort +0.5, Will +0.33 per level."
        d = d..skills.." skill points per level.\n\n"

		return d
    end,
	can_level = function(actor)
        --to do: enable feat requirements and 1st level arcane spells requirement
		if actor.classes and actor.classes["Arcane archer"] and actor.classes["Arcane archer"] >= 10 then return false end
	--	if player.descriptor.race == "Elf" or player.descriptor.race == "Half-elf" then
	-- 	if actor:knowTalent(actor.T_WEAPON_FOCUS_BOW) then
		if actor.combat_bab >= 6 then return true end

		return false

	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
		actor:attr("fortitude_save", 2)
		actor:attr("reflex_save", 2)

		actor:attr("combat_bab", 1)
	--	actor:attr("will_save", 0.5)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--Any level higher than 1
		else

		--Level-specific bonuses
		--Enhance arrow 1,3,5,7,9

		--Level >1, generic bonuses
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.5)
		actor:attr("combat_bab", 1)

		actor:attr("will_save", 0.33)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)
		end

	end,
}

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Loremaster',
	getSkillPoints = function(self, t)
		return 4
	end,
    desc = function(self, t)
        local d
        local desc = "#ORANGE#The most knowledgeable mages the world knows.#LAST#\n"
        local skills = t.getSkillPoints(self, t)
        d = "Requires Knowledge 12 ranks.\n"
        d = d..desc.."\n\n"
        d = d.."BAB +0.5, Will +2, Fort +0, Ref +0 at first level. \n BAB +0.5, Will +0.5, Fort +0.33, Ref +0.33 per level."
        d = d..skills.." skill points per level.\n\n"

		return d
    end,
	can_level = function(actor)
        --to do: enable feat requirements (3x metamagic feats) and 3rd level arcane spells requirement
		if actor.classes and actor.classes["Loremaster"] and actor.classes["Loremaster"] >= 10 then return false end
--		if actor:knowTalent(actor.T_SKILL_FOCUS_KNOWLEDGE)
		if actor.skill_knowledge >= 12 then return true end

		return false

	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
		actor:attr("actor.will_save", 2)
		actor:attr("combat_bab", 0.5)
	--	actor:attr("will_save", 0.5)
	--	actor:attr("reflex_save", 0.5)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--Any level higher than 1
		else

		--Level-specific bonuses
		--Secret 1,3,5,7,9

		--Level >1, generic bonuses
		actor:attr("will_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("fortitude_save", 0.33)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)
		end

	end,
}

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Archmage',
	getSkillPoints = function(self, t)
		return 4
	end,
    desc = function(self, t)
        local d
        local desc = "#ORANGE#The best mages the world knows.#LAST#\n"
        local skills = t.getSkillPoints(self, t)
        d = "Requires Knowledge 15 ranks, Spellcraft 15 ranks.\n"
        d = d..desc.."\n\n"
        d = d.."BAB +0.5, Will +2, Fort +0, Ref +0 at first level.\n BAB +0.5, Will +0.5, Fort +0.33, Ref +0.33 per level."
        d = d..skills.." skill points per level.\n\n"

		return d
    end,
	can_level = function(actor)
        --to do: enable feat requirements (2x spell focus) and 7th level arcane spells requirement
		if actor.classes and actor.classes["Archmage"] and actor.classes["Archmage"] >= 5 then return false end
--		if actor:knowTalent(actor.T_SKILL_FOCUS_SPELLCRAFT)
		if actor.skill_knowledge >= 15 and actor.skill_spellcraft >= 15 then return true end

		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
		actor:attr("will_save", 2)
		actor:attr("combat_bab", 0.5)
	--	actor:attr("will_save", 0.5)
	--	actor:attr("reflex_save", 0.5)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--High arcana (from a list)

		--Any level higher than 1
		else

		--Level >1, generic bonuses
		actor:attr("will_save", 0.5)

		actor:attr("combat_bab", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("fortitude_save", 0.33)

		actor:attr("max_life", 8 + (actor:getCon()-10)/2)

		--High arcana (from a list)
		end

	end,
}
