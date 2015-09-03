-- Veins of the Earth
-- Copyright (C) 2015 Zireael
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
local Map = require "engine.Map"
local BSP = require "engine.BSP"
require "engine.Generator"
local RoomsLoader = require "engine.generator.map.RoomsLoader"
module(..., package.seeall, class.inherit(engine.Generator, RoomsLoader))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level)
	self.data = data
	self.grid_list = self.zone.grid_list
	self.max_building_w = data.max_building_w or 12
	self.max_building_h = data.max_building_h or 12
	self.building_chance = data.building_chance or  85
	self.lshape_chance = data.lshape_chance or 50
	self.double_lshape_chance = data.double_lshape_chance or 40
	self.yard_chance = data.yard_chance or 30

	RoomsLoader.init(self, data)
end

function _M:Lshape(bdoor_grids, inner_grids, x1, x2, y1, y2, ix1, ix2, iy1, iy2)
	if #inner_grids == 0 then return end
	local door_grids = self:makeGridList()
	local void = rng.percent(self.yard_chance)
	local point = rng.tableRemove(inner_grids)
	local dx1, dx2 = math.abs(point.x - ix1), math.abs(point.x - ix2)
	local dy1, dy2 = math.abs(point.y - iy1), math.abs(point.y - iy2)
	if dx1 == dx2 then if rng.percent(50) then dx1 = dx1 + 1 else dx2 = dx2 + 1 end end
	if dy1 == dy2 then if rng.percent(50) then dy1 = dy1 + 1 else dy2 = dy2 + 1 end end
	print("room", dx1, dx2, "::", dy1, dy2)

	if dx2 > dx1 and dy2 > dy1 then
		for i = point.x, x2 do door_grids:add(i,point.y) self.map(i, point.y, Map.TERRAIN, self:resolve("wall")) end
		for j = point.y, y2 do door_grids:add(point.x,j) self.map(point.x, j, Map.TERRAIN, self:resolve("wall")) end
		for i = point.x+1, x2 do for j = point.y+1, y2 do if void then self.map(i, j, Map.TERRAIN, self:resolve("external_floor")) end end end
		bdoor_grids:remove(x2+1, point.y)
		bdoor_grids:remove(point.x, y2+1)
	elseif dx1 > dx2 and dy2 > dy1 then
		for i = x1, point.x do door_grids:add(i,point.y) self.map(i, point.y, Map.TERRAIN, self:resolve("wall")) end
		for j = point.y, y2 do door_grids:add(point.x,j) self.map(point.x, j, Map.TERRAIN, self:resolve("wall")) end
		for i = x1, point.x-1 do for j = point.y+1, y2 do if void then self.map(i, j, Map.TERRAIN, self:resolve("external_floor")) end end end
		bdoor_grids:remove(x1-1, point.y)
		bdoor_grids:remove(point.x, y2+1)
	elseif dx1 > dx2 and dy1 > dy2 then
		for i = x1, point.x do door_grids:add(i,point.y) self.map(i, point.y, Map.TERRAIN, self:resolve("wall")) end
		for j = y1, point.y do door_grids:add(point.x,j) self.map(point.x, j, Map.TERRAIN, self:resolve("wall")) end
		for i = x1, point.x-1 do for j = y1, point.y-1 do if void then self.map(i, j, Map.TERRAIN, self:resolve("external_floor")) end end end
		bdoor_grids:remove(x1-1, point.y)
		bdoor_grids:remove(point.x, y1-1)
	elseif dx2 > dx1 and dy1 > dy2 then
		for i = point.x, x2 do door_grids:add(i,point.y) self.map(i, point.y, Map.TERRAIN, self:resolve("wall")) end
		for j = y1, point.y do door_grids:add(point.x,j) self.map(point.x, j, Map.TERRAIN, self:resolve("wall")) end
		for i = point.x+1, x2 do for j = y1, point.y-1 do if void then self.map(i, j, Map.TERRAIN, self:resolve("external_floor")) end end end
		bdoor_grids:remove(x2+1, point.y)
		bdoor_grids:remove(point.x, y1-1)
	end
	door_grids:remove(point.x, point.y)

	-- Door
	if door_grids:count() > 0 then
		local door = rng.table(door_grids:toList())
		self.map(door.x, door.y, Map.TERRAIN, self:resolve("door"))
	end
end

