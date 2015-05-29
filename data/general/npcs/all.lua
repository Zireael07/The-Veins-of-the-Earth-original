-- Veins of the Earth
-- Zireael 2013-2015


local todo = {}

local loadIfNot = loadIfNot or function(f)
	if loaded[f] then return end
	todo[#todo+1] = {f=f, mod=entity_mod}
end

loadIfNot("/data/general/npcs/good.lua")

loadIfNot("/data/general/npcs/humanoid.lua")
loadIfNot("/data/general/npcs/monstrous_humanoid.lua")
loadIfNot("/data/general/npcs/giant.lua")

loadIfNot("/data/general/npcs/animals.lua")
loadIfNot("/data/general/npcs/animals_druid.lua")
loadIfNot("/data/general/npcs/vermin.lua")

loadIfNot("/data/general/npcs/aberration.lua")
loadIfNot("/data/general/npcs/construct.lua")

loadIfNot("/data/general/npcs/fey.lua")
loadIfNot("/data/general/npcs/draconic.lua")

loadIfNot("/data/general/npcs/magical_beasts.lua")
loadIfNot("/data/general/npcs/magical_beasts_highend.lua")


loadIfNot("/data/general/npcs/elementals.lua")

loadIfNot("/data/general/npcs/ooze.lua")
loadIfNot("/data/general/npcs/plants.lua")

loadIfNot("/data/general/npcs/outsider_evil.lua")
loadIfNot("/data/general/npcs/outsider_good.lua")

loadIfNot("/data/general/npcs/outsider_air.lua")
loadIfNot("/data/general/npcs/outsider_fire.lua")
loadIfNot("/data/general/npcs/outsider_earth.lua")
loadIfNot("/data/general/npcs/outsider_water.lua")


for i = 1, #todo do
	load(todo[i].f, todo[i].mod)
end
