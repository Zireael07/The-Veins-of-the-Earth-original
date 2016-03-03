--Veins of the Earth
--Zireael 2013-2016

newBirthDescriptor{
	type = "class",
	name = "Caster",
	desc = [[Casters are those who are kings of spellcasting. In close quarters, however, they are fairly weak.]],
	descriptor_choices =
	{
		subclass =
		{
			__ALL__ = "disallow",
			Cleric = "allow",
            Druid = "allow",
			Sorcerer = "allow",
			Wizard = "allow",
			Shaman = "allow",
		},
	},
}

newBirthDescriptor{
	type = 'subclass',
	name = 'Cleric',
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
		local desc = "#ORANGE#Clerics are masters of healing."
		return t.getDesc_class(self, t, desc, "good")
	end,
	rarity = 4,
	copy = {
	},
    talents_types = {
    ["class/spellcasting"] = {true, 0.0},
    ["arcane/itemcreation"] = {true, 0.0},
    ["arcane/metamagic"] = {true, 0.0},
    ["arcane/reserve"] = {true, 0.0},
    },
	descriptor_choices = {
		deity =
    	{
            --Can't be atheists
      		['None'] = "disallow",
    	},
		domains = {
			__ALL__ = "allow",
		},
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Cleric"] and actor.descriptor.subclass == "Cleric" then return true end

		if actor:getWis() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("fortitude_save", 2)
			actor:attr("will_save", 2)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_HEAVY_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SHIELD_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			--Don't give spellbook to NPCs
			if actor == game.player then
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


			actor:learnTalent(actor.T_LAY_ON_HANDS, true)
			actor:learnTalent(actor.T_TURN_UNDEAD, true)


			actor:learnTalentType("cleric/cleric", true)

			if actor == game.player then
				local ActorSpells = require "mod.class.interface.ActorSpells"
	            ActorSpells:domainSelection(actor)
            end

			if actor == game.player then
				if actor:hasDescriptor{race="Drow", sex="Female"} or actor:hasDescriptor{race="Half-drow"} then
			actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		--Any level higher than 1
		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "divine", spell_level)
		end

		actor:attr("will_save", 0.5)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("combat_bab", 0.75)

		if actor == game.player then
			if actor:hasDescriptor{race="Drow", sex="Female"} or actor:hasDescriptor{race="Half-drow"} then
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2
		else
		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		else
		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end
		end

		--Gain a caster level every level
		actor:incCasterLevel("divine", 1)
	end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Druid',
	getSkillPoints = function(self, t)
		return 4
	end,
	getHitPoints = function(self, t)
		return 8
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="no", Will="yes"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Clerics of nature."
		return t.getDesc_class(self, t, desc, "good")
	end,
	rarity = 8,
	copy = {
	},
    talents_types = {
    ["class/spellcasting"] = {true, 0.0},
    ["arcane/itemcreation"] = {true, 0.0},
    ["arcane/metamagic"] = {true, 0.0},
    ["arcane/reserve"] = {true, 0.0},
    },
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Evil'] = "disallow",
			['Chaotic Good'] = "disallow",
			['Chaotic Evil'] = "disallow",
		},
        deity =
        {
            --Can only follow Essiah, Hesani, Kysul, Mara, Maeve, Sabin, Xel, Zurvash
            ['Aiswin'] = "disallow",
            ['Asherath'] = "disallow",
            ['Ekliazeh'] = "disallow",
            ['Erich'] = "disallow",
            ['Immotian'] = "disallow",
            ['Khasrach'] = "disallow",
            ['Multitude'] = "disallow",
            ['Semirath'] = "disallow",
            ['Xavias'] = "disallow",
        },
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Druid"] and actor.descriptor.subclass == "Druid" then return true end

		if actor:getWis() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			actor:attr("fortitude_save", 2)
			actor:attr("will_save", 2)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)

			--Don't give spellbook to NPCs
			if actor == game.player then
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

			if actor == game.player then
				if actor:hasDescriptor{race="Lizardfolk"} then
				--Favored class bonuses
				actor.combat_attack = (actor.combat_attack or 0) + 1
				actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		else
		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2
		end

		--Any level higher than 1
		else

		if level == 4 then
			actor:learnTalent(actor.T_WILD_SHAPE, true)
		end
		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "divine", spell_level)
		end

		actor:attr("will_save", 0.5)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)
		actor:attr("combat_bab", 0.75)

		if actor == game.player then
				if actor:hasDescriptor{race="Lizardfolk"} then
				--Favored class bonuses
				actor.combat_attack = (actor.combat_attack or 0) + 1
				actor.max_life = actor.max_life + 10 + (actor:getCon()-10)/2
			else
			actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end

		else
		actor.max_life = actor.max_life + 8 + (actor:getCon()-10)/2 end
	end

		--Gain a caster level every level
		actor:incCasterLevel("divine", 1)

	end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Sorcerer',
	rarity = 6,
	getSkillPoints = function(self, t)
		return 2
	end,
	getHitPoints = function(self, t)
		return 4
	end,
	getSaves = function(self, t)
		return {Fort="no", Ref="no", Will="yes"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Masters of arcane magic."
		return t.getDesc_class(self, t, desc, "bad")
	end,
	copy = {
		resolvers.inventory {
			id=true,
			{ name="light crossbow", ego_chance=-1000},
			{ name="bolts", ego_chance=-1000},
			{ name="rags", ego_chance=-1000},
		}
	},
    talents_types = {
    ["class/spellcasting"] = {true, 0.0},
    ["arcane/itemcreation"] = {true, 0.0},
    ["arcane/metamagic"] = {true, 0.0},
    ["arcane/reserve"] = {true, 0.0},
    },
	descriptor_choices =
	{
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Sorcerer"] and actor.descriptor.subclass == "Sorcerer" then return true end

		if actor:getCha() >= 16 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
		--	actor:attr("innate_casting_arcane", 1)

			actor:attr("will_save", 2)

			local all_schools = {"abjuration", "conjuration", "divination", "enchantment", "evocation", "illusion", "necromancy", "transmutation" }
			descriptor.learn_talent_types(actor, all_schools)

			local both_schools = {"abjuration_both", "conjuration_both", "divination_both", "necromancy_both", "transmutation_both"}
			descriptor.learn_talent_types(actor, both_schools)

            --Get the spell points
            actor:learnTalent(actor.T_SPELL_POINTS_POOL, true)
			--Get the spells menu
			actor:learnTalent(actor.T_SPELLS, true)

			actor:attr("max_life", 4 + (actor:getCon()-10)/2)

			descriptor.learn_all_spells_of_level(actor, "arcane", 0)
			descriptor.learn_all_spells_of_level(actor, "arcane", 1)
		else
			--Level >1, generic bonuses
			actor:attr("will_save", 0.5)
			actor:attr("combat_bab", 0.5)
			actor:attr("fortitude_save", 0.33)
			actor:attr("reflex_save", 0.33)
			actor:attr("max_life", 4 + (actor:getCon()-10)/2)
		end

		-- Sorcerers gain a caster level every level
		actor:incCasterLevel("arcane", 1)
		--Refresh max spell pts
		actor.mana = actor:setMaxSpellPts()
		actor.max_mana = actor:setMaxSpellPts()

		-- At each even level past level 2 we gain a spell level
		if level % 2 == 0 then
			descriptor.learn_all_spells_of_level(actor, "arcane", math.floor(level / 2))
		end
	end,
}

newBirthDescriptor {
	type = 'subclass',
	name = 'Wizard',
	getSkillPoints = function(self, t)
		return 4
	end,
	getHitPoints = function(self, t)
		return 4
	end,
	getSaves = function(self, t)
		return {Fort="no", Ref="no", Will="yes"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#Masters of arcane magic."
		return t.getDesc_class(self, t, desc, "bad")
	end,
	rarity = 5,
	copy = {
		resolvers.inventory {
			id=true,
			{ name="light crossbow", ego_chance=-1000},
			{ name="bolts", ego_chance=-1000},
			{ name="rags", ego_chance=-1000},
		}

	},
    talents_types = {
    ["class/spellcasting"] = {true, 0.0},
    ["arcane/itemcreation"] = {true, 0.0},
    ["arcane/metamagic"] = {true, 0.0},
    ["arcane/reserve"] = {true, 0.0},
    },
	descriptor_choices =
	{
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Wizard"] and actor.descriptor.subclass == "Wizard" then return true end
		if actor:getInt() >= 16 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			--Don't give spellbook to NPCs
			if actor == game.player then
				actor:learnTalent(actor.T_SHOW_SPELLBOOK)
				--Get the spells menu
				actor:learnTalent(actor.T_SPELLS, true)
			end

			actor:attr("will_save", 2)

			if actor == game.player then
				game:registerDialog(require('mod.dialogs.GetChoice').new("Choose a specialization",{
					{name="Generalist", desc="You are the master of everything but nothing. You will be equally good with all spells."},
					{name="Abjuration", desc="Restricts Conjuration"},
					{name="Conjuration", desc="Restricts Transmutation"},
					{name="Divination", desc="Restricts Illusion"},
					{name="Enchantment", desc="Restricts Illusion"},
					{name="Evocation", desc="Restricts Conjuration"},
					{name="Illusion", desc="Restricts Enchantment"},
					{name="Necromancy", desc="Restricts Divination"},
					{name="Transmutation", desc="Restricts Conjuration"}
				}, function(result)

					if result ~= "Abjuration" and result ~= "Evocation" and result ~= "Transmutation" then actor:learnTalentType("conjuration") end --actor:learnTalentType("conjuration_both") end
					if result ~= "Necromancy" then
						actor:learnTalentType("divination")
						actor:learnTalentType("divination_both")
					end
					if result ~= "Illusion" then actor:learnTalentType("enchantment") end

					if result ~= "Divination" and result ~= "Enchantment" then actor:learnTalentType("illusion") end

					if result ~= "Conjuration" then
						actor:learnTalentType("transmutation")
						actor:learnTalentType("transmutation_both")
					end

					actor:learnTalentType("abjuration")
					actor:learnTalentType("abjuration_both")
					actor:learnTalentType("evocation")
					actor:learnTalentType("necromancy")
					actor:learnTalentType("necromancy_both")

					-- Now that we know our schools, learn spells
					descriptor.learn_all_spells_of_level(actor, "arcane", 0)
					descriptor.learn_all_spells_of_level(actor, "arcane", 1)
				end))

				game:registerDialog(require('mod.dialogs.GetChoice').new("Choose a familiar", {
					{name="Bat", desc="Master gains a +3 bonus on Listen checks."},
					{name="Cat", desc="Master gains a +3 bonus on Move Silently checks."},
					{name="Hawk", desc="Master gains a +3 bonus to Spot checks in bright light."},
					{name="Lizard", desc="Master gains a +3 bonus to Climb checks."},
					{name="Owl", desc="Master gains a +3 bonus to Spot checks in shadows."},
					{name="Rat", desc="Master gains a +2 bonus on Fortitude saves."},
					{name="Raven", desc="[Placeholder] Gives a +3 bonus to Appraise checks in d20. We won't have this skill!"},
					{name="Snake", desc="Master gains a +3 bonus on Bluff checks"},
					{name="Toad", desc="Master gains +3 hit points."},
					{name="Weasel", desc="Master gains a +2 bonus on Reflex saves."}
				}, function(result)
					if result == "Bat" then actor:attr("skill_listen", 3) end
					if result == "Cat" then actor:attr("skill_move_silently", 3) end
					if result == "Hawk" then actor:attr("skill_spot", 3) end
					if result == "Lizard" then actor:attr("skill_climb", 3) end
					if result == "Owl" then actor:attr("skill_spot", 3) end
					if result == "Rat" then actor:attr("fortitude_save", 2) end
					if result == "Snake" then actor:attr("skill_bluff", 3) end
					if result == "Toad" then actor:attr("max_life", 3) end
					if result == "Weasel" then actor:attr("reflex_save", 2) end
				end))
			end

			if actor == game.player then
				if actor:hasDescriptor{race="Drow", sex="Male"} then
					actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2
				else
					actor.max_life = actor.max_life + 4 + (actor:getCon()-10)/2
				end
			else
				actor.max_life = actor.max_life + 4 + (actor:getCon()-10)/2
			end
		else
			--Level >1, generic bonuses
			actor:attr("will_save", 0.5)
			actor:attr("combat_bab", 0.5)
			actor:attr("fortitude_save", 0.33)
			actor:attr("reflex_save", 0.33)

			if actor == game.player then
				if actor:hasDescriptor{race="Drow", sex="Male"} then
					actor.max_life = actor.max_life + 6 + (actor:getCon()-10)/2
				else
					actor.max_life = actor.max_life + 4 + (actor:getCon()-10)/2
				end
			else
				actor.max_life = actor.max_life + 4 + (actor:getCon()-10)/2
			end
		end

		-- Wizards gain a caster level every level
		actor:incCasterLevel("arcane", 1)

		-- At each odd level we gain a spell level
		if level % 2 == 1 then
			descriptor.learn_all_spells_of_level(actor, "arcane", math.floor(level / 2) + 1)
		end
	end,
}

--Non-standard class
newBirthDescriptor {
	type = 'subclass',
	name = 'Shaman',
	getSkillPoints = function(self, t)
		return 4
	end,
	getHitPoints = function(self, t)
		return 8
	end,
	getSaves = function(self, t)
		return {Fort="yes", Ref="no", Will="yes"}
	end,
	desc = function(self, t)
		local desc = "#ORANGE#A divine spellcaster who does not need to prepare spells."
		return t.getDesc_class(self, t, desc, "bad")
	end,
	rarity = 10,
	copy = {
	},
    talents_types = {
    ["class/spellcasting"] = {true, 0.0},
    ["arcane/itemcreation"] = {true, 0.0},
    ["arcane/metamagic"] = {true, 0.0},
    ["arcane/reserve"] = {true, 0.0},
    },
	descriptor_choices =
	{
		deity =
        {
            --Can't be atheists
            ['None'] = "disallow",
        },
	},
	can_level = function(actor)
	if actor.classes and actor.classes["Shaman"] and actor.descriptor.subclass == "Shaman" then return true end

		if actor:getCha() >= 13 then return true end
		return false
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then

		--	actor:attr("innate_casting_divine", 1)

			actor:attr("will_save", 2)
			actor:attr("fortitude_save", 2)
			actor:attr("max_life", 4 + (actor:getCon()-10)/2)

			local all_schools = {"abjuration_divine", "conjuration_divine", "divination_divine", "enchantment_divine", "evocation_divine", "necromancy_divine", "transmutation_divine"  }
			descriptor.learn_talent_types(actor, all_schools)

			local both_schools = {"abjuration_both", "conjuration_both", "divination_both", "necromancy_both", "transmutation_both"}
			descriptor.learn_talent_types(actor, both_schools)

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			--Get the spells menu
			actor:learnTalent(actor.T_SPELLS, true)

            --Get the spell points
            actor:learnTalent(actor.T_SPELL_POINTS_POOL, true)

			descriptor.learn_all_spells_of_level(actor, "divine", 0)
			descriptor.learn_all_spells_of_level(actor, "divine", 1)

			if actor == game.player then
				local ActorSpells = require "mod.class.interface.ActorSpells"
                ActorSpells:domainSelection(actor)
            end


		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			descriptor.learn_all_spells_of_level(actor, "divine", spell_level)
		end

		--Level >1, generic bonuses
		actor:attr("will_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)

		actor:attr("max_life", 6 + (actor:getCon()-10)/2)

		--Gain a caster level every level
		actor:incCasterLevel("divine", 1)
		--Refresh max spell pts
		actor.mana = actor:setMaxSpellPts()
		actor.max_mana = actor:setMaxSpellPts()
		end
	end,
}
