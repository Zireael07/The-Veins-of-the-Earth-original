-- Veins of the Earth
-- Zireael 2013-2015
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

	local tt = self:getTalentTypeFrom(t.type[1])
	if tt and tt.no_tt_req then
		t.type_no_req = true
	end

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

--Thanks DarkGod!
newFeat = function(t)
	if not t.points then t.points = 1 end
	if not t.is_feat then t.is_feat = true end
	return newTalent(t)
end

newArcaneSpell = function(t)
	if not t.points then t.points = 1 end
	if not t.is_spell then t.is_spell = true end
	if not t.mana then t.mana = 1 end
	t.spell_kind = {arcane=true}
	t.show_in_spellbook = true
	return newTalent(t)
end

newDivineSpell = function(t)
	if not t.points then t.points = 1 end
	if not t.is_spell then t.is_spell = true end
	if not t.mana then t.mana = 1 end
	t.spell_kind = {divine=true}
	t.show_in_spellbook = true
	return newTalent(t)
end

newArcaneDivineSpell = function(t)
	if not t.points then t.points = 1 end
	if not t.is_spell then t.is_spell = true end
	if not t.mana then t.mana = 1 end
	t.spell_kind = {divine=true, arcane=true}
	t.show_in_spellbook = true
	return newTalent(t)
end

load("data/talents/feats/combat.lua")
load("data/talents/feats/feats.lua")
load("data/talents/feats/focus.lua")
load("data/talents/feats/proficiency.lua")
load("data/talents/feats/combat_passive.lua")
load("data/talents/feats/two_weapons.lua")
load("data/talents/feats/skill_enhancers.lua")
load("data/talents/feats/attribute_enhancers.lua")
load("data/talents/feats/saves_enhancers.lua")


load("data/talents/feats/perks.lua")

load("data/talents/feats/metamagic.lua")
load("data/talents/feats/item_creation.lua")
load("data/talents/feats/reserve.lua")
load("data/talents/feats/spellcasting.lua")

load("data/talents/domains/domains.lua")

load("data/talents/spells/divine.lua")
load("data/talents/spells/arcane.lua")
load("data/talents/spells/arcane_divine.lua")
load("data/talents/spells/innate.lua")


load("data/talents/spells/monster.lua")
load("data/talents/monster.lua")

load("data/talents/skills.lua")
load("data/talents/special.lua")
load("data/talents/menu.lua")

load("data/talents/class features/barbarian.lua")
load("data/talents/class features/bard.lua")
load("data/talents/class features/cleric.lua")
load("data/talents/class features/eldritch.lua")
load("data/talents/class features/monk.lua")
load("data/talents/class features/ranger.lua")
load("data/talents/class features/druid.lua")
load("data/talents/class features/paladin.lua")
