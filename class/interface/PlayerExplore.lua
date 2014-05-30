-- TE4 - T-Engine 4
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

--- This file implements auto-explore whereby a single command can explore unseen tiles and objects,
-- go to unexplored doors, and go to the level exit all while avoiding known traps and water if possible.
--
-- Note that the floodfill algorithm in this file can handle grids with different movement costs

require "engine.class"
local Map = require "engine.Map"
local Dialog = require "engine.ui.Dialog"

-- Man, if only I had known about the ffi library when I first wrote auto-explore, I probably would have structured things differently
local is_ffi, ffi = pcall(require, "ffi") -- check if ffi is available (it should be)

module(..., package.seeall, class.make)

local function toSingle(x, y)
	return x + y * game.level.map.w
end

local function toDouble(c)
	local y = math.floor(c / game.level.map.w)
	return c - y * game.level.map.w, y
end

-- Using structs may be better, but I was able to easily search/replace by using arrays.
-- FFI makes this code 2-3x faster for me.  I think the GC may still cause occasional hiccups of slowness.
if is_ffi then
	ffi.cdef[[
		typedef int cnode[5];
		typedef int ctile[2];
	]]
end

local listAdjacentNodes
local getNextNodes
local listAdjacentTiles
local listSharedTiles
local listSharedTilesPrevious
local previousTile
local checkAmbush

local map_type

