-- Veins of the Earth
-- Copyright (C) 2013-2015 Zireael
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


-- The basic stuff used to damage a grid
setDefaultProjector(function(src, x, y, type, dam)
	if not game.level.map:isBound(x, y) then return 0 end

	local target = game.level.map(x, y, Map.ACTOR)
	if target then

		if dam > 0 then
			local sx, sy = game.level.map:getTileToScreen(x, y)
			if target:takeHit(dam, src) then
				if src == game.player or target == game.player then
					game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, "Kill!", {255,0,255})
				end
			else
				if src == game.player then
					game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {0,255,0})
				elseif target == game.player then
					game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {255,0,0})
				end
			end

			--Damage increases
			if src.inc_damage then
				local inc
				inc = (src.inc_damage.all or 0) + (src.inc_damage[type] or 0)

				dam = dam + (dam * inc / 100)
			end

			-- Log damage for later
			if not DamageType:get(type).hideMessage then
				local visible, srcSeen, tgtSeen = game:logVisible(src, target)
				if visible then -- don't log damage that the player doesn't know about
				local source = src.__project_source or src
					if src.__is_actor then
						game.logSeen(target, "%s hits %s for %s%d %s damage#LAST#.", src:getLogName():capitalize(), target:getLogName(), DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name)
					else
						game.logSeen(target, "%s hits %s for %s%d %s damage#LAST#.", src.name:capitalize(), target:getLogName(), DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name)
					end
			--[[	if src.turn_procs and src.turn_procs.is_crit then
					game:delayedLogDamage(source, target, dam, ("#{bold}#%s%d %s#{normal}##LAST#"):format(DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name), true)
				else
					game:delayedLogDamage(source, target, dam, ("%s%d %s#LAST#"):format(DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name), false)
			--	end]]
				end
			end

		end

		return dam
	end
	return 0
end)

newDamageType{
	name = "physical", type = "PHYSICAL",
	death_message = {"battered", "bludgeoned", "sliced", "maimed", "raked", "impaled", "dissected", "disemboweled", "decapitated", "stabbed", "pierced", "crushed", "shattered", "smashed", "skewered", "squished", "mauled", "splattered", "eviscerated"},
}

-- Acid destroys potions
newDamageType{
	name = "acid", type = "ACID", text_color = "#GREEN#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			local damage = dam.dam or dam
			if target:reflexSave(dam.save_dc or 10) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"dissolved", "corroded", "scalded", "melted"},
}

newDamageType{
	name = "force", type = "FORCE", text_color = "#DARK_KHAKI#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			local damage = dam.dam or dam
			if target:fortitudeSave(dam.save_dc or 10) then
				game.logSeen(target, "The target succeded on the saving throw.")
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"blasted", "energised", "mana-torn", "dweomered", "imploded"},
}

newDamageType{
	name = "fire", type = "FIRE", text_color = "#LIGHT_RED#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			local damage = dam.dam or dam
			if target:reflexSave(dam.save_dc or 10) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"burnt", "scorched", "blazed", "roasted", "flamed", "fried", "combusted", "toasted", "slowly cooked", "boiled"},
}

newDamageType{
	name = "drowning", type = "WATER", text_color = "#DARK_BLUE#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR)
		if target then
			local damage = dam
			if target:fortitudeSave(10) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"drowned", "choked on water", "soaked"}
}

newDamageType{
	name = "lava", type = "LAVA", text_color = "#DARK_RED#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR)
		if target then
			local damage = dam
			if target:reflexSave(20) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"burnt", "scorched", "blazed", "roasted", "flamed", "fried", "combusted", "toasted", "slowly cooked", "boiled"},
}



newDamageType{
	name = "cold", type = "COLD", text_color = "#LIGHT_BLUE#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			local damage = dam.dam or dam
			if target:fortitudeSave(dam.save_dc or 10) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"frozen", "chilled", "iced", "cooled"},
}

newDamageType{
	name = "electricity", type = "ELECTRIC", text_color = "#GOLD#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			local damage = dam.dam or dam
			if target:reflexSave(dam.save_dc or 10) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"electrocuted", "shocked", "bolted", "volted", "amped", "zapped"},
}

