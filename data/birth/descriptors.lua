-- Veins of the Earth
-- Zireael 2013-2015
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

newBirthDescriptor{
	type = "base",
	name = "base",
	world = "Veins",
	desc = {
	},
	experience = 1.0,
    body = { MAIN_HAND=1, OFF_HAND=1, SHOULDER=1, BODY=1, CLOAK=1, BELT=1, QUIVER=1, GLOVES=1, BOOTS=1, HELM=1, RING=2, AMULET=1, LITE=1, TOOL=1, INVEN=30 },

	copy = {
		str = 0,
		dex = 0,
		con = 0,
		int = 0,
		wis = 0,
		cha = 0,
		luc = 0,
    	feat_point = 1,
	--	lite = 3,
		money = 1000,
		max_life = 10,
		max_level = 100,
    	--Moddable tiles
    	moddable_tile = "default",
    	moddable_tile_base = "human_m.png",
		--Wounds
		resolvers.wounds(),

		game_state = {
		  campaign_name = "Veins",
    	},
    	resolvers.inventory {
      		id=true,
      	{ name="food ration" },
      	{ name="food ration" },
      	{ name="food ration" },
      	{ name="food ration" },
      	{ name="flask of water" },
      	{ name="flask of water" },
    	},
    	starting_intro = "main",
		--NOTE: attempt to use the starting equipment resolver
		resolvers.startingeq{
			["Barbarian"] = {
				["Drow"] = "scimitar", --"chain mail"
				["Halfling"] = "long sword", --"chain mail"
				["Gnome"] = "long sword", --"chain mail"
				["Elf"] = "long sword", --"chain mail"
				["Half-Elf"] = "long sword", --"chain mail"
				["general"] = "battleaxe", --"chain mail",
			},
			["Bard"] = {
				["Halfling"] = "dagger", --"chain shirt"
				["Gnome"] = "dagger",
				["Elf"] = "long sword",
				["Drow"] = "scimitar",
				["Human"] = "rapier",
				["Half-Elf"] = "rapier",
				["Dwarf"] = "light mace",
				["Duergar"] = "light mace",
			},
			["Cleric"] = {
				["Halfling"] = "light mace", --"chain mail"
				["Gnome"] = "light mace",
				["general"] = "heavy mace",
			},
			["Shaman"] = {
				["Halfling"] = "light mace", --"chain mail"
				["Gnome"] = "light mace",
				["general"] = "heavy mace",
			},
			["Druid"] = {
				["Halfling"] = "sickle", --"padded armor"
				["Gnome"] = "sickle",
				["Human"] = "quarterstaff",
				["Half-Elf"] = "quarterstaff",
				["Dwarf"] = "scythe",
				["Duergar"] = "scythe",
				["general"] = "scimitar",
			},
			["Fighter"] = {
				["Drow"] = { id=true, {name = "scimitar"}, {name = "chain mail"}, },
				["Half-Orc"] = { id=true, {name = "battleaxe"}, {name = "chain mail"}, },
				["general"] = { id=true, {name = "longsword"}, },
			},
			["Monk"] = {},
			["Paladin"] = {
				["Halfling"] = "short sword", --"chain mail"
				["Gnome"] = "short sword",
				["Dwarf"] = "warhammer",
				["general"] = "long sword" --lance when mounts are in
			},
			["Ranger"] = {
				["Halfling"] = "short spear", --"leather armor"
				["Gnome"] = "short spear",
				["Half-Orc"] = "short spear",
				["Drow"] = "scimitar",
				["Dwarf"] = "warhammer",
				["Duergar"] = "warhammer",
				["general"] = "long sword",
			},
			["Rogue"] = {
				["Halfling"] = "light crossbow",
				["Gnome"] = "light crossbow",
				["Drow"] = "hand crossbow",
				["Elf"] = "longbow",
				["general"] = "shortbow",
			},
			["Sorcerer"] = {
				["general"] = "dagger",
			},
			["Wizard"] = {
				["Halfling"] = "dagger",
				["Gnome"] = "dagger",
				["general"] = "quarterstaff",
			},
			["Warlock"] = {
				["general"] = "long sword" --chain shirt
			},
		},
  	},
  	talents = {
    	[ActorTalents.T_SHOOT]=1,
    	[ActorTalents.T_PRAYER]=1,
    	[ActorTalents.T_POLEARM]=1,
    	[ActorTalents.T_STEALTH]=1,
		[ActorTalents.T_JUMP]=1,
		[ActorTalents.T_INTIMIDATE]=1,
    	[ActorTalents.T_DIPLOMACY]=1,
    	[ActorTalents.T_ANIMAL_EMPATHY]=1,
    	[ActorTalents.T_MOUNT]=1,
		[ActorTalents.T_CRAFT]=1,
		[ActorTalents.T_TRACK]=1,
  	},
  talents_types = {
    ["special/special"] = {true, 0.0},
    ["class/general"] = {true, 0.0},
    ["class/focus"] = {true, 0.0},
    ["class/proficiency"] = {true, 0.0},
    ["class/combat"] = {true, 0.0},
    ["class/skill"] = {true, 0.0},
    ["class/attribute"] = {true, 0.0},
    ["class/twf"] = {true, 0.0},
    ["class/saves"] = {true, 0.0},
    ["combat/general"] = {true, 0.0}
  },
  descriptor_choices =
  {
    domains =
    {
      __ALL__ = "disallow",
    },
    --Disallows prestige classes at birth
    class =
    {
     ['Shadowdancer'] = "disallow",
     ['Assassin'] = "disallow",
     ['Blackguard'] = "disallow",
     ['Arcane archer'] = "disallow",
     ['Loremaster'] = "disallow",
     ['Archmage'] = "disallow",
    }
	},
}

