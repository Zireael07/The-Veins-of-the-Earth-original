-- Underdark
-- Zireael
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

local Entity = require "engine.Entity"

-- Taken from ToME data/talents.lua
local oldNewTalent = Talents.newTalent
Talents.newTalent = function(self, t)
	
	t.type_no_req = true -- Since we do not use talent types

	if not t.image then
		t.image = "talents/"..(t.short_name or t.name):lower():gsub("[^a-z0-9_]", "_")..".png"
	end
	if fs.exists("/data/gfx/"..t.image) then 
		t.display_entity = Entity.new{image=t.image, is_talent=true}
	else
		t.image = "talents/default.png" 
		t.display_entity = Entity.new{image="talents/default.png", is_talent=true}
	end
	return oldNewTalent(self, t)
end


load("data/talents/feats/feats.lua")

load("data/talents/domains/domains.lua")

load("data/talents/barbarian.lua")
load("data/talents/arcane.lua")
load("data/talents/metamagic.lua")
load("data/talents/special.lua")
load("data/talents/divine.lua")
load("data/talents/monster.lua")
load("data/talents/cleric.lua")
load("data/talents/eldritch.lua")