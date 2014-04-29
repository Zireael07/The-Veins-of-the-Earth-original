-- Veins of the Earth
--Zireael 2014
--NOT FUNCTIONAL YET

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
require "engine.Generator"
local RoomsLoader = require "mod.class.generator.map.RoomsLoader"
module(..., package.seeall, class.inherit(engine.Generator, RoomsLoader))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level)
	self.data = data
	self.data.tunnel_change = self.data.tunnel_change or 30
	self.data.tunnel_random = self.data.tunnel_random or 10
	self.data.door_chance = self.data.door_chance or 50
	self.data.lite_room_chance = self.data.lite_room_chance or 25
	data.widen_w = data.widen_w or 1
	data.widen_h = data.widen_h or 1
	self.grid_list = zone.grid_list

	RoomsLoader.init(self, data)
	self.possible_doors = {}
end

function _M:generate(lev, old_lev)
	--Perimeter
--[[	for i = 0, self.map.w - 1 do for j = 0, self.map.h - 1 do
		self.map(i, j, Map.TERRAIN, self:resolve("#"))
	end end]]

	--Place rooms
	local spots = {}
	self.spots = spots

	local nb_room = util.getval(self.data.nb_rooms or 10)
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

	--Taken from Maze generator
		local do_tile = function(i, j, wall)
		for ii = 0, self.data.widen_w-1 do for jj = 0, self.data.widen_h-1 do
			self.map(i*self.data.widen_w+ii, j*self.data.widen_h+jj, Map.TERRAIN, self:resolve(wall and "wall" or "floor"))
		end end
		self.map.room_map[i][j].maze_wall = wall
	end

	for i = 0, self.map.w - 1 do for j = 0, self.map.h - 1 do
		do_tile(i, j, true)
	end end

	local xpos, ypos = 1, 1
	local moves = {{xpos,ypos}}
	local pickp = rng.range(1,4)
	while #moves > 0 do
		local pickn = #moves - math.floor((rng.range(1,100000)/100001)^pickp * #moves)
		local pick = moves[pickn]
		xpos = pick[1]
		ypos = pick[2]
		local dir = {}
		if self.map.room_map[xpos+2] and self.map.room_map[xpos+2][ypos] and self.map.room_map[xpos+2][ypos].maze_wall and xpos+2>0 and xpos+2<self.map.w-1 then
			dir[#dir+1] = 6
		end
		if self.map.room_map[xpos-2] and self.map.room_map[xpos-2][ypos] and self.map.room_map[xpos-2][ypos].maze_wall and xpos-2>0 and xpos-2<self.map.w-1 then
			dir[#dir+1] = 4
		end
		if self.map.room_map[xpos] and self.map.room_map[xpos][ypos-2] and self.map.room_map[xpos][ypos-2].maze_wall and ypos-2>0 and ypos-2<self.map.h-1 then
			dir[#dir+1] = 8
		end
		if self.map.room_map[xpos] and self.map.room_map[xpos][ypos+2] and self.map.room_map[xpos][ypos+2].maze_wall and ypos+2>0 and ypos+2<self.map.h-1 then
			dir[#dir+1] = 2
		end

		--If rooms
		if self.map.room_map[xpos+2] and self.map.room_map[xpos+2][ypos] and self.map.room_map[xpos+2][ypos].room and xpos+2>0 and xpos+2<self.map.w-1 then
			dir[#dir+1] = 6
		end
		if self.map.room_map[xpos-2] and self.map.room_map[xpos-2][ypos] and self.map.room_map[xpos-2][ypos].room and xpos-2>0 and xpos-2<self.map.w-1 then
			dir[#dir+1] = 4
		end
		if self.map.room_map[xpos] and self.map.room_map[xpos][ypos-2] and self.map.room_map[xpos][ypos-2].room and ypos-2>0 and ypos-2<self.map.h-1 then
			dir[#dir+1] = 8
		end
		if self.map.room_map[xpos] and self.map.room_map[xpos][ypos+2] and self.map.room_map[xpos][ypos+2].room and ypos+2>0 and ypos+2<self.map.h-1 then
			dir[#dir+1] = 2
		end


		if #dir > 0 then
			local d = dir[rng.range(1, #dir)]
			if d == 4 then
				do_tile(xpos-2, ypos, false)
				do_tile(xpos-1, ypos, false)
				xpos = xpos - 2
			elseif d == 6 then
				do_tile(xpos+2, ypos, false)
				do_tile(xpos+1, ypos, false)
				xpos = xpos + 2
			elseif d == 8 then
				do_tile(xpos, ypos-2, false)
				do_tile(xpos, ypos-1, false)
				ypos = ypos - 2
			elseif d == 2 then
				do_tile(xpos, ypos+2, false)
				do_tile(xpos, ypos+1, false)
				ypos = ypos + 2
			end
			table.insert(moves, {xpos, ypos})
		else
			local back = table.remove(moves,pickn)
		end
	end
	-- Always starts at 1, 1
	local ux, uy = 1 * self.data.widen_w, 1 * self.data.widen_h
	local dx, dy = math.floor(self.map.w/2)*2-1-2*(1-math.mod(self.map.w,2)), math.floor(self.map.h/2)*2-1-2*(1-math.mod(self.map.h,2))
	self.map(ux, uy, Map.TERRAIN, self:resolve("up"))
	self.map.room_map[ux][uy].special = "exit"
	if lev < self.zone.max_level or self.data.force_last_stair then
		self.map(dx, dy, Map.TERRAIN, self:resolve("down"))
		self.map.room_map[dx][dy].special = "exit"
	end
	return ux, uy, dx, dy
end