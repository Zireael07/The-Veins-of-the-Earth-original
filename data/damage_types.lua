-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009, 2010, 2011, 2012, 2013 Nicolas Casalini
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
--
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

-- The basic stuff used to damage a grid
setDefaultProjector(function(src, x, y, type, dam)
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		local flash = game.flash.NEUTRAL
		if target == game.player then flash = game.flash.BAD end
		if src == game.player then flash = game.flash.GOOD end

		game.logSeen(target, flash, "%s hits %s for %s%0.2f %s damage#LAST#.", src.name:capitalize(), target.name, DamageType:get(type).text_color or "#aaaaaa#", dam, DamageType:get(type).name)
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


		return dam
	end
	return 0
end)

newDamageType{
	name = "physical", type = "PHYSICAL",
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
}

newDamageType{
	name = "force", type = "FORCE", text_color = "#DARK_KHAKI#",
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
}


--Specials!
newDamageType{
	name = "grease", type = "GREASE",
	projector = function(src, x, y, type, dam)
		--dam is the dc to beat
		local target = game.level.map(x, y, Map.ACTOR) or src
		if target then
			if not target:reflexSave(dam.dc) then
				target:setEffect(target.EFF_FELL, 1, {})
			else
				game.logSeen(target, "%s succeeds the saving throw!", target.name:capitalize())
			end
		end
	end,
}

newDamageType{
	name = "darkness", type = "DARKNESS",
	projector = function(src, x, y, type, dam, extra)
		local realdam = DamageType.defaultProjector(src, x, y, type, dam)
		local target = game.level.map(x, y, Map.ACTOR)
		-- Darken
		game.level.map.lites(x, y, false)
		if src.x and src.y then game.level.map.lites(src.x, src.y, false) end
	end,
}


--Enable digging

newDamageType{
    name = "dig", type = "DIG",
    projector = function(src, x, y, typ, dam)
        local feat = game.level.map(x, y, Map.TERRAIN)
        if not feat or not feat.dig then return end

        local newfeat_name, newfeat, silence = feat.dig, nil, false
        if type(feat.dig) == "function" then newfeat_name, newfeat, silence = feat.dig(src, x, y, feat) end
        game.level.map(x, y, Map.TERRAIN, newfeat or game.zone.grid_list[newfeat_name])
        if not silence then
            game.logSeen({x=x,y=y}, "The %s turns into %s.", feat.name, (newfeat or game.zone.grid_list[newfeat_name]).name)
        end

        if src.talentCallbackAllOn then src:talentCallbackAllOn("on_dig", x, y, feat) end
    end,
}