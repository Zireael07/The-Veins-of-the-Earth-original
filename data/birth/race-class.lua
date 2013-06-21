-- $Id: race-class.lua 93 2012-11-10 04:58:24Z dsb $
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
  stats = { cha = 1, },
  copy_add = {
  }
}

newBirthDescriptor {
  type = 'race',
  name = 'Elf',
  desc = [[Elves are also called the Fair Folk.]],
  stats = { dex = 1, con = -1, },
copy_add = {
  infravision = 1,
  }
}

newBirthDescriptor {
  type = 'race',
  name = 'Drow',
  desc = [[The drow are kin to the Fair Folk, who descended underground long ago.]],
  stats = { dex = 1, con = -1, int = 1, cha = 1, luc = -1, },
copy_add = {
  infravision = 3,
  }
}

newBirthDescriptor {
  type = 'class',
  name = 'Warrior',
  desc = [[Simple fighters, they hack away with their trusty weapon.]],
  copy_add = {
  hit_die = 10
  }
}

newBirthDescriptor {
  type = 'class',
  name = 'Mage',
  desc = [[The basic unspecialized warrior-spellcaster]],
    copy_add = {
  hit_die = 4
  }
  }

newBirthDescriptor {
  type = 'class',
  name = 'Ranger',
  desc = [[Rangers are capable archers but are also trained in hand to hand combat and nature/conveyance/divination magic schools]],
  copy_add = {
  hit_die = 8
  }
}

newBirthDescriptor {
  type = 'class',
  name = 'Rogue',
  desc = [[Rogues are masters of tricks. They can steal from shops and monsters, and lure monsters into deadly monster traps.]],
    copy_add = {
  hit_die = 6
  }
  }

