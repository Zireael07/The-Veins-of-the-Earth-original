-- Veins of the Earth
-- Zireael 2013-2014
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

local help = [[#GOLD#Feat points#SANDY_BROWN# are used to pick feats, which improve the character in various ways. #GOLD#Skill points#LAST#are used to improve the character's skills, as their name suggests.
 If you pick the #GOLD#favored class#LAST# later, you will gain +2 hit points per level and a +1 to attack. The latter bonus does not apply if you are a mage, however.
 #GOLD#ECL#LAST# means that your character will need more XP to level up (as though his or her level was equal to level + ECL).
 
 #WHITE#]]

--Standard races
newBirthDescriptor {
	type = 'race',
	name = 'Human',
	desc = help..'Humans are the basic race to which all others are compared.\n\n +1 feat point and +4 skill points at 1st level.',
	copy_add = {
		feat_point = 1,
		skill_point = 4,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Half-Elf',
	desc = help..'A crossbreed of elf and human, they get the best of the two races.\n\n Cha +2. Diplomacy, Listen, Search, Spot +1. Favored class: Bard.',
	stats = { cha = 2, },
	copy_add = {
		skill_diplomacy = 1,
		skill_listen = 1,
		skill_spot = 1,
		skill_search = 1,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Half-Drow',
	desc = help..'A crossbreed of drow and human, they get the best of the two races.\n\n Cha +2. Listen, Spot, Search +1. Darkvision 2. Favored class: Cleric.',
	stats = { cha = 2, },
	copy_add = {
		infravision = 2,
		skill_listen = 1,
		skill_spot = 1,
		skill_search = 1,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Elf',
	desc = help..'Elves are also called the Fair Folk.\n\n Dex +2 Con -2. Listen, Spot, Search +1. Darkvision 3. Favored class: Ranger.',
	stats = { dex = 2, con = -2, },
	copy_add = {
		infravision = 3,
		skill_listen = 2,
		skill_spot = 2,
		skill_search = 2,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Half-Orc',
	desc = help..'A crossbreed of orc and human.\n\n Str +2 Int -2 Cha -2. Darkvision 3. Favored class: Barbarian.',
	stats = { str = 2, int = -2, cha = -2, },
	copy_add = {
		infravision = 3,
		--to do: orc blood
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

--Dancing lights, ghost sound, prestigidation
newBirthDescriptor {
	type = 'race',
	name = 'Gnome',
	desc = help..'A race of inventors.\n\n Str -2 Con +2. AC +1, attack +1. Listen +2. Darkvision 3. Favored class: Bard.',
	stats = { str = -2, con = 2 },
	copy_add = {
		infravision = 3,
		combat_untyped = 1,
		combat_attack = 1,
		skill_listen = 2,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

newBirthDescriptor {
	type = 'race',
	name = 'Halfling',
	desc = help..'A race of lucky rogues.\n\n Str -2 Dex +2 Luc +2. AC +1, attack +1. Climb, Jump, Hide, Move Silently +2. +1 to all saving throws. Darkvision 3. Favored class: Rogue.',
	stats = { str = -2, dex = 2, luc = 2 },
	copy_add = {
		infravision = 3,
		combat_untyped = 1,
		combat_attack = 1,
		skill_hide = 2,
		skill_movesilently = 2,
		skill_jump = 2,
		skill_climb = 2,
		fortitude_save = 1,
		reflex_save = 1,
		will_save = 1,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

--Stone sense
newBirthDescriptor {
	type = 'race',
	name = 'Dwarf',
	desc = help..'A race of tough fighters and miners.\n\n Con +2, Cha -2. Darkvision 3. Favored class: Fighter.',
	stats = { con = 2, cha = -2, },
	copy_add = {
		infravision = 3,
	},
	copy = {
		starting_intro = "main",
		resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

--Underdark races
--Spell-like abilities, +2 vs. spells
newBirthDescriptor {
	type = 'race',
	name = 'Drow',
	desc = help..'The drow are kin to the Fair Folk, who descended underground long ago.\n\n ECL +2. Dex +2 Con -2 Int +2 Cha +2 Luc -2. Darkvision 6. Listen, Spot, Search +2. Favored class: Cleric (female), Wizard (male).',
	stats = { dex = 2, con = -2, int = 2, cha = 2, luc = -2, },
	copy_add = {
		infravision = 6,
		skill_listen = 2,
		skill_spot = 2,
		skill_search = 2,
		spell_resistance = 12,
		ecl = 2,
		talents = {
    [ActorTalents.T_DARKNESS_INNATE]=1,
    [ActorTalents.T_FAERIE_FIRE_INNATE]=1,
--    [ActorTalents.T_LEVITATE_INNATE]=1,
	}
	},
	copy = {
	starting_intro = "dark",
	
	}
}

--Immune to poison, paralysis and phantasms. Stone sense. Invis, enlarge person as spell-likes
newBirthDescriptor {
	type = 'race',
	name = 'Duergar',
	desc = help..'The gray dwarves are the underground offshoot of the dwarves, long ago imprisoned by the mind flayers.\n\n ECL +1. Con +2 Cha -2 Luc -2. Darkvision 6. Listen, Spot +1. Favored class: Fighter.',
	stats = { con = 2, cha = -4, luc = -2, },
	copy_add = {
		infravision = 6,
		skill_listen = 1,
		skill_spot = 1,
		ecl = 1,
	},
	copy = {
	starting_intro = "dark",
	talents = {
    [ActorTalents.T_INVISIBILITY_INNATE]=1,
	}
	}
}

--Stone sense. Spell-like abilities 1/day - disguise actor, blur, blindness/deafness
newBirthDescriptor {
	type = 'race',
	name = 'Deep gnome',
	desc = help..'The deep gnomes are the Underdark offshoot of the gnomes, distrustful of all outsiders.\n\n ECL +3. Str -2 Dex +2 Wis +2 Cha -4 Luc -2. Darkvision 6. Listen +2. Fort, Ref, Will +2. AC +4. Favored class: Rogue.',
	stats = { str = -2, dex = 2, wis = 2, cha = -4, luc = -2, },
	copy_add = {
		infravision = 6,
		skill_listen = 2,
		combat_dodge = 4,
		spell_resistance = 12,
		fortitude_save = 2,
		reflex_save = 2,
		will_save = 2,
		ecl = 3,
	},
	copy = {
	starting_intro = "dark",
	}
}

--Incursion races
newBirthDescriptor{
	type = 'race',
	name = "Lizardfolk",
	desc = help..'Lizardfolk have a mindset highly different from other sentient races. Because of this, they seem dispassionate and ruthless.\n\n Str +2 Con +2 Int -2 Luc -2. ECL +1. Ref +3. AC +5. Jump, Swim, Balance +4. Favored class: Druid.',
	stats = { str = 2, con = 2, int = -2, luc = -2, },
	copy_add = {
		reflex_save = 3,
		combat_natural = 5,
		skill_jump = 4,
		skill_swim = 4,
		skill_balance = 4,
		ecl = 1,
	},
	copy = {
	starting_intro = "main",
	resolvers.equip {
			full_id=true,
			{ name="torch" },
		},
	}
}

newBirthDescriptor{
	type = 'race',
	name = "Kobold",
	desc = help..' Small reptilians, cowardly but crafty.\n\n Str -4 Dex +4 Int +2 Cha -2. Darkvision 3. Hide +4, Search +2. AC +2, attack +1. Favored class: Rogue',
	stats = { str = -4, dex = 4, int = 2, cha = -2, },
	copy_add = {
		infravision = 3,
		skill_search = 2,
		combat_natural = 1,
		combat_untyped = 1,
		combat_attack = 1,
		skill_hide = 4,
		--skill_craft = 2,
	},
	copy = {
	starting_intro = "dark",
	}
}

--Note: Wisdom bonus as opposed to penalty in SRD!!!
newBirthDescriptor{
	type = 'race',
	name = "Orc",
	desc = help..'Huge and muscular, the orcs are seen as a plague by the civilized races. However, on their own, their societies prosper.\n\n Str +4 Int -2 Wis +2 Cha -2. Darkvision 3. Favored class: Barbarian.',
	stats = { str = 4, int = -2, wis = 2, cha = -2, },
	copy_add = {
		infravision = 3,
		--to do: orc blood
	},
	copy = {
	starting_intro = "dark",
	}
}