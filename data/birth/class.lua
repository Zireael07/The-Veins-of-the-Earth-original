--Veins of the Earth
--Zireael

local help = '#GOLD#BAB#SANDY_BROWN# = Base Attack Bonus, required by some feats\n #GOLD#Fort#LAST#, #GOLD#Ref#LAST# and #GOLD#Will#LAST# are saving throws, used to protect you from danger (spells, terrain effects). The type of the saving throw used depends on the spell or effect involved.\n\n'

-- Classes
newBirthDescriptor {
	type = 'class',
	name = 'Barbarian',
	desc = help..'#ORANGE#Raging warriors of the wilds.\n\n #WHITE#+33% movement speed. 12 hit points per level, BAB +1, Fort +2 at first class level. 16 skill points at 1st character level.\n\n BAB +1, Fort +1, Will +0.5, Ref +0.5, 4 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="iron battleaxe", ego_chance=-1000 },
			{ name="chain mail", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 12, --4x skill points at 1st character level
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) +2
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.skill_point = (actor.skill_point or 0) + 4

			actor.movement_speed_bonus = 0.33

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_RAGE, true)

			if actor.descriptor.race == "Half-Orc" then
			actor.max_life = actor.max_life + 14
			else
			actor.max_life = actor.max_life + 12 end
		
		else

		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 4
			if actor.descriptor.race == "Half-Orc" then
			--Favored class bonuses
			actor.combat_attack = (actor.combat_attack or 0) + 1
			actor.max_life = actor.max_life + 14
			else
			actor.max_life = actor.max_life + 12 end
		end
	end,
} 

