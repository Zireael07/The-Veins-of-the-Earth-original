-- Veins of the Earth
-- Copyright (C) 2013-2014 Zireael
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

require "engine.class"
require "engine.Grid"
local DamageType = require "engine.DamageType"

module(..., package.seeall, class.inherit(engine.Grid))

function _M:init(t, no_default)
	engine.Grid.init(self, t, no_default)
end

function _M:block_move(x, y, e, act, couldpass)
	-- Path strings
	if not e then e = {}
	elseif type(e) == "string" then
		e = loadstring(e)()
	end


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

	--Overmap tiles tell you where they lead if you've visited at least once
	if self.change_zone and game.visited_zones[self.change_zone] then
		tstr:add(true, {"font","bold"}, {"color","GOLD"}, self.change_zone, {"color", "LAST"}, {"font","normal"}, true)
	end

	--More info
	if game.player:hasLOS(x, y) then tstr:add({"color", "CRIMSON"}, "In sight", {"color", "LAST"}, true) end

	if game.level.map.seens(x, y) then tstr:add({"color", "CRIMSON"}, "Seen", {"color", "LAST"}, true) end

	if game.level.map.lites(x, y) then tstr:add({"color", "YELLOW"}, "Lit", {"color", "LAST"}, true) end
	if self:check("block_sight", x, y) then tstr:add({"color", "SANDY_BROWN"}, "Blocks sight", {"color", "LAST"}, true) end
	if self:check("block_move", x, y, game.player) then tstr:add({"color", "SANDY_BROWN"}, "Blocks movement", {"color", "LAST"}, true) end

	if self:attr("dig") then tstr:add({"color", "SANDY_BROWN"}, "Diggable", {"color", "LAST"}, true) end
	if self:attr("interact") then tstr:add({"color", "LIGHT_GREEN"}, "Interactable", {"color", "LAST"}, true) end

--	tstr:add({"color", "YELLOW"}, ("Climb: %d"):format(self.climb_dc or 0), {"color", "LAST"}, true)
--	if game.level.map.attrs(x, y, "no_teleport") then tstr:add({"color", "VIOLET"}, "Cannot teleport to this place", {"color", "LAST"}, true) end


--[[tstr:add({"color", "VIOLET"}, "Corridor", {"color", "LAST"})
    end]]

--[[	if game.level.map.attrs(x, y, "room_id", v) then tstr:add({"color", "VIOLET"}, v, {"color", "LAST"}, true)
	else tstr:add({"color", "VIOLET"}, "Corridor", {"color", "LAST"}) end]]

	--Room descriptions go here

	if game.level.map.attrs(x, y, "big_moss1") then tstr:add({"color", "VIOLET"}, "Big moss", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "big_moss2") then tstr:add({"color", "VIOLET"}, "Big moss", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "chasm1") then tstr:add({"color", "VIOLET"}, "Chasm", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "chasm2") then tstr:add({"color", "VIOLET"}, "Chasm", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "chasm3") then tstr:add({"color", "VIOLET"}, "Chasm", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "chasm4") then tstr:add({"color", "VIOLET"}, "Chasm", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "circle") then tstr:add({"color", "VIOLET"}, "Circle", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "circle2") then tstr:add({"color", "VIOLET"}, "Circle", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "icefilled") then tstr:add({"color", "VIOLET"}, "Ice filled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "ice_patch1") then tstr:add({"color", "VIOLET"}, "Ice", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "ice_patch2") then tstr:add({"color", "VIOLET"}, "Ice", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "ice_patch3") then tstr:add({"color", "VIOLET"}, "Ice", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "lake") then tstr:add({"color", "VIOLET"}, "Lake", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "lake2") then tstr:add({"color", "VIOLET"}, "Lake", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "marble") then tstr:add({"color", "VIOLET"}, "Marble", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "marble2") then tstr:add({"color", "VIOLET"}, "Marble", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "moss_patch1") then tstr:add({"color", "VIOLET"}, "Moss patch", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "moss_patch2") then tstr:add({"color", "VIOLET"}, "Moss patch", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "moss_pilar1") then tstr:add({"color", "VIOLET"}, "Moss patch", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "moss_pilar2") then tstr:add({"color", "VIOLET"}, "Moss patch", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "moss_pilar3") then tstr:add({"color", "VIOLET"}, "Moss patch", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "pilar") then tstr:add({"color", "VIOLET"}, "Pillar", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "pilar2") then tstr:add({"color", "VIOLET"}, "Pillar", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "pilar3") then tstr:add({"color", "VIOLET"}, "Pillar", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "rhomboid") then tstr:add({"color", "VIOLET"}, "Rhomboid", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "rhomboid2") then tstr:add({"color", "VIOLET"}, "Rhomboid", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "ritual") then tstr:add({"color", "VIOLET"}, "Ritual", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "ritual2") then tstr:add({"color", "VIOLET"}, "Ritual", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "simple") then tstr:add({"color", "VIOLET"}, "Simple", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "temple") then tstr:add({"color", "VIOLET"}, "Temple", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "treasure_room") then tstr:add({"color", "VIOLET"}, "Treasure room", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled2") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled3") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled4") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled_half") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled_half2") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end
	if game.level.map.attrs(x, y, "waterfilled_pilar") then tstr:add({"color", "VIOLET"}, "Waterfilled", {"color", "LAST"}, true) end


	if game.level.map.attrs(x, y, "forest_clearing") then tstr:add({"color", "VIOLET"}, "Clearing", {"color", "LAST"}, true) end


	return tstr
end

--Overloads to show exits on minimap:
function _M:setupMinimapInfo(mo, map)
	if self:check("block_move") then mo:minimap(150, 150, 150)
	elseif self:check("change_level") then mo:minimap(255, 255, 0)
	else mo:minimap(0, 0, 0)
	end
end
