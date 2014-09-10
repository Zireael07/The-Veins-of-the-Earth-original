-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
require "engine.Grid"
local DamageType = require "engine.DamageType"

module(..., package.seeall, class.inherit(engine.Grid))

function _M:init(t, no_default)
	engine.Grid.init(self, t, no_default)
end

function _M:block_move(x, y, e, act, couldpass)
	-- Open doors
	if self.door_opened and act then
		game.level.map(x, y, engine.Map.TERRAIN, game.zone.grid_list.DOOR_OPEN)
		return true
	elseif self.door_opened and not couldpass then
		return true
	end

	-- Pass walls
	if e and self.can_pass and e.can_pass then
		for what, check in pairs(e.can_pass) do
			if self.can_pass[what] and self.can_pass[what] <= check then return false end
		end
	end

	return self.does_block_move
end

function _M:on_move(x, y, who, forced)
	if forced then return end
	if who.move_project and next(who.move_project) then
		for typ, dam in pairs(who.move_project) do
			DamageType:get(typ).projector(who, x, y, typ, dam)
		end
	end
end

--Make it more informative!!!
function _M:tooltip(x, y)
	if not x or not y then return tstring("") end
	local tstr
	local dist = nil
	if game.player.x and game.player.y then dist = tstring{" (range: ", {"font", "italic"}, {"color", "LIGHT_GREEN"}, tostring(core.fov.distance(game.player.x, game.player.y, x, y)), {"color", "LAST"}, {"font", "normal"}, ")"} end
	--what does this block even do?
	if self.show_tooltip then
		local name = ((self.show_tooltip == true) and self.name or self.show_tooltip)
		if self.desc then
			tstr = tstring{{"uid", self.uid}, name}
			if dist then tstr:merge(dist) end
			tstr:add(true, self.desc, true)
		else
			tstr = tstring{{"uid", self.uid}, name}
			if dist then tstr:merge(dist) end
			tstr:add(true)
		end
	else
		tstr = tstring{{"uid", self.uid}, self.name}
		if dist then tstr:merge(dist) end
		tstr:add(true)
	end

	--More info
	if game.player:hasLOS(x, y) then tstr:add({"color", "CRIMSON"}, "In sight", {"color", "LAST"}, true) end
	
	if game.level.map.seens(x, y) then tstr:add({"color", "CRIMSON"}, "Seen", {"color", "LAST"}, true) end

	if game.level.map.lites(x, y) then tstr:add({"color", "YELLOW"}, "Lit", {"color", "LAST"}, true) end
	if self:check("block_sight", x, y) then tstr:add({"color", "SANDY_BROWN"}, "Blocks sight", {"color", "LAST"}, true) end
	if self:check("block_move", x, y, game.player) then tstr:add({"color", "SANDY_BROWN"}, "Blocks movement", {"color", "LAST"}, true) end

	if self:attr("dig") then tstr:add({"color", "SANDY_BROWN"}, "Diggable", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "no_teleport") then tstr:add({"color", "VIOLET"}, "Cannot teleport to this place", {"color", "LAST"}, true) end

	return tstr

end

--Overloads to show exits on minimap:
function _M:setupMinimapInfo(mo, map)
	if self:check("block_move") then mo:minimap(150, 150, 150)
	elseif self:check("change_level") then mo:minimap(255, 255, 0)
	else mo:minimap(0, 0, 0)
	end
end