newBirthDescriptor {
	type = 'class',
	name = 'Bard',
	desc = help..'#ORANGE#Musicians and gentlefolk.\n\n #WHITE#6 hit points per level, BAB +0, Ref +2, Fort +2 at first class level. 24 skill points at 1st character level.\n\n BAB +0.75, Ref +1, Fort +1, Will +0.5, 6 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="rapier", ego_chance=-1000 },
			{ name="chain shirt", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 18, --4x skill points at 1st level
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 6

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
			actor:learnTalent(actor.T_BARDIC_CLW, true)
			actor:learnTalent(actor.T_SUMMON_CREATURE_I, true)
			actor:learnTalent(actor.T_SLEEP, true)
			actor:learnTalent(actor.T_GREASE, true)

			actor:learnTalentType("arcane/arcane", true)

			if actor.descriptor.race == "Half-Elf" or actor.descriptor.race == "Gnome" then
			actor.max_life = actor.max_life + 8
			else
			actor.max_life = actor.max_life + 6 end
		
		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
		        if t.type[1] == "arcane/arcane" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
		        	actor:learnTalent(t.id)
		        end
		    end
		end
		
		actor.combat_bab = (actor.combat_bab or 0) + 0.75
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 6
		if actor.descriptor.race == "Half-Elf" or actor.descriptor.race == "Gnome" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 8
		else
		actor.max_life = actor.max_life + 6 end
		end
	end,
} 


newBirthDescriptor {
	type = 'class',
	name = 'Cleric',
	desc = help..'#ORANGE#Clerics are masters of healing.\n\n #WHITE#8 hit points per level. Fort +2, Will +2 at first class level. 8 skill points at 1st character level.\n\n BAB +0.75, Will +1, Fort +1, Ref +0.5,  2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="heavy mace", ego_chance=-1000 },
			{ name="chain mail", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 6, --4x skill points at 1st level
	},
	descriptor_choices = {
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.will_save = (actor.will_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 2

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_HEAVY_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
			actor:learnTalent(actor.T_CURE_LIGHT_WOUNDS, true)
			actor:learnTalent(actor.T_INFLICT_LIGHT_WOUNDS, true)

			actor:learnTalent(actor.T_LAY_ON_HANDS, true)
			actor:learnTalent(actor.T_TURN_UNDEAD, true)

			actor:learnTalentType("divine/divine", true)
			actor:learnTalentType("cleric/cleric", true)


			if (actor.descriptor.race == "Drow" and actor.descriptor.sex == "Female") or actor.descriptor.race == "Half-Drow" then
			actor.max_life = actor.max_life + 10
			else
			actor.max_life = actor.max_life + 8 end
			
		else
		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
		        if t.type[1] == "divine/divine" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
		        	actor:learnTalent(t.id)
		        end
		    end
		end


		actor.will_save = (actor.will_save or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.combat_bab = (actor.combat_bab or 0) + 0.75
		actor.skill_point = (actor.skill_point or 0) + 2

		if (actor.descriptor.race == "Drow" and actor.descriptor.sex == "Female") or actor.descriptor.race == "Half-Drow" then
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 1
		else
		actor.max_life = actor.max_life + 8 end
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Druid',
	desc = help..'#ORANGE#Clerics of nature.\n\n #WHITE#8 hit points per level. Fort +2 Will +2 at first class level. 8 skill points at 1st character level.\n\n BAB +0.75, Will +1, Fort +1, Ref +0.5,  2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="quarterstaff", ego_chance=-1000 },
			{ name="padded armor", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 12, --4x skill points at 1st level
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
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.will_save = (actor.will_save or 0) + 2

			actor.max_life = actor.max_life + 8
			actor.skill_point = (actor.skill_point or 0) + 2

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)

			actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
			actor:learnTalent(actor.T_CURE_LIGHT_WOUNDS, true)

			actor:learnTalentType("divine/divine", true)
		
		else
		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
		        if t.type[1] == "divine/divine" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
		        	actor:learnTalent(t.id)
		        end
		    end
		end

		actor.will_save = (actor.will_save or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.combat_bab = (actor.combat_bab or 0) + 0.75

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 4
		end
	end,
}   


newBirthDescriptor {
	type = 'class',
	name = 'Fighter',
	desc = help..'#ORANGE#Simple fighters, they hack away with their trusty weapon.\n\n #WHITE#10 hit points per level, BAB +1, Fort +2 at 1st class level. 8 skill points at 1st character level.\n\n BAB +1, Fort +1, Ref +0.5, Will +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword", ego_chance=-1000 },
			{ name="chain mail", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 6, --4x skill points at 1st level
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.skill_point = (actor.skill_point or 0) + 2

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_HEAVY_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)

			if actor.descriptor.race == "Dwarf" or actor.descriptor.race == "Duergar" then
			actor.max_life = actor.max_life + 12
			else
			actor.max_life = actor.max_life + 10 end
		
		else

		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		if actor.descriptor.race == "Dwarf" or actor.descriptor.race == "Duergar" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 12
		end
		actor.max_life = actor.max_life + 10
		actor.skill_point = (actor.skill_point or 0) + 2
		end
	end,
}


newBirthDescriptor {
	type = 'class',
	name = 'Ranger',
	desc = help..'#ORANGE#Rangers are capable archers but are also trained in hand to hand combat and divine magic.\n\n #WHITE#8 hit points per level, BAB +1, Fort +2, Ref +2 at first class level. 24 skill points at 1st character level. \n\n BAB +1, Fort +1, Ref +1, Will +0.5, 6 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword", ego_chance=-1000 },
			{ name="iron dagger", ego_chance=-1000 },
			{ name="studded leather", ego_chance=-1000 },

		},
		resolvers.inventory {
			full_id=true,
			{ name="shortbow", ego_chance=-1000},
			{ name="arrows (20)", ego_chance=-1000 },
		},

	},
	copy_add = {
		skill_point = 18, --4x skill points at 1st level
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 6

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)
			actor:learnTalent(actor.T_MARTIAL_WEAPON_PROFICIENCY, true)

			actor:learnTalent(actor.T_FAVORED_ENEMY, true)
--			actor:learnTalent(actor.T_TWO_WEAPON_FIGHTING, true)

			if actor.descriptor.race == "Elf" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 10	
			else
			actor.max_life = actor.max_life + 8 end
		
		else

		if level == 5 then
			actor:learnTalentType("divine/divine", true)

		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 6
		if actor.descriptor.race == "Elf" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 10
		else
		actor.max_life = actor.max_life + 8 end
		end

		--Learn a new spell tier every 3rd level starting from lvl 5
		if level >= 5 and level % 3 == 0 then
			local spell_level = ((level-5) / 3) + 1
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
		        if t.type[1] == "divine/divine" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
		        	actor:learnTalent(t.id)
		        end
		    end
		end

		actor.combat_bab = (actor.combat_bab or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 6
		if actor.descriptor.race == "Elf" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 10
		else
		actor.max_life = actor.max_life + 8 end
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Rogue',
	desc = help..'#ORANGE#Rogues are masters of tricks.\n\n #WHITE#6 hit points per level, Ref +2 at first class level. 32 skill points at 1st character level.\n\n BAB +0.75, Ref +1, Fort +0.5, Will +0.5, 8 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="light crossbow", ego_chance=-1000 },
			{ name="bolts (10)", ego_chance=-1000 },
			{ name="studded leather", ego_chance=-1000 },
		},
		resolvers.inventory {
			full_id=true,
			{ name="iron dagger", ego_chance=-1000},
		}
	},
	copy_add = {
		skill_point = 24, --4x skill points at 1st level
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.sneak_attack = (actor.sneak_attack or 0) + 1
			actor.skill_point = (actor.skill_point or 0) + 8

			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			if  actor.descriptor.race == "Deep gnome" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 8
			else
			actor.max_life = actor.max_life + 6 end
		
		else

		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.75
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 8
		if actor.descriptor.race == "Deep gnome" then
		--Favored class bonuses
		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.max_life = actor.max_life + 8
		else
		actor.max_life = actor.max_life + 6 end
		end
	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Wizard',
	desc = help..'#ORANGE#Masters of arcane magic.\n\n #WHITE#4 hit points per level, Will +2 at first character level. 8 skill points at 1st class level.\n\n BAB +0.5, Will +1, Ref +0.5, Fort +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="iron dagger", ego_chance=-1000 },

		},
		resolvers.inventory {
			full_id=true,
			{ name="light crossbow", ego_chance=-1000},
			{ name="bolts (10)", ego_chance=-1000},
		}

	},
	copy_add = {
		skill_point = 6, --4x skill points at 1st level
	},
	talents_types = {
		["arcane/arcane"] = {true, 0.0},
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.will_save = (actor.will_save or 0) + 2
			actor.skill_point = (actor.skill_point or 0) + 2

			actor:learnTalent(actor.T_SHOW_SPELLBOOK, true)
			actor:learnTalent(actor.T_ACID_SPLASH, true)
			actor:learnTalent(actor.T_GREASE, true)
			actor:learnTalent(actor.T_MAGIC_MISSILE, true)
			actor:learnTalent(actor.T_BURNING_HANDS, true)
			actor:learnTalent(actor.T_SUMMON_CREATURE_I, true)
			actor:learnTalent(actor.T_SLEEP, true)
			actor:learnTalent(actor.T_BLINDNESS_DEAFNESS, true)

			actor:learnTalentType("arcane/arcane", true)			

			if actor.descriptor.race == "Drow" and actor.descriptor.sex == "Male" then
			--Favored class bonuses
			actor.max_life = actor.max_life + 6
			else
			actor.max_life = actor.max_life + 4 end
		
		else

		--Learn a new spell tier every 3rd level
		if level % 3 == 0 then
			local spell_level = (level / 3) + 1
			for tid, _ in pairs(actor.talents_def) do
				t = actor:getTalentFromId(tid)
		        if t.type[1] == "arcane/arcane" and t.level == spell_level and not actor:knowTalent(tid) and actor:canLearnTalent(t) then
		        	actor:learnTalent(t.id)
		        end
		    end
		end

		actor.will_save = (actor.will_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.skill_point = (actor.skill_point or 0) + 2
		if actor.descriptor.race == "Drow" and actor.descriptor.sex == "Male" then
		--Favored class bonuses
		actor.max_life = actor.max_life + 6
		else
		actor.max_life = actor.max_life + 4 end

		end
	end,
}


--Non-standard classes
newBirthDescriptor {
	type = 'class',
	name = 'Warlock',
	desc = help..'#ORANGE#A spellcaster who needs no weapon.\n\n #WHITE#6 hit points per level, Will +2 at first character level. 8 skill points at 1st class level.\n\n BAB +0.5, Will +1, Ref +0.5, Fort +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword", ego_chance=-1000 },
			{ name="chain shirt", ego_chance=-1000 },
		},
	},
	copy_add = {
		skill_point = 6, --4x skill points at start
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
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.will_save = (actor.will_save or 0) + 2
			actor.max_life = actor.max_life + 4
			actor.skill_point = (actor.skill_point or 0) + 2
		
			actor:learnTalent(actor.T_LIGHT_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_MEDIUM_ARMOR_PROFICIENCY, true)
			actor:learnTalent(actor.T_SIMPLE_WEAPON_PROFICIENCY, true)

			actor:learnTalent(actor.T_ELDRITCH_BLAST, true)

		else

		actor.will_save = (actor.will_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.reflex_save = (actor.reflex_save or 0) + 0.5

		actor.max_life = actor.max_life + 6
		actor.skill_point = (actor.skill_point or 0) + 2
		end
	end,
} 

--Prestige classes!
newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Shadowdancer',
	desc = [[Requires Move Silently 8 ranks and Hide 10 ranks.

	Skilled rogues who can summon shades and hide in plain sight.]],
	can_level = function(actor)
		if actor.classes and actor.classes["Shadowdancer"] and actor.classes["Shadowdancer"] >= 10 then return false end
		if actor.skill_movesilently >= 8 and actor.skill_hide >= 10 then return true end

		return false
	end,
	on_level = function(actor, level)
		if level == 1 then actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
			--grant hide in plain sight
		elseif level == 2 then 
			actor.combat_bab = (actor.combat_bab or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 1

		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		
		-- only if he doesn't have better infravision already
			if actor.infravision and actor.infravision > 3 then
				actor.infravision = actor.infravision + 1
			else
				actor.infravision = 3
			end
		
		else
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		end
	end,
} 

newBirthDescriptor {
	type = 'class',
	prestige = true,
	name = 'Assasin',
	desc = [[Requires Move Silently 8 ranks and Hide 8 ranks.

	Evil backstabbers who want to kill just for the fun of it.]],
	can_level = function(actor)
		if actor.classes and actor.classes["Assasin"] and actor.classes["Assasin"] >= 10 then return false end
	--	if player.descriptor.alignment ~= "Neutral Evil" or player.descriptor.alignment == "Lawful Evil" or player.descriptor.alignment == "Chaotic Evil" then
		if actor.skill_movesilently >= 8 and actor.skill_hide >= 8 then return true end

		return false
	
	end,
	on_level = function(actor, level)
		if level == 1 then actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.sneak_attack = (actor.sneak_attack or 0) + 1

		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		elseif level == 3 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		elseif level == 5 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		elseif level == 7 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		elseif level == 9 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		else
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_bab = (actor.combat_bab or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6
		end
	end,
} 
