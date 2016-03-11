-- Veins of the Earth
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

--Assume "players" faction is for good or neutral players
--Evil players have their own faction

engine.Faction:add{ name="Neutral", reaction={}, }
--Shopkeepers shouldn't fight random monsters
engine.Faction:setInitialReaction("neutral", "enemies", 0, true)
engine.Faction:setInitialReaction("neutral", "players", 0, true)
engine.Faction:setInitialReaction("neutral", "players_evil", 0, true)

engine.Faction:add{ name="Allies", reaction={}, }
engine.Faction:setInitialReaction("allies", "enemies", -100, true)
engine.Faction:setInitialReaction("allies", "players", 100, true)
engine.Faction:setInitialReaction("allies", "players_evil", 100, true)

engine.Faction:add{ name="Good", reaction={}, }
engine.Faction:setInitialReaction("good", "enemies", -100, true)
engine.Faction:setInitialReaction("good", "players", 0, true)
engine.Faction:setInitialReaction("good", "players_evil", -100, true)

engine.Faction:add{ name="Evil", reaction={}, }
engine.Faction:setInitialReaction("evil", "enemies", 0, true)
engine.Faction:setInitialReaction("evil", "players", -100, true)
engine.Faction:setInitialReaction("evil", "players_evil", 0, true)

--Special faction for evil players
engine.Faction:add{ name="players_evil", reaction={}, }
engine.Faction:setInitialReaction("players_evil", "enemies", -100, true)
engine.Faction:setInitialReaction("players_evil", "allies", 100, true)

--To make vermin friendship ego easier
engine.Faction:add {name="Vermin", reaction={}, }
engine.Faction:setInitialReaction("vermin", "enemies", 0, true)
engine.Faction:setInitialReaction("vermin", "players", -100, true)
engine.Faction:setInitialReaction("vermin", "players_evil", -100, true)

--Drow houses
engine.Faction:add { shortname="baenre", name="House Baenre", reaction={}, }
engine.Faction:setInitialReaction("baenre", "players", 0, true)
engine.Faction:setInitialReaction("baenre", "players_evil", 0, true)
engine.Faction:setInitialReaction("baenre", "enemies", -100, true)

engine.Faction:add { shortname="armgo", name="House Armgo", reaction={}, }
engine.Faction:setInitialReaction("armgo", "players", 0, true)
engine.Faction:setInitialReaction("armgo", "players_evil", 0, true)
engine.Faction:setInitialReaction("armgo", "enemies", -100, true)

engine.Faction:add { shortname="tlabbar", name="House Tlabbar", reaction={}, }
engine.Faction:setInitialReaction("tlabbar", "players", 0, true)
engine.Faction:setInitialReaction("tlabbar", "players_evil", 0, true)
engine.Faction:setInitialReaction("tlabbar", "enemies", -100, true)

engine.Faction:add { shortname="mizzrym", name="House Mizzrym", reaction={}, }
engine.Faction:setInitialReaction("mizzrym", "players", 0, true)
engine.Faction:setInitialReaction("mizzrym", "players_evil", 0, true)
engine.Faction:setInitialReaction("mizzrym", "enemies", -100, true)

engine.Faction:add { shortname="nasadra", name="House Nasadra", reaction={}, }
engine.Faction:setInitialReaction("nasadra", "players", 0, true)
engine.Faction:setInitialReaction("nasadra", "players_evil", 0, true)
engine.Faction:setInitialReaction("nasadra", "enemies", -100, true)

engine.Faction:add { shortname="auvryndar", name="House Auvryndar", reaction={}, }
engine.Faction:setInitialReaction("auvryndar", "players", 0, true)
engine.Faction:setInitialReaction("auvryndar", "players_evil", 0, true)
engine.Faction:setInitialReaction("auvryndar", "enemies", -100, true)

engine.Faction:add { shortname="aleanrahel", name="House Aleanrahel", reaction={}, }
engine.Faction:setInitialReaction("aleanrahel", "players", 0, true)
engine.Faction:setInitialReaction("aleanrahel", "players_evil", 0, true)
engine.Faction:setInitialReaction("aleanrahel", "enemies", -100, true)
