--Veins of the Earth
--Zireael 2013-2016

newBirthDescriptor{
	type = "class",
	name = "Half-caster",
	desc = [[Half-casters can swing a sword and can cast spells - however, they are not as magically powerful as full casters.]],
	descriptor_choices =
	{
		subclass =
		{
			__ALL__ = "disallow",
			Bard = "allow",
			Paladin = "allow",
			Ranger = "allow",
			Magus = "allow",
		},
	},
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Bard',
	getSkillPoints = function(self, t)
		return 6
	end,
	getHitPoints = function(self, t)
		return 6
	end,
	getSaves = function(self, t)
		return {Fort="no", Ref="yes", Will="yes" }
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Musicians and gentlefolk."
		return t.getDesc_class(self, t, desc, "good")
	end,
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
		if actor.classes and actor.classes["Bard"] and actor.descriptor.subclass == "Bard" then return true end

		if actor:getCha() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("will_save", 2)
			actor:attr("reflex_save", 2)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_BARDIC_MUSIC, true)
			actor:learnTalent(actor.T_BARDIC_KNOWLEDGE, true)
			actor:learnTalent(actor.T_ARMORED_CASTER_LIGHT, true)

			--Don't give spellbook to NPCs
			if actor == game.player then
				actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
				--Get the spells menu
				actor:learnTalent(actor.T_SPELLS, true)
			end

			local all_schools = {"abjuration", "conjuration", "divination", "enchantment", "evocation", "illusion", "necromancy", "transmutation" }
			descriptor.learn_talent_types(actor, all_schools)

			local both_schools = {"abjuration_both", "conjuration_both", "divination_both", "necromancy_both", "transmutation_both"}
			descriptor.learn_talent_types(actor, both_schools)

			descriptor.learn_all_spells_of_level(actor, "arcane", 0)
			descriptor.learn_all_spells_of_level(actor, "arcane", 1)

			if actor == game.player then
				if actor.descriptor.race == "Half-elf" or actor.descriptor.race == "Gnome" then
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end

		--Any level higher than 1
		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "arcane", spell_level)
		end

		actor:attr("combat_bab", 0.75)
		actor:attr("fortitude_save", 0.33)
		actor:attr("reflex_save", 0.5)
		actor:attr("will_save", 0.5)

		if actor == game.player then
			if actor.descriptor.race == "Half-elf" or actor.descriptor.race == "Gnome" then
				--Favored class bonuses
				actor.combat_attack = (actor.combat_attack or 0) + 1
				actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end

		else
		actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2 end
		end

		--Gain a caster level every level
		actor:incCasterLevel("arcane", 1)
	end,
}

newBirthDescriptor {
    type = 'subclass',
    name = 'Paladin',
	getSkillPoints = function(self, t)
		return 2
	end,
	getHitPoints = function(self, t)
		return 8
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="no", Will="no" }
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Holy warriors of the deities of good and law."
		return t.getDesc_class(self, t, desc, "full")
	end,
	copy = {
    },
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
                    ['Lawful Neutral'] = "disallow",
                    ['Lawful Evil'] = "disallow",
            },
            deity =
            {
            --Can only follow Ekliazeh, Erich, Immotian, Kysul, Mara, Semirath, Xavias
            ['Aiswin'] = "disallow",
            ['Asherath'] = "disallow",
            ['Hesani'] = "disallow",
            ['Khasrach'] = "disallow",
            ['Multitude'] = "disallow",
            ['Sabin'] = "disallow",
            ['Xel'] = "disallow",
            ['Zurvash'] = "disallow",
            },
    },
    can_level = function(actor)
        if actor.classes and actor.classes["Paladin"] and actor.descriptor.subclass == "Paladin" then return true end

        if actor:getWis() >= 13 then return true end
        return false
    end,
    on_level = function(actor, level, descriptor)
        if level == 1 then
            actor:attr("fortitude_save", 2)
            actor:attr("combat_bab", 1)

            actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
            actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
            actor:learnTalent(actor.T_HEAVY_ARMOR_PROFICIENCY, true)
            actor:learnTalent(actor.T_SHIELD_PROFICIENCY, true)
            actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
            actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)
            actor:learnTalent(actor.T_LAY_ON_HANDS, true)

            actor:attr("max_life", 10 + (actor:getCon()-10)/2)

        --Any level higher than 1
        else

        --Learn a new spell tier every 3rd level starting from lvl 5
		if level >= 5 and level % 3 == 0 then
			local spell_level = ((level-5) / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "divine", spell_level)
		end

		--Level-specific bonuses
        if level == 4 then actor:learnTalent(actor.T_TURN_UNDEAD, true) end
        if level == 5 then
        	--Don't give spellbook to NPCs
			if actor == game.player then
            	--Get spellbook
            	actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
				--Get the spells menu
				actor:learnTalent(actor.T_SPELLS, true)
        	end

			local all_schools = {"abjuration_divine", "conjuration_divine", "divination_divine", "enchantment_divine", "evocation_divine", "necromancy_divine", "transmutation_divine"  }
			descriptor.learn_talent_types(actor, all_schools)

			local both_schools = {"abjuration_both", "conjuration_both", "divination_both", "necromancy_both", "transmutation_both"}
			descriptor.learn_talent_types(actor, both_schools)

        	descriptor.learn_all_spells_of_level(actor, "divine", 0)
			descriptor.learn_all_spells_of_level(actor, "divine", 1)

        	actor:learnTalent(actor.T_SUMMON_MOUNT, true)
        end

        if level >= 5 then
			--Gain a caster level every level
			actor:incCasterLevel("divine", 1)
		end

        --Level >1, generic bonuses
			actor:attr("combat_bab",1)
    		actor:attr("fortitude_save", 0.5)
    		actor:attr("reflex_save", 0.33)
    		actor:attr("will_save", 0.33)
			actor:attr("max_life", 10 + (actor:getCon()-10)/2)
    	end
    end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Ranger',
	getSkillPoints = function(self, t)
		return 6
	end,
	getHitPoints = function(self, t)
		return 8
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="yes", Will="no"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Rangers are capable archers but are also trained in hand to hand combat and divine magic."
		return t.getDesc_class(self, t, desc, "full")
	end,
	rarity = 3,
	copy = {
		resolvers.inventory {
			id=true,
			{ name="shortbow", ego_chance=-1000},
			{ name="arrows", ego_chance=-1000 },
			{ name="dagger", ego_chance=-1000 },
		},

	},
	descriptor_choices =
	{
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Ranger"] and actor.descriptor.subclass == "Ranger" then return true end

		if actor:getStr() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("fortitude_save", 2)
			actor:attr("combat_bab", 1)
			actor:attr("reflex_save", 2)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)
            actor:learnTalent(actor.T_FASTING, true)


