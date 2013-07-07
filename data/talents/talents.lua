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

newTalentType{ type="class/general", name = "general", description = "General feats" }

newTalent{
	name = "Armor Proficiency",
	type = {"class/general", 1},
	points = 3,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in light armors.]],
}

newTalent{
	name = "Exotic Weapon Proficiency",
	type = {"class/general", 1},
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Base attack bonus 1",		 -- Should be base attack bonus of 1
		}
	},
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat makes you proficient in exotic weapons.]],
}



newTalent{
	name = "Toughness",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your HP by 10% and your Fort save by +3.]],
        on_learn = function(self, t)
        self.max_life = self.max_life + self.maxlife/10
        self.fortitude_save = self.fortitude_save or 0 + 3
        end
}

newTalent{
	name = "Dodge",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your AC by +3 and your Ref save by +3.]],
        on_learn = function(self, t)
        self.combat_def = self.combat_def + 3
        self.reflex_save = self.reflex_save or 0 + 3
        end
}

newTalent{
	name = "Iron Will",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your power by 10% and your Will save by +3.]],
      	on_learn = function(self, t)
		self.will_save = self.will_save or 0 + 3       
end
}

newTalent{
	name = "Finesse",
	type = {"class/general", 1},
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Base attack bonus 1",		 -- Should be base attack bonus of 1
		}
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[With a light weapon, rapier, whip, or spiked chain made for a creature of your size category, you may use your Dexterity modifier instead of your Strength modifier on attack rolls. If you carry a shield, its armor check penalty applies to your attack rolls.]],
}


newTalent{
	name = "Combat Expertise",
	type = {"class/general", 1},
	require = {
		stat = { int = 13 }
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[You can substract a number up to -5 from your attack and add it to your AC as a dodge bonus.]],
}

newTalent{
	name = "Improved Critical",
	type = {"class/general", 1},
	is_feat = true,
	points = 3,
	mode = "passive",
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Base attack bonus 8",		 -- Should be base attack bonus of 8
		}
	},
	is_feat = true,
	info = [[This feat increases your power by 10% and your Will save by +3.]],
      	on_learn = function(self, t)
		combat.weapon.threat = combat.weapon.threat + 2       
end
}

newTalent{
	name = "Light Sleeper",
	type = {"class/general", 1},
	require = {
		stat = { wis = 13 }
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[The enemy will not get a free attack if you are resting.]],
}

newTalent{
	name = "Loadbearer",
	type = {"class/general", 1},
	require = {
		stat = { str = 13 } 
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[You suffer no penalties for medium load. The penalty for heavy load is halved.]],
}

newTalent{
	name = "Mobility",
	type = {"class/general", 1},
	is_feat = true,
	points = 1,
--	require = { T.DODGE },
	mode = "passive",
	is_feat = true,
	info = [[This feat increases your AC by +4.]],
        on_learn = function(self, t)
        self.combat_def = self.combat_def + 4
        end
}

newTalent{
	name = "Power Attack",
	type = {"class/general", 1},
	require = {
		stat = {str = 13}
	},
	is_feat = true,
	points = 1,
	mode = "passive",
	info = [[You can substract a number from your base attack bonus and add it to damage bonus.]],
}

load("data/talents/arcane.lua")
load("data/talents/metamagic.lua")
load("data/talents/special.lua")
load("data/talents/divine.lua")
load("data/talents/monster.lua")
load("data/talents/cleric.lua")
