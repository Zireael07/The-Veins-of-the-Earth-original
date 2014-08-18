-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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

local Heightmap = require "engine.Heightmap"

return function(gen, id)
	local w = rng.range(6, 10)
	local h = rng.range(6, 10)
	local function make_hmap(self, x, y, is_lit)
		-- make the fractal heightmap
		local hm = Heightmap.new(self.w, self.h, 2, {middle=Heightmap.min, up_left=Heightmap.max, down_left=Heightmap.max, up_right=Heightmap.max, down_right=Heightmap.max})
		hm:generate()

		local ispit = gen.data.rooms_config and gen.data.rooms_config.forest_clearing and rng.percent(gen.data.rooms_config.forest_clearing.pit_chance)
		if ispit then ispit = rng.table(gen.data.rooms_config.forest_clearing.filters) end

		-- Floodfill to eliminate dead zones
		local dmap = {}
		local opens = {}
		local list = {}
		for i = 1, self.w do
			opens[i] = {}
			dmap[i] = {}
			for j = 1, self.h do if hm.hmap[i][j] < Heightmap.max * 5 / 6 then
				dmap[i][j] = true
				opens[i][j] = #list+1
				list[#list+1] = {x=i, y=j}
			end end
		end
--		print("Flooding with", #list)

		local floodFill floodFill = function(x, y)
			local q = {{x=x,y=y}}
			local closed = {}
			while #q > 0 do
				local n = table.remove(q, 1)
--				print("Flooding!", x, y, "::", #q, n.x, n.y)
				if opens[n.x] and opens[n.x][n.y] then
					closed[#closed+1] = n
					list[opens[n.x][n.y]] = nil
					opens[n.x][n.y] = nil
					q[#q+1] = {x=n.x-1, y=n.y}
					q[#q+1] = {x=n.x, y=n.y+1}
					q[#q+1] = {x=n.x+1, y=n.y}
					q[#q+1] = {x=n.x, y=n.y-1}

					q[#q+1] = {x=n.x+1, y=n.y-1}
					q[#q+1] = {x=n.x+1, y=n.y+1}
					q[#q+1] = {x=n.x-1, y=n.y-1}
					q[#q+1] = {x=n.x-1, y=n.y+1}
				end
			end
			return closed
		end

		-- Process all open spaces
		local groups = {}
		while next(list) do
			local i, l = next(list)
			local closed = floodFill(l.x, l.y)
			groups[#groups+1] = {id=id, list=closed}
--			print("Floodfill group", i, #closed)
		end
		-- If nothing exists, regen
		if #groups == 0 then return make_hmap(self, x, y, is_lit) end

		-- Sort to find the biggest group
		table.sort(groups, function(a,b) return #a.list < #b.list end)
		local g = groups[#groups]
		if #g.list >= 2 then
--			print("Ok floodfill", #g.list)
			for i = 1, #groups-1 do
				for j = 1, #groups[i].list do
					local jn = groups[i].list[j]
					dmap[jn.x][jn.y] = nil
				end
			end
		else
			return make_hmap(self, x, y, is_lit)
		end

		-- Materialize the map
		for i = 1, self.w do
			for j = 1, self.h do
				if not dmap[i][j] then
--					gen.map.room_map[i-1+x][j-1+y].can_open = true
					gen.map(i-1+x, j-1+y, Map.TERRAIN, gen:resolve('#'))
				else
					gen.map.room_map[i-1+x][j-1+y].room = id
					gen.map(i-1+x, j-1+y, Map.TERRAIN, gen:resolve('.'))

					if ispit then
						local e = gen.zone:makeEntity(gen.level, "actor", ispit, nil, true)
						if e then
							if e then
								gen:roomMapAddEntity(i-1+x, j-1+y, "actor", e) 
								e:setEffect(e.EFF_VAULTED, 1, {})
							end
							gen.map.attrs(i-1+x, j-1+y, "no_decay", true)
						end
					end
				end
				if is_lit then gen.map.lites(i-1+x, j-1+y, true) end
			end
		end
--		print("Done!")
	end

	return { name="forest_clearing"..w.."x"..h, w=w, h=h, generator = make_hmap}
end
