-- Underdark
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
  }
}

newBirthDescriptor {
  type = 'race',
  name = 'Half-Elf',
  desc = [[A crossbreed of elf and human, they get the best of the two races.]],
  stats = { cha = 2, },
  copy_add = {
  }
}

newBirthDescriptor {
  type = 'race',
  name = 'Elf',
  desc = [[Elves are also called the Fair Folk. Dex +2 Con -2.]],
  stats = { dex = 2, con = -2, },
copy_add = {
  infravision = 1,
  keen_senses = 2,
  }
}

newBirthDescriptor {
  type = 'race',
  name = 'Half-Orc',
  desc = [[A crossbreed of orc and human. Str +2 Int -2 Cha -2]],
  stats = { str = 2, int = -2, cha = -2, },
  copy_add = {
  infravision = 1,
  }
}

--Stone sense
newBirthDescriptor {
  type = 'race',
  name = 'Dwarf',
  desc = [[A race of tough fighters and miners. Con +2, Cha -2.]],
  stats = { con = 2, cha = -2, },
  copy_add = {
  infravision = 1,
  }
}

--Underdark races
--Spell-like abilities, +2 vs. spells
newBirthDescriptor {
  type = 'race',
  name = 'Drow',
  desc = [[The drow are kin to the Fair Folk, who descended underground long ago. 10% exp penalty. Dex +2 Con -2 Int +2 Cha +2 Luc -2.]],
  stats = { dex = 2, con = -2, int = 2, cha = 2, luc = -2, },
copy_add = {
  infravision = 3,
  keen_senses = 2,
  spell_resistance = 12,
  experience = 1.10,
  }
}

--Immune to poison, paralysis and phantasms. Stone sense. Invis, enlarge person as spell-likes
newBirthDescriptor {
  type = 'race',
  name = 'Duergar',
  desc = [[The gray dwarves are the Underdark offshoot of the dwarves, long ago imprisoned by the mind flayers. 10% exp penalty. Con +2 Cha -2 Luc -2.]],
  stats = { con = 2, cha = -4, luc = -2, },
copy_add = {
  infravision = 3,
  keen_senses = 1,
  experience = 1.10,
  }
}

--Blind, smell 30 ft.; +10 to Hide underground, immune to sight-based effects, illusions
newBirthDescriptor {
  type = 'race',
  name = 'Grimlock',
  desc = [[These blind humanoids are the descendants of barbarians. 30% exp penalty. Str +4 Dex +2 Con +2 Wis -2 Cha -4 Luc -2.]],
  stats = { str = 4, dex = 2, con = 2, wis = -2, cha = -4, luc = -2, },
copy_add = {
--   hit_die = 2,
   combat_attack = 2,
   reflex_save = 3,
   will_save = 3,
   experience = 1.30,
  }
}

--Electricity resistance 10, immune to poison and paralysis
newBirthDescriptor {
  type = 'race',
  name = 'Kuo-toa',
  desc = [[These fishfolk live in the depths of the Underdark. 30% exp penalty. Str +2 Con +2 Int +2 Wis +4 Cha -2 Luc -2.]],
  stats = { str = 2, con = 2, int = 2, wis = 4, cha = -2, luc = -2, },
copy_add = {
  infravision = 3,
  keen_senses = 2,
 -- hit_die = 2,
  combat_def = 6,
  reflex_save = 3,
  will_save = 3,
  experience = 1.30,
  }
}

--Stone sense. Spell-like abilities 1/day - disguise self, blur, blindness/deafness
newBirthDescriptor {
  type = 'race',
  name = 'Deep gnome',
  desc = [[The deep gnomes are the Underdark offshoot of the gnomes, distrustful of all outsiders. 30% exp penalty. Str -2 Dex +2 Wis +2 Cha -4 Luc -2.]],
  stats = { str = -2, dex = 2, wis = 2, cha = -4, luc = -2, },
copy_add = {
  infravision = 3,
  keen_senses = 1,
  combat_def = 4,
  spell_resistance = 12,
  fortitude_save = 2,
  reflex_save = 2,
  will_save = 2,
  experience = 1.30,
  }
}



