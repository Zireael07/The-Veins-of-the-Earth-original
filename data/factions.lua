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

engine.Faction:add{ name="Neutral", reaction={}, }
engine.Faction:setInitialReaction("neutral", "enemies", -100, true)

engine.Faction:add{ name="Allies", reaction={}, }
engine.Faction:setInitialReaction("allies", "enemies", -100, true)

engine.Faction:add{ name="Good", reaction={}, }
engine.Faction:setInitialReaction("evil", "enemies", -100, true)

engine.Faction:add{ name="Evil", reaction={}, }
engine.Faction:setInitialReaction("evil", "enemies", 0, true)