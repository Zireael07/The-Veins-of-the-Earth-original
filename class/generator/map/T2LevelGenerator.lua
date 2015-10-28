-- $Id: T2LevelGenerator.lua 1662 2015-10-04 19:35:21Z dsb $
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
require 'engine.Generator'
local Map = require 'engine.Map'

module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level, data)
  engine.Generator.init(self, zone, map, level)
  self.data = data
  self.data.fill_step = self.data.fill_step or 1
  self.grid_list = zone.grid_list
  -- This can be filled by submodules' :layoutMap().
  self.spots = {}

  self.is_floor = {}
  if data.floor.weighted then
    for f, _ in pairs(data.floor.weighted) do self.is_floor[f] = true end
  else
    for _, f in ipairs(data.floor) do self.is_floor[f] = true end
  end

  self.is_fill = {}
  if data.fill.weighted then
    for f, _ in pairs(data.fill.weighted) do self.is_fill[f] = true end
  else
    for _, f in ipairs(data.fill) do self.is_fill[f] = true end
  end

  self.is_stair = {}
  if data.up then self.is_stair[data.up] = true end
  if data.down then self.is_stair[data.down] = true end

  -- Cardinal directions, for easy reference.
  self.cc = { { x=0, y=1 }, { x=0, y=-1 }, { x=1, y=0 }, { x=-1, y=0 } }
end

-- Mimics cave_gen() in src/generate.c
function _M:generate(lev, old_lev)
  -- We accumulate ratings data for the level feeling here.
  self.level.rating = 0

  -- TODO check for double-scale dungeon (cf. src/generate.c line 7616)
  -- TODO dungeon towns (cf. src/generate.c line 7623)

  self:fill_level(false, self.data.fill_step, lev)
  self:set_level_boundaries(false)

  self:layoutMap(lev, old_lev)

  -- Place stairs (cf. src/generate.c line 7671)
  local stair_locs = self:placeStairs()

  -- TODO process hook HOOK_GEN_LEVEL, used by the Merton quest
  --      (cf. src/generate.c line 7706)
  -- TODO check fates (cf. src/generate.c line 7748)
  -- TODO place traps (cf. src/generate.c line 7900)
  --      (I think traps will be covered by the trap generator)
