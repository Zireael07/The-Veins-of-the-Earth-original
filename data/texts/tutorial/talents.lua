-- Veins of the Earth
-- Copyright (C) 2014 Zireael
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


if not game.player.tutored_levels then
	game.player:learnTalent(game.player.T_MAGIC_MISSILE, true, 1, {no_unlearn=true})
	game.player.tutored_levels = true
end

return [[You now possess some spell-casting abilities.
Look down to find the magic missile spell! 
Numbers cast spells, remember? You can also bring up a list of them!

Now open your spellbook and see all that delicious magic at your fingertips!

Abilities come in three types:
* #GOLD#Active#WHITE#: A talent that is activated when you use it and has an instantaneous effect.
* #GOLD#Sustained#WHITE#: A talent that must be turned on and lasts until it is turned off. Usually this will reduce your maximum resource available (stamina in this case).
* #GOLD#Passive#WHITE#: A talent that provides an ever-present benefit.

Some of them require a target, when you use them the interface will change to let you select the target:
* #GOLD#Using the keyboard#WHITE#: Pressing a direction key will shift between possible targets. Pressing shift+direction will move freely to any spot. Enter or space will confirm the target.
* #GOLD#Using the mouse#WHITE#: Moving your mouse will move the target around. Left-click will confirm it.
]]
