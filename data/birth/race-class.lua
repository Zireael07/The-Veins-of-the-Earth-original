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

newBirthDescriptor {
  type = 'race',
  name = 'Human',
  desc = [[Humans are the basic race to which all others are compared.]],
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
  }
}

newBirthDescriptor {
  type = 'race',
  name = 'Drow',
  desc = [[The drow are kin to the Fair Folk, who descended underground long ago. Dex +2 Con -2 Int +2 Cha +2 Luc -2.]],
  stats = { dex = 2, con = -2, int = 2, cha = 2, luc = -2, },
copy_add = {
  infravision = 3,
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

newBirthDescriptor {
  type = 'race',
  name = 'Dwarf',
  desc = [[A race of tough fighters and miners. Con +2, Cha -2.]],
  stats = { con = 2, cha = -2, },
  copy_add = {
  infravision = 1,
  }
}

newBirthDescriptor {
  type = 'class',
  name = 'Fighter',
  desc = [[Simple fighters, they hack away with their trusty weapon. HD d10, BAB +1.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="long sword" },
      { name="chain mail" },
    },
},
  copy_add = {
  hit_die = 10,
  max_life = 10,
  combat_attack = 1,
  fortitude_save = 2,
  },
}

newBirthDescriptor {
  type = 'class',
  name = 'Wizard',
  desc = [[Masters of arcane magic. HD d4.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="iron dagger" },
      },
},
  copy_add = {
  hit_die = 4,
  max_life = 4,
  will_save = 2,
  },
  talents = {
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

newBirthDescriptor {
  type = 'class',
  name = 'Ranger',
  desc = [[Rangers are capable archers but are also trained in hand to hand combat and divine magic. HD d8.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="long sword" },
      { name="studded leather" },
    },
},
  copy_add = {
  hit_die = 8,
  max_life = 8,
  combat_attack = 1,
  fortitude_save = 2,
  reflex_save = 2,
  },
}

newBirthDescriptor {
  type = 'class',
  name = 'Rogue',
  desc = [[Rogues are masters of tricks. HD d6.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="iron dagger" },
      { name="studded leather" },
    },
},
  copy_add = {
  hit_die = 6,
  max_life = 6,
  reflex_save = 2,
  sneak_attack = 1,
  },
  }

newBirthDescriptor {
  type = 'class',
  name = 'Cleric',
  desc = [[Clerics are masters of healing. HD d8.]],
  copy = {
    resolvers.equip {
      full_id=true,
      { name="heavy mace" },
      { name="chain mail" },
    },
  },
  copy_add = {
    hit_die = 8,
    max_life = 8,
    fortitude_save = 2,
    will_save = 2,
  },
  talents = {
    [ActorTalents.T_HEAL_LIGHT_WOUNDS]=1,
  },
}

newBirthDescriptor {
  type = 'class',
  name = 'Barbarian',
  desc = [[Simple fighters, they hack away with their trusty weapon. HD d12, BAB +1.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="iron battleaxe" },
      { name="chain mail" },
    },
  },
  copy_add = {
  hit_die = 12,
  max_life = 12,
  combat_attack = 1,
  fortitude_save = 2,
  },
} 

newBirthDescriptor {
  type = 'class',
  name = 'Druid',
  desc = [[Clerics of nature. HD d8.]],
  copy = {
  resolvers.equip {
      full_id=true,
      { name="quarterstaff" },
      { name="padded armor" },
    },
  },
  copy_add = {
  hit_die = 8,
  max_life = 8,
  fortitude_save = 2,
  will_save = 2,
  },
}  

newBirthDescriptor {
  type = 'class',
  name = 'Warlock',
  desc = [[A spellcaster who needs no weapon. HD d6.]],
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
  },
  talents = {
    [ActorTalents.T_ELDRITCH_BLAST]=1,
  },
} 