newBirthDescriptor {
  type = 'sex',
  name = 'Female',
  desc = [[You are a female of the species.  There is no in-game difference between the two sexes.]],
}

newBirthDescriptor {
  type = 'sex',
  name = 'Male',
  desc = [[You are a male of the species.  There is no in-game difference between the two sexes.]],
}

--Alignment
newBirthDescriptor {
  type = 'alignment',
  name = 'Lawful Good',
  desc = [[You are Lawful Good. Lawful spells will not harm you. Good characters will not be hostile.]],
  descriptor_choices =
  {
    domains =
    {
      ['Evil'] = "disallow",
      ['Chaos'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Neutral Good',
  desc = [[You are Neutral Good. Good characters will not be hostile.]],
  descriptor_choices =
  {
    domains =
    {
      ['Evil'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Chaotic Good',
  desc = [[You are Neutral Good. Chaotic spells will not harm you. Good characters will not be hostile.]],
  descriptor_choices =
  {
    domains =
    {
      ['Evil'] = "disallow",
      ['Law'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Lawful Neutral',
  desc = [[You are Lawful Neutral. Lawful spells will not harm you.]],
  descriptor_choices =
  {
    domains =
    {
      ['Good'] = "disallow",
      ['Evil'] = "disallow",
      ['Chaos'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Neutral',
  desc = [[You are Neutral.]],
  descriptor_choices =
  {
    domains =
    {
      ['Good'] = "disallow",
      ['Evil'] = "disallow",
      ['Chaos'] = "disallow",
      ['Law'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Chaotic Neutral',
  desc = [[You are Chaotic Neutral. Chaotic spells will not harm you.]],
  descriptor_choices =
  {
    domains =
    {
      ['Good'] = "disallow",
      ['Evil'] = "disallow",
      ['Law'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Lawful Evil',
  desc = [[You are Lawful Evil. Lawful spells will not harm you. Evil characters will not be hostile.]],
  copy = {
    faction = "players_evil",
  },
  descriptor_choices =
  {
    domains =
    {
      ['Good'] = "disallow",
      ['Chaos'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Chaotic Evil',
  desc = [[You are Chaotic Evil. Chaotic spells will not harm you. Evil characters will not be hostile.]],
  copy = {
    faction = "players_evil",
  },
  descriptor_choices =
  {
    domains =
    {
      ['Good'] = "disallow",
      ['Law'] = "disallow",
    }
  },
}

newBirthDescriptor {
  type = 'alignment',
  name = 'Neutral Evil',
  desc = [[You are Neutral Evil. Evil characters will not be hostile.]],
  copy = {
    faction = "players_evil",
  },
  descriptor_choices =
  {
    domains =
    {
      ['Good'] = "disallow",
      ['Law'] = "disallow",
      ['Chaos'] = "disallow",
    }
  },
}

load('/data/birth/races.lua')
load('/data/birth/class.lua')
load('/data/birth/background.lua')
load('/data/birth/deities.lua')
load('/data/birth/domains.lua')
