-- Veins of the Earth
-- Copyright (C) 2013-2016 Zireael
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
homepage = "http://veins-of-the-earth.wikidot.com/"
version = {0,35,0}
engine = {1,4,8,"te4"}
description = [[
#SANDY_BROWN# BETA 12.5#LAST#
In DarkGod's words, #GOLD#"a fantasy d20-themed dungeon crawler"#LAST#.
You are an adventurer in a world of immense sunless corridors and tunnels. How long can you survive?

***
Please report any bugs you encounter by contacting me (see below).

Liked it? Disliked? Wished for a feature? Let me know - there are multiple ways to contact me, including GitHub, ModDB, Roguetemple forums, Bay12 forums and others.

Know some Lua? All contributions are welcome!

]]
starter = "mod.load"

no_get_name = true

show_only_on_cheat = false -- Example modules are not shown to normal players

allow_userchat = true -- We can talk to the online community

profile_stats_fields = {"scores"}

profile_defs = {
achievements = { nosync = true,
    {id="index:string:40"}, {gained_on="timestamp"}, {who="string:50"}, {turn="number"}, receive=function(data, save) save[data.id] = {who=data.who, when=data.gained_on, turn=data.turn} end, export=function(env) for id, v in pairs(env) do add{id=id, who=v.who, gained_on=v.when, turn=v.turn} end end },
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
loading_wait_ticks = 140

load_tips = {
  { text = [[If you are a spellcaster, you should prepare your spells in your spellbook and rest ASAP to gain them.]] },
  { text = [[If a monster is wounded, it will flee. Unless it can heal, you do not have to worry.]] },
  { text = [[Remember to wear your armor.]]},
  { text = [[Some spellcasters do not have to memorize their spells - they can cast them innately.]]},
  { text = [[If you're lucky when creating your hero, you might get some innate spells or resistances!]]},
  { text = [[Certain races have innate magical abilities due to exposure to magical radiation.]]},
  { text = [[Remember that being unable to move does not mean you're dead (yet).]]},
  { text = [[If you are a spellcaster or a rogue with Use Magic Device skill, you can use wands.]]},
  { text = [[Do not rush into fights if you are wounded. Take your time to rest.]]},
  { text = [[Use your spellbook to prepare your spells. Remember that you have to rest to memorize them.]]},
  { text = [[A divine patron may aid you in times of need. However, he or she might grow angry and smite you.]]},
  { text = [[Look out for altars to sacrifice creatures, their corpses and items on.]]},
  { text = [[You don't need an altar to pray to your divine patron.]]},
  { text = [[Click "Graphics Mode" to bring up a menu where you can toggle tiles on/off.]]}
}

background_name = {
    "Veins"
}
