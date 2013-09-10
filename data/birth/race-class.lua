
-- Veins of the Earth
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--

--Standard races
newBirthDescriptor {
	type = 'race',
	name = 'Human',
	desc = [[Humans are the basic race to which all others are compared.]],
	copy_add = {
		feat_point = 1,
		skill_point = 4,
	},
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="a torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Half-Elf',
	desc = [[A crossbreed of elf and human, they get the best of the two races.]],
	stats = { cha = 2, },
	copy_add = {
	},
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="a torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Elf',
	desc = [[Elves are also called the Fair Folk. Dex +2 Con -2.]],
	stats = { dex = 2, con = -2, },
	copy_add = {
		infravision = 3,
		skill_listen = 2,
		skill_spot = 2,
		skill_search = 2,
	},
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="a torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Half-Orc',
	desc = [[A crossbreed of orc and human. Str +2 Int -2 Cha -2]],
	stats = { str = 2, int = -2, cha = -2, },
	copy_add = {
		infravision = 3,
	},
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="a torch" },
		},
	}
}

--Stone sense
newBirthDescriptor {
	type = 'race',
	name = 'Dwarf',
	desc = [[A race of tough fighters and miners. Con +2, Cha -2.]],
	stats = { con = 2, cha = -2, },
	copy_add = {
		infravision = 3,
	},
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="a torch" },
		},
	}
}

--Underdark races
--Spell-like abilities, +2 vs. spells
newBirthDescriptor {
	type = 'race',
	name = 'Drow',
	desc = 'The drow are kin to the Fair Folk, who descended underground long ago.\n\n ECL +2. Dex +2 Con -2 Int +2 Cha +2 Luc -2.',
	stats = { dex = 2, con = -2, int = 2, cha = 2, luc = -2, },
	copy_add = {
		infravision = 6,
		skill_listen = 2,
		skill_spot = 2,
		skill_search = 2,
		spell_resistance = 12,
		ecl = 2,
	}
}

--Immune to poison, paralysis and phantasms. Stone sense. Invis, enlarge person as spell-likes
newBirthDescriptor {
	type = 'race',
	name = 'Duergar',
	desc = 'The gray dwarves are the underground offshoot of the dwarves, long ago imprisoned by the mind flayers.\n\n ECL +1. Con +2 Cha -2 Luc -2.',
	stats = { con = 2, cha = -4, luc = -2, },
	copy_add = {
		infravision = 6,
		skill_listen = 1,
		skill_spot = 1,
		ecl = 1,
	}
}

--Stone sense. Spell-like abilities 1/day - disguise self, blur, blindness/deafness
newBirthDescriptor {
	type = 'race',
	name = 'Deep gnome',
	desc = 'The deep gnomes are the Underdark offshoot of the gnomes, distrustful of all outsiders.\n\n ECL +3. Str -2 Dex +2 Wis +2 Cha -4 Luc -2.',
	stats = { str = -2, dex = 2, wis = 2, cha = -4, luc = -2, },
	copy_add = {
		infravision = 6,
		skill_listen = 2,
		combat_def = 4,
		spell_resistance = 12,
		fortitude_save = 2,
		reflex_save = 2,
		will_save = 2,
		ecl = 3,
	}
}



-- Classes
newBirthDescriptor {
	type = 'class',
	name = 'Barbarian',
	desc = 'Raging warriors of the wilds.\n\n +33% movement speed. HD d12, BAB +1, Fort +2 at first class level. 16 skill points at 1st character level.\n\n BAB +1, Fort +1, Will +0.5, Ref +0.5, 4 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="iron battleaxe" },
			{ name="chain mail" },
		},
	},
	copy_add = {
		hd_size = 12,
		skill_point = 12, --4x skill points at 1st level
		movement_speed_bonus = 0.33
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_RAGE]=1,
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) +2
			actor.combat_attack = (actor.combat_attack or 0) + 1
			actor.max_life = actor.max_life + 12
			actor.skill_point = (actor.skill_point or 0) + 4
		end

		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 12
		actor.skill_point = (actor.skill_point or 0) + 4
	end,
} 

newBirthDescriptor {
	type = 'class',
	name = 'Bard',
	desc = 'Musicians and gentlefolk.\n\n HD d6, BAB +0, Ref +2, Fort +2 at first class level. 24 skill points at 1st character level.\n\n BAB +0.75, Ref +1, Fort +1, Will +0.5, 6 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="rapier" },
			{ name="chain shirt" },
		},
	},
	copy_add = {
		hd_size = 6,
		skill_point = 18, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_SHOW_SPELLBOOK]=1,
	--	[ActorTalents.T_BARDIC_HEAL_LIGHT_WOUNDS]=1,
		[ActorTalents.T_SUMMON_CREATURE_I]=1,
		[ActorTalents.T_SLEEP]=1,
		[ActorTalents.T_GREASE]=1,
	},
	talents_types = {
		["arcane/arcane"] = {true, 0.0},
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then 
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.max_life = actor.max_life + 6
			actor.skill_point = (actor.skill_point or 0) + 6
		end

		actor.combat_attack = (actor.combat_attack or 0) + 0.75
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 6
		actor.skill_point = (actor.skill_point or 0) + 4
	end,
} 