function _M:building(leaf, spots)
	local x1, x2 = leaf.rx + rng.range(2, math.max(2, math.floor(leaf.w / 2 - 3))), leaf.rx + leaf.w - rng.range(2, math.max(2, math.floor(leaf.w / 2 - 3)))
	local y1, y2 = leaf.ry + rng.range(2, math.max(2, math.floor(leaf.h / 2 - 3))), leaf.ry + leaf.h - rng.range(2, math.max(2, math.floor(leaf.h / 2 - 3)))
	local ix1, ix2, iy1, iy2 = x1 + 2, x2 - 2, y1 + 2, y2 - 2
	local inner_grids = {}
	local door_grids = self:makeGridList()

	for i = leaf.rx, leaf.rx + leaf.w do for j = leaf.ry, leaf.ry + leaf.h do
		-- Abort if there is something already
		if self.map:isBound(i, j) and self.map.room_map[i][j].room then return end
	end end

	for i = x1, x2 do for j = y1, y2 do
		self.map.room_map[i][j].is_building = true
		if i == x1 or i == x2 or j == y1 or j == y2 then
			self.map(i, j, Map.TERRAIN, self:resolve("wall"))
			if not (i == x1 and j == y1) and not (i == x2 and j == y1) and not (i == x1 and j == y2) and not (i == x2 and j == y2) then
				door_grids:add(i, j)
			end
		else
			self.map(i, j, Map.TERRAIN, self:resolve("floor"))
			if i >= ix1 and i <= ix2 and j >= iy1 and j <= iy2 then
				inner_grids[#inner_grids+1] = {x=i,y=j}
			end
		end
	end end

	-- L shape
	if rng.percent(self.lshape_chance) then
		self:Lshape(door_grids, inner_grids, x1, x2, y1, y2, ix1, ix2, iy1, iy2)
	end

	-- Door
	local door = rng.table(door_grids:toList())
	self.map(door.x, door.y, Map.TERRAIN, self:resolve("door"))

	spots[#spots+1] = {x=math.floor((x1+x2)/2), y=math.floor((y1+y2)/2), type="building", subtype="building"}
end

function _M:generate(lev, old_lev)
	for i = 0, self.map.w - 1 do for j = 0, self.map.h - 1 do
		self.map(i, j, Map.TERRAIN, self:resolve("external_floor"))
	end end

	local spots = {}
	self.spots = spots

	local nb_room = util.getval(self.data.nb_rooms or 0)
	local rooms = {}
	while nb_room > 0 do
		local rroom
		while true do
			rroom = self.rooms[rng.range(1, #self.rooms)]
			if type(rroom) == "table" and rroom.chance_room then
				if rng.percent(rroom.chance_room) then rroom = rroom[1] break end
			else
				break
			end
		end

		local r = self:roomAlloc(rroom, #rooms+1, lev, old_lev)
		if r then rooms[#rooms+1] = r end
		nb_room = nb_room - 1
	end

	local bsp = BSP.new(self.map.w, self.map.h, self.max_building_w, self.max_building_h)
	bsp:partition()

	print("Town gen made ", #bsp.leafs, "BSP leafs")
	for z, leaf in ipairs(bsp.leafs) do
		if rng.percent(self.building_chance) then
			self:building(leaf, spots)
		end
	end

	local ux, uy, dx, dy
	if self.data.edge_entrances then
		ux, uy, dx, dy, spots = self:makeStairsSides(lev, old_lev, self.data.edge_entrances, spots)
	else
		ux, uy, dx, dy, spots = self:makeStairsInside(lev, old_lev, spots)
	end

    self:makeWall()

	return ux, uy, dx, dy, spots
end

function _M:makeWall()
    local i, j = 0, 0
	for i = 0, self.level.map.w - 2 do
		self.map(i, j, Map.TERRAIN, self:resolve("external_wall"))
	end

	j = self.level.map.h - 1
	for i = 0, self.level.map.w - 2 do
		self.map(i, j, Map.TERRAIN, self:resolve("external_wall"))
	end

	i = 0
	for j = 1, self.level.map.h - 2 do
		self.map(i, j, Map.TERRAIN, self:resolve("external_wall"))
	end

	i = self.level.map.w - 2
	for j = 1, self.level.map.h - 2 do
		self.map(i, j, Map.TERRAIN, self:resolve("external_wall"))
	end

	dx, dy = self.level.map.w -2, rng.range(1, self.map.h -2)
		self.map(dx, dy, Map.TERRAIN, self:resolve("gate"))
end

--- Create the stairs inside the level
function _M:makeStairsInside(lev, old_lev, spots)
	-- Put down stairs
	local dx, dy
	if lev < self.zone.max_level or self.data.force_last_stair then
		while true do
			dx, dy = rng.range(1, self.map.w - 1), rng.range(1, self.map.h - 1)
			if not self.map:checkEntity(dx, dy, Map.TERRAIN, "block_move") and not self.map.room_map[dx][dy].special then
				self.map(dx, dy, Map.TERRAIN, self:resolve("down"))
				self.map.room_map[dx][dy].special = "exit"
				break
			end
		end
	end

	-- Put up stairs
	local ux, uy
	while true do
		ux, uy = rng.range(1, self.map.w - 1), rng.range(1, self.map.h - 1)
		if not self.map:checkEntity(ux, uy, Map.TERRAIN, "block_move") and not self.map.room_map[ux][uy].special then
			self.map(ux, uy, Map.TERRAIN, self:resolve("up"))
			self.map.room_map[ux][uy].special = "exit"
			break
		end
	end

	return ux, uy, dx, dy, spots
end

--- Create the stairs on the sides
function _M:makeStairsSides(lev, old_lev, sides, spots)
	-- Put down stairs
	local dx, dy
	if lev < self.zone.max_level or self.data.force_last_stair then
		while true do
			if     sides[2] == 4 then dx, dy = 0, rng.range(0, self.map.h - 1)
			elseif sides[2] == 6 then dx, dy = self.map.w - 1, rng.range(0, self.map.h - 1)
			elseif sides[2] == 8 then dx, dy = rng.range(0, self.map.w - 1), 0
			elseif sides[2] == 2 then dx, dy = rng.range(0, self.map.w - 1), self.map.h - 1
			end

			if not self.map.room_map[dx][dy].special then
				self.map(dx, dy, Map.TERRAIN, self:resolve("down"))
				self.map.room_map[dx][dy].special = "exit"
				break
			end
		end
	end

	-- Put up stairs
	local ux, uy
	while true do
		if     sides[1] == 4 then ux, uy = 0, rng.range(0, self.map.h - 1)
		elseif sides[1] == 6 then ux, uy = self.map.w - 1, rng.range(0, self.map.h - 1)
		elseif sides[1] == 8 then ux, uy = rng.range(0, self.map.w - 1), 0
		elseif sides[1] == 2 then ux, uy = rng.range(0, self.map.w - 1), self.map.h - 1
		end

		if not self.map.room_map[ux][uy].special then
			self.map(ux, uy, Map.TERRAIN, self:resolve("up"))
			self.map.room_map[ux][uy].special = "exit"
			break
		end
	end

	return ux, uy, dx, dy, spots
end
