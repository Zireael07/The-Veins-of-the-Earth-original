-- $Id: basic.lua 483 2013-11-16 05:34:48Z dsb $
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

-- Minimum dungeon depth for this room type.
T2DungeonLevel.room_mindep.basic = 1

-- Roughly mimics build_type1() in src/generate.c, to build a normal
-- rectangular room.
return function(gen, gx, gy)
  local width = rng.range(1, 10) + rng.range(1, 9)
  local height = rng.range(1, 4) + rng.range(1, 3)

  local ctr = gen:roomAlloc(width+2, height+2, false, gx, gy)
  if not ctr then return end

  local y1 = ctr.y - math.floor(height/2)
  local x1 = ctr.x - math.floor(width/2)
  local y2 = y1 + height - 1
  local x2 = x1 + width - 1

  local lit = gen.cur_lev <= rng.range(1, 25)

  -- Floor
  for y = y1, y2 do
    for x = x1, x2 do
      gen.map(x, y, Map.TERRAIN, gen:resolve('floor', nil, false, gen.cur_lev))
      if lit then gen.map.lites(x, y, true) end
      gen.map.attrs(x, y, 'room', true)
    end
  end

  -- Top and bottom walls
  for x = x1 - 1, x2 + 1 do
    gen.map(x, y1 - 1, Map.TERRAIN, gen:resolve('outer_wall', nil, false, gen.cur_lev))
    if lit then gen.map.lites(x, y1 - 1, true) end
    gen.map.attrs(x, y1 - 1, 'room', true)
    gen.map(x, y2 + 1, Map.TERRAIN, gen:resolve('outer_wall', nil, false, gen.cur_lev))
    if lit then gen.map.lites(x, y2 + 1, true) end
    gen.map.attrs(x, y2 + 1, 'room', true)
  end
  -- Left and right walls
  for y = y1 - 1, y2 + 1 do
    gen.map(x1 - 1, y, Map.TERRAIN, gen:resolve('outer_wall', nil, false, gen.cur_lev))
    if lit then gen.map.lites(x1 - 1, y, true) end
    gen.map.attrs(x1 - 1, y, 'room', true)
    gen.map(x2 + 1, y, Map.TERRAIN, gen:resolve('outer_wall', nil, false, gen.cur_lev))
    if lit then gen.map.lites(x2 + 1, y, true) end
    gen.map.attrs(x2 + 1, y, 'room', true)
  end

  -- Assorted occasional frills, if the room is big enough
  if width > 2 and height > 2 then
    if rng.chance(20) then
      -- Room full of pillars
      for y = y1, y2, 2 do
	for x = x1, x2, 2 do
	  gen.map(x, y, Map.TERRAIN, gen:resolve('inner_wall', nil, false, gen.cur_lev))
	end
      end
    elseif rng.chance(50) then
      -- Ragged edges
      for y = y1 + 2, y2 - 2, 2 do
	gen.map(x1, y, Map.TERRAIN, gen:resolve('inner_wall', nil, false, gen.cur_lev))
	gen.map(x2, y, Map.TERRAIN, gen:resolve('inner_wall', nil, false, gen.cur_lev))
      end
      for x = x1 + 2, x2 - 2, 2 do
	gen.map(x, y1, Map.TERRAIN, gen:resolve('inner_wall', nil, false, gen.cur_lev))
	gen.map(x, y2, Map.TERRAIN, gen:resolve('inner_wall', nil, false, gen.cur_lev))
      end
    end
  end
end
