--Veins of the Earth
--Zireael 2014
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

module(..., package.seeall, class.inherit(engine.interface.ObjectIdentify))

function _M:init(t)
	if t.identified ~= nil then
		self.identified = t.identified
	else
		self.identified = false
	end

	--Actually initiate pseudo-id
    if t.pseudo_id ~= nil then
        self.pseudo_id = t.pseudo_id
    else
        self.pseudo_id = false
    end
end

--- Defines the default IDed status
function _M:resolveIdentify()
	if not self.unided_name then
		self.unided_name = self.name
	end
end

--- Can this object be identified at all ?
-- Defaults to true, you can overload it
function _M:canIdentify()
	return true
end

--- Is the object identified ?
function _M:isIdentified()
	-- Auto id by type ?
--[[	if game.object_known_types and game.object_known_types[self.type] and game.object_known_types[self.type][self.subtype] and game.object_known_types[self.type][self.subtype][self.name] then
		self.identified = game.object_known_types[self.type][self.subtype][self.name]
	end]]

	if self.auto_id then
		self.identified = self.auto_id
	end

	return self.identified
end

--- Get the unided name
function _M:getUnidentifiedName()
	return self.unided_name
end