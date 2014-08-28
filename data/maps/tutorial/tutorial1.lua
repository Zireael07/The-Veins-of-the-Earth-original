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


startx = 49
starty = 24

defineTile("&", "WALL", nil, nil, nil)
defineTile(")", "FLOOR", {random_filter={name="longbow"}}, nil, nil)
defineTile("s", "FLOOR", nil, "TUTORIAL_NPC_SPIDER", nil)
defineTile(",", "FLOOR", nil, nil, nil)
defineTile("S", "FLOOR", nil, {random_filter={type="vermin", max_ood=2}}, nil)
--defineTile("B", "FLOOR", nil, "TUTORIAL_NPC_GUIDE", nil)
defineTile("B", "FLOOR", nil, {random_filter={subtype="drow"}}, nil)
defineTile("1", "FLOOR", nil, nil, "TUTORIAL_MELEE")
defineTile("|", "FLOOR", {random_filter={name="arrows"}}, nil, nil)
defineTile("2", "FLOOR", {random_filter={name="potion"}}, nil, "TUTORIAL_OBJECTS")
defineTile("3", "FLOOR", nil, nil, "TUTORIAL_TALENTS")
defineTile("4", "FLOOR", nil, nil, "TUTORIAL_LEVELUP")
defineTile("~", "WATER", nil, nil, nil)
defineTile("5", "WATER", nil, nil, "TUTORIAL_TERRAIN")
defineTile("6", "FLOOR", nil, nil, "TUTORIAL_TACTICS1")
defineTile("7", "FLOOR", nil, nil, "TUTORIAL_RANGED")
defineTile("8", "FLOOR", nil, nil, "TUTORIAL_QUESTS")

return [[
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&~~~,,,&&&&&&&&
&&&&&&&&&,,,,,&&&&&&&&&&&&&&&&&&~~&&~~~&&,,,&&&&&&
&&&&&&&&,s,,,,,,,,,,,,&&&&&&&&&&~~~~~~~&&&&,&&&&&&
&&&&&&&&,s,,,,,,,,,,,,,&&&&&&&&&~~~~~~&&&&&,&&&&&&
&&&&&&&&,s,,s,,,,,,,,,,&&&&&&&&&~~~&~~&&&&&,&&&&&&
&&&&&&&,,,,,s,,,,,,,,,,,&&&&&&&&&~~~~&&&s&,,&&&&&&
&&&&&&&,,s,,s,,,,,,,,,,,,,,&&&&&,~&~~&&&,,,,&&&&&&
&&&&&&&&,s,,,,,,,,,,,,,,,&,&&&,,,~~~~&&,,,,,,&&&&&
&&&&&&&&,s,,,,,,,,,,,,,,&&,|)7,&&&~~&&&&,,,,,&&&&&
&&&&&&&&,,,,,,,,,,,,,,,&&&&&&&&&&&&&&&&&,,,,,&&&&&
&&&&&&&&&,,,,,,,,,,,,,&&&&&&&&&&,,,,,,,,,,,,&&&&&&
&&&&&&&&&&&&&&,,,,,&&&&&&&&&&&&,,&&&&&&&,,,,&&&&&&
&&&&&&&&&&&&&&&,&&&&&&&&&&&&&&,,&&&&&&&&,,,&&&&&&&
&&&&&&&&&&&&&&&,&&&&&&&&&&&&&,,&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&,&&&&&&&&&&&&&,&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&8&&&&&&&&&&&&&,&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&,,&&&&&&&&&&&&,,&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&,,&&&&&&&&&&&&&,&&&&&&&&,,,,,,,&&&&&&
&&&&&&&&&&&&&,&&&&&&&&&&&&&&,&&&&&&&,,s,,,,,,&&&&&
&&&&&&&&&&&&&,&&&&&&&&&&&&&&,&&&&&&,,,2,,,,,,1,,,,
&&&&&&&&&,,,,,,&&&&&&&&&&&&&,&&&,,,,,,s,,,,,&&&&&&
&&&&&&&&,,,,,,,,&&&&&&&&&&&&,&&&,&&&,,,,,,,,&&&&&&
&&&&&&&&,,,,,&,,,&&&&&&&&&&&,&&&,&&&&,,,,,,&&&&&&&
&&&&&&&,,&,,,,,,,,&&&&&&&&&&,&&&,&&&&&&&&&&&&&&&&&
&&&&&,,,,,,,,,&&,&,,&&&&&&&,,&&&,,&&&&&&&&&&&&&&&&
&&&&&&,,&,,,,,,,,,&,,&&&&&&,&&&&&,,&&&&&&&&&&&&&&&
&&&&&,,,,,,&&,,,,&,,&&&&&,,,&&&&&&,,,&&&&&&&&&&&&&
&&&&&&,,,,,,,,,,&,&&&&&&,SSSS,&&&&&&,,,&&&&&&&&&&&
&&&&&&,,&,&,,&&,,,&&&&&&,SSSSS,&&&&&&&,,s,s3,,&&&&
&&&&&&&,,,,,,&&&,&&&&&&,SSSSSS,&&&&&&&&&&&&&&s,&&&
&&&&&&&&,B,,,,,,,,&&&&&,SSSSS,,&&&&&&&&&&&&&&&,&&&
&&&&&&&,,,,,,&&&&&&&&&&&,SS,,,,&&&&&&&&&&&&&&&,,&&
&&&&&&&&&&&&&&&&&&&&&&&,S,,,,,&&&&&&&&&&&&&&&&&4&&
&&&&&&&&&&&&&&&&&&&&&&&&,,,,,,&&&&&&&&&~~~&&&&&,,&
&&&&&&&&&&&&&&&&&&&&&&&&&,,,,,&&&&&&&&&~~~~~&&&&s&
&&&&&&&&&&&&&&&&&&&&&&&&&&,,,&&&&&&&&~~~~&~~~&&,,&
&&&&&&&&&&&&&&&&&&&&&&&&&&&6&&&&&&&&&~~~&&&~5,,,&&
&&&&&&&&&&&&&&&&&&&&&&&&&,,,&&&&&&,,,,,~~&~~~~&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&,&&&&&&&&,&&&~~~~~~~~&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&,,,&&&&&&,&&&&~~~~~~&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&,,&&&&,,&&&&&&&~~~&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&,,,,,,&&&&&&&&&~&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&,&&&&&&&&&&&&~&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&]]
