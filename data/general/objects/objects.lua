--Veins of the Earth
--Zireael 2016

local loadIfNot = function(f)
	if loaded[f] then return end
	load(f, entity_mod)
end

if config.settings.veins.body_parts then
	load("/data/general/objects/variant/body_parts_armor.lua")
else
	load("/data/general/objects/armor.lua")
end
loadIfNot("/data/general/objects/shields.lua")

loadIfNot("/data/general/objects/weapons.lua")
loadIfNot("/data/general/objects/ranged.lua")
loadIfNot("/data/general/objects/exotic.lua")
loadIfNot("/data/general/objects/exoticranged.lua")
loadIfNot("/data/general/objects/reach.lua")
loadIfNot("/data/general/objects/thrown.lua")

loadIfNot("/data/general/objects/consumables.lua")
loadIfNot("/data/general/objects/containers.lua")

loadIfNot("/data/general/objects/wondrous_items.lua")
if not config.settings.veins.body_parts then
	load("/data/general/objects/more_wondrous.lua")
end
loadIfNot("/data/general/objects/magic_items.lua")
loadIfNot("/data/general/objects/poisons.lua")

loadIfNot("/data/general/objects/pickaxes.lua")
loadIfNot("/data/general/objects/lite.lua")
loadIfNot("/data/general/objects/tools.lua")

loadIfNot("/data/general/objects/specific_items.lua")

--Lore
loadIfNot("/data/general/objects/lore.lua")

if config.settings.veins.money_weight then
    load("/data/general/objects/variant/money_weight.lua")
else
    load("/data/general/objects/money.lua")
end

loadIfNot("/data/general/objects/gems.lua")
