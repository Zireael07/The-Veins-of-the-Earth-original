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

	if not t.image then
		t.image = "talents/"..(t.short_name or t.name):lower():gsub("[^a-z0-9_]", "_")..".png"
	end
	if fs.exists("/data/gfx/"..t.image) then t.display_entity = Entity.new{image=t.image, is_talent=true}
	else
		t.image = "talents/default.png" 
		t.display_entity = Entity.new{image="talents/default.png", is_talent=true}
	end

	if t.is_spell then
		t.charges = 0
		t.max_charges = 0 --temporary, untill the spellbook works
	end

	return oldNewTalent(self, t)
end

newTalentType{ type="class/general", name = "general", description = "General feats" }

newTalent{
	name = "Toughness",
	type = {"class/general", 1},
	points = 3,
	mode = "passive",
	info = [[This feat increases your HP by 10% and your Fort save by +3.]],
        on_learn = function(self, t)
        self.max_life = self.max_life + 10
        end
}

newTalent{
	name = "Dodge",
	type = {"class/general", 1},
	points = 3,
	mode = "passive",
	info = [[This feat increases your AC by +3 and your Ref save by +3.]],
        on_learn = function(self, t)
        self.combat_def = self.combat_def +3
        end
}

newTalent{
	name = "Iron Will",
	type = {"class/general", 1},
	points = 3,
	mode = "passive",
	info = [[This feat increases your sp by 10% and your Will save by +3.]],
 --       on_learn = function(self, t)
--        end
}

load("data/talents/arcane.lua")
load("data/talents/special.lua")