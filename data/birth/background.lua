--Veins of the Earth
--Zireael

--Fighter backgrounds (8 pts max)
newBirthDescriptor {
	type = 'background',
	name = "Brawler",
	desc = 'Brawlers use their strength to full extent.\n\n Spend 4 skill points on Intimidate and Jump each. Pick Power Attack as your first feat.',
	copy_add = {
	skill_point = -4,
	skill_intimidate = 4,
	skill_jump = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_POWER_ATTACK]=1,
	},
}

newBirthDescriptor {
	type = 'background',
	name = "Tough guy",
	desc = 'You are really hard to kill.\n\n Spend 4 skill points on Tumble and Swim each. Pick Toughness as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_intimidate = 4,
	skill_swim = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_TOUGHNESS]=1,
	},
}

--Require BAB 1 at 1st level
newBirthDescriptor {
	type = 'background',
	name = "Master of one",
	desc = 'You have focused on your weapon of choice.\n\n Spend 4 skill points on Jump and Swim each. Pick Weapon Focus as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_jump = 4,
	skill_swim = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_WEAPON_FOCUS]=1,
	},
}

--Require BAB 1 at 1st level
newBirthDescriptor {
	type = 'background',
	name = "Exotic fighter",
	desc = 'You have learned how to use exotic weaponry.\n\n Spend 4 skill points on Jump and Swim each. Pick Exotic Weapon Proficiency as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_jump = 4,
	skill_swim = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_EXOTIC_WEAPON_PROFICIENCY]=1,
	},
}

--Require BAB 1 at 1st level
newBirthDescriptor {
	type = 'background',
	name = "Fencing duelist",
	desc = 'You prefer dexterity to brute force.\n\n Spend 4 skill points on Tumble and Bluff each. Pick Finesse as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_tumble = 4,
	skill_bluff = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_FINESSE]=1,
	},
}

newBirthDescriptor {
	type = 'background',
	name = "Nimble fighter",
	desc = 'Instead of charging blindly into battle, you dance around your opponent.\n\n Spend 4 skill points on Tumble and Swim each. Pick Dodge as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_tumble = 4,
	skill_swim = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_DODGE]=1,
	},
}

newBirthDescriptor {
	type = 'background',
	name = "Smart fighter",
	desc = 'You use your head instead of fighting mindlessly.\n\n Spend 4 skill points on Intuition and Swim. Pick Combat Expertise as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_intuition = 4,
	skill_swim = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_COMBAT_EXPERTISE]=1,
	},
}

newBirthDescriptor {
	type = 'background',
	name = "Savage",
	desc = 'You were raised in the wild.\n\n Spend 4 skill points on Survival and Swim. Pick Power Attack as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_survival = 4,
	skill_swim = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_POWER_ATTACK]=1,
	},
}

--TO DO: Archer background and twf fighter background (24 pts max)

--Rogue backgrounds (32 pts max)
newBirthDescriptor {
	type = 'background',
	name = "Sneaky thief",
	desc = 'You prefer sneaking around the opponents to face-to-face combat.\n\n Spend 4 skill points on Hide and Move Silently each. Pick Stealthy as the first feat.',
	copy_add = {
	skill_point = -16,
	skill_hide = 4,
	skill_movesilently = 4,
	skill_intuition = 4,
	skill_tumble = 4,
	skill_listen = 4,
	skill_search = 4,
	skill_spot = 4,
	skill_disabledevice = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_STEALTHY]=1,
	},
}

newBirthDescriptor {
	type = 'background',
	name = "Magical thief",
	desc = 'You love playing with all those magic trinkets.\n\n Spend 4 skill points on Use Magic Device and Intuition each. Pick Magical Aptitude as the first feat.',
	copy_add = {
	skill_point = -16,
	skill_usemagic = 4,
	skill_intuition = 4,
	skill_knowledge = 4,
	skill_tumble = 4,
	skill_disabledevice = 4,
	skill_spot = 4,
	skill_search = 4,
	skill_pickpocket = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_MAGICAL_APTITUDE]=1,
	},
}

--Spellcaster stuff (8 pts max)
newBirthDescriptor {
	type = 'background',
	name = "Spellcaster",
	desc = 'Spells are your strength.\n\n Spend 4 skill points on Concentration and Knowledge each. Pick Combat Casting as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_concentration = 4,
	skill_spellcraft = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_COMBAT_CASTING]=1,
	},
}

--All-rounders (8 pts max)
newBirthDescriptor {
	type = 'background',
	name = "Smart brainiac",
	desc = 'You utilize your brain to its fullest.\n\n Spend 4 skill points on Intuition and Knowledge. Pick Iron Will as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_intuition = 4,
	skill_knowledge = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_IRON_WILL]=1,
	},
}

--Special background (8 pts max)
newBirthDescriptor {
	type = 'background',
	name = "Born hero",
	desc = 'You were born to be a hero.\n\n Spend 4 skill points on Intuition and Swim. Pick #GOLD#Born Hero (special)#LAST# as your first feat.',
	copy_add = {
	skill_point = -8,
	skill_intuition = 4,
	skill_knowledge = 4,
	feat_point = -1,
	},
	talents = {
		[ActorTalents.T_BORN_HERO]=1,
	},
}


--Filler (or for those who want to customize the character completely)
newBirthDescriptor {
	type = 'background',
	desc = 'Pick this option if you want to customize your character later or if none of the backgrounds appeal to you.\n\n You gain a feat point and none of the skill points are used up.',
	name = "None",
	copy_add = {
--	feat_point = 1,
	}
}