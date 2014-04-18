-- Veins of the Earth
-- Copyright (C) 2013 Zireael
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

name = "VotE"
long_name = "The Veins of the Earth"
short_name = "veins"
author = { "Zireael", "x" }
homepage = "https://github.com/Zireael07/The-Veins-of-the-Earth"
version = {0,16,0}
engine = {1,1,5,"te4"}
description = [[
In DarkGod's words, #GOLD#"a fantasy d20-themed dungeon crawler"#LAST#.
You are an adventurer in a world of immense sunless corridors and tunnels. How long can you survive?

***
Please use either the built-in #LIGHT_RED#report error function#LAST# (remember to fill in "what I was doing" field) or report any bugs on ToME 4 forums. 

Liked it? Disliked? Wished for a feature? Let me know - there are multiple ways to contact me, including GitHub, ModDB and various forums.

Know some Lua? All contributions are welcome!

]]
starter = "mod.load"

no_get_name = true

show_only_on_cheat = false -- Example modules are not shown to normal players

allow_userchat = true -- We can talk to the online community

profile_stats_fields = {"scores"}

profile_defs = {
	scores = {
		nosync=true,
		receive=function(data,save)
			save.sc = save.sc or {}
			save.sc[data.world] = save.sc[data.world] or {}
			save.sc[data.world].alive = save.sc[data.world].alive or {}
			save.sc[data.world].dead = save.sc[data.world].dead or {}
			if data.type == "alive" then
				save.sc[data.world].alive = save.sc[data.world].alive or {}
				save.sc[data.world].alive[data.name] = data
			else
				-- clear any 'alive' entry with this name
				save.sc[data.world].alive[data.name] = nil
				save.sc[data.world].dead = save.sc[data.world].dead or {}
				save.sc[data.world].dead[#save.sc[data.world].dead+1] = data
			end
		end
	},
}


score_formatters = {
	["Veins"] = {
		alive="#LIGHT_GREEN#{score} : #LIGHT_BLUE#{name}#LAST# the #LIGHT_RED#{role} (level {level})#LAST# is still alive and well in the #GREEN#{where}#LAST##WHITE#",
		dead="{score} : #LIGHT_BLUE#{name}#LAST# the #LIGHT_RED#{role} (level {level})#LAST# died in the #GREEN#{where}#LAST#"

	},
}

--"Wait finished, counted NNN, MMM ticks." This is NNN
loading_wait_ticks = 39

load_tips = {
  { text = [[If you are a spellcaster, you should pick your spells and rest ASAP to gain them.]] },
  { text = [[If a monster has negative hp, you can simply wait until it bleeds out.]] },
  { text = [[Remember to wear your armor.]]},
}

background_name = {
    "Veins" 
}
