--Veins of the Earth
--Zireael 2013-2015

load("/data/birth/prestige.lua")

-- Classes
newBirthDescriptor {
	type = 'class',
	name = 'Barbarian',
	getSkillPoints = function(self, t)
		return 4
	end,
	getClassSkills = function(self, t)
		skills = "Climb, Craft, Handle Animal, Intimidate, Jump, Listen, Ride, Swim, Survival."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Raging warriors of the wilds."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#+33% movement speed. 12 hit points per level, BAB +1, Fort +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +1, Fort +0.5, Will +0.33, Ref +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#STR 13#LAST# to multiclass to this class."

		return d
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
		--Prevent another game-breaking combo; why would anyone want a fighter/spellcaster is beyond me
		background =
		{
			['Magical thief'] = "disallow",
			['Spellcaster'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Barbarian"] and actor.descriptor.class == "Barbarian" then return true end

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
	type = 'class',
	name = 'Bard',
	getSkillPoints = function(self, t)
		return 6
	end,
	getClassSkills = function(self, t)
		skills = "Appraise, Balance, Bluff, Climb, Concentration, Craft, Diplomacy, Decipher Script, Escape Artist, Hide, Intuition, Jump, Knowledge, Listen, Move Silently, Pick Pocket, Sense Motive, Swim, Spellcraft, Survival, Tumble, Use Magic."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Musicians and gentlefolk."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#6 hit points per level, BAB +0, Ref +2, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.75, Fort +0.33, Ref +0.5,  Will +0.5. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#CHA 13#LAST# to multiclass to this class."

		return d
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Bard"] and actor.descriptor.class == "Bard" then return true end

		if actor:getCha() >= 13 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "arcane") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
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
			end

			actor:learnTalentType("abjuration")
			actor:learnTalentType("conjuration")
			actor:learnTalentType("divination")
			actor:learnTalentType("enchantment")
			actor:learnTalentType("illusion")
			actor:learnTalentType("transmutation")
			actor:learnTalentType("evocation")
			actor:learnTalentType("necromancy")
			actor:learnTalentType("arcane_divine")

			descriptor.learn_all_spells_of_level(actor, 0)
			descriptor.learn_all_spells_of_level(actor, 1)

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
			descriptor.learn_all_spells_of_level(actor, spell_level)
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
	type = 'class',
	name = 'Cleric',
	getSkillPoints = function(self, t)
		return 4
	end,
	getClassSkills = function(self, t)
		skills = "Concentration, Craft, Diplomacy, Heal, Intuition, Knowledge, Spellcraft."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Clerics are masters of healing."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#8 hit points per level, BAB +0, Fort +2, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.75, Will +0.5, Fort +0.5, Ref +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#WIS 13#LAST# to multiclass to this class."

		return d
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Cleric"] and actor.descriptor.class == "Cleric" then return true end

		if actor:getWis() >= 13 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "divine") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
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
			end

			actor:learnTalentType("abjuration_divine", true)
			actor:learnTalentType("conjuration_divine", true)
			actor:learnTalentType("divination_divine", true)
			actor:learnTalentType("enchantment_divine", true)
			actor:learnTalentType("evocation_divine", true)
			actor:learnTalentType("necromancy_divine", true)
			actor:learnTalentType("transmutation_divine", true)

			actor:learnTalentType("arcane_divine", true)

			descriptor.learn_all_spells_of_level(actor, 0)
			descriptor.learn_all_spells_of_level(actor, 1)


			actor:learnTalent(actor.T_LAY_ON_HANDS, true)
			actor:learnTalent(actor.T_TURN_UNDEAD, true)


			actor:learnTalentType("cleric/cleric", true)

				if actor == game.player then

                --Domain selection
                if actor:hasDescriptor{deity="Aiswin"} then
                game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Knowledge", desc=""},
                {name="Night", desc=""},
                {name="Planning", desc=""},
                {name="Retribution", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Knowledge" then end
                    if result == "Night" then end
                    if result == "Planning" then end
                    if result == "Retribution" then end
                    if result == "Trickery" then end
                end))

                end

                if actor:hasDescriptor{deity="Asherath"} then
                 game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Knowledge", desc=""},
                {name="Night", desc=""},
                {name="Planning", desc=""},
                {name="Retribution", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Knowledge" then end
                    if result == "Night" then end
                    if result == "Planning" then end
                    if result == "Retribution" then end
                    if result == "Trickery" then end
                end))

                end

                if actor:hasDescriptor{deity="Ekliazeh"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Craft", desc=""},
                {name="Community", desc=""},
                {name="Earth", desc=""},
                {name="Law", desc=""},
                {name="Strength", desc=""},
                {name="Protection", desc=""},
                },
                function(result)
                    if result == "Craft" then end
                    if result == "Community" then end
                    if result == "Earth" then end
                    if result == "Law" then end
                    if result == "Strength" then end
                    if result == "Protection" then end
                end))

                end

                if actor:hasDescriptor{deity="Erich"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Domination", desc=""},
                {name="Guardian", desc=""},
                {name="Law", desc=""},
                {name="Nobility", desc=""},
                {name="Protection", desc=""},
                {name="War", desc=""},
                },
                function(result)
                    if result == "Domination" then end
                    if result == "Guardian" then end
                    if result == "Law" then end
                    if result == "Nobility" then end
                    if result == "Protection" then end
                    if result == "War" then end
                end))

                end

                if actor:hasDescriptor{deity="Essiah"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Beauty", desc=""},
                {name="Good", desc=""},
                {name="Liberation", desc=""},
                {name="Luck", desc=""},
                {name="Passion", desc=""},
                {name="Travel", desc=""},
                },
                function(result)
                    if result == "Beauty" then end
                    if result == "Good" then end
                    if result == "Liberation" then end
                    if result == "Luck" then end
                    if result == "Passion" then end
                    if result == "Travel" then end
                end))

                end

                if actor:hasDescriptor{deity="Hesani"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Healing", desc=""},
                {name="Magic", desc=""},
                {name="Succor", desc=""},
                {name="Sun", desc=""},
                {name="Weather", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Healing" then end
                    if result == "Magic" then end
                    if result == "Succor" then end
                    if result == "Sun" then end
                    if result == "Weather" then end
                end))
                end

                if actor:hasDescriptor{deity="Immotian"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Community", desc=""},
                {name="Fire", desc=""},
                {name="Knowledge", desc=""},
                {name="Law", desc=""},
                {name="Protection", desc=""},
                {name="Succor", desc=""},
                },
                function(result)
                    if result == "Community" then end
                    if result == "Fire" then end
                    if result == "Knowledge" then end
                    if result == "Law" then end
                    if result == "Protection" then end
                    if result == "Succor" then end
                end))

                end

                if actor:hasDescriptor{deity="Khasrach"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Destruction", desc=""},
                {name="Hatred", desc=""},
                {name="Mysticism", desc=""},
                {name="Strength", desc=""},
                {name="Pain", desc=""},
                {name="War", desc=""},
                },
                function(result)
                    if result == "Destruction" then end
                    if result == "Hatred" then end
                    if result == "Mysticism" then end
                    if result == "Strength" then end
                    if result == "Pain" then end
                    if result == "War" then end
                end))

                end

                if actor:hasDescriptor{deity="Kysul"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Good", desc=""},
                {name="Mysticism", desc=""},
                {name="Planning", desc=""},
                {name="Slime", desc=""},
                {name="Water", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Good" then end
                    if result == "Mysticism" then end
                    if result == "Planning" then end
                    if result == "Slime" then end
                    if result == "Water" then end
                end))

                end

                if actor:hasDescriptor{deity="Maeve"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Beauty", desc=""},
                {name="Chaos", desc=""},
                {name="Domination", desc=""},
                {name="Magic", desc=""},
                {name="Moon", desc=""},
                {name="Nobility", desc=""},
                },
                function(result)
                    if result == "Beauty" then end
                    if result == "Chaos" then end
                    if result == "Domination" then end
                    if result == "Magic" then end
                    if result == "Moon" then end
                    if result == "Nobility" then end
                end))

                end

                if actor:hasDescriptor{deity="Mara"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Beauty", desc=""},
                {name="Death", desc=""},
                {name="Good", desc=""},
                {name="Healing", desc=""},
                {name="Night", desc=""},
                {name="Succor", desc=""},
                },
                function(result)
                    if result == "Beauty" then end
                    if result == "Death" then end
                    if result == "Good" then end
                    if result == "Healing" then end
                    if result == "Night" then end
                    if result == "Succor" then end
                end))

                end

                if actor:hasDescriptor{deity="Sabin"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Air", desc=""},
                {name="Chaos", desc=""},
                {name="Destruction", desc=""},
                {name="Luck", desc=""},
                {name="Time", desc=""},
                {name="Weather", desc=""},
                },
                function(result)
                    if result == "Air" then end
                    if result == "Chaos" then end
                    if result == "Destruction" then end
                    if result == "Luck" then end
                    if result == "Time" then end
                    if result == "Weather" then end
                end))

                end

                if actor:hasDescriptor{deity="Semirath"} then
                game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Chaos", desc=""},
                {name="Good", desc=""},
                {name="Liberation", desc=""},
                {name="Luck", desc=""},
                {name="Retribution", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Chaos" then end
                    if result == "Good" then end
                    if result == "Liberation" then end
                    if result == "Luck" then end
                    if result == "Retribution" then end
                    if result == "Trickery" then end
                end))

                end

                if actor:hasDescriptor{deity="Multitude"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Blood", desc=""},
                {name="Chaos", desc=""},
                {name="Destruction", desc=""},
                {name="Death", desc=""},
                {name="Evil", desc=""},
                {name="Pain", desc=""},
                },
                function(result)
                    if result == "Blood" then end
                    if result == "Chaos" then end
                    if result == "Destruction" then end
                    if result == "Death" then end
                    if result == "Evil" then end
                    if result == "Pain" then end
                end))

                end

                if actor:hasDescriptor{deity="Xavias"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Craft", desc=""},
                {name="Fate", desc=""},
                {name="Knowledge", desc=""},
                {name="Magic", desc=""},
                {name="Mysticism", desc=""},
                {name="Planning", desc=""},
                },
                function(result)
                    if result == "Craft" then end
                    if result == "Fate" then end
                    if result == "Knowledge" then end
                    if result == "Magic" then end
                    if result == "Mysticism" then end
                    if result == "Planning" then end
                end))

                end

                if actor:hasDescriptor{deity="Xel"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Community", desc=""},
                {name="Death", desc=""},
                {name="Evil", desc=""},
                {name="Pain", desc=""},
                {name="Nature", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Community" then end
                    if result == "Death" then end
                    if result == "Evil" then end
                    if result == "Pain" then end
                    if result == "Nature" then end
                    if result == "Trickery" then end
                end))
                end

                if actor:hasDescriptor{deity="Zurvash"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Animal", desc=""},
                {name="Domination", desc=""},
                {name="Night", desc=""},
                {name="Passion", desc=""},
                {name="Pain", desc=""},
                {name="Strength", desc=""},
                },
                function(result)
                    if result == "Animal" then end
                    if result == "Domination" then end
                    if result == "Night" then end
                    if result == "Passion" then end
                    if result == "Pain" then end
                    if result == "Strength" then end
                end))

                end

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
			descriptor.learn_all_spells_of_level(actor, spell_level)
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
	type = 'class',
	name = 'Druid',
	getSkillPoints = function(self, t)
		return 4
	end,
	getClassSkills = function(self, t)
		skills = "Concentration, Craft, Diplomacy, Handle Animal, Heal, Intuition, Knowledge, Listen, Ride, Spot, Swim, Spellcraft, Survival."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Clerics of nature."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#8 hit points per level, BAB +0, Fort +2, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.75, Will +0.5, Fort +0.5, Ref +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#WIS 13#LAST# to multiclass to this class."

		return d
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
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
		if actor.classes and actor.classes["Druid"] and actor.descriptor.class == "Druid" then return true end

		if actor:getWis() >= 13 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "divine") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
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
			end

			actor:learnTalentType("divine")
			actor:learnTalentType("arcane_divine", true)

			descriptor.learn_all_spells_of_level(actor, 0)
			descriptor.learn_all_spells_of_level(actor, 1)

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
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
				if t.type[1] == "divine" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
					actor:learnTalent(t.id)
				end
			end
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
	type = 'class',
	name = 'Fighter',
	getSkillPoints = function(self, t)
		return 2
	end,
	getClassSkills = function(self, t)
		skills = "Climb, Craft, Handle Animal, Intimidate, Jump, Ride, Swim."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Simple fighters, they hack away with their trusty weapon."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#10 hit points per level, BAB +1, Fort +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +1, Fort +0.5, Ref +0.33, Will +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#STR 13#LAST# to multiclass to this class."

		return d
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
		if actor.classes and actor.classes["Fighter"] and actor.descriptor.class == "Fighter" then return true end

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
        type = 'class',
        name = 'Monk',
		getSkillPoints = function(self, t)
			return 4
		end,
		getClassSkills = function(self, t)
			skills = "Balance, Climb, Concentration, Craft, Diplomacy, Escape Artist, Hide, Jump, Knowledge, Listen, Move Silently, Sense Motive, Spot, Swim, Tumble."

			return skills
		end,
		desc = function(self, t)
			local d
			local desc = "#ORANGE#Unarmed and without armor, they are nevertheless fearsome warriors."
			local skills = t.getSkillPoints(self, t)
			local skills_first = skills*4
			d = desc.."\n\n #LIGHT_BLUE#Class skills: "
			local skills_list = t.getClassSkills(self, t)
			d = d..skills_list.."\n\n"
			d = d.."#WHITE#8 hit points per level, BAB +0, Fort +2 Ref +2 Will +2 at first class level. "
			d = d..skills_first.." skill points at 1st character level.\n\n"
			d = d.."BAB +1, Fort +0.5, Will +0.5, Ref +0.5. "..skills.." skill points per level.\n\n"
			d = d.."#GOLD#WIS 13#LAST# to multiclass to this class."

			return d
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
                --Prevent another game-breaking combo; why would anyone want a fighter/spellcaster is beyond me
                background =
                {
                        ['Magical thief'] = "disallow",
                        ['Spellcaster'] = "disallow",
                        ['Two weapon fighter'] = 'disallow',
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
            if actor.classes and actor.classes["Monk"] and actor.descriptor.class == "Monk" then return true end

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
        type = 'class',
        name = 'Paladin',
		getSkillPoints = function(self, t)
			return 2
		end,
		getClassSkills = function(self, t)
			skills = "Concentration, Craft, Diplomacy, Handle Animal, Heal, Knowledge, Ride, Sense Motive."

			return skills
		end,
		desc = function(self, t)
			local d
			local desc = "#ORANGE#Holy warriors of the deities of good and law."
			local skills = t.getSkillPoints(self, t)
			local skills_first = skills*4
			d = desc.."\n\n #LIGHT_BLUE#Class skills: "
			local skills_list = t.getClassSkills(self, t)
			d = d..skills_list.."\n\n"
			d = d.."#WHITE#8 hit points per level, BAB +1, Fort +2 at first class level. "
			d = d..skills_first.." skill points at 1st character level.\n\n"
			d = d.."BAB +1, Fort +0.5, Will +0.33, Ref +0.33. "..skills.." skill points per level.\n\n"
			d = d.."#GOLD#WIS 13#LAST# to multiclass to this class."

			return d
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
                --Prevent another game-breaking combo; why would anyone want a fighter/spellcaster is beyond me
                background =
                {
                        ['Magical thief'] = "disallow",
                        ['Spellcaster'] = "disallow",
                        ['Two weapon fighter'] = 'disallow',
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
            if actor.classes and actor.classes["Paladin"] and actor.descriptor.class == "Paladin" then return true end

            if actor:getWis() >= 13 then return true end
            return false
        end,
        learn_all_spells_of_level = function(actor, level)
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
				tt = actor:getTalentTypeFrom(t.type[1])
				if actor:spellIsKind(t, "divine") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
					actor:learnTalent(t.id)
				end
			end
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
				descriptor.learn_all_spells_of_level(actor, spell_level)
			end

			--Level-specific bonuses
            if level == 4 then actor:learnTalent(actor.T_TURN_UNDEAD, true) end
            if level == 5 then
            	--Don't give spellbook to NPCs
				if actor == game.player then
            	--Get spellbook
            	actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
            	end

            	actor:learnTalentType("divine")

            	descriptor.learn_all_spells_of_level(actor, 0)
				descriptor.learn_all_spells_of_level(actor, 1)

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
	type = 'class',
	name = 'Ranger',
	getSkillPoints = function(self, t)
		return 6
	end,
	getClassSkills = function(self, t)
		skills = "Climb, Concentration, Craft, Handle Animal, Heal, Hide, Intuition, Jump, Knowledge, Listen, Move Silently, Ride, Search, Spot, Swim, Survival."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Rangers are capable archers but are also trained in hand to hand combat and divine magic."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#8 hit points per level, BAB +1, Fort +2, Ref +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +1, Fort +0.5, Ref +0.5, Will +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#STR 13#LAST# to multiclass to this class."

		return d
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
		--Prevent another game-breaking combo
		background =
		{
			['Magical thief'] = "disallow",
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Ranger"] and actor.descriptor.class == "Ranger" then return true end

		if actor:getStr() >= 13 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "divine") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
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
			descriptor.learn_all_spells_of_level(actor, spell_level)
		end


		if level == 5 then
			--Don't give spellbook to NPCs
			if actor == game.player then
			--Get spellbook
            actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
        	end

			actor:learnTalentType("divine")

			descriptor.learn_all_spells_of_level(actor, 0)
			descriptor.learn_all_spells_of_level(actor, 1)
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
	type = 'class',
	name = 'Rogue',
	getSkillPoints = function(self, t)
		return 8
	end,
	getClassSkills = function(self, t)
		skills = "Appraise, Balance, Bluff, Climb, Craft, Diplomacy, Decipher Script, Disable Device, Escape Artist, Hide, Intuition, Jump, Knowledge, Listen, Move Silently, Open Lock, Pick Pocket, Search, Sense Motive, Spot, Tumble, Use Magic."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Rogues are masters of tricks."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#6 hit points per level, BAB +0, Ref +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.75, Ref +0.5, Fort +0.33, Will +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#DEX 13#LAST# to multiclass to this class."

		return d
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Rogue"] and actor.descriptor.class == "Rogue" then return true end

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

newBirthDescriptor {
	type = 'class',
	name = 'Sorcerer',
	rarity = 6,
	getSkillPoints = function(self, t)
		return 2
	end,
	getClassSkills = function(self, t)
		skills = "Bluff, Concentration, Craft, Diplomacy, Intuition, Knowledge, Sense Motive, Spellcraft."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Masters of arcane magic."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#4 hit points per level, BAB +0, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.5, Will +0.5, Ref +0.33, Fort +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#CHA 16#LAST# to multiclass to this class."

		return d
	end,
	copy = {
		resolvers.inventory {
			id=true,
			{ name="light crossbow", ego_chance=-1000},
			{ name="bolts", ego_chance=-1000},
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Sorcerer"] and actor.descriptor.class == "Sorcerer" then return true end

		if actor:getCha() >= 16 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "arcane") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
		--	actor:attr("innate_casting_arcane", 1)

			actor:attr("will_save", 2)

			actor:learnTalentType("abjuration")
			actor:learnTalentType("conjuration")
			actor:learnTalentType("divination")
			actor:learnTalentType("enchantment")
			actor:learnTalentType("illusion")
			actor:learnTalentType("transmutation")
			actor:learnTalentType("evocation")
			actor:learnTalentType("necromancy")
			actor:learnTalentType("arcane_divine", true)

            --Get the spell points
            actor:learnTalent(actor.T_SPELL_POINTS_POOL, true)

			actor:attr("max_life", 4 + (actor:getCon()-10)/2)

			descriptor.learn_all_spells_of_level(actor, 0)
			descriptor.learn_all_spells_of_level(actor, 1)
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

		-- At each even level past level 2 we gain a spell level
		if level % 2 == 0 then
			descriptor.learn_all_spells_of_level(actor, math.floor(level / 2))
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Wizard',
	getSkillPoints = function(self, t)
		return 4
	end,
	getClassSkills = function(self, t)
		skills = "Concentration, Craft, Intuition, Knowledge, Sense Motive, Spellcraft."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#Masters of arcane magic."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#4 hit points per level, BAB +0, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.5, Will +0.5, Ref +0.33, Fort +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#INT 16#LAST# to multiclass to this class."

		return d
	end,
	rarity = 5,
	copy = {
		resolvers.inventory {
			id=true,
			{ name="light crossbow", ego_chance=-1000},
			{ name="bolts", ego_chance=-1000},
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
		if actor.classes and actor.classes["Wizard"] and actor.descriptor.class == "Wizard" then return true end
		if actor:getInt() >= 16 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "arcane") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then
			--Don't give spellbook to NPCs
			if actor == game.player then
			actor:learnTalent(actor.T_SHOW_SPELLBOOK)
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
					actor:learnTalentType("abjuration")
					if result ~= "Abjuration" and result ~= "Evocation" and result ~= "Transmutation" then actor:learnTalentType("conjuration") end
					if result ~= "Necromancy" then actor:learnTalentType("divination") end
					if result ~= "Illusion" then actor:learnTalentType("enchantment") end
					actor:learnTalentType("evocation")
					if result ~= "Divination" and result ~= "Enchantment" then actor:learnTalentType("illusion") end
					actor:learnTalentType("necromancy")
					if result ~= "Conjuration" then actor:learnTalentType("transmutation") end

					-- Now that we know our schools, learn spells
					descriptor.learn_all_spells_of_level(actor, 0)
					descriptor.learn_all_spells_of_level(actor, 1)
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
			descriptor.learn_all_spells_of_level(actor, math.floor(level / 2) + 1)
		end
	end,
}


--Non-standard classes
newBirthDescriptor {
	type = 'class',
	name = 'Warlock',
	getSkillPoints = function(self, t)
		return 2
	end,
	getClassSkills = function(self, t)
		skills = "Concentration, Craft, Intuition, Knowledge, Sense Motive, Spellcraft."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#A spellcaster who needs no weapon."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#6 hit points per level, BAB +0, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.5, Will +0.5, Ref +0.33, Fort +0.33. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#CHA 13#LAST# to multiclass to this class."

		return d
	end,
	rarity = 10,
	copy = {
	},
	descriptor_choices =
	{
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
	if actor.classes and actor.classes["Warlock"] and actor.descriptor.class == "Warlock" then return true end

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


--Non-standard class
newBirthDescriptor {
	type = 'class',
	name = 'Shaman',
	getSkillPoints = function(self, t)
		return 4
	end,
	getClassSkills = function(self, t)
		skills = "Concentration, Craft, Diplomacy, Heal, Intuition, Knowledge, Spellcraft."

		return skills
	end,
	desc = function(self, t)
		local d
		local desc = "#ORANGE#A divine spellcaster who does not need to prepare spells."
		local skills = t.getSkillPoints(self, t)
		local skills_first = skills*4
		d = desc.."\n\n #LIGHT_BLUE#Class skills: "
		local skills_list = t.getClassSkills(self, t)
		d = d..skills_list.."\n\n"
		d = d.."#WHITE#8 hit points per level, BAB +0, Fort +2, Will +2 at first class level. "
		d = d..skills_first.." skill points at 1st character level.\n\n"
		d = d.."BAB +0.5, Will +0.5, Ref +0.33, Fort +0.5. "..skills.." skill points per level.\n\n"
		d = d.."#GOLD#CHA 13#LAST# to multiclass to this class."

		return d
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
		--Prevent game-breaking combos due to 1 BAB requirement of some feats
		background =
		{
			['Master of one'] = "disallow",
			['Fencing duelist'] = "disallow",
			['Exotic fighter'] = "disallow",
			--Prevent another game-breaking combo
			['Magical thief'] = "disallow",
			['Two weapon fighter'] = 'disallow',
		}
	},
	can_level = function(actor)
	if actor.classes and actor.classes["Shaman"] and actor.descriptor.class == "Shaman" then return true end

		if actor:getCha() >= 13 then return true end
		return false
	end,
	learn_all_spells_of_level = function(actor, level)
		for tid, _ in pairs(actor.talents_def) do
			t = actor:getTalentFromId(tid)
			tt = actor:getTalentTypeFrom(t.type[1])
			if actor:spellIsKind(t, "divine") and t.level == level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
				actor:learnTalent(t.id)
			end
		end
	end,
	on_level = function(actor, level, descriptor)
		if level == 1 then

		--	actor:attr("innate_casting_divine", 1)

			actor:attr("will_save", 2)
			actor:attr("fortitude_save", 2)
			actor:attr("max_life", 4 + (actor:getCon()-10)/2)

			actor:learnTalentType("divine")

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

            --Get the spell points
            actor:learnTalent(actor.T_SPELL_POINTS_POOL, true)

			descriptor.learn_all_spells_of_level(actor, 0)
			descriptor.learn_all_spells_of_level(actor, 1)

			if actor == game.player then

                --Domain selection
                if actor:hasDescriptor{deity="Aiswin"} then
                game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Knowledge", desc=""},
                {name="Night", desc=""},
                {name="Planning", desc=""},
                {name="Retribution", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Knowledge" then end
                    if result == "Night" then end
                    if result == "Planning" then end
                    if result == "Retribution" then end
                    if result == "Trickery" then end
                end))

                end

                if actor:hasDescriptor{deity="Asherath"} then
                 game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Knowledge", desc=""},
                {name="Night", desc=""},
                {name="Planning", desc=""},
                {name="Retribution", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Knowledge" then end
                    if result == "Night" then end
                    if result == "Planning" then end
                    if result == "Retribution" then end
                    if result == "Trickery" then end
                end))

                end

                if actor:hasDescriptor{deity="Ekliazeh"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Craft", desc=""},
                {name="Community", desc=""},
                {name="Earth", desc=""},
                {name="Law", desc=""},
                {name="Strength", desc=""},
                {name="Protection", desc=""},
                },
                function(result)
                    if result == "Craft" then end
                    if result == "Community" then end
                    if result == "Earth" then end
                    if result == "Law" then end
                    if result == "Strength" then end
                    if result == "Protection" then end
                end))

                end

                if actor:hasDescriptor{deity="Erich"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Domination", desc=""},
                {name="Guardian", desc=""},
                {name="Law", desc=""},
                {name="Nobility", desc=""},
                {name="Protection", desc=""},
                {name="War", desc=""},
                },
                function(result)
                    if result == "Domination" then end
                    if result == "Guardian" then end
                    if result == "Law" then end
                    if result == "Nobility" then end
                    if result == "Protection" then end
                    if result == "War" then end
                end))

                end

                if actor:hasDescriptor{deity="Essiah"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Beauty", desc=""},
                {name="Good", desc=""},
                {name="Liberation", desc=""},
                {name="Luck", desc=""},
                {name="Passion", desc=""},
                {name="Travel", desc=""},
                },
                function(result)
                    if result == "Beauty" then end
                    if result == "Good" then end
                    if result == "Liberation" then end
                    if result == "Luck" then end
                    if result == "Passion" then end
                    if result == "Travel" then end
                end))

                end

                if actor:hasDescriptor{deity="Hesani"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Healing", desc=""},
                {name="Magic", desc=""},
                {name="Succor", desc=""},
                {name="Sun", desc=""},
                {name="Weather", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Healing" then end
                    if result == "Magic" then end
                    if result == "Succor" then end
                    if result == "Sun" then end
                    if result == "Weather" then end
                end))
                end

                if actor:hasDescriptor{deity="Immotian"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Community", desc=""},
                {name="Fire", desc=""},
                {name="Knowledge", desc=""},
                {name="Law", desc=""},
                {name="Protection", desc=""},
                {name="Succor", desc=""},
                },
                function(result)
                    if result == "Community" then end
                    if result == "Fire" then end
                    if result == "Knowledge" then end
                    if result == "Law" then end
                    if result == "Protection" then end
                    if result == "Succor" then end
                end))

                end

                if actor:hasDescriptor{deity="Khasrach"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Destruction", desc=""},
                {name="Hatred", desc=""},
                {name="Mysticism", desc=""},
                {name="Strength", desc=""},
                {name="Pain", desc=""},
                {name="War", desc=""},
                },
                function(result)
                    if result == "Destruction" then end
                    if result == "Hatred" then end
                    if result == "Mysticism" then end
                    if result == "Strength" then end
                    if result == "Pain" then end
                    if result == "War" then end
                end))

                end

                if actor:hasDescriptor{deity="Kysul"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Fate", desc=""},
                {name="Good", desc=""},
                {name="Mysticism", desc=""},
                {name="Planning", desc=""},
                {name="Slime", desc=""},
                {name="Water", desc=""},
                },
                function(result)
                    if result == "Fate" then end
                    if result == "Good" then end
                    if result == "Mysticism" then end
                    if result == "Planning" then end
                    if result == "Slime" then end
                    if result == "Water" then end
                end))

                end

                if actor:hasDescriptor{deity="Maeve"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Beauty", desc=""},
                {name="Chaos", desc=""},
                {name="Domination", desc=""},
                {name="Magic", desc=""},
                {name="Moon", desc=""},
                {name="Nobility", desc=""},
                },
                function(result)
                    if result == "Beauty" then end
                    if result == "Chaos" then end
                    if result == "Domination" then end
                    if result == "Magic" then end
                    if result == "Moon" then end
                    if result == "Nobility" then end
                end))

                end

                if actor:hasDescriptor{deity="Mara"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Beauty", desc=""},
                {name="Death", desc=""},
                {name="Good", desc=""},
                {name="Healing", desc=""},
                {name="Night", desc=""},
                {name="Succor", desc=""},
                },
                function(result)
                    if result == "Beauty" then end
                    if result == "Death" then end
                    if result == "Good" then end
                    if result == "Healing" then end
                    if result == "Night" then end
                    if result == "Succor" then end
                end))

                end

                if actor:hasDescriptor{deity="Sabin"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Air", desc=""},
                {name="Chaos", desc=""},
                {name="Destruction", desc=""},
                {name="Luck", desc=""},
                {name="Time", desc=""},
                {name="Weather", desc=""},
                },
                function(result)
                    if result == "Air" then end
                    if result == "Chaos" then end
                    if result == "Destruction" then end
                    if result == "Luck" then end
                    if result == "Time" then end
                    if result == "Weather" then end
                end))

                end

                if actor:hasDescriptor{deity="Semirath"} then
                game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Chaos", desc=""},
                {name="Good", desc=""},
                {name="Liberation", desc=""},
                {name="Luck", desc=""},
                {name="Retribution", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Chaos" then end
                    if result == "Good" then end
                    if result == "Liberation" then end
                    if result == "Luck" then end
                    if result == "Retribution" then end
                    if result == "Trickery" then end
                end))

                end

                if actor:hasDescriptor{deity="Multitude"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Blood", desc=""},
                {name="Chaos", desc=""},
                {name="Destruction", desc=""},
                {name="Death", desc=""},
                {name="Evil", desc=""},
                {name="Pain", desc=""},
                },
                function(result)
                    if result == "Blood" then end
                    if result == "Chaos" then end
                    if result == "Destruction" then end
                    if result == "Death" then end
                    if result == "Evil" then end
                    if result == "Pain" then end
                end))

                end

                if actor:hasDescriptor{deity="Xavias"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Craft", desc=""},
                {name="Fate", desc=""},
                {name="Knowledge", desc=""},
                {name="Magic", desc=""},
                {name="Mysticism", desc=""},
                {name="Planning", desc=""},
                },
                function(result)
                    if result == "Craft" then end
                    if result == "Fate" then end
                    if result == "Knowledge" then end
                    if result == "Magic" then end
                    if result == "Mysticism" then end
                    if result == "Planning" then end
                end))

                end

                if actor:hasDescriptor{deity="Xel"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Community", desc=""},
                {name="Death", desc=""},
                {name="Evil", desc=""},
                {name="Pain", desc=""},
                {name="Nature", desc=""},
                {name="Trickery", desc=""},
                },
                function(result)
                    if result == "Community" then end
                    if result == "Death" then end
                    if result == "Evil" then end
                    if result == "Pain" then end
                    if result == "Nature" then end
                    if result == "Trickery" then end
                end))
                end

                if actor:hasDescriptor{deity="Zurvash"} then
                    game:registerDialog(require('mod.dialogs.GetChoice').new("Choose your domains",{
                {name="Animal", desc=""},
                {name="Domination", desc=""},
                {name="Night", desc=""},
                {name="Passion", desc=""},
                {name="Pain", desc=""},
                {name="Strength", desc=""},
                },
                function(result)
                    if result == "Animal" then end
                    if result == "Domination" then end
                    if result == "Night" then end
                    if result == "Passion" then end
                    if result == "Pain" then end
                    if result == "Strength" then end
                end))

                end

            end

		--	end

		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			descriptor.learn_all_spells_of_level(actor, spell_level)
		end

		--Level >1, generic bonuses
		actor:attr("will_save", 0.5)
		actor:attr("combat_bab", 0.5)
		actor:attr("fortitude_save", 0.5)
		actor:attr("reflex_save", 0.33)

		actor:attr("max_life", 6 + (actor:getCon()-10)/2)

		--Gain a caster level every level
		actor:incCasterLevel("divine", 1)
		end
	end,
}
