-- Veins of the Earth
-- Zireael 2013-2016
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
    body = { MAIN_HAND=1, OFF_HAND=1, SHOULDER=1, BODY=1, CLOAK=1, BELT=1, QUIVER=1, GLOVES=1, LEGS=1, ARMS=1, BOOTS=1, HELM=1, RING=2, AMULET=1, LITE=1, TOOL=1, INVEN=30 },

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
		{ name="potion", force_addon = " of cure light wounds"},
		{ name="potion"},
    	},
    	starting_intro = "main",
		--NOTE: new starting equipment resolver
		resolvers.startingeq{
			Barbarian = {
				["Drow"] = {id=true, {name="scimitar", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Halfling"] = {id=true, {name="long sword", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="long sword"}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Elf"] = {id=true, {name="long sword"}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Half-Elf"] = {id=true, {name="long sword"}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="battleaxe"}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Bard = {
				["Halfling"] = {id=true, {name="dagger", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="dagger", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Elf"] = {id=true, {name="long sword", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Drow"] = {id=true, {name="scimitar", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Human"] = {id=true, {name="rapier", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Half-Elf"] = {id=true, {name="rapier", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Dwarf"] = {id=true, {name="light mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
				["Duergar"] = {id=true, {name="light mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Cleric = {
				["Halfling"] = {id=true, {name="light mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="light mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="heavy mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Shaman = {
				["Halfling"] = {id=true, {name="light mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="light mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="heavy mace", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Druid = {
				["Halfling"] = {id=true, {name="sickle", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="sickle", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Human"] = {id=true, {name="quarterstaff", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Half-Elf"] = {id=true, {name="quarterstaff", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Dwarf"] = {id=true, {name="scythe", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Duergar"] = {id=true, {name="scythe", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="scimitar", ego_chance=-1000, not_properties = {"cursed"}}, {name="padded armor", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Fighter = {
				["Drow"] = { id=true, {name = "scimitar", ego_chance=-1000, not_properties = {"cursed"}}, {name = "chain mail", ego_chance=-1000, not_properties = {"cursed"}}, },
				["Half-Orc"] = { id=true, {name = "battleaxe", ego_chance=-1000, not_properties = {"cursed"}}, {name = "chain mail", ego_chance=-1000, not_properties = {"cursed"}}, },
				["general"] = { id=true, {name = "long sword", ego_chance=-1000, not_properties = {"cursed"}}, {name = "chain mail", ego_chance=-1000, not_properties = {"cursed"}}, },
			},
			Monk = {},
			Paladin = {
				["Halfling"] = { id=true, {name = "short sword", ego_chance=-1000, not_properties = {"cursed"}}, {name ="chain mail", ego_chance=-1000, not_properties = {"cursed"}} },
				["Gnome"] = { id=true, {name = "short sword", ego_chance=-1000, not_properties = {"cursed"}}, {name ="chain mail", ego_chance=-1000, not_properties = {"cursed"}}},
				["Dwarf"] = { id=true, {name = "warhammer", ego_chance=-1000, not_properties = {"cursed"}}, {name ="chain mail", ego_chance=-1000, not_properties = {"cursed"}} },
				["general"] = { id=true, {name = "long sword", ego_chance=-1000, not_properties = {"cursed"}}, {name ="chain mail", ego_chance=-1000, not_properties = {"cursed"}}} --lance when mounts are in
			},
			Ranger = {
				["Halfling"] = {id=true, {name="short spear", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="short spear", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Half-Orc"] = {id=true, {name="short spear", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Drow"] = {id=true, {name="scimitar", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Dwarf"] = {id=true, {name="warhammer", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Duergar"] = {id=true, {name="warhammer", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="long sword", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Rogue = {
				["Halfling"] = {id=true, {name="light crossbow", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="light crossbow", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Drow"] = {id=true, {name="hand crossbow", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["Elf"] = {id=true,{name="longbow", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="shortbow", ego_chance=-1000, not_properties = {"cursed"}}, {name="leather armor", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Sorcerer = {
				["general"] = {id=true, {name="dagger", ego_chance=-1000, not_properties = {"cursed"}} },
			},
			Wizard = {
				["Halfling"] = {id=true, {name="dagger", ego_chance=-1000, not_properties = {"cursed"}}},
				["Gnome"] = {id=true, {name="dagger", ego_chance=-1000, not_properties = {"cursed"}}},
				["general"] = {id=true, {name="quarterstaff", ego_chance=-1000, not_properties = {"cursed"}}},
			},
			Warlock = {
				["general"] = {id=true, {name="long sword", ego_chance=-1000, not_properties = {"cursed"}}, {name="chain shirt", ego_chance=-1000, not_properties = {"cursed"}}}
			},
		},
  	},
  	talents = {
		--menu talents
		[ActorTalents.T_ATTACK]=1,
		[ActorTalents.T_SKILLS]=1,
		--basic talents
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
		[ActorTalents.T_PICK_POCKETS]=1,
		[ActorTalents.T_THROW_POTION]=1,

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
  desc = function(self, t)
	  d = "You are "..t.name.."."
	  d = d.." Lawful spells will not harm you. Good characters will not be hostile."
	  return d
  end,
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
  desc = function(self, t)
	  d = "You are "..t.name.."."
	  d = d.." Good characters will not be hostile."
	  return d
  end,
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
  desc = function(self, t)
	  d = "You are "..t.name.."."
	  d = d.." Chaotic spells will not harm you. Good characters will not be hostile."
	  return d
  end,
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
  desc = function(self, t)
	d = "You are "..t.name.."."
	d = d.." Lawful spells will not harm you."
	return d
  end,
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
  desc = function(self, t)
	d = "You are "..t.name.."."
	return d
  end,
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
  desc = function(self, t)
  d = "You are "..t.name.."."
  d = d.." Chaotic spells will not harm you."
  return d
  end,
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
  desc = function(self, t)
  d = "You are "..t.name.."."
  d = d.." Lawful spells will not harm you. Evil characters will not be hostile."
  return d
  end,
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
  name = 'Neutral Evil',
  desc = function(self, t)
  d = "You are "..t.name.."."
  d = d.." Evil characters will not be hostile."
  return d
  end,
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

newBirthDescriptor {
  type = 'alignment',
  name = 'Chaotic Evil',
  desc = function(self, t)
  d = "You are "..t.name.."."
  d = d.." Chaotic spells will not harm you. Evil characters will not be hostile."
  return d
  end,
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


load('/data/birth/races.lua')
load('/data/birth/class.lua')
load('/data/birth/background.lua')
load('/data/birth/deities.lua')
load('/data/birth/domains.lua')
