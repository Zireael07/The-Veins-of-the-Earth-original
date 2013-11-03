load("data/talents/spells/arcane/abjuration.lua")
load("data/talents/spells/arcane/conjuration.lua")
load("data/talents/spells/arcane/divination.lua")
load("data/talents/spells/arcane/enchantment.lua")
load("data/talents/spells/arcane/evocation.lua")
load("data/talents/spells/arcane/illusion.lua")
load("data/talents/spells/arcane/necromancy.lua")
load("data/talents/spells/arcane/transmutation.lua")

newTalentType{ all_limited=true, type="arcane/arcane", name = "arcane", description = "Arcane Spells" }

--Bardic heal spells
newTalent{
	name = "Cure Light Wounds", short_name = "BARDIC_CLW",
	type = {"arcane/arcane", 1},
	mode = 'activated',
	--require = ,
	level = 1,
	points = 1,
	tactical = { BUFF = 2 },
	range = 0,
	--caster_bonus = function(self)
	--	return math.min(self.level or 1, 5)
	--end,
	action = function(self)
	if not self then return nil end
	self:heal(rng.dice(1,8)) --+ caster_bonus)
	return true
	--end,
	end,

	info = function(self, t)
		return ([[You heal yourself - the amount of damage healed is equal to 1d8 +1 per level (max 5).]])
	end,	
}