--			actor:learnTalent(actor.T_TWO_WEAPON_FIGHTING, true)
			if actor == game.player then
            game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your favored enemy",{
                {name="Aberration", desc=""},
                {name="Animal", desc=""},
                {name="Construct", desc=""},
                {name="Dragon", desc=""},
                {name="Elemental", desc=""},
                {name="Fey", desc=""},
                {name="Giant", desc=""},
                {name="Humanoid (dwarf)", desc=""},
                {name="Humanoid (gnome)", desc=""},
                {name="Humanoid (drow)", desc=""},
                {name="Humanoid (elf)", desc=""},
                {name="Humanoid (human)", desc=""},
                {name="Humanoid (halfling)", desc=""},
                {name="Humanoid (planetouched)", desc=""},
                {name="Humanoid (aquatic)", desc=""},
                {name="Humanoid (goblinoid)", desc=""},
                {name="Humanoid (gnoll)", desc=""},
                {name="Humanoid (reptilian)", desc=""},
                {name="Humanoid (orc)", desc=""},
                {name="Magical beast", desc=""},
                {name="Monstrous humanoid", desc=""},
                {name="Outsider (air)", desc=""},
                {name="Outsider (earth)", desc=""},
                {name="Outsider (evil)", desc=""},
                {name="Outsider (fire)", desc=""},
                {name="Outsider (good)", desc=""},
                {name="Outsider (water)", desc=""},
                {name="Ooze", desc=""},
                {name="Plant", desc=""},
                {name="Undead", desc=""},
                {name="Vermin", desc=""}
                },

            function(result)
            --	game.log("Result: "..result)
            	--Learn talent types based on the choice
            	if result == "Aberration" then actor:learnTalent(actor.T_FAVORED_ENEMY_ABERRATION) end
            	if result == "Animal" then actor:learnTalent(actor.T_FAVORED_ENEMY_ANIMAL) end
				if result == "Construct" then actor:learnTalent(actor.T_FAVORED_ENEMY_CONSTRUCT) end
				if result == "Dragon" then actor:learnTalent(actor.T_FAVORED_ENEMY_DRAGON) end
            	if result == "Elemental" then actor:learnTalent(actor.T_FAVORED_ENEMY_ELEMENTAL) end
            	if result == "Fey" then actor:learnTalent(actor.T_FAVORED_ENEMY_FEY) end
            	if result == "Giant" then actor:learnTalent(actor.T_FAVORED_ENEMY_GIANT) end
            	if result == "Magical beast" then actor:learnTalent(actor.T_FAVORED_ENEMY_MAGBEAST) end
			   	if result == "Monstrous humanoid" then actor:learnTalent(actor.T_FAVORED_ENEMY_MONSTROUS_HUMANOID) end
			   	if result == "Ooze" then actor:learnTalent(actor.T_FAVORED_ENEMY_OOZE) end
			   	if result == "Plant" then actor:learnTalent(actor.T_FAVORED_ENEMY_PLANT) end
			   	if result == "Undead" then actor:learnTalent(actor.T_FAVORED_ENEMY_UNDEAD) end
			   	if result == "Vermin" then actor:learnTalent(actor.T_FAVORED_ENEMY_VERMIN) end
			   	if result == "Humanoid (dwarf)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_DWARF) end
			   	if result == "Humanoid (gnome)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_GNOME) end
			   	if result == "Humanoid (drow)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_DROW) end
			   	if result == "Humanoid (elf)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_ELF) end
			   	if result == "Humanoid (human)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_HUMAN) end
			   	if result == "Humanoid (halfling)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_HALFLING) end
			   	if result == "Humanoid (planetouched)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_PLANETOUCHED) end
			   	if result == "Humanoid (aquatic)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_AQUATIC) end
			   	if result == "Humanoid (goblinoid)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_GOBLINOID) end
			   	if result == "Humanoid (gnoll)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_GNOLL) end
			   	if result == "Humanoid (reptilian)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_REPTILIAN) end
			   	if result == "Humanoid (orc)" then actor:learnTalent(actor.T_FAVORED_ENEMY_HUMANOID_ORC) end
			   	if result == "Outsider (air)" then actor:learnTalent(actor.T_FAVORED_ENEMY_OUTSIDER_AIR) end
			   	if result == "Outsider (earth)" then actor:learnTalent(actor.T_FAVORED_ENEMY_OUTSIDER_EARTH) end
			   	if result == "Outsider (evil)" then actor:learnTalent(actor.T_FAVORED_ENEMY_OUTSIDER_EVIL) end
			   	if result == "Outsider (fire)" then actor:learnTalent(actor.T_FAVORED_ENEMY_OUTSIDER_FIRE) end
			   	if result == "Outsider (good)" then actor:learnTalent(actor.T_FAVORED_ENEMY_OUTSIDER_GOOD) end
			   	if result == "Outsider (water)" then actor:learnTalent(actor.T_FAVORED_ENEMY_OUTSIDER_WATER) end
			end))
			end

			if actor == game.player then
				if actor.descriptor.race == "Elf" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		--Any level higher than 1
		else

		--Learn a new spell tier every 3rd level starting from lvl 5
		if level >= 5 and level % 3 == 0 then
			local spell_level = ((level-5) / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "divine", spell_level)
		end


		if level == 5 then
			--Don't give spellbook to NPCs
			if actor == game.player then
				--Get spellbook
	            actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
				--Get the spells menu
				actor:learnTalent(actor.T_SPELLS, true)
        	end

			local all_schools = {"abjuration_divine", "conjuration_divine", "divination_divine", "enchantment_divine", "evocation_divine", "necromancy_divine", "transmutation_divine"  }
			descriptor.learn_talent_types(actor, all_schools)

			local both_schools = {"abjuration_both", "conjuration_both", "divination_both", "necromancy_both", "transmutation_both"}
			descriptor.learn_talent_types(actor, both_schools)

			descriptor.learn_all_spells_of_level(actor, "divine", 0)
			descriptor.learn_all_spells_of_level(actor, "divine", 1)
		end

		if level >= 5 then
			--Gain a caster level every level
			actor:incCasterLevel("divine", 1)
		end

		--Level >1, generic bonuses
		actor:attr("combat_bab", 1)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.5)
		actor:attr("will_save", 0.33)
		if actor == game.player then
			if actor.descriptor.race == "Elf" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		else
		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end
		end
	end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Magus',
	getSkillPoints = function(self, t)
		return 4
	end,
	getHitPoints = function(self, t)
		return 8
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="no", Will="yes" }
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Those who blend martial ability and magical prowess."
		return t.getDesc_class(self, t, desc, "good")
	end,
	copy = {
	},
	descriptor_choices =
	{
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Magus"] and actor.descriptor.subclass == "Magus" then return true end

		if actor:getInt() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("will_save", 2)
			actor:attr("fort_save", 2)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_ARMORED_CASTER_LIGHT, true)
			actor:learnTalent(actor.T_SPELL_COMBAT, true)

			--Don't give spellbook to NPCs
			if actor == game.player then
				actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
				--Get the spells menu
				actor:learnTalent(actor.T_SPELLS, true)
			end

			local all_schools = {"abjuration", "conjuration", "divination", "enchantment", "evocation", "illusion", "necromancy", "transmutation" }
			descriptor.learn_talent_types(actor, all_schools)

			local both_schools = {"abjuration_both", "conjuration_both", "divination_both", "necromancy_both", "transmutation_both"}
			descriptor.learn_talent_types(actor, both_schools)

			descriptor.learn_all_spells_of_level(actor, "arcane", 0)
			descriptor.learn_all_spells_of_level(actor, "arcane", 1)

			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2

		--Any level higher than 1
		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "arcane", spell_level)
		end

		actor:attr("combat_bab", 0.75)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("will_save", 0.5)

		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		--Gain a caster level every level
		actor:incCasterLevel("arcane", 1)
	end,
}