-- Heh, this somehow turned into 1850 lines.  Trust me, this didn't take nearly as long to write as you might expect.
-- Ample use of search/replace and copy/paste was used at every step.  Heh, got kind of out of control though :-P
local function generateNodeFunctions()
	if util.isHex() == map_type then return end
	map_type = util.isHex()

	if util.isHex() and is_ffi then
		-- a flexible but slow function to list all adjacent tile
		listAdjacentNodes = function(tile, no_diagonal, no_cardinal)
			local tiles = {}
			local x, y, c
			if type(tile) == "number" then
				x, y = toDouble(tile)
				c = tile
				val = 1
			elseif tile[0] then
				x, y, c, val = tile[0], tile[1], tile[2], tile[3]+1
			else
				return tiles
			end
			local left_okay = x > 0
			local right_okay = x < game.level.map.w - 1
			local lower_okay = y > 0
			local upper_okay = y < game.level.map.h - 1
			local p = x % 2
			local r = 1 - p
			if not no_cardinal then
				if (upper_okay or p == 0) and left_okay  then tiles[1]        = ffi.new("cnode", { x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 }) end
				if  upper_okay                           then tiles[#tiles+1] = ffi.new("cnode", { x,     y + 1, c     +   game.level.map.w, val, 2 }) end
				if (upper_okay or p == 0) and right_okay then tiles[#tiles+1] = ffi.new("cnode", { x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 }) end
				if (lower_okay or r == 0) and left_okay  then tiles[#tiles+1] = ffi.new("cnode", { x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 }) end
				if  lower_okay                           then tiles[#tiles+1] = ffi.new("cnode", { x,     y - 1, c     -   game.level.map.w, val, 8 }) end
				if (lower_okay or r == 0) and right_okay then tiles[#tiles+1] = ffi.new("cnode", { x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 }) end
			end
			return tiles
		end

		-- Performing a flood-fill algorithm in lua with robust logic is going to be relatively slow, so we
		-- need to make things more efficient wherever we can.  "getNextNodes" below is an example of this.
		-- Every node knows from which direction it was explored, and it only explores adjacent tiles that
		-- may not have previously been explored.  Nodes that were explored from a cardinal direction only
		-- have three new adjacent tiles to iterate over, and diagonal directions have five new tiles.
		-- Therefore, we should favor cardinal direction tile propagation for speed whenever possible.
		--
		-- Note: if we want this to be faster such as using a floodfill for NPCs (better ai!), then we should
		-- perform the floodfill in C, where we could use more advanced tricks to make it blazingly fast.
		getNextNodes = {
			-- Dir 1
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x > 0 then
					                                           cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 })
					if y < game.level.map.h - 1 or p == 0 then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 }) end
				end
				if y < game.level.map.h - 1                   then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y + 1, c     +   game.level.map.w, val, 2 }) end
			end,
			--Dir 2
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				if y < game.level.map.h - 1 or p == 0 then
					if x > 0                    then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 }) end
					if x < game.level.map.w - 1 then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 }) end
				end
				if y < game.level.map.h - 1         then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y + 1, c     +   game.level.map.w, val, 2 }) end
			end,
			-- Dir 3
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x < game.level.map.w - 1 then
					                                           cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 })
					if y < game.level.map.h - 1 or p == 0 then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 }) end
				end
				if y < game.level.map.h - 1                   then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y + 1, c     +   game.level.map.w, val, 2 }) end
			end,
			--Dir 4
			function(node, cardinal_tiles, diagonal_tiles) end,
			--Dir 5 (all adjacent, slow)
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				local left_okay = x > 0
				local right_okay = x < game.level.map.w - 1
				local lower_okay = y > 0
				local upper_okay = y < game.level.map.h - 1
				if (upper_okay or p == 0) and left_okay  then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 }) end
				if  upper_okay                           then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y + 1, c     +   game.level.map.w, val, 2 }) end
				if (upper_okay or p == 0) and right_okay then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 }) end
				if (lower_okay or r == 0) and left_okay  then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 }) end
				if  lower_okay                           then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y - 1, c     -   game.level.map.w, val, 8 }) end
				if (lower_okay or r == 0) and right_okay then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 }) end
			end,
			--Dir 6
			function(node, cardinal_tiles, diagonal_tiles) end,
			-- Dir 7
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x > 0 then
					                        cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 })
					if y > 0 or r == 0 then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 }) end
				end
				if y > 0                   then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y - 1, c     -   game.level.map.w, val, 8 }) end
			end,
			--Dir 8
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local r = 1 - x % 2
				if y > 0 or r == 0 then
					if x > 0 then                    cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 }) end
					if x < game.level.map.w - 1 then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 }) end
				end
				if y > 0 then                            diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y - 1, c     -   game.level.map.w, val, 8 }) end
			end,
			-- Dir 9
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x < game.level.map.w - 1 then
					                        cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 })
					if y > 0 or r == 0 then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 }) end
				end
				if y > 0 then                   diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x,     y - 1, c     -   game.level.map.w, val, 8 }) end
			end
		}

		-- Use directional information to list all adjacent tiles more efficiently
		listAdjacentTiles = {
			-- Dir 1
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {ffi.new("ctile", { x,     y - 1 }),
				               ffi.new("ctile", { x + 1, y - r })}
				if y < game.level.map.h - 1 then
					tiles[3] = ffi.new("ctile", { x,     y + 1 })
					tiles[4] = ffi.new("ctile", { x + 1, y + p })
				end
				if x > 0 then
					                                           tiles[#tiles+1] = ffi.new("ctile", { x - 1, y - r })
					if y < game.level.map.h - 1 or p == 0 then tiles[#tiles+1] = ffi.new("ctile", { x - 1, y + p }) end
				end
				return tiles
			end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {ffi.new("ctile", { x,     y - 1 })}
				if x > 0                            then tiles[2]        = ffi.new("ctile", { x - 1, y - r }) end
				if x < game.level.map.w - 1         then tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - r }) end
				if y < game.level.map.h - 1 or p == 0 then
					if x > 0                    then tiles[#tiles+1] = ffi.new("ctile", { x - 1, y + p }) end
					if x < game.level.map.w - 1 then tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + p }) end
				end
				if y < game.level.map.h - 1         then tiles[#tiles+1] = ffi.new("ctile", { x,     y + 1 }) end
				return tiles
			end,
			-- Dir 3
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {ffi.new("ctile", { x - 1, y - r }),
				               ffi.new("ctile", { x,     y - 1 })}
				if y < game.level.map.h - 1 then
					tiles[3] = ffi.new("ctile", { x - 1, y + p })
					tiles[4] = ffi.new("ctile", { x,     y + 1 })
				end
				if x < game.level.map.w - 1 then
					                                           tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - r })
					if y < game.level.map.h - 1 or p == 0 then tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + p }) end
				end
				return tiles
			end,
			-- Dir 4
			function(node) end,
			-- Dir 5
			function(node)
				local tiles = {}
				getNextNodes[5](node, tiles, tiles)
				return tiles
			end,
			-- Dir 6
			function(node) end,
			-- Dir 7
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {ffi.new("ctile", { x,     y + 1 }),
				               ffi.new("ctile", { x + 1, y + p })}
				if y > 0 then
					tiles[3] = ffi.new("ctile", { x,     y - 1 })
					tiles[4] = ffi.new("ctile", { x + 1, y - r })
				end
				if x > 0 then
					                        tiles[#tiles+1] = ffi.new("ctile", { x - 1, y + p })
					if y > 0 or r == 0 then tiles[#tiles+1] = ffi.new("ctile", { x - 1, y - r }) end
				end
				return tiles
			end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {ffi.new("ctile", { x,     y + 1 })}
				if x > 0                            then tiles[2]        = ffi.new("ctile", { x - 1, y + p }) end
				if x < game.level.map.w - 1         then tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + p }) end
				if y > 0 or r == 0 then
					if x > 0 then                    tiles[#tiles+1] = ffi.new("ctile", { x - 1, y - r }) end
					if x < game.level.map.w - 1 then tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - r }) end
				end
				if y > 0 then                            tiles[#tiles+1] = ffi.new("ctile", { x,     y - 1 }) end
				return tiles
			end,
			-- Dir 9
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {ffi.new("ctile", { x - 1, y + p }),
				               ffi.new("ctile", { x,     y + 1 })}
				if y > 0 then
					tiles[3] = ffi.new("ctile", { x - 1, y - r })
					tiles[4] = ffi.new("ctile", { x,     y - 1 })
				end
				if x < game.level.map.w - 1 then
					                        tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + p })
					if y > 0 or r == 0 then tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - r }) end
				end
				return tiles
			end
		}

		-- DON'T TRY TO INFER WALLS IN HEX MODE
		-- List tiles that are adjacent to both current tile and previous tile that the previous tile iterated over.
		-- Right now these (and "listSharedTilesPrevious") are used to infer what might be a wall, and may be useful later.
		-- c = current, p = previous     c*    *c*
		-- * = returned tile             *p    .p.
		listSharedTiles = {
			-- Dir 1
			function(node) return {} end,
			-- Dir 2
			function(node) return {} end,
			-- Dir 3
			function(node) return {} end,
			-- Dir 4
			function(node) return {} end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node) return {} end,
			-- Dir 7
			function(node) return {} end,
			-- Dir 8
			function(node) return {} end,
			-- Dir 9
			function(node) return {} end
		}

		-- DON'T TRY TO INFER WALLS IN HEX MODE
		-- A partial complement to "listSharedTiles".  "listSharedTiles" and "listSharedTilesPrevious" allow us to easily
		-- check specific configurations, which will come in handy if/when I rewrite the "hack" for exploring large areas.
		-- c = current, p = previous     c.    .c.
		-- * = returned tile             .p    *p*
		listSharedTilesPrevious = {
			-- Dir 1
			function(node) return {} end,
			-- Dir 2
			function(node) return {} end,
			-- Dir 3
			function(node) return {} end,
			-- Dir 4
			function(node) return {} end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node) return {} end,
			-- Dir 7
			function(node) return {} end,
			-- Dir 8
			function(node) return {} end,
			-- Dir 9
			function(node) return {} end
		}

		previousTile = {
			-- Dir 1
			function(node) return ffi.new("ctile", { node[0] + 1, node[1] - 1 + node[0]%2 }) end,
			-- Dir 2
			function(node) return ffi.new("ctile", { node[0],     node[1] - 1             }) end,
			-- Dir 3
			function(node) return ffi.new("ctile", { node[0] - 1, node[1] - 1 + node[0]%2 }) end,
			-- Dir 4
			function(node) end,
			-- Dir 5
			function(node) return ffi.new("ctile", { node[0],     node[1]     }) end,
			-- Dir 6
			function(node) end,
			-- Dir 7
			function(node) return ffi.new("ctile", { node[0] + 1, node[1] + node[0]%2 }) end,
			-- Dir 8
			function(node) return ffi.new("ctile", { node[0],     node[1] + 1         }) end,
			-- Dir 9
			function(node) return ffi.new("ctile", { node[0] - 1, node[1] + node[0]%2 }) end,
		}

		-- One more kindness to the player: take advantage of asymmetric LoS in this one specific case.
		-- If an enemy is at '?', the player is able to prevent an ambush by moving to 'x' instead of 't'.
		-- This is the only sensibly preventable ambush (that I know of) in which the player can move
		-- in a way to see the would-be ambusher and the would-be ambusher can't see the player.
		-- However, don't do this if it will step onto a known trap
		--
		--   .tx      Moving onto 't' puts us adjacent to an unseen tile, '?'
		--   ?#@      --> Pick 'x' instead
		checkAmbush = function(self)
			-- HEX TODO
			if true then return nil end
			if not self.running or not self.running.explore or not self.running.path or not self.running.path[self.running.cnt] then return end

			local cx, cy = self.running.path[self.running.cnt].x, self.running.path[self.running.cnt].y
			if math.abs(self.x - cx) == 1 and math.abs(self.y - cy) == 1 then
				if game.level.map:checkAllEntities(self.x, cy, "block_move", self) and not game.level.map:checkAllEntities(cx, self.y, "block_move", self) and
						game.level.map:isBound(self.x, 2*cy - self.y) and not game.level.map.has_seens(self.x, 2*cy - self.y) then
					local trap = game.level.map(cx, self.y, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=cx, y=self.y})
					end
				elseif game.level.map:checkAllEntities(cx, self.y, "block_move", self) and not game.level.map:checkAllEntities(self.x, cy, "block_move", self) and
						game.level.map:isBound(2*cx - self.x, self.y) and not game.level.map.has_seens(2*cx - self.x, self.y) then
					local trap = game.level.map(self.x, cy, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=self.x, y=cy})
					end
				end
			end
		end

	elseif is_ffi then
		-- a flexible but slow function to list all adjacent tile
		listAdjacentNodes = function(tile, no_diagonal, no_cardinal)
			local tiles = {}
			local x, y, c
			if type(tile) == "number" then
				x, y = toDouble(tile)
				c = tile
				val = 1
			elseif tile[0] then
				x, y, c, val = tile[0], tile[1], tile[2], tile[3]+1
			else
				return tiles
			end
			local left_okay = x > 0
			local right_okay = x < game.level.map.w - 1
			local lower_okay = y > 0
			local upper_okay = y < game.level.map.h - 1
			if not no_cardinal then
				if upper_okay then tiles[1]        = ffi.new("cnode", { x,     y + 1, c + game.level.map.w, val, 2 }) end
				if left_okay  then tiles[#tiles+1] = ffi.new("cnode", { x - 1, y,     c - 1,                val, 4 }) end
				if right_okay then tiles[#tiles+1] = ffi.new("cnode", { x + 1, y,     c + 1,                val, 6 }) end
				if lower_okay then tiles[#tiles+1] = ffi.new("cnode", { x,     y - 1, c - game.level.map.w, val, 8 }) end
			end
			if not no_diagonal then
				if left_okay  and upper_okay then tiles[#tiles+1] = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }) end
				if right_okay and upper_okay then tiles[#tiles+1] = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }) end
				if left_okay  and lower_okay then tiles[#tiles+1] = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }) end
				if right_okay and lower_okay then tiles[#tiles+1] = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }) end
			end
			return tiles
		end

		-- Performing a flood-fill algorithm in lua with robust logic is going to be relatively slow, so we
		-- need to make things more efficient wherever we can.  "getNextNodes" below is an example of this.
		-- Every node knows from which direction it was explored, and it only explores adjacent tiles that
		-- may not have previously been explored.  Nodes that were explored from a cardinal direction only
		-- have three new adjacent tiles to iterate over, and diagonal directions have five new tiles.
		-- Therefore, we should favor cardinal direction tile propagation for speed whenever possible.
		--
		-- Note: if we want this to be faster such as using a floodfill for NPCs (better ai!), then we should
		-- perform the floodfill in C, where we could use more advanced tricks to make it blazingly fast.
		getNextNodes = {
			-- Dir 1
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y < game.level.map.h - 1 then
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x,     y + 1, c     + game.level.map.w, val, 2 })
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 })
					if x > 0 then
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 })
						cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y,     c - 1,                    val, 4 })
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 })
					end
				elseif x > 0 then
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x - 1, y,     c - 1,                    val, 4 })
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 })
				end
			end,
			--Dir 2
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y > game.level.map.h - 2 then return end
				if x > 0 then diagonal_tiles[#diagonal_tiles+1]                    = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }) end
				cardinal_tiles[#cardinal_tiles+1]                                  = ffi.new("cnode", { x,     y + 1, c     + game.level.map.w, val, 2 })
				if x < game.level.map.w - 1 then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }) end
			end,
			-- Dir 3
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y < game.level.map.h - 1 then
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 })
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x,     y + 1, c     + game.level.map.w, val, 2 })
					if x < game.level.map.w - 1 then
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 })
						cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y,     c + 1,                    val, 6 })
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 })
					end
				elseif x < game.level.map.w - 1 then
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x + 1, y,     c + 1,                    val, 6 })
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 })
				end
			end,
			--Dir 4
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x < 1 then return end
				if y < game.level.map.h - 1 then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }) end
				cardinal_tiles[#cardinal_tiles+1]                                  = ffi.new("cnode", { x - 1, y,     c - 1,                    val, 4 })
				if y > 0 then diagonal_tiles[#diagonal_tiles+1]                    = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }) end
			end,
			--Dir 5 (all adjacent, slow)
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local left_okay = x > 0
				local right_okay = x < game.level.map.w - 1
				local lower_okay = y > 0
				local upper_okay = y < game.level.map.h - 1
				if upper_okay then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x,     y + 1, c + game.level.map.w, val, 2 }) end
				if left_okay  then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x - 1, y,     c - 1,                val, 4 }) end
				if right_okay then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x + 1, y,     c + 1,                val, 6 }) end
				if lower_okay then cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x,     y - 1, c - game.level.map.w, val, 8 }) end
				if left_okay  and upper_okay then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }) end
				if right_okay and upper_okay then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }) end
				if left_okay  and lower_okay then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }) end
				if right_okay and lower_okay then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }) end
			end,
			--Dir 6
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x > game.level.map.w - 2 then return end
				if y < game.level.map.h - 1 then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }) end
				cardinal_tiles[#cardinal_tiles+1]                                  = ffi.new("cnode", { x + 1, y,     c + 1,                    val, 6 })
				if y > 0 then diagonal_tiles[#diagonal_tiles+1]                    = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }) end
			end,
			-- Dir 7
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x > 0 then
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x - 1, y + 1, c - 1 + game.level.map.w, val, 1 })
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x - 1, y,     c - 1,                    val, 4 })
					if y > 0 then
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 })
						cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x,     y - 1, c     - game.level.map.w, val, 8 })
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 })
					end
				elseif y > 0 then
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x,     y - 1, c     - game.level.map.w, val, 8 })
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 })
				end
			end,
			--Dir 8
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y < 1 then return end
				if x > 0 then diagonal_tiles[#diagonal_tiles+1]                    = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }) end
				cardinal_tiles[#cardinal_tiles+1]                                  = ffi.new("cnode", { x,     y - 1, c     - game.level.map.w, val, 8 })
				if x < game.level.map.w - 1 then diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }) end
			end,
			-- Dir 9
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x < game.level.map.w - 1 then
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x + 1, y + 1, c + 1 + game.level.map.w, val, 3 })
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x + 1, y,     c + 1,                    val, 6 })
					if y > 0 then
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 })
						cardinal_tiles[#cardinal_tiles+1] = ffi.new("cnode", { x,     y - 1, c     - game.level.map.w, val, 8 })
						diagonal_tiles[#diagonal_tiles+1] = ffi.new("cnode", { x + 1, y - 1, c + 1 - game.level.map.w, val, 9 })
					end
				elseif y > 0 then
					diagonal_tiles[#diagonal_tiles+1]         = ffi.new("cnode", { x - 1, y - 1, c - 1 - game.level.map.w, val, 7 })
					cardinal_tiles[#cardinal_tiles+1]         = ffi.new("cnode", { x,     y - 1, c     - game.level.map.w, val, 8 })
				end
			end
		}

		-- Use directional information to list all adjacent tiles more efficiently
		listAdjacentTiles = {
			-- Dir 1
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x + 1, y     }),
				               ffi.new("ctile", { x,     y - 1 }),
				               ffi.new("ctile", { x + 1, y - 1 })}
				if y < game.level.map.h - 1 then
					tiles[4]         = ffi.new("ctile", { x,     y + 1 })
					tiles[5]         = ffi.new("ctile", { x + 1, y + 1 })
					if x > 0 then
						tiles[6] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[7] = ffi.new("ctile", { x - 1, y     })
						tiles[8] = ffi.new("ctile", { x - 1, y - 1 })
					end
				elseif x > 0 then
					tiles[4]         = ffi.new("ctile", { x - 1, y     })
					tiles[5]         = ffi.new("ctile", { x - 1, y - 1 })
				end
				return tiles
			end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x,     y - 1 })}
				if y < game.level.map.h - 1 then
					tiles[2] = ffi.new("ctile", { x,     y + 1 })
					if x > 0 then
						tiles[3] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[4] = ffi.new("ctile", { x - 1, y     })
						tiles[5] = ffi.new("ctile", { x - 1, y - 1 })
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y     })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - 1 })
					end
				else
					if x > 0 then
						tiles[2] = ffi.new("ctile", { x - 1, y     })
						tiles[3] = ffi.new("ctile", { x - 1, y - 1 })
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y     })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - 1 })
					end
				end
				return tiles
			end,
			-- Dir 3
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x - 1, y     }),
				               ffi.new("ctile", { x - 1, y - 1 }),
				               ffi.new("ctile", { x,     y - 1 })}
				if y < game.level.map.h - 1 then
					tiles[4]         = ffi.new("ctile", { x - 1, y + 1 })
					tiles[5]         = ffi.new("ctile", { x,     y + 1 })
					if x < game.level.map.w - 1 then
						tiles[6] = ffi.new("ctile", { x + 1, y + 1 })
						tiles[7] = ffi.new("ctile", { x + 1, y     })
						tiles[8] = ffi.new("ctile", { x + 1, y - 1 })
					end
				elseif x < game.level.map.w - 1 then
					tiles[4]         = ffi.new("ctile", { x + 1, y     })
					tiles[5]         = ffi.new("ctile", { x + 1, y - 1 })
				end
				return tiles
			end,
			-- Dir 4
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x + 1, y     })}
				if x > 0 then
					tiles[2] = ffi.new("ctile", { x - 1, y     })
					if y < game.level.map.h - 1 then
						tiles[3] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[4] = ffi.new("ctile", { x,     y + 1 })
						tiles[5] = ffi.new("ctile", { x + 1, y + 1 })
					end
					if y > 0 then
						tiles[#tiles+1] = ffi.new("ctile", { x - 1, y - 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x,     y - 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - 1 })
					end
				else
					if y < game.level.map.h - 1 then
						tiles[2] = ffi.new("ctile", { x,     y + 1 })
						tiles[3] = ffi.new("ctile", { x + 1, y + 1 })
					end
					if y > 0 then
						tiles[#tiles+1] = ffi.new("ctile", { x,     y - 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - 1 })
					end
				end
				return tiles
			end,
			-- Dir 5
			function(node)
				local tiles = {}
				getNextNodes[5](node, tiles, tiles)
				return tiles
			end,
			-- Dir 6
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x - 1, y     })}
				if x < game.level.map.w - 1 then
					tiles[2] = ffi.new("ctile", { x + 1, y     })
					if y < game.level.map.h - 1 then
						tiles[3] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[4] = ffi.new("ctile", { x,     y + 1 })
						tiles[5] = ffi.new("ctile", { x + 1, y + 1 })
					end
					if y > 0 then
						tiles[#tiles+1] = ffi.new("ctile", { x - 1, y - 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x,     y - 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - 1 })
					end
				else
					if y < game.level.map.h - 1 then
						tiles[2] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[3] = ffi.new("ctile", { x,     y + 1 })
					end
					if y > 0 then
						tiles[#tiles+1] = ffi.new("ctile", { x - 1, y - 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x,     y - 1 })
					end
				end
				return tiles
			end,
			-- Dir 7
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x,     y + 1 }),
				               ffi.new("ctile", { x + 1, y + 1 }),
				               ffi.new("ctile", { x + 1, y     })}
				if x > 0 then
					tiles[4]         = ffi.new("ctile", { x - 1, y + 1 })
					tiles[5]         = ffi.new("ctile", { x - 1, y     })
					if y > 0 then
						tiles[6] = ffi.new("ctile", { x - 1, y - 1 })
						tiles[7] = ffi.new("ctile", { x,     y - 1 })
						tiles[8] = ffi.new("ctile", { x + 1, y - 1 })
					end
				elseif y > 0 then
					tiles[4]         = ffi.new("ctile", { x,     y - 1 })
					tiles[5]         = ffi.new("ctile", { x + 1, y - 1 })
				end
				return tiles
			end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x,     y + 1 })}
				if y > 0 then
					tiles[2] = ffi.new("ctile", { x,     y - 1 })
					if x > 0 then
						tiles[3] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[4] = ffi.new("ctile", { x - 1, y     })
						tiles[5] = ffi.new("ctile", { x - 1, y - 1 })
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y     })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y - 1 })
					end
				else
					if x > 0 then
						tiles[2] = ffi.new("ctile", { x - 1, y + 1 })
						tiles[3] = ffi.new("ctile", { x - 1, y     })
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y + 1 })
						tiles[#tiles+1] = ffi.new("ctile", { x + 1, y     })
					end
				end
				return tiles
			end,
			-- Dir 9
			function(node)
				local x, y = node[0], node[1]
				local tiles = {ffi.new("ctile", { x - 1, y + 1 }),
				               ffi.new("ctile", { x,     y + 1 }),
				               ffi.new("ctile", { x - 1, y     })}
				if x < game.level.map.w - 1 then
					tiles[4]         = ffi.new("ctile", { x + 1, y + 1 })
					tiles[5]         = ffi.new("ctile", { x + 1, y     })
					if y > 0 then
						tiles[6] = ffi.new("ctile", { x - 1, y - 1 })
						tiles[7] = ffi.new("ctile", { x,     y - 1 })
						tiles[8] = ffi.new("ctile", { x + 1, y - 1 })
					end
				elseif y > 0 then
					tiles[4]         = ffi.new("ctile", { x - 1, y - 1 })
					tiles[5]         = ffi.new("ctile", { x,     y - 1 })
				end
				return tiles
			end
		}

		-- List tiles that are adjacent to both current tile and previous tile that the previous tile iterated over.
		-- Right now these (and "listSharedTilesPrevious") are used to infer what might be a wall, and may be useful later.
		-- c = current, p = previous     c*    *c*
		-- * = returned tile             *p    .p.
		listSharedTiles = {
			-- Dir 1
			function(node)
				local x, y = node[0], node[1]
				return {ffi.new("ctile", { x + 1, y     }),
				        ffi.new("ctile", { x,     y - 1 })}
			end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {ffi.new("ctile", { x + 1, y     })}
				elseif x > game.level.map.w - 2 then return {ffi.new("ctile", { x - 1, y     })}
				else return {ffi.new("ctile", { x - 1, y     }),
				             ffi.new("ctile", { x + 1, y     })}
				end
			end,
			-- Dir 3
			function(node)
				local x, y = node[0], node[1]
				return {ffi.new("ctile", { x - 1, y     }),
				        ffi.new("ctile", { x,     y - 1 })}
			end,
			-- Dir 4
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {ffi.new("ctile", { x,     y + 1 })}
				elseif y > game.level.map.h - 2 then return {ffi.new("ctile", { x,     y - 1 })}
				else return {ffi.new("ctile", { x,     y + 1 }),
				             ffi.new("ctile", { x,     y - 1 })}
				end
			end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {ffi.new("ctile", { x,     y + 1 })}
				elseif y > game.level.map.h - 2 then return {ffi.new("ctile", { x,     y - 1 })}
				else return {ffi.new("ctile", { x,     y + 1 }),
				             ffi.new("ctile", { x,     y - 1 })}
				end
			end,
			-- Dir 7
			function(node)
				local x, y = node[0], node[1]
				return {ffi.new("ctile", { x,     y + 1 }),
				        ffi.new("ctile", { x + 1, y     })}
			end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {ffi.new("ctile", { x + 1, y     })}
				elseif x > game.level.map.w - 2 then return {ffi.new("ctile", { x - 1, y     })}
				else return {ffi.new("ctile", { x - 1, y     }),
				             ffi.new("ctile", { x + 1, y     })}
				end
			end,
			-- Dir 9
			function(node)
				local x, y = node[0], node[1]
				return {ffi.new("ctile", { x,     y + 1 }),
				        ffi.new("ctile", { x - 1, y     })}
			end
		}

		-- A partial complement to "listSharedTiles".  "listSharedTiles" and "listSharedTilesPrevious" allow us to easily
		-- check specific configurations, which will come in handy if/when I rewrite the "hack" for exploring large areas.
		-- c = current, p = previous     c.    .c.
		-- * = returned tile             .p    *p*
		listSharedTilesPrevious = {
			-- Dir 1
			function(node) return {} end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {ffi.new("ctile", { x + 1, y - 1 })}
				elseif x > game.level.map.w - 2 then return {ffi.new("ctile", { x - 1, y - 1 })}
				else return {ffi.new("ctile", { x + 1, y - 1 }),
				             ffi.new("ctile", { x - 1, y - 1 })}
				end
			end,
			-- Dir 3
			function(node) return {} end,
			-- Dir 4
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {ffi.new("ctile", { x + 1, y + 1 })}
				elseif y > game.level.map.h - 2 then return {ffi.new("ctile", { x + 1, y - 1 })}
				else return {ffi.new("ctile", { x + 1, y + 1 }),
				             ffi.new("ctile", { x + 1, y - 1 })}
				end
			end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {ffi.new("ctile", { x - 1, y + 1 })}
				elseif y > game.level.map.h - 2 then return {ffi.new("ctile", { x - 1, y - 1 })}
				else return {ffi.new("ctile", { x - 1, y + 1 }),
				             ffi.new("ctile", { x - 1, y - 1 })}
				end
			end,
			-- Dir 7
			function(node) return {} end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {ffi.new("ctile", { x + 1, y + 1 })}
				elseif x > game.level.map.w - 2 then return {ffi.new("ctile", { x - 1, y + 1 })}
				else return {ffi.new("ctile", { x + 1, y + 1 }),
				             ffi.new("ctile", { x - 1, y + 1 })}
				end
			end,
			-- Dir 9
			function(node) return {} end
		}

		previousTile = {
			-- Dir 1
			function(node) return ffi.new("ctile", { node[0] + 1, node[1] - 1 }) end,
			-- Dir 2
			function(node) return ffi.new("ctile", { node[0],     node[1] - 1 }) end,
			-- Dir 3
			function(node) return ffi.new("ctile", { node[0] - 1, node[1] - 1 }) end,
			-- Dir 4
			function(node) return ffi.new("ctile", { node[0] + 1, node[1]     }) end,
			-- Dir 5
			function(node) return ffi.new("ctile", { node[0],     node[1]     }) end,
			-- Dir 6
			function(node) return ffi.new("ctile", { node[0] - 1, node[1]     }) end,
			-- Dir 7
			function(node) return ffi.new("ctile", { node[0] + 1, node[1] + 1 }) end,
			-- Dir 8
			function(node) return ffi.new("ctile", { node[0],     node[1] + 1 }) end,
			-- Dir 9
			function(node) return ffi.new("ctile", { node[0] - 1, node[1] + 1 }) end,
		}

		-- One more kindness to the player: take advantage of asymmetric LoS in this one specific case.
		-- If an enemy is at '?', the player is able to prevent an ambush by moving to 'x' instead of 't'.
		-- This is the only sensibly preventable ambush (that I know of) in which the player can move
		-- in a way to see the would-be ambusher and the would-be ambusher can't see the player.
		-- However, don't do this if it will step onto a known trap
		--
		--   .tx      Moving onto 't' puts us adjacent to an unseen tile, '?'
		--   ?#@      --> Pick 'x' instead
		checkAmbush = function(self)
			if not self.running or not self.running.explore or not self.running.path or not self.running.path[self.running.cnt] then return end

			local cx, cy = self.running.path[self.running.cnt].x, self.running.path[self.running.cnt].y
			if math.abs(self.x - cx) == 1 and math.abs(self.y - cy) == 1 then
				if game.level.map:checkAllEntities(self.x, cy, "block_move", self) and not game.level.map:checkAllEntities(cx, self.y, "block_move", self) and
						game.level.map:isBound(self.x, 2*cy - self.y) and not game.level.map.has_seens(self.x, 2*cy - self.y) then
					local trap = game.level.map(cx, self.y, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=cx, y=self.y})
					end
				elseif game.level.map:checkAllEntities(cx, self.y, "block_move", self) and not game.level.map:checkAllEntities(self.x, cy, "block_move", self) and
						game.level.map:isBound(2*cx - self.x, self.y) and not game.level.map.has_seens(2*cx - self.x, self.y) then
					local trap = game.level.map(self.x, cy, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=self.x, y=cy})
					end
				end
			end
		end

	elseif util.isHex() then
		-- a flexible but slow function to list all adjacent tile
		listAdjacentNodes = function(tile, no_diagonal, no_cardinal)
			local tiles = {}
			local x, y, c
			if type(tile) == "number" then
				x, y = toDouble(tile)
				c = tile
				val = 1
			elseif tile[0] then
				x, y, c, val = tile[0], tile[1], tile[2], tile[3]+1
			else
				return tiles
			end
			local left_okay = x > 0
			local right_okay = x < game.level.map.w - 1
			local lower_okay = y > 0
			local upper_okay = y < game.level.map.h - 1
			local p = x % 2
			local r = 1 - p
			if not no_cardinal then
				if (upper_okay or p == 0) and left_okay  then tiles[1]        = { [0] = x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 } end
				if  upper_okay                           then tiles[#tiles+1] = { [0] = x,     y + 1, c     +   game.level.map.w, val, 2 } end
				if (upper_okay or p == 0) and right_okay then tiles[#tiles+1] = { [0] = x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 } end
				if (lower_okay or r == 0) and left_okay  then tiles[#tiles+1] = { [0] = x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 } end
				if  lower_okay                           then tiles[#tiles+1] = { [0] = x,     y - 1, c     -   game.level.map.w, val, 8 } end
				if (lower_okay or r == 0) and right_okay then tiles[#tiles+1] = { [0] = x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 } end
			end
			return tiles
		end

		-- Performing a flood-fill algorithm in lua with robust logic is going to be relatively slow, so we
		-- need to make things more efficient wherever we can.  "getNextNodes" below is an example of this.
		-- Every node knows from which direction it was explored, and it only explores adjacent tiles that
		-- may not have previously been explored.  Nodes that were explored from a cardinal direction only
		-- have three new adjacent tiles to iterate over, and diagonal directions have five new tiles.
		-- Therefore, we should favor cardinal direction tile propagation for speed whenever possible.
		--
		-- Note: if we want this to be faster such as using a floodfill for NPCs (better ai!), then we should
		-- perform the floodfill in C, where we could use more advanced tricks to make it blazingly fast.
		getNextNodes = {
			-- Dir 1
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x > 0 then
					                                           cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 }
					if y < game.level.map.h - 1 or p == 0 then cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 } end
				end
				if y < game.level.map.h - 1                   then diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y + 1, c     +   game.level.map.w, val, 2 } end
			end,
			--Dir 2
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				if y < game.level.map.h - 1 or p == 0 then
					if x > 0                    then cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 } end
					if x < game.level.map.w - 1 then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 } end
				end
				if y < game.level.map.h - 1         then diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y + 1, c     +   game.level.map.w, val, 2 } end
			end,
			-- Dir 3
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x < game.level.map.w - 1 then
					                                           cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 }
					if y < game.level.map.h - 1 or p == 0 then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 } end
				end
				if y < game.level.map.h - 1                   then diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y + 1, c     +   game.level.map.w, val, 2 } end
			end,
			--Dir 4
			function(node, cardinal_tiles, diagonal_tiles) end,
			--Dir 5 (all adjacent, slow)
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				local left_okay = x > 0
				local right_okay = x < game.level.map.w - 1
				local lower_okay = y > 0
				local upper_okay = y < game.level.map.h - 1
				if (upper_okay or p == 0) and left_okay  then cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 } end
				if  upper_okay                           then diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y + 1, c     +   game.level.map.w, val, 2 } end
				if (upper_okay or p == 0) and right_okay then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 } end
				if (lower_okay or r == 0) and left_okay  then cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 } end
				if  lower_okay                           then diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y - 1, c     -   game.level.map.w, val, 8 } end
				if (lower_okay or r == 0) and right_okay then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 } end
			end,
			--Dir 6
			function(node, cardinal_tiles, diagonal_tiles) end,
			-- Dir 7
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x > 0 then
					                        cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y + p, c - 1 + p*game.level.map.w, val, 1 }
					if y > 0 or r == 0 then cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 } end
				end
				if y > 0                   then diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y - 1, c     -   game.level.map.w, val, 8 } end
			end,
			--Dir 8
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local r = 1 - x % 2
				if y > 0 or r == 0 then
					if x > 0 then                    cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y - r, c - 1 - r*game.level.map.w, val, 7 } end
					if x < game.level.map.w - 1 then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 } end
				end
				if y > 0 then                            diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y - 1, c     -   game.level.map.w, val, 8 } end
			end,
			-- Dir 9
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local p = x % 2
				local r = 1 - p
				if x < game.level.map.w - 1 then
					                        cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y + p, c + 1 + p*game.level.map.w, val, 3 }
					if y > 0 or r == 0 then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y - r, c + 1 - r*game.level.map.w, val, 9 } end
				end
				if y > 0 then                   diagonal_tiles[#diagonal_tiles+1] = { [0] = x,     y - 1, c     -   game.level.map.w, val, 8 } end
			end
		}

		-- Use directional information to list all adjacent tiles more efficiently
		listAdjacentTiles = {
			-- Dir 1
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {{ [0] = x,     y - 1 },
				               { [0] = x + 1, y - r }}
				if y < game.level.map.h - 1 then
					tiles[3] = { [0] = x,     y + 1 }
					tiles[4] = { [0] = x + 1, y + p }
				end
				if x > 0 then
					                                           tiles[#tiles+1] = { [0] = x - 1, y - r }
					if y < game.level.map.h - 1 or p == 0 then tiles[#tiles+1] = { [0] = x - 1, y + p } end
				end
				return tiles
			end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {{ [0] = x,     y - 1 }}
				if x > 0                            then tiles[2]        = { [0] = x - 1, y - r } end
				if x < game.level.map.w - 1         then tiles[#tiles+1] = { [0] = x + 1, y - r } end
				if y < game.level.map.h - 1 or p == 0 then
					if x > 0                    then tiles[#tiles+1] = { [0] = x - 1, y + p } end
					if x < game.level.map.w - 1 then tiles[#tiles+1] = { [0] = x + 1, y + p } end
				end
				if y < game.level.map.h - 1         then tiles[#tiles+1] = { [0] = x,     y + 1 } end
				return tiles
			end,
			-- Dir 3
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {{ [0] = x - 1, y - r },
				               { [0] = x,     y - 1 }}
				if y < game.level.map.h - 1 then
					tiles[3] = { [0] = x - 1, y + p }
					tiles[4] = { [0] = x,     y + 1 }
				end
				if x < game.level.map.w - 1 then
					                                           tiles[#tiles+1] = { [0] = x + 1, y - r }
					if y < game.level.map.h - 1 or p == 0 then tiles[#tiles+1] = { [0] = x + 1, y + p } end
				end
				return tiles
			end,
			-- Dir 4
			function(node) end,
			-- Dir 5
			function(node)
				local tiles = {}
				getNextNodes[5](node, tiles, tiles)
				return tiles
			end,
			-- Dir 6
			function(node) end,
			-- Dir 7
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {{ [0] = x,     y + 1 },
				               { [0] = x + 1, y + p }}
				if y > 0 then
					tiles[3] = { [0] = x,     y - 1 }
					tiles[4] = { [0] = x + 1, y - r }
				end
				if x > 0 then
					                        tiles[#tiles+1] = { [0] = x - 1, y + p }
					if y > 0 or r == 0 then tiles[#tiles+1] = { [0] = x - 1, y - r } end
				end
				return tiles
			end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {{ [0] = x,     y + 1 }}
				if x > 0                            then tiles[2]        = { [0] = x - 1, y + p } end
				if x < game.level.map.w - 1         then tiles[#tiles+1] = { [0] = x + 1, y + p } end
				if y > 0 or r == 0 then
					if x > 0 then                    tiles[#tiles+1] = { [0] = x - 1, y - r } end
					if x < game.level.map.w - 1 then tiles[#tiles+1] = { [0] = x + 1, y - r } end
				end
				if y > 0 then                            tiles[#tiles+1] = { [0] = x,     y - 1 } end
				return tiles
			end,
			-- Dir 9
			function(node)
				local x, y = node[0], node[1]
				local p = x % 2
				local r = 1 - p
				local tiles = {{ [0] = x - 1, y + p },
				               { [0] = x,     y + 1 }}
				if y > 0 then
					tiles[3] = { [0] = x - 1, y - r }
					tiles[4] = { [0] = x,     y - 1 }
				end
				if x < game.level.map.w - 1 then
					                        tiles[#tiles+1] = { [0] = x + 1, y + p }
					if y > 0 or r == 0 then tiles[#tiles+1] = { [0] = x + 1, y - r } end
				end
				return tiles
			end
		}

		-- DON'T TRY TO INFER WALLS IN HEX MODE
		-- List tiles that are adjacent to both current tile and previous tile that the previous tile iterated over.
		-- Right now these (and "listSharedTilesPrevious") are used to infer what might be a wall, and may be useful later.
		-- c = current, p = previous     c*    *c*
		-- * = returned tile             *p    .p.
		listSharedTiles = {
			-- Dir 1
			function(node) return {} end,
			-- Dir 2
			function(node) return {} end,
			-- Dir 3
			function(node) return {} end,
			-- Dir 4
			function(node) return {} end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node) return {} end,
			-- Dir 7
			function(node) return {} end,
			-- Dir 8
			function(node) return {} end,
			-- Dir 9
			function(node) return {} end
		}

		-- DON'T TRY TO INFER WALLS IN HEX MODE
		-- A partial complement to "listSharedTiles".  "listSharedTiles" and "listSharedTilesPrevious" allow us to easily
		-- check specific configurations, which will come in handy if/when I rewrite the "hack" for exploring large areas.
		-- c = current, p = previous     c.    .c.
		-- * = returned tile             .p    *p*
		listSharedTilesPrevious = {
			-- Dir 1
			function(node) return {} end,
			-- Dir 2
			function(node) return {} end,
			-- Dir 3
			function(node) return {} end,
			-- Dir 4
			function(node) return {} end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node) return {} end,
			-- Dir 7
			function(node) return {} end,
			-- Dir 8
			function(node) return {} end,
			-- Dir 9
			function(node) return {} end
		}

		previousTile = {
			-- Dir 1
			function(node) return { [0] = node[0] + 1, node[1] - 1 + node[0]%2 } end,
			-- Dir 2
			function(node) return { [0] = node[0],     node[1] - 1             } end,
			-- Dir 3
			function(node) return { [0] = node[0] - 1, node[1] - 1 + node[0]%2 } end,
			-- Dir 4
			function(node) end,
			-- Dir 5
			function(node) return { [0] = node[0],     node[1]     } end,
			-- Dir 6
			function(node) end,
			-- Dir 7
			function(node) return { [0] = node[0] + 1, node[1] + node[0]%2 } end,
			-- Dir 8
			function(node) return { [0] = node[0],     node[1] + 1         } end,
			-- Dir 9
			function(node) return { [0] = node[0] - 1, node[1] + node[0]%2 } end,
		}

		-- One more kindness to the player: take advantage of asymmetric LoS in this one specific case.
		-- If an enemy is at '?', the player is able to prevent an ambush by moving to 'x' instead of 't'.
		-- This is the only sensibly preventable ambush (that I know of) in which the player can move
		-- in a way to see the would-be ambusher and the would-be ambusher can't see the player.
		-- However, don't do this if it will step onto a known trap
		--
		--   .tx      Moving onto 't' puts us adjacent to an unseen tile, '?'
		--   ?#@      --> Pick 'x' instead
		checkAmbush = function(self)
			-- HEX TODO
			if true then return nil end
			if not self.running or not self.running.explore or not self.running.path or not self.running.path[self.running.cnt] then return end

			local cx, cy = self.running.path[self.running.cnt].x, self.running.path[self.running.cnt].y
			if math.abs(self.x - cx) == 1 and math.abs(self.y - cy) == 1 then
				if game.level.map:checkAllEntities(self.x, cy, "block_move", self) and not game.level.map:checkAllEntities(cx, self.y, "block_move", self) and
						game.level.map:isBound(self.x, 2*cy - self.y) and not game.level.map.has_seens(self.x, 2*cy - self.y) then
					local trap = game.level.map(cx, self.y, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=cx, y=self.y})
					end
				elseif game.level.map:checkAllEntities(cx, self.y, "block_move", self) and not game.level.map:checkAllEntities(self.x, cy, "block_move", self) and
						game.level.map:isBound(2*cx - self.x, self.y) and not game.level.map.has_seens(2*cx - self.x, self.y) then
					local trap = game.level.map(self.x, cy, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=self.x, y=cy})
					end
				end
			end
		end

	else
		-- a flexible but slow function to list all adjacent tile
		listAdjacentNodes = function(tile, no_diagonal, no_cardinal)
			local tiles = {}
			local x, y, c
			if type(tile) == "number" then
				x, y = toDouble(tile)
				c = tile
				val = 1
			elseif tile[0] then
				x, y, c, val = tile[0], tile[1], tile[2], tile[3]+1
			else
				return tiles
			end
			local left_okay = x > 0
			local right_okay = x < game.level.map.w - 1
			local lower_okay = y > 0
			local upper_okay = y < game.level.map.h - 1
			if not no_cardinal then
				if upper_okay then tiles[1]        = { [0] = x,     y + 1, c + game.level.map.w, val, 2 } end
				if left_okay  then tiles[#tiles+1] = { [0] = x - 1, y,     c - 1,                val, 4 } end
				if right_okay then tiles[#tiles+1] = { [0] = x + 1, y,     c + 1,                val, 6 } end
				if lower_okay then tiles[#tiles+1] = { [0] = x,     y - 1, c - game.level.map.w, val, 8 } end
			end
			if not no_diagonal then
				if left_okay  and upper_okay then tiles[#tiles+1] = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 } end
				if right_okay and upper_okay then tiles[#tiles+1] = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 } end
				if left_okay  and lower_okay then tiles[#tiles+1] = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 } end
				if right_okay and lower_okay then tiles[#tiles+1] = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 } end
			end
			return tiles
		end

		-- Performing a flood-fill algorithm in lua with robust logic is going to be relatively slow, so we
		-- need to make things more efficient wherever we can.  "getNextNodes" below is an example of this.
		-- Every node knows from which direction it was explored, and it only explores adjacent tiles that
		-- may not have previously been explored.  Nodes that were explored from a cardinal direction only
		-- have three new adjacent tiles to iterate over, and diagonal directions have five new tiles.
		-- Therefore, we should favor cardinal direction tile propagation for speed whenever possible.
		--
		-- Note: if we want this to be faster such as using a floodfill for NPCs (better ai!), then we should
		-- perform the floodfill in C, where we could use more advanced tricks to make it blazingly fast.
		getNextNodes = {
			-- Dir 1
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y < game.level.map.h - 1 then
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x,     y + 1, c     + game.level.map.w, val, 2 }
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }
					if x > 0 then
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }
						cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y,     c - 1,                    val, 4 }
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }
					end
				elseif x > 0 then
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x - 1, y,     c - 1,                    val, 4 }
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }
				end
			end,
			--Dir 2
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y > game.level.map.h - 2 then return end
				if x > 0 then diagonal_tiles[#diagonal_tiles+1]                    = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 } end
				cardinal_tiles[#cardinal_tiles+1]                                  = { [0] = x,     y + 1, c     + game.level.map.w, val, 2 }
				if x < game.level.map.w - 1 then diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 } end
			end,
			-- Dir 3
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y < game.level.map.h - 1 then
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x,     y + 1, c     + game.level.map.w, val, 2 }
					if x < game.level.map.w - 1 then
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }
						cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y,     c + 1,                    val, 6 }
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }
					end
				elseif x < game.level.map.w - 1 then
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x + 1, y,     c + 1,                    val, 6 }
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }
				end
			end,
			--Dir 4
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x < 1 then return end
				if y < game.level.map.h - 1 then diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 } end
				cardinal_tiles[#cardinal_tiles+1]                                  = { [0] = x - 1, y,     c - 1,                    val, 4 }
				if y > 0 then diagonal_tiles[#diagonal_tiles+1]                    = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 } end
			end,
			--Dir 5 (all adjacent, slow)
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				local left_okay = x > 0
				local right_okay = x < game.level.map.w - 1
				local lower_okay = y > 0
				local upper_okay = y < game.level.map.h - 1
				if upper_okay then cardinal_tiles[#cardinal_tiles+1] = { [0] = x,     y + 1, c + game.level.map.w, val, 2 } end
				if left_okay  then cardinal_tiles[#cardinal_tiles+1] = { [0] = x - 1, y,     c - 1,                val, 4 } end
				if right_okay then cardinal_tiles[#cardinal_tiles+1] = { [0] = x + 1, y,     c + 1,                val, 6 } end
				if lower_okay then cardinal_tiles[#cardinal_tiles+1] = { [0] = x,     y - 1, c - game.level.map.w, val, 8 } end
				if left_okay  and upper_okay then diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 } end
				if right_okay and upper_okay then diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 } end
				if left_okay  and lower_okay then diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 } end
				if right_okay and lower_okay then diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 } end
			end,
			--Dir 6
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x > game.level.map.w - 2 then return end
				if y < game.level.map.h - 1 then diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 } end
				cardinal_tiles[#cardinal_tiles+1]                                  = { [0] = x + 1, y,     c + 1,                    val, 6 }
				if y > 0 then diagonal_tiles[#diagonal_tiles+1]                    = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 } end
			end,
			-- Dir 7
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x > 0 then
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x - 1, y + 1, c - 1 + game.level.map.w, val, 1 }
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x - 1, y,     c - 1,                    val, 4 }
					if y > 0 then
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }
						cardinal_tiles[#cardinal_tiles+1] = { [0] = x,     y - 1, c     - game.level.map.w, val, 8 }
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }
					end
				elseif y > 0 then
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x,     y - 1, c     - game.level.map.w, val, 8 }
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }
				end
			end,
			--Dir 8
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if y < 1 then return end
				if x > 0 then diagonal_tiles[#diagonal_tiles+1]                    = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 } end
				cardinal_tiles[#cardinal_tiles+1]                                  = { [0] = x,     y - 1, c     - game.level.map.w, val, 8 }
				if x < game.level.map.w - 1 then diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 } end
			end,
			-- Dir 9
			function(node, cardinal_tiles, diagonal_tiles)
				local x, y, c, val = node[0], node[1], node[2], node[3]+1
				if x < game.level.map.w - 1 then
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x + 1, y + 1, c + 1 + game.level.map.w, val, 3 }
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x + 1, y,     c + 1,                    val, 6 }
					if y > 0 then
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }
						cardinal_tiles[#cardinal_tiles+1] = { [0] = x,     y - 1, c     - game.level.map.w, val, 8 }
						diagonal_tiles[#diagonal_tiles+1] = { [0] = x + 1, y - 1, c + 1 - game.level.map.w, val, 9 }
					end
				elseif y > 0 then
					diagonal_tiles[#diagonal_tiles+1]         = { [0] = x - 1, y - 1, c - 1 - game.level.map.w, val, 7 }
					cardinal_tiles[#cardinal_tiles+1]         = { [0] = x,     y - 1, c     - game.level.map.w, val, 8 }
				end
			end
		}

		-- Use directional information to list all adjacent tiles more efficiently
		listAdjacentTiles = {
			-- Dir 1
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x + 1, y     },
				               { [0] = x,     y - 1 },
				               { [0] = x + 1, y - 1 }}
				if y < game.level.map.h - 1 then
					tiles[4]         = { [0] = x,     y + 1 }
					tiles[5]         = { [0] = x + 1, y + 1 }
					if x > 0 then
						tiles[6] = { [0] = x - 1, y + 1 }
						tiles[7] = { [0] = x - 1, y     }
						tiles[8] = { [0] = x - 1, y - 1 }
					end
				elseif x > 0 then
					tiles[4]         = { [0] = x - 1, y     }
					tiles[5]         = { [0] = x - 1, y - 1 }
				end
				return tiles
			end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x,     y - 1 }}
				if y < game.level.map.h - 1 then
					tiles[2] = { [0] = x,     y + 1 }
					if x > 0 then
						tiles[3] = { [0] = x - 1, y + 1 }
						tiles[4] = { [0] = x - 1, y     }
						tiles[5] = { [0] = x - 1, y - 1 }
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = { [0] = x + 1, y + 1 }
						tiles[#tiles+1] = { [0] = x + 1, y     }
						tiles[#tiles+1] = { [0] = x + 1, y - 1 }
					end
				else
					if x > 0 then
						tiles[2] = { [0] = x - 1, y     }
						tiles[3] = { [0] = x - 1, y - 1 }
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = { [0] = x + 1, y     }
						tiles[#tiles+1] = { [0] = x + 1, y - 1 }
					end
				end
				return tiles
			end,
			-- Dir 3
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x - 1, y     },
				               { [0] = x - 1, y - 1 },
				               { [0] = x,     y - 1 }}
				if y < game.level.map.h - 1 then
					tiles[4]         = { [0] = x - 1, y + 1 }
					tiles[5]         = { [0] = x,     y + 1 }
					if x < game.level.map.w - 1 then
						tiles[6] = { [0] = x + 1, y + 1 }
						tiles[7] = { [0] = x + 1, y     }
						tiles[8] = { [0] = x + 1, y - 1 }
					end
				elseif x < game.level.map.w - 1 then
					tiles[4]         = { [0] = x + 1, y     }
					tiles[5]         = { [0] = x + 1, y - 1 }
				end
				return tiles
			end,
			-- Dir 4
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x + 1, y     }}
				if x > 0 then
					tiles[2] = { [0] = x - 1, y     }
					if y < game.level.map.h - 1 then
						tiles[3] = { [0] = x - 1, y + 1 }
						tiles[4] = { [0] = x,     y + 1 }
						tiles[5] = { [0] = x + 1, y + 1 }
					end
					if y > 0 then
						tiles[#tiles+1] = { [0] = x - 1, y - 1 }
						tiles[#tiles+1] = { [0] = x,     y - 1 }
						tiles[#tiles+1] = { [0] = x + 1, y - 1 }
					end
				else
					if y < game.level.map.h - 1 then
						tiles[2] = { [0] = x,     y + 1 }
						tiles[3] = { [0] = x + 1, y + 1 }
					end
					if y > 0 then
						tiles[#tiles+1] = { [0] = x,     y - 1 }
						tiles[#tiles+1] = { [0] = x + 1, y - 1 }
					end
				end
				return tiles
			end,
			-- Dir 5
			function(node)
				local tiles = {}
				getNextNodes[5](node, tiles, tiles)
				return tiles
			end,
			-- Dir 6
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x - 1, y     }}
				if x < game.level.map.w - 1 then
					tiles[2] = { [0] = x + 1, y     }
					if y < game.level.map.h - 1 then
						tiles[3] = { [0] = x - 1, y + 1 }
						tiles[4] = { [0] = x,     y + 1 }
						tiles[5] = { [0] = x + 1, y + 1 }
					end
					if y > 0 then
						tiles[#tiles+1] = { [0] = x - 1, y - 1 }
						tiles[#tiles+1] = { [0] = x,     y - 1 }
						tiles[#tiles+1] = { [0] = x + 1, y - 1 }
					end
				else
					if y < game.level.map.h - 1 then
						tiles[2] = { [0] = x - 1, y + 1 }
						tiles[3] = { [0] = x,     y + 1 }
					end
					if y > 0 then
						tiles[#tiles+1] = { [0] = x - 1, y - 1 }
						tiles[#tiles+1] = { [0] = x,     y - 1 }
					end
				end
				return tiles
			end,
			-- Dir 7
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x,     y + 1 },
				               { [0] = x + 1, y + 1 },
				               { [0] = x + 1, y     }}
				if x > 0 then
					tiles[4]         = { [0] = x - 1, y + 1 }
					tiles[5]         = { [0] = x - 1, y     }
					if y > 0 then
						tiles[6] = { [0] = x - 1, y - 1 }
						tiles[7] = { [0] = x,     y - 1 }
						tiles[8] = { [0] = x + 1, y - 1 }
					end
				elseif y > 0 then
					tiles[4]         = { [0] = x,     y - 1 }
					tiles[5]         = { [0] = x + 1, y - 1 }
				end
				return tiles
			end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x,     y + 1 }}
				if y > 0 then
					tiles[2] = { [0] = x,     y - 1 }
					if x > 0 then
						tiles[3] = { [0] = x - 1, y + 1 }
						tiles[4] = { [0] = x - 1, y     }
						tiles[5] = { [0] = x - 1, y - 1 }
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = { [0] = x + 1, y + 1 }
						tiles[#tiles+1] = { [0] = x + 1, y     }
						tiles[#tiles+1] = { [0] = x + 1, y - 1 }
					end
				else
					if x > 0 then
						tiles[2] = { [0] = x - 1, y + 1 }
						tiles[3] = { [0] = x - 1, y     }
					end
					if x < game.level.map.w - 1 then
						tiles[#tiles+1] = { [0] = x + 1, y + 1 }
						tiles[#tiles+1] = { [0] = x + 1, y     }
					end
				end
				return tiles
			end,
			-- Dir 9
			function(node)
				local x, y = node[0], node[1]
				local tiles = {{ [0] = x - 1, y + 1 },
				               { [0] = x,     y + 1 },
				               { [0] = x - 1, y     }}
				if x < game.level.map.w - 1 then
					tiles[4]         = { [0] = x + 1, y + 1 }
					tiles[5]         = { [0] = x + 1, y     }
					if y > 0 then
						tiles[6] = { [0] = x - 1, y - 1 }
						tiles[7] = { [0] = x,     y - 1 }
						tiles[8] = { [0] = x + 1, y - 1 }
					end
				elseif y > 0 then
					tiles[4]         = { [0] = x - 1, y - 1 }
					tiles[5]         = { [0] = x,     y - 1 }
				end
				return tiles
			end
		}

		-- List tiles that are adjacent to both current tile and previous tile that the previous tile iterated over.
		-- Right now these (and "listSharedTilesPrevious") are used to infer what might be a wall, and may be useful later.
		-- c = current, p = previous     c*    *c*
		-- * = returned tile             *p    .p.
		listSharedTiles = {
			-- Dir 1
			function(node)
				local x, y = node[0], node[1]
				return {{ [0] = x + 1, y     },
				        { [0] = x,     y - 1 }}
			end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {{ [0] = x + 1, y     }}
				elseif x > game.level.map.w - 2 then return {{ [0] = x - 1, y     }}
				else return {{ [0] = x - 1, y     },
				             { [0] = x + 1, y     }}
				end
			end,
			-- Dir 3
			function(node)
				local x, y = node[0], node[1]
				return {{ [0] = x - 1, y     },
				        { [0] = x,     y - 1 }}
			end,
			-- Dir 4
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {{ [0] = x,     y + 1 }}
				elseif y > game.level.map.h - 2 then return {{ [0] = x,     y - 1 }}
				else return {{ [0] = x,     y + 1 },
				             { [0] = x,     y - 1 }}
				end
			end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {{ [0] = x,     y + 1 }}
				elseif y > game.level.map.h - 2 then return {{ [0] = x,     y - 1 }}
				else return {{ [0] = x,     y + 1 },
				             { [0] = x,     y - 1 }}
				end
			end,
			-- Dir 7
			function(node)
				local x, y = node[0], node[1]
				return {{ [0] = x,     y + 1 },
				        { [0] = x + 1, y     }}
			end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {{ [0] = x + 1, y     }}
				elseif x > game.level.map.w - 2 then return {{ [0] = x - 1, y     }}
				else return {{ [0] = x - 1, y     },
				             { [0] = x + 1, y     }}
				end
			end,
			-- Dir 9
			function(node)
				local x, y = node[0], node[1]
				return {{ [0] = x,     y + 1 },
				        { [0] = x - 1, y     }}
			end
		}

		-- A partial complement to "listSharedTiles".  "listSharedTiles" and "listSharedTilesPrevious" allow us to easily
		-- check specific configurations, which will come in handy if/when I rewrite the "hack" for exploring large areas.
		-- c = current, p = previous     c.    .c.
		-- * = returned tile             .p    *p*
		listSharedTilesPrevious = {
			-- Dir 1
			function(node) return {} end,
			-- Dir 2
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {{ [0] = x + 1, y - 1 }}
				elseif x > game.level.map.w - 2 then return {{ [0] = x - 1, y - 1 }}
				else return {{ [0] = x + 1, y - 1 },
				             { [0] = x - 1, y - 1 }}
				end
			end,
			-- Dir 3
			function(node) return {} end,
			-- Dir 4
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {{ [0] = x + 1, y + 1 }}
				elseif y > game.level.map.h - 2 then return {{ [0] = x + 1, y - 1 }}
				else return {{ [0] = x + 1, y + 1 },
				             { [0] = x + 1, y - 1 }}
				end
			end,
			-- Dir 5
			function(node) return {} end,
			-- Dir 6
			function(node)
				local x, y = node[0], node[1]
				if     y < 1                    then return {{ [0] = x - 1, y + 1 }}
				elseif y > game.level.map.h - 2 then return {{ [0] = x - 1, y - 1 }}
				else return {{ [0] = x - 1, y + 1 },
				             { [0] = x - 1, y - 1 }}
				end
			end,
			-- Dir 7
			function(node) return {} end,
			-- Dir 8
			function(node)
				local x, y = node[0], node[1]
				if     x < 1                    then return {{ [0] = x + 1, y + 1 }}
				elseif x > game.level.map.w - 2 then return {{ [0] = x - 1, y + 1 }}
				else return {{ [0] = x + 1, y + 1 },
				             { [0] = x - 1, y + 1 }}
				end
			end,
			-- Dir 9
			function(node) return {} end
		}

		previousTile = {
			-- Dir 1
			function(node) return { [0] = node[0] + 1, node[1] - 1 } end,
			-- Dir 2
			function(node) return { [0] = node[0],     node[1] - 1 } end,
			-- Dir 3
			function(node) return { [0] = node[0] - 1, node[1] - 1 } end,
			-- Dir 4
			function(node) return { [0] = node[0] + 1, node[1]     } end,
			-- Dir 5
			function(node) return { [0] = node[0],     node[1]     } end,
			-- Dir 6
			function(node) return { [0] = node[0] - 1, node[1]     } end,
			-- Dir 7
			function(node) return { [0] = node[0] + 1, node[1] + 1 } end,
			-- Dir 8
			function(node) return { [0] = node[0],     node[1] + 1 } end,
			-- Dir 9
			function(node) return { [0] = node[0] - 1, node[1] + 1 } end,
		}

		-- One more kindness to the player: take advantage of asymmetric LoS in this one specific case.
		-- If an enemy is at '?', the player is able to prevent an ambush by moving to 'x' instead of 't'.
		-- This is the only sensibly preventable ambush (that I know of) in which the player can move
		-- in a way to see the would-be ambusher and the would-be ambusher can't see the player.
		-- However, don't do this if it will step onto a known trap
		--
		--   .tx      Moving onto 't' puts us adjacent to an unseen tile, '?'
		--   ?#@      --> Pick 'x' instead
		checkAmbush = function(self)
			if not self.running or not self.running.explore or not self.running.path or not self.running.path[self.running.cnt] then return end

			local cx, cy = self.running.path[self.running.cnt].x, self.running.path[self.running.cnt].y
			if math.abs(self.x - cx) == 1 and math.abs(self.y - cy) == 1 then
				if game.level.map:checkAllEntities(self.x, cy, "block_move", self) and not game.level.map:checkAllEntities(cx, self.y, "block_move", self) and
						game.level.map:isBound(self.x, 2*cy - self.y) and not game.level.map.has_seens(self.x, 2*cy - self.y) then
					local trap = game.level.map(cx, self.y, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=cx, y=self.y})
					end
				elseif game.level.map:checkAllEntities(cx, self.y, "block_move", self) and not game.level.map:checkAllEntities(self.x, cy, "block_move", self) and
						game.level.map:isBound(2*cx - self.x, self.y) and not game.level.map.has_seens(2*cx - self.x, self.y) then
					local trap = game.level.map(self.x, cy, Map.TRAP)
					if not trap or not trap:knownBy(self) then
						table.insert(self.running.path, self.running.cnt, {x=self.x, y=cy})
					end
				end
			end
		end
	end -- end else
end -- end generateNodeFunctions


-- If a target destination is found, then it creates (or updates) "self.running" and returns true.
-- If no target, or if we shouldn't explore for some reason, then return false.
function _M:autoExplore()
	generateNodeFunctions()

	-- levels that use "all_remembered" (like towns) don't set "has_seen" values to true for all grids,
	-- so this lets us behave reasonably in these zones: go to objects and then exit
	local do_unseen = not (game.level.all_remembered or game.zone and game.zone.all_remembered)

	-- if we changed levels, then remove previous auto-explore information
	if self.running_prev and self.running_prev.levelstring ~= tostring(game.level) then self.running_prev = nil end

	local node = is_ffi and ffi.new("cnode", {self.x, self.y, toSingle(self.x, self.y), 0, 5 }) or { [0] = self.x, self.y, toSingle(self.x, self.y), 0, 5 }
	local current_tiles = { node }
	local unseen_tiles = {}
	local unseen_singlets = {}
	local unseen_items = {}
	local unseen_special = {}
	local unseen_doors = {}
	local exits = {}
	local portals = {}
	local values = {}
	values[node[2]] = 0
	local safe_doors = {}
	local door_values = {}
	local slow_values = {}
	local slow_tiles = {}
	local iter = 1
	local running = true
	local minval = 999999999999999
	local minval_items = 999999999999999
	local minval_special = 999999999999999
	local minval_portals = 999999999999999
	local val, _, anode, tile_list

	-- a few tunable parameters
	local extra_iters = 5     -- number of extra iterations to do after we found an item or unseen tile
	local singlet_greed = 4   -- number of additional moves we're willing to do to explore a single unseen tile
	local item_greed = 5      -- number of additional moves we're willing to do to visit an unseen item rather than an unseen tile
	local special_greed = 5   -- number of additional moves we're willing to do to visit a special tile rather than an unseen tile

	-- we only run to a vault or locked door once, but if we are next to it, then we should try to open it if appropriate
	local c = toSingle(self.x, self.y)
	for _, node in ipairs(listAdjacentNodes(c)) do
		local ax, ay = node[0], node[1]
		local terrain = game.level.map(ax, ay, Map.TERRAIN)
		if terrain and game.level.map.attrs(ax, ay, "autoexplore_ignore") and (terrain.door_player_check or terrain.door_player_stop) then
			unseen_doors[#unseen_doors + 1] = toSingle(ax, ay)
			door_values[toSingle(ax, ay)] = 1
		end
	end

	-- Create a distance map array via flood-fill to locate unseen tiles, unvisited items, closed doors, and exits
	while running do
		-- construct lists of adjacent tiles to iterate over, and iterate in cardinal directions first
		local current_tiles_next = {}
		local cardinal_tiles = {}
		local diagonal_tiles = {}
		-- Nearly half the time is spent here.  This could be implemented in C if desired, but I think it's fast enough
		-- I wonder how much time is spent here now that nodes are using ffi data
		for _, node in ipairs(current_tiles) do
			getNextNodes[node[4]](node, cardinal_tiles, diagonal_tiles)
		end

		-- The other half of the time is spent in this loop
		for _, tile_list in ipairs({cardinal_tiles, diagonal_tiles}) do
			for _, node in ipairs(tile_list) do
				local x, y, c, move_cost, dir = node[0], node[1], node[2], node[3], node[4]

				if not game.level.map.has_seens(x, y) and do_unseen then
					if not values[c] or values[c] > move_cost then
						unseen_tiles[#unseen_tiles + 1] = c
						values[c] = move_cost
						if move_cost < minval then
							minval = move_cost
						end
						-- Try to not abandon lone unseen tiles
						local is_singlet = true
						for _, anode in ipairs(listAdjacentTiles[dir](node)) do
							if not game.level.map.has_seens(anode[0], anode[1]) then
								is_singlet = false
								break
							end
						end

						-- DON'T TRY TO INFER WALLS IN HEX MODE
						-- look for tiles that are probably walls so we can hopefully explore more efficiently by preventing unnecessary return trips.
						--               ?#       #?#
						-- For example:  #.  and  ...  are probably walls (in most zones)
						if not is_singlet and not util.isHex() then
							is_singlet = true
							for _, anode in ipairs(listSharedTiles[dir](node)) do
								if not game.level.map.has_seens(anode[0], anode[1]) or not game.level.map:checkEntity(anode[0], anode[1], Map.TERRAIN, "does_block_move") then
									is_singlet = false
								-- if we propagated diagonally, then check if this might be a wall side, not corner
								--  c = current,  1 = supposed wall    #c1
								--  p = previous, 2 = supposed floor   p.2
								elseif dir % 2 == 1 then
									local x1 = 2*x - anode[0]
									local y1 = 2*y - anode[1]
									if game.level.map.has_seens(x1, y1) and game.level.map:checkEntity(x1, y1, Map.TERRAIN, "does_block_move") then
										local pnode = previousTile[dir](node)
										x1 = x1 + pnode[0] - anode[0]
										y1 = y1 + pnode[1] - anode[1]
										if game.level.map.has_seens(x1, y1) and not game.level.map:checkEntity(x1, y1, Map.TERRAIN, "does_block_move") then
											is_singlet = true
											break
										end
									end
								end
							end
							-- if walls are where we expect them to be, check that floors are where we expect:
							-- c = current, ? = supposed floor   #c#
							-- p = previous,                     ?p?
							if is_singlet then
								for _, anode in ipairs(listSharedTilesPrevious[dir](node)) do
									if not game.level.map.has_seens(anode[0], anode[1]) or game.level.map:checkEntity(anode[0], anode[1], Map.TERRAIN, "does_block_move") then
										is_singlet = false
										break
									end
								end
							end
						end
						if is_singlet then
							unseen_singlets[#unseen_singlets + 1] = c
						end
					end
				else
					-- Increase move cost for known traps and terrain that drains air or deals damage
					-- These could stack if we want--such as a trap in poisonous water--but this way is slightly faster and "good enough"
					-- "slow" terrain will be avoided if at all possible
					-- The additional movement costs below are completely arbitrary
					local trap = game.level.map(x, y, Map.TRAP)
					local terrain = game.level.map(x, y, Map.TERRAIN)
					local is_slow = false
					if trap and trap:knownBy(self) then
						move_cost = move_cost + 67
						is_slow = true
					elseif terrain.mindam or terrain.maxdam then
						move_cost = move_cost + 32
						is_slow = true
					elseif terrain.on_stand and not terrain.on_stand_safe then
						move_cost = move_cost + 21
						is_slow = true
					end
					-- propagate "current_tiles" for next iteration
					if (not values[c] or values[c] > move_cost or is_slow) and (not is_slow or not slow_values[c] or slow_values[c] > move_cost) then
--						if not game.level.map:checkEntity(x, y, Map.TERRAIN, "block_move", self, nil, true) then
--						if not game.level.map:checkAllEntities(x, y, "block_move", self) then

						-- This is a sinful man's "block_move".  If it messes up, then players can explore the level themselves!
						-- (and they can always interrupt running if something terrible happens)
						if not (terrain.does_block_move or terrain.door_opened) then
							if is_slow then
								node[3] = move_cost
								slow_values[c] = move_cost
								slow_tiles[#slow_tiles + 1] = node
							else
								values[c] = move_cost
								current_tiles_next[#current_tiles_next + 1] = node
							end
						end
						-- go to special terrain unless it should be ignored
						if terrain.special and not terrain.autoexplore_ignore and not game.level.map.attrs(x, y, "autoexplore_ignore") then
							unseen_special[#unseen_special + 1] = c
							values[c] = move_cost
							if move_cost < minval_special then
								minval_special = move_cost
							end
						-- only go to objects we haven't walked over yet
						elseif game.level.map:getObject(x, y, 1) and not game.level.map.attrs(x, y, "obj_seen") then
							unseen_items[#unseen_items + 1] = c
							values[c] = move_cost
							if move_cost < minval_items then
								minval_items = move_cost
							end
						-- default to reasonable targets if there are no accessible unseen tiles or objects left on the map
						-- only go to closed doors with unseen grids behind them. We can go through "safe" doors
						elseif terrain.door_opened and do_unseen then
							local is_unexplored = false
							for _, anode in ipairs(listAdjacentTiles[dir](node)) do
								if not game.level.map.has_seens(anode[0], anode[1]) then
									is_unexplored = true
									break
								end
							end
							if is_unexplored and not game.level.map.attrs(x, y, "autoexplore_ignore") then
								unseen_doors[#unseen_doors + 1] = c
								if not door_values[c] or door_values[c] > move_cost then
									door_values[c] = move_cost
								end
							elseif not is_unexplored then -- door is safe to move through
								node[3] = move_cost + 1
								safe_doors[c] = true
								if is_slow then
									slow_values[c] = move_cost + 1
									slow_tiles[#slow_tiles + 1] = node
								else
									values[c] = move_cost + 1
									current_tiles_next[#current_tiles_next + 1] = node
								end
							end
						-- go to next level, exit, previous level, or orb portal (in that order of precedence)
						elseif terrain.change_level then
							exits[#exits + 1] = c
							values[c] = move_cost
						elseif terrain.orb_portal then
							local is_portal_center = true
							local is_small_portal = true
							for _, anode in ipairs(listAdjacentTiles[dir](node)) do
								if not game.level.map:checkEntity(anode[0], anode[1], Map.TERRAIN, "orb_portal") then
									is_portal_center = false
								else
									is_small_portal = false
								end
							end
							if is_portal_center or is_small_portal then
								portals[#portals + 1] = c
								values[c] = move_cost
								if move_cost < minval_portals then
									minval_portals = move_cost
								end
							end
						end
					end
				end
			end
		end
		-- Continue the loop if we haven't found any destination tiles or if lower cost paths to the destination tiles may exist
		running = #unseen_tiles == 0 and #unseen_items == 0 and #unseen_special == 0
		for _, c in ipairs(unseen_tiles) do
			if values[c] > iter then
				running = true
				break
			end
		end
		if not running then
			for _, c in ipairs(unseen_items) do
				if values[c] > iter then
					running = true
					break
				end
			end
		end
		-- performing a few extra iteration will help us conveniently handle a few fringe cases
		if not running and extra_iters > 0 then
			running = true
			extra_iters = extra_iters - 1
		end

		-- if we need to continue running but have no more tiles to iterate over, propagate from "slow_tiles" such as traps
		if #current_tiles_next == 0 and #slow_tiles > 0 and #unseen_tiles == 0 and #unseen_items == 0 and #unseen_special == 0 then
			running = true
			current_tiles = slow_tiles
			for _, node in ipairs(slow_tiles) do
				local c, val = node[2], node[3]
				if not values[c] or val < values[c] then
					values[c] = val
				end
			end
			slow_tiles = {}
		-- otherwise, stop the loop if there are no more tiles to iterate over
		else
			running = running and #current_tiles_next > 0
			current_tiles = current_tiles_next
		end

		iter = iter + 1
	end

	-- Negligible time is spent below
	-- Choose target
	if #unseen_tiles > 0 or #unseen_items > 0 or #unseen_special > 0 or #unseen_doors > 0 or #exits > 0 or #portals > 0 then
		local target_type
		local choices = {}
		local distances = {}
		local mindist = 999999999999999
		-- If we already have a suitable target that we haven't reached yet, then use that as our target.  This will be more useful
		-- if or when we save info between between instances of running auto-explore.  For now it's useful when dodging traps on the fly.
		if self.running_prev and (self.running_prev.explore == "exit" or self.running_prev.explore == "portal") and (self.x ~= self.running_prev.target.x or self.y ~= self.running_prev.target.y) then
			-- verify that the target is currently reachable
			for _, c in ipairs(exits) do
				local x, y = toDouble(c)
				if x == self.running_prev.target.x and y == self.running_prev.target.y then
					target_type = "exit"
					choices[1] = c
					distances[c] = 1
					mindist = 1
					break
				end
			end
			if #choices == 0 then
				for _, c in ipairs(portals) do
					local x, y = toDouble(c)
					if x == self.running_prev.target.x and y == self.running_prev.target.y then
						target_type = "portal"
						choices[1] = c
						distances[c] = 1
						mindist = 1
						break
					end
				end
			end
		end

		-- metric to favor exploring (1) edges of map, (2) near recently explored, and (3) closest fov distance
		local function distance_cost(lx, ly)
			local val = self.running and self.running.ave_x and core.fov.distance(self.x, self.y, self.running.ave_x, self.running.ave_y, true) or 0
			return val + 0.9*core.fov.distance(self.x, self.y, lx, ly, true) - 0.6*(math.abs(0.5*game.level.map.w - lx) + math.abs(0.5*game.level.map.h - ly))
		end

		-- go to closest special terrain first
		if #choices == 0 and minval_special <= minval + special_greed then
			for _, c in ipairs(unseen_special) do
				if values[c] == minval_special then
					target_type = "special"
					choices[#choices + 1] = c
					local x, y = toDouble(c)
					local dist = distance_cost(x, y)
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- go to closest items next
		if #choices == 0 and minval_items <= minval + item_greed then
			for _, c in ipairs(unseen_items) do
				if values[c] == minval_items then
					target_type = "object"
					choices[#choices + 1] = c
					local x, y = toDouble(c)
					local dist = distance_cost(x, y)
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- try to explore cleanly--don't leave single unseen tiles by themselves
		if #choices == 0 then
			for _, c in ipairs(unseen_singlets) do
				if values[c] <= minval + singlet_greed then
					target_type = "unseen"
					choices[#choices + 1] = c
					local x, y = toDouble(c)
					local dist = distance_cost(x, y)
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end

		-- hack! temporary hack to explore large unseen areas more reasonably and carefully (but not very efficiently)
		local min_hack_dist = 999999999999999
		local min_hack_val = 999999999999999
		local hack_greed = 5
		local hack_distances = {}
		local hack_tiles = {}
		if #choices == 0 and self.running and self.running.ave_x and self.running.ave_N % 6 == 0 then
			for _, c in ipairs(unseen_tiles) do
				if values[c] <= minval + hack_greed then
					hack_tiles[#hack_tiles + 1] = c
					local x, y = toDouble(c)
					local hack_dist = x*(x - 2*self.running.ave_x) + y*(y - 2*self.running.ave_y) + values[c]*(values[c] - 0.5)
					hack_distances[c] = hack_dist
					if hack_dist < min_hack_dist then
						min_hack_dist = hack_dist
					end
				end
			end
			for _, c in ipairs(hack_tiles) do
				if hack_distances[c] == min_hack_dist then
					if values[c] < min_hack_val then
						min_hack_val = values[c]
					end
				end
			end
			for _, c in ipairs(hack_tiles) do
				if hack_distances[c] == min_hack_dist and values[c] == min_hack_val then
					target_type = "unseen"
					choices[#choices + 1] = c
					local x, y = toDouble(c)
					local dist = distance_cost(x, y)
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- end hack!

		-- if no nearby items, go to nearest unseen tile
		if #choices == 0 then
			for _, c in ipairs(unseen_tiles) do
				if values[c] <= minval + 2 then  -- have some flexibility to explore based on "distance_cost"
					target_type = "unseen"
					choices[#choices + 1] = c
					local x, y = toDouble(c)
					local dist = distance_cost(x, y) + 0.3*values[c]
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- if no destination yet, go to nearest unexplored closed non-vault door
		if #choices == 0 then
			local add_values = {}
			for _, c in ipairs(unseen_doors) do
				local x, y = toDouble(c)
				local terrain = game.level.map(x, y, Map.TERRAIN)
				if not terrain.door_player_check and not terrain.door_player_stop then
					target_type = "door"
					choices[#choices + 1] = c
					-- we may take an extra step to approach a door squarely from a cardinal direction, so let's account for this
					local door_val = door_values[c]
					local min_diagonal = door_val
					local min_cardinal = door_val
					for _, node in ipairs(listAdjacentNodes(c, true)) do
						if values[node[2]] and values[node[2]] < min_cardinal then
							min_cardinal = values[node[2]]
						end
					end
					for _, node in ipairs(listAdjacentNodes(c, false, true)) do
						if values[node[2]] and values[node[2]] < min_diagonal then
							min_diagonal = values[node[2]]
						end
					end
					local plus_one = 0
					if min_cardinal > min_diagonal then
						for _, node in ipairs(listAdjacentNodes(c, false, true)) do
							if values[node[2]] then
								add_values[node[2]] = values[node[2]] + 1
								plus_one = 1
							end
						end
					end

					local dist = distance_cost(x, y) + 10*(door_values[c] + plus_one)
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
			for _, c in ipairs(add_values) do
				values[c] = (values[c] or 0) + (add_values[c] or 0)
			end
		end
		-- ...or vault door
		if #choices == 0 then
			for _, c in ipairs(unseen_doors) do
				local x, y = toDouble(c)
				local terrain = game.level.map(x, y, Map.TERRAIN)
				if terrain.door_player_check or terrain.door_player_stop then
					target_type = "door"
					choices[#choices + 1] = c
					local dist = distance_cost(x, y) + 10*door_values[c]
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- if still no destination, then the accessible parts of the level are fully explored and we can go to the next level
		if #choices == 0 then
			for _, c in ipairs(exits) do
				local x, y = toDouble(c)
				local terrain = game.level.map(x, y, Map.TERRAIN)
				if terrain.change_level > 0 and not terrain.change_zone then
					target_type = "exit"
					choices[#choices + 1] = c
					local dist = distance_cost(x, y) + 10*values[c]
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- ...or next zone
		if #choices == 0 then
			for _, c in ipairs(exits) do
				local x, y = toDouble(c)
				local terrain = game.level.map(x, y, Map.TERRAIN)
				if terrain.change_zone then
					target_type = "exit"
					choices[#choices + 1] = c
					local dist = distance_cost(x, y) + 10*values[c]
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- ...or previous level
		if #choices == 0 then
			for _, c in ipairs(exits) do
				local x, y = toDouble(c)
				local terrain = game.level.map(x, y, Map.TERRAIN)
				if terrain.change_level < 0 then
					target_type = "exit"
					choices[#choices + 1] = c
					local dist = distance_cost(x, y) + 10*values[c]
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end
		-- ...or orb portal
		if #choices == 0 then
			for _, c in ipairs(portals) do
				if values[c] == minval_portals then
					target_type = "portal"
					choices[#choices + 1] = c
					local x, y = toDouble(c)
					local dist = distance_cost(x, y)
					distances[c] = dist
					if dist < mindist then
						mindist = dist
					end
				end
			end
		end

		-- if multiple choices, then choose nearest one based on fov distance metric
		if #choices > 1 then
			local choices2 = {}
			for _, c in ipairs(choices) do
				if distances[c] == mindist then
					choices2[#choices2 + 1] = c
				end
			end
			choices = choices2
		end
		-- if still multiple choices, then choose one randomly
		local target = #choices > 0 and rng.table(choices) or nil

		-- Now create the path to the target (constructed from target to source)
		if target then
			if target_type == "door" then values[target] = door_values[target] end
			local target_x, target_y = toDouble(target)
			local x, y = toDouble(target)
			local path = {{x=x, y=y}}
			local current_val = values[target]
			-- the idiot check condition should NEVER occur, but, well, if it does, it'll save us from being stuck in an infinite loop
			local idiot_counter = 0
			local idiot_check = current_val + 5
			while (path[#path].x ~= self.x or path[#path].y ~= self.y) and idiot_counter <= idiot_check do
				idiot_counter = idiot_counter + 1
				-- perform a greedy minimization that prefers cardinal directions
				local cardinals = {}
				local min_cardinal = current_val
				for _, node in ipairs(listAdjacentNodes(target, true)) do
					local c = node[2]
					if values[c] and values[c] <= min_cardinal then
						min_cardinal = values[c]
						cardinals[#cardinals + 1] = node
					end
				end
				local diagonals = {}
				local min_diagonal = current_val
				for _, node in ipairs(listAdjacentNodes(target, false, true)) do
					local c = node[2]
					if values[c] and values[c] < min_diagonal then
						min_diagonal = values[c]
						diagonals[#diagonals + 1] = node
					end
				end

				-- Favor cardinal directions since we are constructing the path in reverse.
				-- This results in dog-leg (or hockey stick)-like movement.  If desired, we could try adding an A*-like heuristic
				-- to favor straighter line movement (i.e., alternate between diagonal and cardinal moves), but, meh, whatever ;)
				-- If our target is a door, it would be very nice to approach it from a cardinal direction, because this would
				-- give a much better and safer view should the player choose to open the door.  Also do this for "safe" doors
				local c = toSingle(path[#path].x, path[#path].y)
				if #cardinals == 0 or min_diagonal < min_cardinal and not (min_cardinal < min_diagonal + 2 and (safe_doors[c] or door_values[c])) then
					current_val = min_diagonal
					for _, node in ipairs(diagonals) do
						if values[node[2]] == min_diagonal then
							path[#path + 1] = {x=node[0], y=node[1]}
							target = node[2]
							break
						end
					end
				else
					current_val = min_cardinal
					for _, node in ipairs(cardinals) do
						if values[node[2]] == min_cardinal then
							path[#path + 1] = {x=node[0], y=node[1]}
							target = node[2]
							break
						end
					end
				end
			end

			-- sanity check.  This should NEVER occur, but if it does by freak accident, let's be prepared
			if path[#path].x ~= self.x or path[#path].y ~= self.y then
				path = {}
			else
				-- un-reverse the path and don't include the player x, y
				local temp_path = {}
				for i = #path-1, 1, -1 do temp_path[#temp_path + 1] = path[i] end
				path = temp_path
			end

			if #path > 0 then
				if self.running and self.running.explore then
					-- take care of a couple fringe cases
					-- don't open adjacent or target doors if we've already been running
					local x, y = path[1].x, path[1].y
					local terrain = game.level.map(x, y, Map.TERRAIN)
					if target_type == "door" then
						if #path == 1 then
							self:runStop("at door")
							if terrain and (terrain.door_player_check or terrain.door_player_stop) then game.level.map.attrs(x, y, "autoexplore_ignore", true) end
							return false
						else
							path[#path] = nil
						end
					end
					-- don't bump into special terrain if we've already been running
					if target_type == "special" then
						if #path == 1 then
							self:runStop("something interesting")
							game.level.map.attrs(x, y, "autoexplore_ignore", true)
							return false
						end
					end

					-- don't run into adjacent interesting terrain if we've already been running
					if terrain.notice and (target_type ~= "exit" and target_type ~= "portal" or #path ~= 1) then
						if safe_doors[toSingle(x, y)] and not self.running.busy then
							self.running.busy = { type = "opening door", do_move = true, no_energy = true }
						elseif not game.level.map.attrs(x, y, "noticed") then
							if terrain.change_level or terrain.orb_portal or terrain.escort_portal then game.level.map.attrs(x, y, "noticed", true) end
							self:runStop("interesting terrain")
							return false
						end
					end

					self.running.path = path
					self.running.cnt = 1
					self.running.explore = target_type
					self.running.target = {x=target_x, y=target_y}
					-- hack!
					self.running.ave_x = (self.running.ave_x*self.running.ave_N + 2*(target_x + self.x)) / (self.running.ave_N + 4)
					self.running.ave_y = (self.running.ave_y*self.running.ave_N + 2*(target_y + self.y)) / (self.running.ave_N + 4)
					self.running.ave_N = self.running.ave_N + 2
					-- end hack!
					checkAmbush(self)
				else
					if #path == 1 then
						-- another fringe case: if we target an item in an adjacent wall that we've probably already targeted, then mark it as seen and find a new target
						if target_type == "object" and game.level.map:checkEntity(target_x, target_y, Map.TERRAIN, "block_move", self, nil, true) then
							game.level.map.attrs(target_x, target_y, "obj_seen", true)
							return self:autoExplore()
						end
						-- similar deal for adjacent "special" terrain
						if target_type == "special" then
							game.level.map.attrs(target_x, target_y, "autoexplore_ignore", true)
							return self:autoExplore()
						end
						local x, y = path[1].x, path[1].y
						local terrain = game.level.map(x, y, Map.TERRAIN)
						if target_type == "door" and terrain and (terrain.door_player_check or terrain.door_player_stop) then
							game.level.map.attrs(x, y, "autoexplore_ignore", true)
						end
					end
					-- don't open non-adjacent target doors
					if target_type == "door" and #path > 1 then path[#path] = nil end

					self.running = {
						path = path,
						cnt = 1,
						dialog = Dialog:simplePopup("Running...", "You are exploring, press any key to stop.", function()
							self:runStop()
						end, false, true),
						explore = target_type,
						target = {x=target_x, y=target_y},
						levelstring = tostring(game.level)
					}
					-- hack!
					if self.running_prev then
						self.running.ave_N = 0.6*self.running_prev.ave_N
						self.running.ave_x = (self.running_prev.ave_x*self.running.ave_N + 2*(target_x + self.x)) / (self.running.ave_N + 4)
						self.running.ave_y = (self.running_prev.ave_y*self.running.ave_N + 2*(target_y + self.y)) / (self.running.ave_N + 4)
						self.running.ave_N = 2*math.floor(0.5*self.running.ave_N + 1)
					else
						self.running.ave_x = 0.5*(target_x + self.x)
						self.running.ave_y = 0.5*(target_y + self.y)
						self.running.ave_N = 2
					end
					-- end hack!

					self.running.dialog.__showup = nil
					self.running.dialog.__hidden = true
					self.running_prev = self.running

					self:runStep()
				end
				return true
			end
		end
	end
	return false
end

function _M:checkAutoExplore()
	if not self.running or not self.running.explore then return false end

	-- We can open a door and explore if the player initiated auto-explore directly adjacent to the target door.
	-- If not, though, then stop, because the player *must* choose to open the door (except for "safe" doors)
	local node = self.running.path[self.running.cnt]
	local cx, cy = node and node.x, node and node.y
	local terrain = node and game.level.map(cx, cy, Map.TERRAIN)
	if terrain and terrain.door_opened then
		-- we already tried to open the door but failed (always fails on vault doors)
		if self.running.busy and self.running.busy.type == "opening door" then
			self:runStop("checked door")
			return false
		-- we didn't know this was a door at the time, so explore a new path
		elseif self.running.explore == "unseen" and self.running.cnt == #self.running.path and game.level.map.has_seens(cx, cy) then
			return self:autoExplore()
		-- this is either a "safe" door or a target adjacent door.  Either way, we can open it, which takes a movement action but no energy to do
		else
			self.running.busy = { type = "opening door", do_move = true, no_energy = true }
			return true
		end
	end
	self.running.busy = nil

	-- if we opened the adjacent target door, then continue exploring elsewhere
	if self.running.explore == "door" and #self.running.path == self.running.cnt and self.running.cnt == 1 and terrain.door_closed then
		return self:autoExplore()
	end

	-- if we're at the end of the path and we're searching for unseen tiles, then continue with a new path
	local tx, ty = self.running.path[#self.running.path].x, self.running.path[#self.running.path].y
	local obj = game.level.map:getObject(tx, ty, 1)
	if not node then
		if self.running.explore == "unseen" or self.running.explore == "object" and not obj then
			return self:autoExplore()
		else
			--only go to locked vault doors once
			if self.running.explore == "door" then
				local c = toSingle(tx, ty)
				for _, anode in ipairs(listAdjacentNodes(c)) do
					local ax, ay = anode[0], anode[1]
					local aterrain = game.level.map(ax, ay, Map.TERRAIN)
					if aterrain and (aterrain.door_player_check or aterrain.door_player_stop) then
						game.level.map.attrs(ax, ay, "autoexplore_ignore", true)
					end
				end
			end
			self:runStop("at " .. self.running.explore)
			return false
		end
	end

	-- if the next spot in the path is blocked, explore a new path if we are searching for unseen tiles, otherwise stop
	if game.level.map.has_seens(cx, cy) and game.level.map:checkEntity(cx, cy, Map.TERRAIN, "block_move", self, nil, true) then
	-- game.level.map:checkAllEntities(cx, cy, "block_move", self) then
		if terrain.notice then
			if terrain.change_level or terrain.orb_portal or terrain.escort_portal then game.level.map.attrs(cx, cy, "noticed", true) end
			self:runStop("interesting terrain")
			return false
		elseif self.running.explore == "unseen" or self.running.explore == "object" and self.running.cnt ~= #self.running.path then
			return self:autoExplore()
		else
			if self.running.explore == "object" and self.running.cnt == #self.running.path then
				game.level.map.attrs(cx, cy, "obj_seen", true)
				self:runStop("at object (diggable)")
			else
				self:runStop("the path is blocked")
			end
			return false
		end
	end

	-- if we are about to step on a trap, then verify that we actually intend to do so
	local trap = game.level.map(cx, cy, Map.TRAP)
	if trap and trap:knownBy(self) and self.running.cnt ~= 1 then
		return self:autoExplore()
	end

	-- avoid a simple preventable ambush
	checkAmbush(self)

	-- continue current path if we haven't seen the target tile or object yet
	if not game.level.map.has_seens(tx, ty) then return true end
	if obj and not game.level.map.attrs(tx, ty, "obj_seen") then return true end

	-- if we have explored the unseen node or the unseen item is no longer there, then continue auto-exploring somewhere else
	if self.running.explore == "unseen" or self.running.explore == "object" and not obj then
		return self:autoExplore()
	else
	-- otherwise, try to continue running on the current path to reach our target
		return true
	end
end

