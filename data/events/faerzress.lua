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

-- Find a random spot
local x, y = game.state:findEventGrid(level)
if not x then return false end

local g = game.level.map(x, y, engine.Map.TERRAIN):cloneFull()
g.name = "faerzess"
g.display='&' g.color_r=200 g.color_g=200 g.color_b=0 g.notice = true
g:removeAllMOs()

game.zone:addEntity(game.level, g, "terrain", x, y)

local on_stand = function(self, x, y, who) who:setEffect(who.EFF_FAERZRESS, 1, {}) end

local grids = core.fov.circle_grids(x, y, 2, "do not block")
for x, yy in pairs(grids) do for y, _ in pairs(yy) do
	local g = game.level.map(x, y, engine.Map.TERRAIN):cloneFull()
	g.on_stand = g.on_stand or on_stand
	g.on_stand_safe = true
	game.zone:addEntity(game.level, g, "terrain", x, y)
end end
return true
