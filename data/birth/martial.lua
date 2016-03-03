--Veins of the Earth
--Zireael 2013-2016

newBirthDescriptor{
	type = "class",
	name = "Martial",
	desc = [[Martials focus on the art of weapon combat.]],
	descriptor_choices =
	{
		subclass =
		{
			__ALL__ = "disallow",
			Barbarian = "allow",
			Fighter = "allow",
			Monk = "allow",
			Rogue = "allow",
		},
	},
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Barbarian',
	getSkillPoints = function(self, t)
		return 4
	end,
	getClassSkills = function(self, t)
		skills = "Climb, Craft, Handle Animal, Intimidate, Jump, Listen, Ride, Spot, Swim, Survival."
		return skills
	end,
	getHitPoints = function(self, t)
		return 12
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="no", Will="no" }
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Raging warriors of the wilds."
		local special = "+33% movement speed."
		return t.getDesc_class(self, t, desc, "full", special)
	end,
	rarity = 2,
	copy = {
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		},
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Barbarian"] and actor.descriptor.subclass == "Barbarian" then return true end

		if actor:getStr() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("fortitude_save", 2)
			actor:attr("combat_bab", 1)

			actor.movement_speed_bonus = 0.33

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SHIELD_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_RAGE, true)

			if actor == game.player then
				if actor.descriptor.race == "Half-orc" or actor.descriptor.race == "Orc" then
			actor.max_life = actor.max_life + 14 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 12 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 12 + (actor:getCon()-10)/2 end

		--Any level higher than 1
		else

		actor:attr("combat_bab", 1)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("will_save", 0.33)
			if actor == game.player then
				if actor.descriptor.race == "Half-orc" or actor.descriptor.race == "Orc" then
			--Favored class bonuses
			actor.combat_attack = (actor.combat_attack or 0) + 1
			actor.max_life = actor.max_life + 14 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 12 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 12 + (actor:getCon()-10)/2 end
		end
	end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Fighter',
	getSkillPoints = function(self, t)
		return 2
	end,
	getClassSkills = function(self, t)
		skills = "Climb, Craft, Handle Animal, Intimidate, Jump, Ride, Spot, Swim."

		return skills
	end,
	getHitPoints = function(self, t)
		return 10
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="no", Will="no" }
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Simple fighters, they hack away with their trusty weapon."
		return t.getDesc_class(self, t, desc, "full")
	end,
	rarity = 2,
	copy = {
	},
	descriptor_choices =
	{
		--Prevent another game-breaking combo; why would anyone want a fighter/spellcaster is beyond me
		background =
		{
			['Spellcaster'] = "disallow",
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Fighter"] and actor.descriptor.subclass == "Fighter" then return true end

		if actor:getStr() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level)
		if level == 1 then
			actor:attr("fortitude_save", 2)
			actor:attr("combat_bab", 1)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_HEAVY_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SHIELD_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)

			actor.fighter_bonus = 1

			actor:learnTalent(actor.T_SUMMON_MOUNT, true)

			if actor == game.player then
			 if actor.descriptor.race == "Dwarf" or actor.descriptor.race == "Duergar" then
			actor.max_life = actor.max_life + 12 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2 end

		--Any level higher than 1
		else

		--Bonus fighter feat every 2 levels
		if level % 2 == 0 then actor.fighter_bonus = (actor.fighter_bonus or 0) + 1 end


		actor:attr("combat_bab", 1)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("will_save", 0.33)

		if actor == game.player then
			if actor.descriptor.race == "Dwarf" or actor.descriptor.race == "Duergar" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 12 + (actor:getCon()-10)/2
		else
		actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2 end
		else
		actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2 end
		end
	end,
}