newBirthDescriptor {
	type = 'class',
	name = 'Cleric',
	desc = 'Clerics are masters of healing.\n\n HD d8. Fort +2, Will +2 at first class level. 8 skill points at 1st character level.\n\n BAB +0.75, Will +1, Fort +1, Ref +0.5,  2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="heavy mace" },
			{ name="chain mail" },
		},
	},
	copy_add = {
		hd_size = 8,
		skill_point = 6, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_SHOW_SPELLBOOK]=1,
		[ActorTalents.T_HEAL_LIGHT_WOUNDS]=1,
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_HEAVY_ARMOR_PROFICIENCY]=1,
	},
	talents_types = {
		["cleric/cleric"] = {true, 0.0},
		["divine/divine"] = {true, 0.0}
	},
	descriptor_choices = {
		domains = {
			__ALL__ = "allow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then
			actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.will_save = (actor.will_save or 0) + 2

			actor.max_life = actor.max_life + 8
			actor.skill_point = (actor.skill_point or 0) + 2

		--	self:levelPassives()
		end	

		actor.will_save = (actor.will_save or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.combat_attack = (actor.combat_attack or 0) + 0.75

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 2

	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Druid',
	desc = 'Clerics of nature.\n\n HD d8. Fort +2 Will +2 at first class level. 8 skill points at 1st character level.\n\n BAB +0.75, Will +1, Fort +1, Ref +0.5,  2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="quarterstaff" },
			{ name="padded armor" },
		},
	},
	copy_add = {
		hd_size = 8,
		skill_point = 12, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_HEAL_LIGHT_WOUNDS]=1,
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Evil'] = "disallow",
			['Chaotic Good'] = "disallow",
			['Chaotic Evil'] = "disallow",
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

	--		self:levelPassives()
		end


		actor.will_save = (actor.will_save or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.combat_attack = (actor.combat_attack or 0) + 0.75

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 4

	end,
}   


newBirthDescriptor {
	type = 'class',
	name = 'Fighter',
	desc = 'Simple fighters, they hack away with their trusty weapon.\n\n HD d10, BAB +1, Fort +2 at 1st class level. 8 skill points at 1st character level.\n\n BAB +1, Fort +1, Ref +0.5, Will +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword" },
			{ name="chain mail" },
		},
	},
	copy_add = {
		hd_size = 10,
		skill_point = 6, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_HEAVY_ARMOR_PROFICIENCY]=1,
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.combat_attack = (actor.combat_attack or 0) + 1

			actor.max_life = actor.max_life + 10
			actor.skill_point = (actor.skill_point or 0) + 2
		end

		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 10
		actor.skill_point = (actor.skill_point or 0) + 2
	end,
}


