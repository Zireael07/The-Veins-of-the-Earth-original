-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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

--load("/data/general/traps/natural_forest.lua")

newEntity{ define_as = "TRAP_TUTORIAL",
	type = "tutorial", subtype="tutorial", id_by_type=true, unided_name = "tutorial",
	detect_power = 999999, disarm_power = 999999,
	desc = [[A tutorial]],
	display = ' ', color=colors.WHITE,
	message = false,
	triggered = function(self, x, y, who)
		if who.player then
			game.player:runStop()
			local d = require("engine.dialogs.ShowText").new("Tutorial: "..self.name, "tutorial/"..self.text)
			game:registerDialog(d)
		end
		return false, false
	end
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_MOVE",
	name = "Movement",
	text = "move",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_MELEE",
	name = "Melee Combat",
	text = "melee",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_OBJECTS",
	name = "Objects",
	text = "objects",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_TALENTS",
	name = "Talents",
	text = "talents",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_LEVELUP",
	name = "Experience and Levels",
	text = "levelup",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_TERRAIN",
	name = "Different terrains",
	text = "terrain",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_TACTICS1",
	name = "Basic tactic: Do not get surrounded",
	text = "tactics1",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_TACTICS2",
	name = "Basic tactic: Take cover",
	text = "tactics2",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_RANGED",
	name = "Ranged Combat",
	text = "ranged",
}

newEntity{ base = "TRAP_TUTORIAL", define_as = "TUTORIAL_QUESTS",
	name = "Quests",
	text = "quests",
}
