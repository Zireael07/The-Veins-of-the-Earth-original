-- Veins of the Earth
-- Copyright (C) 2013-2014 Zireael

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
local ActorAI = require "engine.interface.ActorAI"
local Faction = require "engine.Faction"
require "mod.class.Actor"

module(..., package.seeall, class.inherit(mod.class.Actor, engine.interface.ActorAI))

function _M:init(t, no_default)
	mod.class.Actor.init(self, t, no_default)
	ActorAI.init(self, t)
end

function _M:act()
    local player = game.player


	if self.life <= -10 then self:die() end

	-- Do basic actor stuff
	if not mod.class.Actor.act(self) then return end

	-- Compute FOV, if needed
		self:doFOV()

	--Morale and fleeing
	if self.morale_life then --and not self.inactive then
		if self.life < self.morale_life then
			if not self.energy.used then 
                self:runAI("flee_dmap") 
            --    self:setEffect(self.EFF_FEAR, 1, {src=player, range=10})
            end
		end
	end

	if self.life / self.max_life < 0.5 then
		if not self.energy.used then 
            self:runAI("flee_dmap") 
        --    self:setEffect(self.EFF_FEAR, 1, {src=player, range=10})
        end
	end

	-- Ranged (based on DataQueen)
	if self.ranged and self:isNear(game.player.x, game.player.y, self.ranged_limit) then
		self.ai = "flee_dmap"
	else
		self.ai = "dumb_talented_simple"
		if self.tricky then self.ranged = false end -- For ranged enemies
	end


	-- Let the AI think .... beware of Shub !
	-- If AI did nothing, use energy anyway
	self:doAI()

	if not self.energy.used then self:runAI("move_simple") end
	if not self.energy.used then self:runAI("move_wander") end
	if not self.energy.used then self:useEnergy() end
end

function _M:doFOV()
-- Clean FOV before computing it
  --game.level.map:cleanFOV()
  -- Compute both the normal and the lite FOV, using cache
  self:computeFOV(self.sight or 3, "block_sight", function(x, y, dx, dy, sqdist)
 --   game.level.map:apply(x, y, fovdist[sqdist])
  end, true, false, true)
  -- Calculate our own FOV
  self:computeFOV(self.lite, "block_sight", function(x, y, dx, dy, sqdist) 
 --     game.level.map:applyLite(x, y)
 --     game.level.map.remembers(x, y, true) -- Remember the tile 
    end, true, true, true)

  --If our darkvision is better than our lite, check it.
  if (self:attr("infravision") or 0) > self.lite then
    self:computeFOV(self:attr("infravision"), "block_sight", function(x, y, dx, dy, sqdist)
      if not game.level.map.seens(x, y) then 
        game.level.map.seens(x, y, 0.75) -- If we only see due to darkvision, it looks dark
      end
 --     game.level.map.remembers(x, y, true)
    end, true, true, true)
  end

end	


--- Called by ActorLife interface
-- We use it to pass aggression values to the AIs
function _M:onTakeHit(value, src)
	self.last_attacker = src
	if not self.ai_target.actor and src.targetable then
		self.ai_target.actor = src
	end

	return mod.class.Actor.onTakeHit(self, value, src)
end

--Personal reaction stuff
function _M:setPersonalReaction(src, value)
	local rsrc = src:resolveSource()
	local rid = rsrc.unique or rsrc.name
	if not self.reaction_actor then self.reaction_actor = {} end
	self.reaction_actor[rid] = util.bound(value, -200, 200)
end

function _M:getPersonalReaction(src, value)
	local rsrc = src:resolveSource()
	local rid = rsrc.unique or rsrc.name
	if not self.reaction_actor then self.reaction_actor = {} end
	return self.reaction_actor[rid] or 0
end



function _M:tooltip()
	local killed = game.player.all_kills and (game.player.all_kills[self.name] or 0) or 0
	local target = self.ai_target.actor

	local str = mod.class.Actor.tooltip(self)
	--Safeguard from weirdness
	if not str then return end

    str:add(
        true,
        ("Killed by you: %s"):format(killed), true,
        "Target: ", target and target.name or "none"
    )
    str:add(true, "UID: "..self.uid, true)

    return str
end