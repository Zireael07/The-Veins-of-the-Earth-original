-- $Id: T2DungeonLevel.lua 1662 2015-10-04 19:35:21Z dsb $
-- ToME - Tales of Middle-Earth
-- Copyright (C) 2012 Scott Bigham
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
-- Scott Bigham "Zizzo"
-- dsb-tome@killerbbunnies.org

require 'engine.class'
local Map = require 'engine.Map'
local T2LevelGenerator = require 'mod.class.generator.map.T2LevelGenerator';

module(..., package.seeall, class.inherit(T2LevelGenerator))

-- We'll back this out once we're sure this is working...
local debug_tunnels = true

-- We set up rooms in 11x11 blocks.
_M.block_h = 11
_M.block_w = 11

-- Supported room types.  Listed with their corresponding 'typ' parameter
-- to room_build() in src/generate.c.
_M.room_types = {
  'basic',	-- 1
  'circular',	-- 9
}
-- These will get populated by the various room loaders.
_M.room_mindep = {}
_M.room_crowded = {}

function _M:init(zone, map, level, data)
  T2LevelGenerator.init(self, zone, map, level, data)

  -- Load room generators for known room types
  local tmp = {}
  for _, rtyp in ipairs(_M.room_types) do
    local f, err = loadfile('/data/rooms/t2/'..rtyp..'.lua')
    if not f then
      error('Failed to load room type '..rtyp..':  '..(err or 'unknown error'))
    else
      setfenv(f, setmetatable({
	Map = require('engine.Map'),
	T2DungeonLevel = require('mod.class.generator.map.T2DungeonLevel'),
      }, { __index=_G }))
      local ret, err = f()
      if not ret then
	error('Failed to load room type '..rtyp..':  '..(err or 'unknown error'))
      else
	tmp[rtyp] = ret
      end
    end
  end

  for rtyp, f in pairs(tmp) do _M.room_types[rtyp] = f end
end

-- Roughly mimics level_generate_dungeon() in src/generate.c
function _M:layoutMap(lev, old_lev)
  self.cur_lev = lev
  self.rooms = {}
  self.doors = {}
  self.has_crowded_room = false
  self.avoid = {}
  local cavern = false

  -- TODO dungeon town level (cf. src/generate.c line 6768)

  -- TODO cavern (cf. src/generate.c line 6792)
  --[[
  -- Cavern in the middle of the level.
  if self.data.flags.CAVERN and rng.range(1, math.floor(lev/2)) > 30 then
    cavern = true
    if game.player and game.player:has('PRECOGNITION') then
      game.log('[precognition] Cavern on level')
    end
    self:build_cavern()
  end
  ]]

  -- TODO destroyed level (except for quest levels and small levels)
  --      (cf. src/generate.c line 6806)

  self.room_grid = {
    w = math.floor(self.map.w / _M.block_w),
    h = math.floor(self.map.h / _M.block_h)
  }
  for y = 0, self.room_grid.h - 1 do self.room_grid[y] = {} end

  -- Equivalent of hook HOOK_BUILD_ROOM1, used by princess quests and
  -- Thrain in Dol Guldur (cf. src/generate.c line 6855).
  local hook = {
    'MapGenerator:T2DungeonLevel:firstRoom',
    gen = self,
    gy = rng.range(0, self.room_grid.h - 1),
    gx = rng.range(0, self.room_grid.w - 1),
    lev = lev,
    old_lev = old_lev,
    spots = self.spots,
    done = false,
    no_down = false
  }
  self:triggerHook(hook)
  if hook.no_down then self.data.no_down_stairs = true end

  for _ = 1, util.getval(self.data.nb_rooms or 50) - (hook.done and 1 or 0) do
    local gy = rng.range(0, self.room_grid.h - 1)
    local gx = rng.range(0, self.room_grid.w - 1)
    -- Arrange x%3==1 if align_rooms is set.
