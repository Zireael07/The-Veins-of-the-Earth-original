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

local Object = require "engine.Object"
local DamageType = require "engine.DamageType"

--- Random tunnel dir
local function randDir(sx, sy)
	local dirs = util.primaryDirs() --{4,6,8,2}
	return util.dirToCoord(dirs[rng.range(1, #dirs)], sx, sy)
end

--- Find the direction in which to tunnel
local function tunnelDir(x1, y1, x2, y2)
	local xdir = (x1 == x2) and 0 or ((x1 < x2) and 1 or -1)
	local ydir = (y1 == y2) and 0 or ((y1 < y2) and 1 or -1)
	if xdir ~= 0 and ydir ~= 0 then
		if rng.percent(50) then xdir = 0
		else ydir = 0
		end
	end
	return xdir, ydir
end

local function tunnel(self, x1, y1, x2, y2)
	if not x1 or not x2 or not y1 or not y2 then return end
	if x1 == x2 and y1 == y2 then return end
	-- Disable the many prints of tunnelling
--	local print = function()end

	local xdir, ydir = tunnelDir(x1, y1, x2, y2)
--	print("tunneling from",x1, y1, "to", x2, y2, "initial dir", xdir, ydir)

	local startx, starty = x1, y1

	if rng.percent(30) then
		if rng.percent(10) then xdir, ydir = randDir(x1, x2)
		else xdir, ydir = tunnelDir(x1, y1, x2, y2)
		end
	end

	local nx, ny = x1 + xdir, y1 + ydir
	while true do
		if self.map:isBound(nx, ny) then break end

		if rng.percent(10) then xdir, ydir = randDir()
		else xdir, ydir = tunnelDir(x1, y1, x2, y2)
		end
		nx, ny = x1 + xdir, y1 + ydir
	end
--	print(feat, "try pos", nx, ny, "dir", util.coordToDir(xdir, ydir, nx, ny))

	return nx, ny
end

-- Very special AI for sandworm tunnelers in the sandworm lair
-- Does not care about a target, simple crawl toward a level spot and when there, go for the next
newAI("sandworm_tunneler", function(self)
	-- Get a spot
	if not self.ai_state.spot_x then
		if game.level.default_up and rng.chance(#game.level.spots + 2) then
			-- Go for the stairs
			self.ai_state.spot_x = game.level.default_up.x
			self.ai_state.spot_y = game.level.default_up.y
		elseif game.level.default_down and rng.chance(#game.level.spots + 2) then
			-- Go for the stairs
			self.ai_state.spot_x = game.level.default_down.x
			self.ai_state.spot_y = game.level.default_down.y
		else
			local s = rng.table(game.level.spots)
			self.ai_state.spot_x = s.x
			self.ai_state.spot_y = s.y
		end
	end

	-- Move toward it, digging your way to it
	local lx, ly = tunnel(game.level, self.x, self.y, self.ai_state.spot_x, self.ai_state.spot_y)
	if not lx then
		self.ai_state.spot_x = nil
		self.ai_state.spot_y = nil
		self:useEnergy()
	else
		local feat = game.level.map(lx, ly, engine.Map.TERRAIN)
		if feat:check("block_move") or feat:check("tunneler_dig") then
			self:project({type="hit"}, lx, ly, DamageType.DIG, 1)
		end
		self:move(lx, ly)

		-- if we could not move, find a new spot
		if self.x ~= lx or self.y ~= ly then
			local s = rng.table(game.level.spots)
			self.ai_state.spot_x = s.x
			self.ai_state.spot_y = s.y
		end
	end
end)

-- Very special AI for sandworm tunnelers in the sandworm lair
-- Does not care about a target, simple crawl toward a level spot and when there, go for the next
newAI("sandworm_tunneler_huge", function(self)
	-- Get a spot
	if not self.ai_state.spot_x then
		self.ai_state.next_spot = self.ai_state.next_spot + 1
		local s = game.level.ordered_spots[self.ai_state.next_spot]
		if not s then
			local ls = game.level.ordered_spots[#game.level.ordered_spots]
			if self.x == ls.x and self.y == ls.y then
				game.logSeen(self, "#OLIVE_DRAB#The %s burrows into the ground and disappears.", self.name)
				self:disappear()
				return
			else -- Relentlessly try to get to the end
				self.ai_state.next_spot = #game.level.ordered_spots
				s = ls
			end
		end
		self.ai_state.spot_x = s.x
		self.ai_state.spot_y = s.y
	end

	-- Move toward it, digging your way to it
	local lx, ly = tunnel(game.level, self.x, self.y, self.ai_state.spot_x, self.ai_state.spot_y)
	if not lx then
		self.ai_state.spot_x = nil
		self.ai_state.spot_y = nil
		self:useEnergy()
	else
		local feat = game.level.map(lx, ly, engine.Map.TERRAIN)
		if feat:check("block_move") or feat:check("tunneler_dig") then
			self:project({type="ball", radius=2}, lx, ly, DamageType.DIG, 1)
		end
		self:move(lx, ly)

		-- if we could not move, find a new spot
		if self.x ~= lx or self.y ~= ly then
			self.ai_state.spot_x = nil
			self.ai_state.spot_y = nil
		end
	end
end)