--[[ local k = util.minBound(lev/3, 2, 10)
  self:place_stuff(false, true, rng.range(1, k), 'RUBBLE', true, lev)
  -- TODO place objects on floor (cf. src/generate.c line 7910)
  --      (this will be covered by the object generator, I think)
  -- [final guardian, if any, is placed by actor generator]
  self:place_stuff(true, false, rng.normal(1, 3), 'ALTAR_OF_DARKNESS', true, lev)
  self:place_stuff(true, false, rng.normal(2, 3), 'VOID_JUMPGATE', true, lev)

  -- Slight Hack(TM):  Precompute a list of potions that can appear in
  -- fountains at this depth.
  local adj_lev = self.zone:level_adjust_level(self.level, 'object')
  self.potions = {}
  for _, o in ipairs(self.zone.object_list) do
    if o.type == 'utility' and o.subtype == 'potion' and not o.artifact_info and o.level and o.level <= adj_lev then
      self.potions[#self.potions+1] = o.define_as
    end
  end
  self:place_stuff(true, false, rng.normal(1, 3), 'FOUNTAIN', true, lev)
  self.potions = nil]]

  -- Artifact and artifact guardian (cf. src/generate.c line 7934) should
  -- be placed by object resp. actor generators.

  -- Light empty levels.
  if self.empty_level then
    -- Don't need this anymore.
    self.empty_level = nil
    if not rng.chance(5) or not rng.percent(lev) then
      self.map:liteAll(0, 0, self.map.w, self.map.h)
      self.map:rememberAll(0, 0, self.map.w, self.map.h)
    end
  end

  -- TODO scale up double-scale level (cf. src/generate.c line 8084)

  -- If placeStairs() generated any up_branch or down_branch stairs,
  -- remember their locations as level spots.
  for _, xy in ipairs(stair_locs.up_branch or {}) do
    self.spots[#self.spots+1] = { x=xy.x, y=xy.y, type='branch', subtype='up' }
  end
  for _, xy in ipairs(stair_locs.down_branch or {}) do
    self.spots[#self.spots+1] = { x=xy.x, y=xy.y, type='branch', subtype='down' }
  end

  --Make spots in our rooms (Zireael)
  -- Find out "interesting" spots
  local rooms = self.rooms
  local spots = self.spots
  for i, r in ipairs(rooms) do
      spots[#spots+1] = {x=rooms[i].cx, y=rooms[i].cy, type="room", subtype="room"} --subtype=rooms[i].room.name}
  end

  -- Pick a random up stair and a random down stair for our entry points.
  stair_locs.up = stair_locs.up or {}
  stair_locs.down = stair_locs.down or {}
  local uxy = rng.table(stair_locs.up) or rng.table(stair_locs.down) or {}
  local dxy = rng.table(stair_locs.down) or rng.table(stair_locs.up) or {}
  return uxy.x, uxy.y, dxy.x, dxy.y, self.spots
end

-- Placeholder; implemented in submodules.
function _M:layoutMap(lev, old_lev)
end

-- Mimics in_bounds() macro.
function _M:in_bounds(x, y)
  return x > 0 and y > 0 and x < self.map.w-1 and y < self.map.h-1
end

-- Roughly mimics fill_level() in src/generate.c
-- TODO Add explanatory comments therefrom
function _M:fill_level(use_floor, step, lev)
  local grids = use_floor and self.data.floor or self.data.fill
  if self.map.w < 16 or self.map.h < 16 then step = math.min(step, 4) end

  local x, y
  if step == 0 then
    local grid = type(grids) == 'table' and grids[1] or grids
    for x = 0, self.map.w - 1 do
      for y = 0, self.map.h - 1 do
	self.map(x, y, Map.TERRAIN, self:resolve(grid, nil, true))
      end
    end
  else
    for y = 0, self.map.h - 1, step do
      for x = 0, self.map.w - 1, step do
	self.map(x, y, Map.TERRAIN, self:resolve(grids, nil, true, lev))
      end
    end
    step = math.floor(step/2)
    while step > 0 do
      local y_even = false
      local y_w = math.floor((self.map.h - 1)/(step*2))*step*2;
      local x_w = math.floor((self.map.w - 1)/(step*2))*step*2;
      for y = 0, self.map.h - 1, step do
	y_even = not y_even
	local x_even = false
	for x = 0, self.map.w - 1, step do
	  x_even = not x_even
	  if not y_even or not x_even then
	    local y_s = y_even and y or rng.chance(2) and y + step or y - step
	    local x_s = x_even and x or rng.chance(2) and x + step or x - step
	    y_s = y_s >= self.map.h and 0 or y_s < 0 and y_w or y_s
	    x_s = x_s >= self.map.w and 0 or x_s < 0 and x_w or x_s
	    local grid = self.map(x_s, y_s, Map.TERRAIN).define_as
	    self.map(x, y, Map.TERRAIN, self:resolve(grid, nil, true))
	  end
	end
      end
      step = math.floor(step/2)
    end
  end
end

-- Set perma walls around the level boundaries.
-- Roughly mimics set_bounders() in src/generate.c
-- TODO Make these mimic outer wall feature (or floor fill on flat levels)
function _M:set_level_boundaries(use_floor)
  for x = 0, self.map.w - 1 do
    self.map(x, 0, Map.TERRAIN, self:resolve('PERMA_WALL', nil, true, lev))
    self.map(x, self.map.h - 1, Map.TERRAIN, self:resolve('PERMA_WALL', nil, true, lev))
  end
  for y = 0, self.map.h - 1 do
    self.map(0, y, Map.TERRAIN, self:resolve('PERMA_WALL', nil, true, lev))
    self.map(self.map.w - 1, y, Map.TERRAIN, self:resolve('PERMA_WALL', nil, true, lev))
  end
end

-- Roughly mimics the stair-generation portion of cave_gen()
-- (cf. src/generate.c, lines 7671-7704)
function _M:placeStairs()
  local locs = {}

  -- Place stairs for in-dungeon branches, if any.
  if self.data.down_branch then
    self:place_stairs('down_branch', 5, 3, locs)
  end
  if self.data.up_branch then
    self:place_stairs('up_branch', rng.range(1, 2), locs)
  end

  if not self.data.no_down_stairs and (self.cur_lev < self.zone.max_level or (self.cur_lev == self.zone.max_level and self.data.flags.FORCE_DOWN)) then
    -- Down stairs
    self:place_stairs('down', rng.range(3, 4), 3, locs)
    -- TODO place down shafts
  end
  -- Clean this up behind ourself.
  self.data.no_down_stairs = nil
  if self.cur_lev > 1 or (self.cur_lev == 1 and not self.data.flags.NO_UP) then
    -- Up stairs
    self:place_stairs('up', rng.range(1, 2), 3, locs)
    -- TODO place up shafts
  end

  return locs
end

-- Roughly mimics alloc_stairs() in src/generate.c
function _M:place_stairs(feat, n_stairs, wall, locs)
  -- Unlike alloc_stairs(), we assume that our caller has already checked
  -- whether we're allowed to place the requested stair feature.
  local i, cnt = 0, 0
  -- XXX I haven't been able to decipher what this loop condition means in
  -- the original code...
  while i < n_stairs or (cnt < 1 and n_stairs > 1) do
    i = i + 1
    for j = 1, 5000 do
      local x, y
      if self.data.flags.FLAT then
	x, y = self:place_new_way()
      else
	x = rng.range(0, self.map.w - 1)
	y = rng.range(0, self.map.h - 1)
	if not self.map:checkEntity(x, y, Map.TERRAIN, 'naked_bold') or self:adjacent_walls(x, y) < wall then
	  x, y = nil, nil
	end
      end
      if x and y then
	self.map(x, y, Map.TERRAIN, self:resolve(feat))
	print(('[STAIRS] placed %s @%d,%d'):format(self.map(x, y, Map.TERRAIN).name, x, y))
	cnt = cnt + 1
	locs[feat] = locs[feat] or {}
	local ll = locs[feat]
	ll[#ll+1] = { x=x, y=y }
	break;
      end
    end
    -- Require fewer walls
    if wall > 0 then wall = wall - 1 end
  end
end

-- Rougly mimics next_to_walls() in src/generate.c
function _M:adjacent_walls(x, y)
  local n = 0
  for _, cc in ipairs(self.cc) do
    if self.map:checkEntity(x+cc.x, y+cc.y, Map.TERRAIN, 'wall') then n=n+1 end
  end
  return n
end

-- Rougly mimics next_to_corr() in src/generate.c
function _M:adjacent_corridors(x, y)
  local n = 0
  for _, cc in ipairs(self.cc) do
    local g = self.map(x+cc.x, y+cc.y, Map.TERRAIN)
    if not self.map:checkEntity(x+cc.x, y+cc.y, Map.TERRAIN, 'wall') --g:floor_bold(x+cc.x, y+cc.y)
    and not self.is_floor[g.define_as] and not self.map.attrs(x+cc.x, y+cc.y, 'room') then
      n = n + 1
    end
  end
  return n
end

-- Rougly mimics place_new_way() in src/generate.c
function _M:place_new_way()
  local way, ok, xret, yret

  -- Keep trying until we find something.
  while true do
    local x, y, dx, dy, dxs1, dxs2, dys1, dys2
    way = {}
    ok = false

    -- Choose left/right or top/bottom edge, weighted by level width/height
    if rng.range(1, self.map.w + self.map.h) <= self.map.h then
      -- Left/right
      y = rng.range(1, self.map.h - 2)
      x = 1 + rng.range(0, 1)*(self.map.w - 3)
      dx, dy = (x == 1 and 1 or -1), 0
      dxs1, dxs2, dys1, dys2 = 0, 0, -1, 1
    else
      -- Top/bottom
      x = rng.range(1, self.map.w - 2)
      y = 1 + rng.range(0, 1)*(self.map.h - 3)
      dx, dy = 0, (y == 1 and 1 or -1)
      dxs1, dxs2, dys1, dys2 = -1, 1, 0, 0
    end
    xret, yret = x, y

    local g = self.map(x, y, Map.TERRAIN)
    local gn = self.map(x+dx, y+dy, Map.TERRAIN)
    local skip = self.map.attrs(x, y, 'icky') or	-- Vault
		 (g.permanent and g.floor) or		-- Permanent (?)
		 (self.map.attrs('room') and
		  g.define_as == self.data.outer_wall)	-- Room wall
    if not skip then
      local g1 = self.map(x+dxs1, y+dys1, Map.TERRAIN)
      local g2 = self.map(x+dxs2, y+dys2, Map.TERRAIN)
      -- Skip if next to a stair.
      skip = self.is_stair[g1.define_as] or self.is_stair[g2.define_as] or
	     self.is_stair[gn.define_as]
    end
    if not skip then
      -- We're good; start tunneling.
      while self:in_bounds(x, y) do
	ok = self:is_safe_floor(x+dx, y+dy) or
	     self:is_safe_floor(x+dxs1, y+dys1) or
	     self:is_safe_floor(x+dxs2, y+dys2)
	-- If we've connected, we're done.
	if ok then break end

	-- Avoid opening vaults
	if self.map.attrs(x+dx, y+dy, 'vault_outer') then
	  ok = true
	  break
	end

	-- Paranoia:  avoid outer dungeon border
	if gn.define_as == 'PERMA_WALL' then break end

	if self.map.attrs(x+dx, y+dy, 'room') then
	  -- Hit a room
	  -- Hack:  if we hit a room corner, hook around it.
	  local rn1 = self.map.attrs(x+dx+dxs1, y+dy+dys1, 'room')
	  local rn2 = self.map.attrs(x+dx+dxs2, y+dy+dys2, 'room')
	  if rn1 and not rn2 then
	    way[#way+1] = { x=x+dxs1, y=y+dys1 }
	    way[#way+1] = { x=x+dx+dxs1, y=y+dy+dys1 }
	  elseif rn2 and not rn1 then
	    way[#way+1] = { x=x+dxs2, y=y+dys2 }
	    way[#way+1] = { x=x+dx+dxs2, y=y+dy+dys2 }
	  else
	    way[#way+1] = { x=x+dx, y=y+dy }
	  end
	  -- We're done
	  ok = true
	  break
	end

	-- Add this grid to the path and advance.
	way[#way+1] = { x=x+dx, y=y+dy }
	x, y = x+dx, y+dy
      end
    end

    -- If we've connected, we can stop trying.
    if ok then break end
  end

  -- And place the actual path.
  self:dumpMap(('stair path from %d,%d'):format(xret, yret), { ['*'] = way })
  for _, w in ipairs(way) do
    self.map(w.x, w.y, Map.TERRAIN, self:resolve('floor'))
  end
  return xret, yret
end

-- Roughly mimics is_safe_floor() in src/generate.c
function _M:is_safe_floor(x, y)
  local g = self.map(x, y, Map.TERRAIN)
  return self.is_floor[g.define_as]
end

--[[function _M:place_stuff(only_room, only_corr, num, feat, force, lev)
  for _ = 1, num do
    for _ = 1, 5000 do
      local x, y = rng.range(0, self.map.w - 1), rng.range(0, self.map.h - 1)
      local floor = self.map:checkEntity(x, y, Map.TERRAIN, 'naked_bold')
      local room = self.map.attrs(x, y, 'room')
      if floor and ((room and not only_coor) or (not room and not only_room)) then
	if feat == 'RUBBLE' then
	  self.map(x, y, Map.TERRAIN, self:resolve(feat, nil, force, lev))
	elseif feat == 'FOUNTAIN' then
	  if rng.percent(30) then
	    self.map(x, y, Map.TERRAIN, self:resolve('EMPTY_FOUNTAIN', nil, force, lev))
	  else
	    self.map(x, y, Map.TERRAIN, self:resolve(feat, nil, force, lev))
	    self.map.attrs(x, y, 'potion_type', rng.table(self.potions))
	    self.map.attrs(x, y, 'potion_num', rng.dice(3, 4))
	  end
	elseif feat == 'VOID_JUMPGATE' then
	  while true do
	    local gx, gy = rng.range(0, self.map.w - 1), rng.range(0, self.map.h - 1)
	    if self.map:checkEntity(gx, gy, Map.TERRAIN, 'naked_bold') then
	      self.map(x, y, Map.TERRAIN, self:resolve(feat, nil, force, lev))
	      self.map(gx, gy, Map.TERRAIN, self:resolve(feat, nil, force, lev))
	      self.map.attrs(x, y, 'pair_gate', { x=gx, y=gy })
	      self.map.attrs(gx, gy, 'pair_gate', { x=x, y=y })
	      break
	    end
	  end
	elseif feat == 'ALTAR_OF_DARKNESS' and rng.percent(10) then
	  self.map(x, y, Map.TERRAIN, self:resolve(feat, nil, force, lev))
	end
	break
      end
    end
  end
end]]

function _M:resolve(c, list, force, lev)
  local res = force and c or self.data[c]
  if type(res) == 'table' and type(res.weighted) == 'table' then
    -- Roughly mimics init_feat_info() in src/generate.c
    if not res.wgt_cache or (lev and res.wgt_cache.level ~= lev) then
      -- Precompute a simple-lookup table from the provided weights to
      -- speed things up.
      res.wgt_cache = { level=lev }
      local n = 0
      for grid, wgt in pairs(res.weighted) do
	local w = wgt
	if type(w) == 'table' then
	  w = w[1] + math.floor((w[2] - w[1]) * lev/self.zone.max_level)
	end
	for i = n+1, n+w do res.wgt_cache[i] = grid end
	n = n + w
      end
    end
    -- The parent method covers randomly selecting an entity type from a
    -- table with uniform distribution, so we can just pass it our pre-
    -- computed cache.
    return engine.Generator.resolve(self, res.wgt_cache, list, true)
  else
    return engine.Generator.resolve(self, c, list, force)
  end
end

function _M:dumpMap(note, annotations)
  if note then print(note..':') end
  local ra = {}
  for sym, xys in pairs(annotations or {}) do
    for _, xy in ipairs(xys) do
      local key = xy.x..','..xy.y
      ra[key] = ra[key] and '?' or sym
    end
  end

  for y = 0, self.map.h - 1 do
    local row = ''
    for x = 0, self.map.w - 1 do
      local g = self.map(x, y, Map.TERRAIN)
      row = row .. (ra[x..','..y] or (g and g.display) or ' ')
    end
    print(row)
  end
end

-- Roughly mimics store_height() in src/generate.c
local function store_height(hmap, x, y, x0, y0, val, xhsize, yhsize, cutoff)
  local xx, yy = x + x0 - xhsize, y + y0 - yhsize
  -- Only write to "blank" grids
  if hmap[yy] ~= nil and hmap[yy][xx] ~= nil then return end
  -- Fill in as needed.
  hmap[yy] = hmap[yy] or {}
  -- At the boundary, make sure val > cutoff, so walls are not as square.
  if x == 0 or y == 0 or x == xhsize*2 or y == xhsize*2 then
    val = math.max(val, cutoff + 1)
  end
  hmap[yy][xx] = val
end

-- Roughly mimics generate_hmap() in src/generate.c
function _M.generate_hmap(y0, x0, xsize, ysize, grd, roug, cutoff)
  xsize = util.bound(xsize, 4, 254)
  ysize = util.bound(ysize, 4, 254)
  local xhsize, yhsize = math.floor(xsize/2), math.floor(ysize/2)
  -- Make sure both of these are even.
  xsize, ysize = xhsize*2, yhsize*2

  -- The original code uses fixed-point arithmetic by multiplying
  -- everything by 256; this is roughly 256*sqrt(2).
  local diagsize = 362
  local maxsize = math.max(xsize, ysize)

  local hmap = {}
  -- Set corner values in case grd > size.
  store_height(0, 0, x0, y0, maxsize, xhsize, yhsize, cutoff)
  store_height(0, ysize, x0, y0, maxsize, xhsize, yhsize, cutoff)
  store_height(xsize, 0, x0, y0, maxsize, xhsize, yhsize, cutoff)
  store_height(xsize, ysize, x0, y0, maxsize, xhsize, yhsize, cutoff)
  -- Set middle grid to open.
  store_height(xhsize, yhsize, x0, y0, 0, xhsize, yhsize, cutoff)

  local xstep, ystep = xsize*256, ysize*256
  local xhstep, yhstep = xsize*256, ysize*256
  local xxsize, yysize = xsize*256, ysize*256

  while xstep >= 512 or ystep >= 512 do
    -- Halve step sizes.
    xstep, ystep = xhstep, yhstep
    xhstep, yhstep = math.floor(xhstep/2), math.floor(yhstep/2)
    local big_xhstep = xhstep >= (grd+1)*256

    -- Middle top to bottom
    for x = xhstep, xxsize - xhstep, xstep do
      local x_ = math.floor(x/256)
      local xl = math.floor((x-xhstep)/256) + x0 - xhsize
      local xr = math.floor((x+xhstep)/256) + x0 - xhsize
      for y = 0, yysize, ystep do
	local y_ = math.floor(y/256)
	local yy = y_ + y0 - yhsize
	if big_xhstep then
	  store_height(x_, y_, x0, y0, rng.range(1, maxsize), xhsize, yhsize, cutoff)
	else
	  local val = math.floor((hmap[yy][xl]+hmap[yy][xr])/2)
	  val = val + math.floor((rng.range(1, math.floor(xstep/256)) - math.floor(xhstep/256)) * roug/16)
	  store_height(x_, y_, x0, y0, val, xhsize, yhsize, cutoff)
	end
      end
    end

    -- Middle left to right
    for y = yhstep, yysize - yhstep, ystep do
      local y_ = math.floor(y/256)
      local yu = math.floor((y-yhstep)/256) + y0 - yhsize
      local yd = math.floor((y+yhstep)/256) + y0 - yhsize
      for x = 0, xxsize, xstep do
	local x_ = math.floor(x/256)
	if big_xhstep then
	  store_height(x_, y_, x0, y0, rng.range(1, maxsize), xhsize, yhsize, cutoff)
	else
	  local val = math.floor((hmap[yu][xx]+hmap[yd][xx])/2)
	  val = val + math.floor((rng.range(1, math.floor(ystep/256)) - math.floor(yhstep/256)) * roug/16)
	  store_height(x_, y_, x0, y0, val, xhsize, yhsize, cutoff)
	end
      end
    end

    -- Center
    for x = xhstep, xxsize - xhstep, xstep do
      local x_ = math.floor(x/256)
      local xl = math.floor((x-xhstep)/256) + x0 - xhsize
      local xr = math.floor((x+xhstep)/256) + x0 - xhsize
      for y = yhstep, yysize - yhstep, ystep do
	local y_ = math.floor(y/256)
	local yu = math.floor((y-yhstep)/256) + y0 - yhsize
	local yd = math.floor((y+yhstep)/256) + y0 - yhsize
	if big_xhstep then
	  store_height(x_, y_, x0, y0, rng.range(1, maxsize), xhsize, yhsize, cutoff)
	else
	  local val = math.floor((hmap[yu][xl] + hmap[yd][xl] + hmap[yu][xr] + hmap[yd][xr])/4)
	  -- Average over all four corners, and scale by diagsize to reduce
	  -- the effect of the square grid on the shape of the fractal.
	  val = val + (rng.range(1, math.floor(xstep/256)) - math.floor(xhstep/256)) * math.floor(math.floor(diagsize/16)/256) * roug
	  store_height(x_, y_, x0, y0, val, xhsize, yhsize, cutoff)
	end
      end
    end
  end
end