--    if config.settings.tome2.align_rooms then gx = gx + 1 - (gx % 3) end

    -- TODO rearrange the following to mimic the use of 'continue' in the C code
    -- TODO destroyed rooms (cf. src/generate.c line 6875)
    -- TODO vaults and other fancy rooms (except on town levels)
    --      (cf. src/generate.c line 6903)
    if self.data.flags.CAVE then
      -- TODO (cf. src/generate.c line 6980)
    elseif self.data.flags.CIRCULAR_ROOMS then
      self:createRoom('circular', gx, gy)
    else
      self:createRoom('basic', gx, gy)
    end
  end

  -- Force at least one room.
  while #self.rooms == 0 do self:createRoom('basic', 0, 0) end

  -- Connect rooms.
  table.shuffle(self.rooms)
  for i = 1, #self.rooms do
    local prev = i == 1 and #self.rooms or i - 1
    self:connectRooms(prev, i)
  end

  -- Place doors in intersection spaces we found while tunneling.
  if not self.data.flags.NO_DOORS then
    for _, d in ipairs(self.doors) do
      self:try_doors(d.x, d.y)
    end
  end

  -- TODO magma streamers, quartz streamers, sand streamers
  --      (cf. src/generate.c line 7050)
  -- TODO water and lava rivers (cf. src/generate.c line 7084)
  -- TODO tree/water/lava streamers (cf. src/generate.c line 7128)

  -- Don't need these anymore.
  self.avoid = nil
  self.room_grid = nil
--  self.rooms = nil
  self.doors = nil

  self:set_level_boundaries(false)

  -- TODO get player starting position (cf. src/generate.c line 7232)
  -- (maybe not; this may get handled by stair placement in parent generate())
end

-- Roughly mimics room_alloc() in src/generate.c
-- width and height are in map coordinates; gx and gy are in room_grid
-- coordinates.
-- Returns the center of the allocated room in map coordinates.
function _M:roomAlloc(width, height, crowded, gx, gy)
  local gw = math.floor((width - 1)/_M.block_w) + 1
  local gh = math.floor((height - 1)/_M.block_h) + 1
  if gw > self.room_grid.w or gh > self.room_grid.h then return false end

  -- Shift the room left and up if it's off-map.
  gx = math.min(gx, self.room_grid.w - gw)
  gy = math.min(gy, self.room_grid.h - gh)

  -- Check that the space is empty
  for ggy = gy, gy + gh - 1 do
    for ggx = gx, gx + gw - 1 do
      if self.room_grid[ggy][ggx] then return false end
    end
  end

  local ctr = {
    x = gx*_M.block_w + math.floor(gw*_M.block_w/2),
    y = gy*_M.block_h + math.floor(gh*_M.block_h/2),
  }
  self.rooms[#self.rooms+1] = {
    w = width, h = height, cx = ctr.x, cy = ctr.y
  }

  -- Reserve the space
  for ggy = gy, gy + gh - 1 do
    for ggx = gx, gx + gw - 1 do
      self.room_grid[ggy][ggx] = true
    end
  end
  self.has_crowded_room = crowded or self.has_crowded_room

  -- TODO check room boundary to see if room will cut off cavern
  -- cf. src/generate.c, room_alloc(), line 2033

  return ctr
end

-- Roughly mimics room_build() in src/generate.c
function _M:createRoom(rtyp, gx, gy)
  -- Check min depth for room.
  if self.cur_lev < (_M.room_mindep[rtyp] or 0) and not self.data.flags.IRONMAN_ROOMS then
    return false
  end

  -- Don't create a 'crowded' room if we've already got one on the level.
  if self.has_crowded_room and _M.room_crowded[rtyp] then return false end

  if not _M.room_types[rtyp] then return false end
  _M.room_types[rtyp](self, gx, gy)
  return true
end

-- Roughly mimics correct_dir() in src/generate.c
local function tunnel_dir(x1, y1, x2, y2)
  local dx = x1 == x2 and 0 or x1 < x2 and 1 or -1
  local dy = y1 == y2 and 0 or y1 < y2 and 1 or -1
  if dx ~= 0 and dy ~= 0 then
    -- If diagonal, choose between vertical or horizontal randomly.
    if rng.chance(2) then dx = 0 else dy = 0 end
  end
  return dx, dy
