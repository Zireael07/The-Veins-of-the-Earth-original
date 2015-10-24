-- $Id: circular.lua 469 2013-11-15 04:21:57Z dsb $
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
T2DungeonLevel.room_mindep.circular = 1

-- Roughly mimics build_type9() in src/generate.c, to build a vertical oval
-- room.
return function(gen, gx, gy)
  local rad = rng.range(2, 9)

  local ctr = gen:roomAlloc(rad*2+1, rad*2+1, false, gx, gy)
  if not ctr then return end

  local lit = rng.range(0, gen.cur_lev - 1) <= 5

  local x, y
  for x = ctr.x - rad, ctr.x + rad do
    for y = ctr.y - rad, ctr.y + rad do
      local d = core.fov.distance(ctr.x, ctr.y, x, y, false)
      if d <= rad then
	gen.map(x, y, Map.TERRAIN, gen:resolve((d == rad and 'outer_wall' or 'floor'), nil, false, gen.cur_lev))
	if lit then gen.map.lites(x, y, true) end
	gen.map.attrs(x, y, 'room', true)
      end
    end
  end
end
