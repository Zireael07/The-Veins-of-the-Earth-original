-- ToME - Tales of Maj'Eyal
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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

-- This file defines the generic matchers and such for 5x5 tiles, but no tiles

base = {w=5, h=5}

is_opening = function(c)
	return (c == '.' or c == "'" or c == '+') and true or false
end

matcher = function(t1, t2)
	local ok = false
	if t1 == '.' or t2 == '.' or t1 == "'" or t2 == "'" then ok = true end

	if t1 == t2 then return true, ok end
	if t1 == '.' and t2 == "'" then return true, ok end
	if t2 == '.' and t1 == "'" then return true, ok end
	return false
end

-- Remove some silly doors
filler = function(c, x, y, room_map, data)
	if c ~= "'" then return c end
	local nb = 0
	if room_map[x-1] and room_map[x-1][y] and (room_map[x-1][y].symbol == '.' or room_map[x-1][y].symbol == '+' or room_map[x-1][y].symbol == "'") then nb = nb + 1 end
	if room_map[x+1] and room_map[x+1][y] and (room_map[x+1][y].symbol == '.' or room_map[x+1][y].symbol == '+' or room_map[x+1][y].symbol == "'") then nb = nb + 1 end
	if room_map[x] and room_map[x][y-1]   and (room_map[x][y-1].symbol == '.' or room_map[x][y-1].symbol == '+' or room_map[x][y-1].symbol == "'") then nb = nb + 1 end
	if room_map[x] and room_map[x][y+1]   and (room_map[x][y+1].symbol == '.' or room_map[x][y+1].symbol == '+' or room_map[x][y+1].symbol == "'") then nb = nb + 1 end

	if nb == 2 and rng.percent(data.door_chance or 25) then return '+'
	elseif nb < 2 then return '#'
	else return '.'
	end
end

tiles = {}