newBirthDescriptor {
	type = 'class',
	name = 'Ranger',
	desc = 'Rangers are capable archers but are also trained in hand to hand combat and divine magic.\n\n HD d8, BAB +1, Fort +2, Ref +2 at first class level. 24 skill points at 1st character level. \n\n BAB +1, Fort +1, Ref +1, Will +0.5, 6 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword" },
			{ name="iron dagger" },
			{ name="studded leather" },

		},
		resolvers.inventory {
			full_id=true,
			{ name="shortbow"},
			{ name="arrows (20)" },
		},

	},
	copy_add = {
		hd_size = 8,
		skill_point = 18, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.fortitude_save = (actor.fortitude_save or 0) + 2
			actor.combat_attack = (actor.combat_attack or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 2

			actor.max_life = actor.max_life + 8
			actor.skill_point = (actor.skill_point or 0) + 6
		end

		actor.combat_attack = (actor.combat_attack or 0) + 1
		actor.fortitude_save = (actor.fortitude_save or 0) + 1
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6

	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Rogue',
	desc = 'Rogues are masters of tricks.\n\n HD d6, Ref +2 at first class level. 32 skill points at 1st character level.\n\n BAB +0.75, Ref +1, Fort +0.5, Will +0.5, 8 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="light crossbow" },
			{ name="bolts (10)" },
			{ name="studded leather" },
		},
		resolvers.inventory {
			full_id=true,
			{ name="iron dagger"},
		}
	},
	copy_add = {
		hd_size = 6,
		sneak_attack = 1,
		skill_point = 24, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
	descriptor_choices =
	{
		alignment =
		{
			['Lawful Good'] = "disallow",
			['Lawful Neutral'] = "disallow",
			['Lawful Evil'] = "disallow",
		}
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.reflex_save = (actor.reflex_save or 0) + 2
			actor.sneak_attack = (actor.sneak_attack or 0) + 1
			actor.max_life = actor.max_life + 6
			actor.skill_point = (actor.skill_point or 0) + 8
		end

		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_attack = (actor.combat_attack or 0) + 0.75
		actor.will_save = (actor.will_save or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5

		actor.max_life = actor.max_life + 6
		actor.skill_point = (actor.skill_point or 0) + 8

	end,
}

newBirthDescriptor {
	type = 'class',
	name = 'Wizard',
	desc = 'Masters of arcane magic.\n\n HD d4, Will +2 at first character level. 8 skill points at 1st class level.\n\n BAB +0.5, Will +1, Ref +0.5, Fort +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="iron dagger" },

		},
		resolvers.inventory {
			full_id=true,
			{ name="light crossbow"},
			{ name="bolts (10)"},
		}

	},
	copy_add = {
		hd_size = 4,
		skill_point = 6, --4x skill points at 1st level
	},
	talents = {
		[ActorTalents.T_EMPOWER] = 1,
		[ActorTalents.T_SHOW_SPELLBOOK]=1,
		[ActorTalents.T_ACID_SPLASH]=1,
		[ActorTalents.T_GREASE]=1,
		[ActorTalents.T_MAGIC_MISSILE]=1,
		[ActorTalents.T_BURNING_HANDS]=1,
		[ActorTalents.T_SUMMON_CREATURE_I]=1,
		[ActorTalents.T_SLEEP]=1,
		[ActorTalents.T_BLINDNESS_DEAFNESS]=1,
	},
	talents_types = {
		["arcane/arcane"] = {true, 0.0},
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.will_save = (actor.will_save or 0) + 2
			actor.max_life = actor.max_life + 4
			actor.skill_point = (actor.skill_point or 0) + 2
		end

		actor.will_save = (actor.will_save or 0) + 1
		actor.combat_attack = (actor.combat_attack or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.reflex_save = (actor.reflex_save or 0) + 0.5

		actor.max_life = actor.max_life + 4
		actor.skill_point = (actor.skill_point or 0) + 2

	end,
}


--Non-standard classes
newBirthDescriptor {
	type = 'class',
	name = 'Warlock',
	desc = 'A spellcaster who needs no weapon.\n\n HD d6, Will +2 at first character level. 8 skill points at 1st class level.\n\n BAB +0.5, Will +1, Ref +0.5, Fort +0.5, 2 skill points per level.',
	copy = {
		resolvers.equip {
			full_id=true,
			{ name="long sword" },
			{ name="chain shirt" },
		},
	},
	copy_add = {
		hd_size = 6,
		skill_point = 6, --4x skill points at start
	},
	talents = {
		[ActorTalents.T_ELDRITCH_BLAST]=1,
		[ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
		[ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
	},
	can_level = function(actor)
		return true
	end,
	on_level = function(actor, level)
		if level == 1 then actor.will_save = (actor.will_save or 0) + 2
			actor.max_life = actor.max_life + 4
			actor.skill_point = (actor.skill_point or 0) + 2
		end

		actor.will_save = (actor.will_save or 0) + 1
		actor.combat_attack = (actor.combat_attack or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.reflex_save = (actor.reflex_save or 0) + 0.5

		actor.max_life = actor.max_life + 6
		actor.skill_point = (actor.skill_point or 0) + 2

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
			--grant hide in plain sight
		elseif level == 2 then 
			actor.combat_attack = (actor.combat_attack or 0) + 1
			actor.reflex_save = (actor.reflex_save or 0) + 1
		
		-- only if he doesn't have better infravision already
			if actor.infravision and actor.infravision > 3 then
				actor.infravision = actor.infravision + 1
			else
				actor.infravision = 3
			end
		end
				
		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_attack = (actor.combat_attack or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6

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
		elseif level == 3 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 5 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 7 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		elseif level == 9 then actor.sneak_attack = (actor.sneak_attack or 0) + 1
		end

		actor.reflex_save = (actor.reflex_save or 0) + 1
		actor.combat_attack = (actor.combat_attack or 0) + 0.5
		actor.fortitude_save = (actor.fortitude_save or 0) + 0.5
		actor.will_save = (actor.will_save or 0) + 0.5

		actor.max_life = actor.max_life + 8
		actor.skill_point = (actor.skill_point or 0) + 6

	end,
} 