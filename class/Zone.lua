-- Veins of the Earth
-- Copyright (C) 2013 Zireael
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

require "engine.class"
local Zone = require "engine.Zone"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(Zone))

--- Called when the zone file is loaded
function _M:onLoadZoneFile(basedir)
	-- Load events if they exist
	if fs.exists(basedir.."events.lua") then
		local f = loadfile(basedir.."events.lua")
		setfenv(f, setmetatable({self=self}, {__index=_G}))
		self.events = f()
	end
end