newBirthDescriptor {
        type = 'subclass',
        name = 'Monk',
		getSkillPoints = function(self, t)
			return 4
		end,
		getClassSkills = function(self, t)
			skills = "Balance, Climb, Concentration, Craft, Diplomacy, Escape Artist, Hide, Jump, Knowledge, Listen, Move Silently, Sense Motive, Spot, Swim, Tumble."

			return skills
		end,
		getHitPoints = function(self, t)
			return 8
		end,
		getSaves = function(self, t)
			return {Fort="yes", Ref="yes", Will="yes" }
		end,
		desc = function(self, t)
			local desc = "#ORANGE#Unarmed and without armor, they are nevertheless fearsome warriors."
			return t.getDesc_class(self, t, desc, "good")
		end,
--[[        copy = {
                resolvers.equip {
                        id=true,
                        { name="long sword", ego_chance=-1000 },
                        { name="chain mail", ego_chance=-1000 },
                },
        },]]
        descriptor_choices =
        {
                alignment =
                {
                        ['Neutral Good'] = "disallow",
                        ['Neutral'] = "disallow",
                        ['Neutral Evil'] = "disallow",
                        ['Chaotic Good'] = "disallow",
                        ['Chaotic Neutral'] = "disallow",
                        ['Chaotic Evil'] = "disallow",
                },
                deity =
                {
                    --Can only follow Aiswin, Essiah, Hesani, Immotian, Kysul, Mara, Multitude, Xavias
                    ['Asherath'] = "disallow",
                    ['Ekliazeh'] = "disallow",
                    ['Erich'] = "disallow",
                    ['Khasrach'] = "disallow",
                    ['Maeve'] = "disallow",
                    ['Sabin'] = "disallow",
                    ['Semirath'] = "disallow",
                    ['Xel'] = "disallow",
                    ['Zurvash'] = "disallow",
                },
        },
        can_level = function(actor)
            if actor.classes and actor.classes["Monk"] and actor.descriptor.subclass == "Monk" then return true end

            if actor:getWis() >= 13 then return true end
            return false
        end,
        on_level = function(actor, level, descriptor)
            if level == 1 then
            actor:attr("fortitude_save", 2)
            actor:attr("reflex_save", 2)
            actor:attr("will_save", 2)
			actor:attr("max_life", 8 + (actor:getCon()-10)/2)
            actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
            --monk specific abilities
            actor:learnTalent(actor.T_WISDOM_AC_MONK, true)
            actor:learnTalent(actor.T_STUNNING_FIST, true)

            --Any level higher than 1
            else

            actor:attr("combat_bab", 1)
            actor:attr("fortitude_save", 0.5)
            actor:attr("reflex_save", 0.5)
            actor:attr("will_save", 0.5)
			actor:attr("max_life", 8 + (actor:getCon()-10)/2)
            end
        end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Rogue',
	getSkillPoints = function(self, t)
		return 8
	end,
	getClassSkills = function(self, t)
		skills = "Appraise, Balance, Bluff, Climb, Craft, Diplomacy, Decipher Script, Disable Device, Escape Artist, Hide, Intuition, Jump, Knowledge, Listen, Move Silently, Open Lock, Pick Pocket, Search, Sense Motive, Spot, Tumble, Use Magic."

		return skills
	end,
	getHitPoints = function(self, t)
		return 8
	end,
	getSaves = function(self, t)
		return {Fort="no", Ref="yes", Will="no"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Rogues are masters of tricks."
		return t.getDesc_class(self, t, desc, "good")
	end,
	rarity = 3,
	copy = {
		resolvers.equip {
			id=true,
		--	{ name="light crossbow", ego_chance=-1000 },
			{ name="bolts", ego_chance=-1000 },
		--	{ name="studded leather", ego_chance=-1000 },
		},
		resolvers.inventory {
			id=true,
			{ name="dagger", ego_chance=-1000},
		}
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		},
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Rogue"] and actor.descriptor.subclass == "Rogue" then return true end

		if actor:getDex() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("reflex_save", 2)
			actor:attr("sneak_attack", 1)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			actor:learnTalent(actor.T_FINESSE, true)

			if actor == game.player then
				if actor.descriptor.race == "Deep gnome" or actor.descriptor.race == "Kobold" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2
				else
				actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end

		--Any level higher than 1
		else

		--Level-specific bonuses
		if level == 3 then
            actor:attr("sneak_attack", 1)
            actor:attr("trap_sense", 1)
        end
		if level == 5 then actor:attr("sneak_attack", 1) end
        if level == 6 then actor:attr("trap_sense", 1) end
		if level == 7 then actor:attr("sneak_attack", 1) end
		if level == 9 then
            actor:attr("sneak_attack", 1)
            actor:attr("trap_sense", 1)
        end
		if level == 11 then actor:attr("sneak_attack", 1) end
        if level == 12 then actor:attr("trap_sense", 1) end
		if level == 13 then actor:attr("sneak_attack", 1) end
		if level == 15 then
            actor:attr("sneak_attack", 1)
            actor:attr("trap_sense", 1)
        end
		if level == 17 then actor:attr("sneak_attack", 1) end
        if level == 18 then actor:attr("trap_sense", 1) end
		if level == 19 then actor:attr("sneak_attack", 1) end

		--Level >1, generic bonuses
		actor:attr("reflex_save", 0.5)
		actor:attr("combat_bab", 0.75)
		actor:attr("will_save", 0.33)
		actor:attr("fortitude_save", 0.33)

		if actor == game.player then
			if actor.descriptor.race == "Deep gnome" or actor.descriptor.race == "Kobold" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end
		else
		actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end
		end
	end,
}

--Non-standard classes
newBirthDescriptor {
	type = 'subclass',
	name = 'Warlock',
	getSkillPoints = function(self, t)
		return 2
	end,
	getClassSkills = function(self, t)
		skills = "Concentration, Craft, Intuition, Knowledge, Sense Motive, Spellcraft."

		return skills
	end,
	getHitPoints = function(self, t)
		return 6
	end,
	getSaves = function(self, t)
		return {Fort="no", Ref="no", Will="yes"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#A spellcaster who needs no weapon."
		return t.getDesc_class(self, t, desc, "bad")
	end,
	rarity = 10,
	copy = {
	},
	descriptor_choices =
	{
	},
	can_level = function(actor)
	if actor.classes and actor.classes["Warlock"] and actor.descriptor.subclass == "Warlock" then return true end

		if actor:getCha() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("will_save", 2)
			actor:attr("max_life", 4 + (actor:getCon()-10)/2)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			actor:learnTalent(actor.T_ELDRITCH_BLAST, true)

		else

		--Level >1, generic bonuses
		actor:attr("will_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("fortitude_save", 0.33)
		actor:attr("reflex_save", 0.33)

		actor:attr("max_life", 6 + (actor:getCon()-10)/2)
		end
	end,
}