-- Classes
newBirthDescriptor {
  type = 'class',
  name = 'Barbarian',
  desc = [[Simple fighters, they hack away with their trusty weapon. HD d12, BAB +1, Fort +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="iron battleaxe" },
      { name="chain mail" },
    },
  },
  copy_add = {
  hd_size = 12,
  max_life = 12,
  combat_attack = 1,
  fortitude_save = 2,
  skill_point = 8,
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
} 

newBirthDescriptor {
  type = 'class',
  name = 'Cleric',
  desc = [[Clerics are masters of healing. HD d8. Fort +2, Will +2 at first level.]],
  copy = {
    resolvers.equip {
      full_id=true,
      { name="heavy mace" },
      { name="chain mail" },
    },
  },
  copy_add = {
    hd_size = 8,
    max_life = 8,
    fortitude_save = 2,
    will_save = 2,
    skill_point = 2,
  },
  talents = {
    [ActorTalents.T_HEAL_LIGHT_WOUNDS]=1,
    [ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_HEAVY_ARMOR_PROFICIENCY]=1,
  },
  talents_types = {
    ["cleric/cleric"] = {true, 0.0},
  },
  descriptor_choices = {
    domains = {
      __ALL__ = "allow",
    }
  },
}

newBirthDescriptor {
  type = 'class',
  name = 'Druid',
  desc = [[Clerics of nature. HD d8. Fort +2 Will +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="quarterstaff" },
      { name="padded armor" },
    },
  },
  copy_add = {
  hd_size = 8,
  max_life = 8,
  fortitude_save = 2,
  will_save = 2,
  skill_point = 4,
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
}  


newBirthDescriptor {
  type = 'class',
  name = 'Fighter',
  desc = [[Simple fighters, they hack away with their trusty weapon. HD d10, BAB +1, Fort +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="long sword" },
      { name="chain mail" },
    },
},
  copy_add = {
  hd_size = 10,
  max_life = 10,
  combat_attack = 1,
  fortitude_save = 2,
  skill_point = 2,
  },
  talents = {
    [ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_HEAVY_ARMOR_PROFICIENCY]=1,
  },
}


newBirthDescriptor {
  type = 'class',
  name = 'Ranger',
  desc = [[Rangers are capable archers but are also trained in hand to hand combat and divine magic. HD d8, BAB +1, Fort +2, Ref +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="long sword" },
      { name="studded leather" },
    },
},
  copy_add = {
  hd_size = 8,
  max_life = 8,
  combat_attack = 1,
  fortitude_save = 2,
  reflex_save = 2,
  skill_point = 6,
  },
  talents = {
    [ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
  },
}

newBirthDescriptor {
  type = 'class',
  name = 'Rogue',
  desc = [[Rogues are masters of tricks. HD d6, Ref +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="iron dagger" },
      { name="studded leather" },
    },
},
  copy_add = {
  hd_size = 6,
  max_life = 6,
  reflex_save = 2,
  sneak_attack = 1,
  skill_point = 8,
  },
  talents = {
    [ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
  },
  }

newBirthDescriptor {
  type = 'class',
  name = 'Wizard',
  desc = [[Masters of arcane magic. HD d4, Will +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="iron dagger" },
      },
},
  copy_add = {
  hd_size = 4,
  max_life = 4,
  will_save = 2,
  skill_point = 2,
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
}


--Non-standard classes
newBirthDescriptor {
  type = 'class',
  name = 'Warlock',
  desc = [[A spellcaster who needs no weapon. HD d6, Will +2 at first level.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="long sword" },
      { name="chain shirt" },
    },
  },
  copy_add = {
  hit_die = 6,
  max_life = 6,
  will_save = 2,
  skill_point = 2,
  },
  talents = {
    [ActorTalents.T_ELDRITCH_BLAST]=1,
    [ActorTalents.T_LIGHT_ARMOR_PROFICIENCY]=1,
    [ActorTalents.T_MEDIUM_ARMOR_PROFICIENCY]=1,
    },
} 
