-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2015 Nicolas Casalini
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
local Map = require "engine.Map"
local BSP = require "engine.BSP"
require "engine.Generator"
local RoomsLoader = require "engine.generator.map.RoomsLoader"
module(..., package.seeall, class.inherit(engine.Generator, RoomsLoader))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level)
	self.data = data
	self.grid_list = self.zone.grid_list
	self.max_block_w = data.max_block_w or 20
	self.max_block_h = data.max_block_h or 20
	self.max_building_w = data.max_building_w or 7
	self.max_building_h = data.max_building_h or 7
	self.margin_w = data.margin_w or 0
	self.margin_h = data.margin_h or 0

	RoomsLoader.init(self, data)
end

function _M:doorOnWall(wall)
	if wall.vert then
		local j = rng.table(table.keys(wall.ps))
		self.map(wall.base, j, Map.TERRAIN, self:resolve("door"))
	else
		local i = rng.table(table.keys(wall.ps))
		self.map(i, wall.base, Map.TERRAIN, self:resolve("door"))
	end
	wall.doored = true
end

function _M:addWall(vert, base, p1, p2)
	local walls = self.walls
	local ps = table.genrange(p1, p2, true)

	local todel = {}
	for z, _ in pairs(ps) do
		local x, y
		if vert then x, y = base, z else x, y = z, base end
		local nb =
			(game.level.map:checkEntity(x - 1, y, Map.TERRAIN, "block_move") and 1 or 0) +
			(game.level.map:checkEntity(x + 1, y, Map.TERRAIN, "block_move") and 1 or 0) +
			(game.level.map:checkEntity(x, y - 1, Map.TERRAIN, "block_move") and 1 or 0) +
			(game.level.map:checkEntity(x, y + 1, Map.TERRAIN, "block_move") and 1 or 0)
		if nb ~= 2 then todel[#todel+1] = z end
	end
	for i, z in ipairs(todel) do ps[z] = nil end

	for i = 1, #walls do
		local w = walls[i]
		if w.vert == vert and w.base == base then
			w.ps = table.minus_keys(w.ps, ps)
		end
	end

	walls[#walls+1] = {vert=vert, base=base, ps=ps}

	return walls[#walls]
end

function _M:building(leaf, spots)
--	local x1, x2 = leaf.rx + rng.range(2, math.max(2, math.floor(leaf.w / 2 - 3))), leaf.rx + leaf.w - rng.range(2, math.max(2, math.floor(leaf.w / 2 - 3)))
--	local y1, y2 = leaf.ry + rng.range(2, math.max(2, math.floor(leaf.h / 2 - 3))), leaf.ry + leaf.h - rng.range(2, math.max(2, math.floor(leaf.h / 2 - 3)))
	local x1, x2 = leaf.rx, leaf.rx + leaf.w
	local y1, y2 = leaf.ry, leaf.ry + leaf.h
	local ix1, ix2, iy1, iy2 = x1 + 2, x2 - 1, y1 + 2, y2 - 1
	local inner_grids = {}
	local door_grids = {}
	local is_lit = rng.percent(self.data.lite_room_chance or 70)

	for i = leaf.rx, leaf.rx + leaf.w do for j = leaf.ry, leaf.ry + leaf.h do

		-- Abort if there is something already
		if self.map:isBound(i, j) and self.map.room_map[i][j].room then return end
	end end

		self:placeRoom(leaf)

--[[	for i = x1, x2 do for j = y1, y2 do
		if i == x1 or i == x2 or j == y1 or j == y2 then

		self:placeRoom(leaf) end

	end end]]

--[[			if not self.map.room_map[i][j].walled then self.map(i, j, Map.TERRAIN, self:resolve("wall")) end
			self.map.room_map[i][j].walled = true
			self.map.room_map[i][j].can_open = true
		else
			self.map(i, j, Map.TERRAIN, self:resolve("floor"))
			if is_lit then self.map.lites(i, j, true) end
			if i >= ix1 and i <= ix2 and j >= iy1 and j <= iy2 then
				inner_grids[#inner_grids+1] = {x=i,y=j}
			end
		end
	end end]]

--[[	local walls = {}
	walls.up = self:addWall(false, y1, x1 + 1, x2 - 1)
	walls.down = self:addWall(false, y2, x1 + 1, x2 - 1)
	walls.left = self:addWall(true,  x1, y1 + 1, y2 - 1)
	walls.right = self:addWall(true,  x2, y1 + 1, y2 - 1)
	self.rooms[#self.rooms+1] = {cx=math.floor((x1+x2)/2), cy=math.floor((y1+y2)/2), id=#self.rooms, walls=walls}

	-- Eliminate inner grids that face the door
	for i = #inner_grids, 1, -1 do
		local g = inner_grids[i]
		if door and (g.x == door.x or g.y == door.y) then table.remove(inner_grids, i) end
	end]]

	spots[#spots+1] = {x=math.floor((x1+x2)/2), y=math.floor((y1+y2)/2), type="building", subtype="building"}
end

function _M:block(leaf, spots)
	local x1, x2 = leaf.rx, leaf.rx + leaf.w
	local y1, y2 = leaf.ry, leaf.ry + leaf.h
	local ix1, ix2, iy1, iy2 = x1 + 2, x2 - 1, y1 + 2, y2 - 1
	local inner_grids = {}
	local door_grids = {}

	for i = leaf.rx, leaf.rx + leaf.w do for j = leaf.ry, leaf.ry + leaf.h do
		-- Abort if there is something already
		if self.map:isBound(i, j) and self.map.room_map[i][j].room then return end
	end end

	local door_grids = {}
	for i = x1, x2 do for j = y1, y2 do
		if i == x1 or i == x2 or j == y1 or j == y2 then
			self.map(i, j, Map.TERRAIN, self:resolve("floor"))
		end
	end end

	local bsp = BSP.new(leaf.w-2, leaf.h-2, self.max_building_w, self.max_building_h)
	bsp:partition()

	print("Building gen made ", #bsp.leafs, "building BSP leafs")
	for z, sleaf in ipairs(bsp.leafs) do
		sleaf.rx = sleaf.rx + leaf.rx + 1
		sleaf.ry = sleaf.ry + leaf.ry + 1
		self:building(sleaf, spots)
	end
end

function _M:generate(lev, old_lev)
	for i = 0, self.map.w - 1 do for j = 0, self.map.h - 1 do
		self.map(i, j, Map.TERRAIN, self:resolve("wall"))
	end end

	local spots = {}
	self.spots = spots
	self.walls = {}
--	self.rooms = {}

	local bsp = BSP.new(self.map.w - self.margin_w, self.map.h - self.margin_h, self.max_block_w, self.max_block_h)
	bsp:partition()

	print("Building gen made ", #bsp.leafs, "blocks BSP leafs")
	for z, leaf in ipairs(bsp.leafs) do
		self:block(leaf, spots)
	end

	for i = 1, #self.walls do
		self:doorOnWall(self.walls[i])
	end

	local ux, uy, dx, dy
	if self.data.edge_entrances then
		ux, uy, dx, dy, spots = self:makeStairsSides(lev, old_lev, self.data.edge_entrances, spots)
	else
		ux, uy, dx, dy, spots = self:makeStairsInside(lev, old_lev, spots)
	end

	return ux, uy, dx, dy, spots
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


function _M:placeRoom(leaf)
	local nb_room = 1
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

	--	local r = self:roomAlloc(rroom, #rooms+1, lev, old_lev)
		local r = self:placeRoomHelper(leaf, rroom, #rooms+1, lev, old_lev)
		if r then rooms[#rooms+1] = r end
		nb_room = nb_room - 1
	end
end

function _M:placeRoomHelper(leaf, room, id, lev, old_lev, add_check)
	room = self:roomGen(room, id, lev, old_lev)
	if not room then return end

	local tries = 100
	while tries > 0 do
		local ok = true
		local x, y = rng.range(1, leaf.w - 2 - room.w), rng.range(1, leaf.h - 2 - room.h)

		-- Do we stomp ?
		for i = 1, room.w do
			for j = 1, room.h do
				if self.map.room_map[i-1+x][j-1+y].room then ok = false break end
			end
			if not ok then break end
		end

		if ok and (not add_check or add_check(room, x, y)) then
			local res = self:roomPlace(room, id, x, y)
			if res then return res end
		end
		tries = tries - 1
	end
	return false
end