end

-- Roughly mimics rand_dir() in src/generate.c
local function rand_hv_dir()
  local dx, dy = 0, rng.chance(2) and 1 or -1
  if rng.chance(2) then dx, dy = dy, dx end
  return dx, dy
end

-- Roughly mimics build_tunnel() in src/generate.c
function _M:connectRooms(room1, room2)
  local x1, y1 = self.rooms[room1].cx, self.rooms[room1].cy
  local x2, y2 = self.rooms[room2].cx, self.rooms[room2].cy
  local xs, ys = x1, y1
  local tunnels, walls = {}, {}
  local max_loop = 0

  local dx, dy = tunnel_dir(x1, y1, x2, y2)
  local tx, ty
  local no_door = false

  if debug_tunnels then print(('[MAPGEN] starting tunnel %d,%d -> %d,%d, dir %d,%d'):format(x1, y1, x2, y2, dx, dy)) end
  while x1 ~= x2 or y1 ~= y2 do
    if max_loop > 2000 then
      if debug_tunnels then print('[MAPGEN] tunnel loop aborted at 2000 iters') end
      break
    end
    max_loop = max_loop + 1

    -- Chance of tunnel turning
    if rng.percent(30) then
      dx, dy = tunnel_dir(x1, y1, x2, y2)
      if debug_tunnels then print(('[MAPGEN]   turning to dir %d,%d at %d,%d'):format(dx, dy, x1, y1)) end
      if rng.percent(10) then
	-- Or maybe completely random.
	dx, dy = rand_hv_dir()
	if debug_tunnels then print(('[MAPGEN]     turning again to dir %d,%d'):format(dx, dy)) end
      end
    end

    tx, ty = x1+dx, y1+dy
    while not self:in_bounds(tx, ty) do
      -- Don't wander off the edge...
      dx, dy = tunnel_dir(x1, y1, x2, y2)
      if debug_tunnels then print(('[MAPGEN]     %d,%d is off map; changing direction to %d,%d'):format(tx, ty, dx, dy)) end
      if rng.percent(10) then
	-- Or maybe completely random.
	dx, dy = rand_hv_dir()
	if debug_tunnels then print(('[MAPGEN]       turning again to dir %d,%d'):format(dx, dy, x1, y1)) end
      end
      tx, ty = x1+dx, y1+dy
    end

    local g = self.map(tx, ty, Map.TERRAIN)
    local skip = g.define_as == 'PERMA_WALL' or		-- Dungeon edge
		 self.map.attrs(tx, ty, 'vault_outer') or	-- Vault wall
		 self.avoid[tx + ty*self.map.w]		-- Marked to avoid
							-- (see below)
    if not skip then
      if self:is_room_wall(tx, ty) then
	-- Hit a room wall.
	local nx, ny = tx+dx, ty+dy
	local gn = self.map(nx, ny, Map.TERRAIN)
	skip = gn.define_as == 'PERMA_WALL' or
	       self.map.attrs(nx, ny, 'vault_outer') or
	       self:is_room_wall(nx, ny) or
	       self.avoid[nx + ny*self.map.w]
	if not skip then
	  -- Good location; save it, and mark adjacent walls to avoid.
	  if debug_tunnels then print(('[MAPGEN]   tunneling through room wall %d,%d -> %d,%d'):format(x1, y1, tx, ty)) end
	  x1, y1 = tx, ty
	  walls[#walls+1] = { x=tx, y=ty }
	  for ax = tx-1, tx+1 do
	    for ay = ty-1, ty+1 do
	      if self:is_room_wall(ax, ay) then
		if debug_tunnels then print(('[MAPGEN]     marking room wall %d,%d to avoid'):format(ax, ay)) end
		self.avoid[ax + ay*self.map.w] = true
	      end
	    end
	  end
	else
	  if debug_tunnels then
	    local reason =
	      (gn.define_as == 'PERMA_WALL' and 'perma-wall') or
	      (self.map.attrs(nx, ny, 'vault_outer') and 'vault wall') or
	      (self:is_room_wall(nx, ny) and 'room wall') or
	      (self.avoid[tx + ty*self.map.w] and 'marked to avoid') or '???'
	    print(('[MAPGEN]   skipping bad room wall (%s) at %d,%d'):format(reason, tx, ty))
	  end
	end
      elseif self.map.attrs(tx, ty, 'room') then
	-- In a room; pass through quickly
	if debug_tunnels then print(('[MAPGEN]   advancing through room interior %d,%d -> %d,%d'):format(x1, y1, tx, ty)) end
	x1, y1 = tx, ty
      elseif self.is_fill[g.define_as] then
	-- Fill wall; tunnel through it
	if debug_tunnels then print(('[MAPGEN]   tunneling through fill wall %d,%d -> %d,%d'):format(x1, y1, tx, ty)) end
	x1, y1 = tx, ty
	tunnels[#tunnels+1] = { x=tx, y=ty }
	-- Allow door in next grid
	no_door = false
      else
	-- Corridor intersection or overlap
	if debug_tunnels then print(('[MAPGEN]   intersecting corridor %d,%d -> %d,%d'):format(x1, y1, tx, ty)) end
	x1, y1 = tx, ty
	-- Remember that a door is allowed here, and forbid a door in the
	-- next grid.
	if not no_door then
	  self.doors[#self.doors+1] = { x=tx, y=ty }
	  no_door = true
	end

	-- Hack:  Allow pre-emptive tunnel termination if it's gone far
	-- enough.
	if rng.range(0, 99) >= 15 then
	  local dxs = x1 < xs and xs - x1 or x1 - xs
	  local dys = y1 < ys and ys - y1 or y1 - ys
	  if dxs > 10 or dys > 10 then
	    if debug_tunnels then print(('[MAPGEN]   early corridor termination at %d,%d'):format(x1, y1)) end
	    break
	  end
	end
      end
    else
      if debug_tunnels then
	local reason =
	  (g.define_as == 'PERMA_WALL' and 'perma-wall') or
	  (self.map.attrs(tx, ty, 'vault_outer') and 'vault wall') or
	  (self.avoid[tx + ty*self.map.w] and 'grid marked to avoid') or
	  'mysterious bad grid'
	print(('[MAPGEN]   skipping %s at %d,%d'):format(reason, tx, ty))
      end
    end
  end
  if debug_tunnels and x1 == x2 and y1 == y2 then print(('[MAPGEN] finished tunnel at %d,%d'):format(x2, y2)) end

  -- Actually make the tunnel.
  self:dumpMap(('tunnel %d,%d -> %d,%d'):format(xs, ys, x2, y2), {
    ['*'] = tunnels,
    ['X'] = { { x=xs, y=ys } },
    ['Y'] = { { x=x2, y=y2 } },
  })
  for _, t in ipairs(tunnels) do
    -- TODO Allow placing water here, if 'water' parameter is provided
    --      (cf. src.generate.c line 6375)
    self.map(t.x, t.y, Map.TERRAIN, self:resolve('floor'))
  end

  -- Punch through the room walls, possibly placing doors.
  self:dumpMap('doors for preceding tunnel', { ['@'] = walls })
  for _, w in ipairs(walls) do
    if not self.data.flags.NO_DOORS and rng.percent(90) then
      self:place_random_door(w.x, w.y)
    else
      self.map(w.x, w.y, Map.TERRAIN, self:resolve('floor'))
    end
  end
end

function _M:is_room_wall(x, y)
  local g = self.map(x, y, Map.TERRAIN)
  return g.define_as == self.data.outer_wall and self.map.attrs(x, y, 'room')
end

-- Roughly mimics place_random_door() in src/generate.c
function _M:place_random_door(x, y)
  local tmp = rng.range(1, 1000)
  if tmp <= 300 then		-- 30% chance open door
    self.map(x, y, Map.TERRAIN, self:resolve('OPEN_DOOR', nil, true))
  elseif tmp <= 400 then	-- 10% chance broken door
    self.map(x, y, Map.TERRAIN, self:resolve('BROKEN_DOOR', nil, true))
  elseif tmp <= 600 then	-- 20% chance secret door
    self:place_secret_door(x, y)
  elseif tmp <= 900 then	-- 30% chance closed door
    self.map(x, y, Map.TERRAIN, self:resolve('DOOR', nil, true))
  elseif tmp <= 999 then	-- 9.9% chance locked door
    local f = ('LOCKED_DOOR_POWER_%d'):format(rng.range(1, 7))
    self.map(x, y, Map.TERRAIN, self:resolve(f, nil, true))
  else				-- 0.1% chance jammed door
    local f = ('JAMMED_DOOR_POWER_%d'):format(rng.range(0, 7))
    self.map(x, y, Map.TERRAIN, self:resolve(f, nil, true))
  end
end

-- Roughly mimics place_secret_door() in src/generate.c
function _M:place_secret_door(x, y)
  -- TODO Don't know how to do this yet; it uses T2's 'mimic' field on grid
  -- features, which T4 doesn't appear to reproduce.  For now, just put a
  -- closed door here.
  self.map(x, y, Map.TERRAIN, self:resolve('DOOR', nil, true))
end

-- Roughly mimics try_doors() in src/generate.c
function _M:try_doors(x, y)
  if self.data.flags.NO_DOORS then return end

  -- Find all the cardinally adjacent spots where we can place doors.
  local dd = {}
  for _, cc in ipairs(self.cc) do
    if self:in_bounds(x+cc.x, y+cc.y) and
       not self.map:checkEntity(x+cc.x, y+cc.y, Map.TERRAIN, 'wall') and
       not self.map.attrs(x+cc.x, y+cc.y, 'room') and
       self:allow_door(x+cc.x, y+cc.y)
    then
      dd[#dd+1] = { x=x+cc.x, y=y+cc.y }
    end
  end

  if not rng.chance(4) then	-- 75% chance place doors on all ok spots.
    for _, d in ipairs(dd) do
      if rng.percent(90) then
	self:place_random_door(d.x, d.y)
      end
    end
  else				-- 25% chance something else:
    if #dd == 4 then		--   At a crossroad, place two secret doors
      while #dd > 2 do table.remove(dd, rng.range(1, #dd)) end
    elseif #dd > 1 then		--   At a T-junction or regular spot, place one secret door
      while #dd > 1 do table.remove(dd, rng.range(1, #dd)) end
    end
    for _, d in ipairs(dd) do
      self:place_secret_door(d.x, d.y)
    end
  end
end

-- Roughly mimics possible_doorway() in src/generate.c
function _M:allow_door(x, y)
  if self:adjacent_corridors(x, y) < 2 then return false end
  -- Vertical walls.
  if self.map:checkEntity(x, y-1, Map.TERRAIN, 'wall') and
     self.map:checkEntity(x, y+1, Map.TERRAIN, 'wall')
  then
    return true
  end
  -- Horizontal walls
  if self.map:checkEntity(x-1, y, Map.TERRAIN, 'wall') and
     self.map:checkEntity(x+1, y, Map.TERRAIN, 'wall')
  then
    return true
  end
  -- Nope.
  return false
end

-- Roughly mimics build_cavern() in src/generate.c
function _M:build_cavern()
  local grd, roug, cutoff
  local done, light, room = false, self.cur_lev <= rng.range(1, 25), false
  local x0, y0 = math.floor((self.map.w - 1)/2), math.floor((self.map.h - 1)/2)
  local xsize, ysize = x0*2, y0*2

  while not done do
    -- *sigh* Lua doesn't have a << operator.
    grd = 1
    for _ = 1, rng.range(5, 8) do grd = grd * 2 end
    roug = rng.range(1, 8) * rng.range(1, 4)
    cutoff = math.floor(xsize/2)
    local hmap = self.generate_hmap(y0, x0, xsize, ysize, grd, roug, cutoff)
    done = generate_fracave(y0, x0, xsize, ysize, cutoff, light, room)
  end
end