newDamageType{
	name = "sonic", type = "SONIC", text_color = "#TEAL#",
	projector = function(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			local damage = dam.dam or dam
			if target:fortitudeSave(dam.save_dc or 10) then
				damage = math.floor(damage / 2)
			end
			local realdam = DamageType.defaultProjector(src, x, y, type, damage)
			return realdam
		end
	end,
	death_message = {"shocked", "blasted", "sound-blasted", "busted"}
}


--Not exactly damaging stuff
newDamageType{
	name = "grease", type = "GREASE",
	projector = function(src, x, y, type, dam)
		--dam is the dc to beat
		local target = game.level.map(x, y, Map.ACTOR)
		if target then
			if not target:reflexSave(dam.save_dc) then
				target:setEffect(target.EFF_FELL, 1, {})
			else
				game.logSeen(target, "%s succeeds the saving throw!", target.name:capitalize())
			end
		end
	end,
}

newDamageType{
	name = "darkness", type = "DARKNESS",
	projector = function(src, x, y, type, dam)
		local realdam = DamageType.defaultProjector(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR)
		if target then
			target:setEffect(target.EFF_DARKNESS, 1, {})
			-- Darken
			game.level.map.lites(x, y, false)
		--	if src.x and src.y then game.level.map.lites(src.x, src.y, false) end
		end
	end,
}

-- Lite up the room (from ToME)
newDamageType{
	name = "lite", type = "LITE", text_color = "#YELLOW#",
	projector = function(src, x, y, type, dam)
		-- Don't lit magically unlit grids
		local g = game.level.map(x, y, Map.TERRAIN+1)
		if g and g.unlit then
			if g.unlit <= dam then game.level.map:remove(x, y, Map.TERRAIN+1)
			else return end
		end

		game.level.map.lites(x, y, true)
	end,
}

--Dummies
newDamageType{
	name = "faerie", type = "FAERIE",
	projector = function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		target:setEffect(target.EFF_FAERIE, 1, {})
	end
	end,
}

newDamageType{
	name = "detect evil", type = "DETECT_EVIL",
	projector = function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		if target:isEvil() then
		game.log("Target glows red briefly.")
		target:setEffect(target.EFF_DETECT_EVIL, 3, {})
		else
		game.log("Target is not evil.")
		end
	end
	end,
}

newDamageType{
	name = "detect good", type = "DETECT_GOOD",
	projector = function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		if target:isEvil() then
		game.log("Target glows blue briefly.")
		target:setEffect(target.EFF_DETECT_GOOD, 3, {})
		else
		game.log("Target is not good.")
		end
	end
	end,
}

newDamageType{
	name = "detect chaos", type = "DETECT_CHAOS",
	projector = function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		if target:isEvil() then
		game.log("Target glows green briefly.")
		target:setEffect(target.EFF_DETECT_CHAOS, 3, {})
		else
		game.log("Target is not chaotic.")
		end
	end
	end,
}

newDamageType{
	name = "detect law", type = "DETECT_LAW",
	projector = function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		if target:isEvil() then
		game.log("Target glows yellow briefly.")
		target:setEffect(target.EFF_DETECT_LAW, 3, {})
		else
		game.log("Target is not lawful.")
		end
	end
	end,
}


--Enable digging
newDamageType{
	name = "dig", type = "DIG",
	projector = function(src, x, y, typ, dam)
		local feat = game.level.map(x, y, Map.TERRAIN)
		if feat then
			if feat.dig then
				local newfeat_name, newfeat, silence = feat.dig, nil, false
				if type(feat.dig) == "function" then newfeat_name, newfeat, silence = feat.dig(src, x, y, feat) end
				newfeat = newfeat or game.zone.grid_list[newfeat_name]
				if newfeat then
					game.level.map(x, y, Map.TERRAIN, newfeat)
					src.dug_times = (src.dug_times or 0) + 1

					if not silence then
						game.logSeen({x=x,y=y}, "%s turns into %s.", feat.name:capitalize(), newfeat.name)
					end
				end
			end
		end
	end,

}
