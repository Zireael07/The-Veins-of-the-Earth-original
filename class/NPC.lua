-- Veins of the Earth
-- Copyright (C) 2013-2015 Zireael

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

local Map = require "engine.Map"
require "mod.class.Actor"

module(..., package.seeall, class.inherit(mod.class.Actor, engine.interface.ActorAI))

function _M:init(t, no_default)
	mod.class.Actor.init(self, t, no_default)
	ActorAI.init(self, t)
end

function _M:resolve(t, last, on_entity, key_chain)
  -- Dodgy Hack(TM):  resolve() calls itself, and we only want to do our
  -- special stuff once at the top level.
  if self.nested then
    mod.class.Actor.resolve(self, t, last, on_entity, key_chain)
    return
  end
  self.nested = true

 --[[ local NPCEgo = require 'mod.class.NPCEgo'
  if not last then
    NPCEgo:tryAddEgo(self)
    NPCEgo:applyEgo(self)
  end]]

  mod.class.Actor.resolve(self, t, last, on_entity, key_chain)

  if last then
    -- Clean these up behind ourself.
    _M.resolve_flags = {}
    -- This isn't getting handled right, and I can't figure out how to
    -- disentangle it; ham-hand it manually here.
    self.life = self.max_life
  end
  self.nested = nil
end

function _M:act()
    local player = game.player

	if self.life <= -10 then self:die() end

	-- Do basic actor stuff
	if not mod.class.Actor.act(self) then return end

	-- Compute FOV, if needed
		self:doFOV()

	-- Let the AI think .... beware of Shub !
	-- If AI did nothing, use energy anyway
	self:doAI()

    --Emotes
    if self.emote_random and self.x and self.y and game.level.map.seens(self.x, self.y) and rng.range(0, 999) < self.emote_random.chance * 10 then
        local e = util.getval(rng.table(self.emote_random))
        if e then
            local dur = util.bound(#e, 30, 90)
                 self:doEmote(e, dur)
        end
    end

	if not self.energy.used then self:runAI("move_simple") end
	if not self.energy.used then self:runAI("move_wander") end
	if not self.energy.used then self:useEnergy() end
    --if old_energy == self.energy.value then break end -- Prevent infinite loops
end

function _M:doFOV()
	self:computeFOV(self.sight or 10, "block_sight", nil, nil, nil, true)

  -- Calculate our own FOV
  if self:attr("lite") then
  	self:computeFOV(self.lite)
  end

  --If our darkvision is better than our lite, check it.
  	if (self:attr("infravision") or 0) > (self:attr("lite") or 0) then
    	self:computeFOV(self:attr("infravision"))
	end

--[[	if not self:attr("lite") or not self:attr("infravision") then
		self:computeFOV(self.sight or 3)
	end]]
end

function _M:onTalentLuaError(ab, err)
	self:useEnergy()  -- prevent infinitely long erroring out turns
end

--Taken from ToME 4
--- Give target to others
function _M:seen_by(who)
    if self:hasEffect(self.EFF_VAULTED) and who and game.party:hasMember(who) then self:removeEffect(self.EFF_VAULTED, true, true) end

    -- Check if we can pass target
    if self.dont_pass_target then return end
    if not who.ai_target then return end
    if not who.ai_target.actor then return end
    if not who.ai_target.actor.x then return end
    -- Only receive targets from allies
    if self:reactionToward(who) <= 0 then return end
    -- Check if we can actually see the ally (range and obstacles)
    if not who.x or not self:hasLOS(who.x, who.y) then return end
	-- Check if it's actually a being of cold machinery and not of blood and flesh
 	if not who.aiSeeTargetPos then return end
    if self.ai_target.actor then
        -- Pass last seen coordinates
        if self.ai_target.actor == who.ai_target.actor then
            -- Adding some type-safety checks, but this isn't fixing the source of the errors
            local last_seen = {turn=0}
            if self.ai_state.target_last_seen and type(self.ai_state.target_last_seen) == "table" then
                last_seen = self.ai_state.target_last_seen
            end
            if who.ai_state.target_last_seen and type(who.ai_state.target_last_seen) == "table" and who.ai_state.target_last_seen.turn > last_seen.turn then
                last_seen = who.ai_state.target_last_seen
            end
            if last_seen.x and last_seen.y then
                self.ai_state.target_last_seen = last_seen
                who.ai_state.target_last_seen = last_seen
            end
        end
        return
    end
    if who.ai_state and who.ai_state.target_last_seen and type(who.ai_state.target_last_seen) == "table" then
        -- Don't believe allies if they saw the target far, far away
        if who.ai_state.target_last_seen.x and who.ai_state.target_last_seen.y and core.fov.distance(self.x, self.y, who.ai_state.target_last_seen.x, who.ai_state.target_last_seen.y) > self.sight then return end
        -- Don't believe allies if they saw the target over 10 turns ago
        if (game.turn - (who.ai_state.target_last_seen.turn or game.turn)) / (game.energy_to_act / game.energy_per_tick) > 10 then return end
    end
    -- And only trust the ally if they can actually see the target
    if not who:canSee(who.ai_target.actor) then return end

    self:setTarget(who.ai_target.actor, who.ai_state.target_last_seen)
    print("[TARGET] Passing target", self.name, "from", who.name, "to", who.ai_target.actor.name)
end

--- Check if we are angered
-- @param src the angerer
-- @param set true if value is the finite value, false if it is an increment
-- @param value the value to add/subtract
-- @param turns how many turns to delay reaction decay
function _M:checkAngered(src, set, value, turns)
    if not src.resolveSource then return end
    if not src.faction then return end
    if self.never_anger then return end
    if game.party:hasMember(self) then return end
    if self.summoner and self.summoner == src then return end

    -- Cant anger at our own faction unless it's the silly player
    if self.faction == src.faction and not src.player then return end

    local rsrc = src:resolveSource()
    local rid = rsrc.unique or rsrc.name
    if not self.reaction_actor then self.reaction_actor = {} end

    local was_hostile = self:reactionToward(src) < 0

    if not set then
        self.reaction_actor[rid] = util.bound((self.reaction_actor[rid] or 0) + value, -200, 200)
    else
        self.reaction_actor[rid] = util.bound(value, -200, 200)
    end

	if turns then self.reaction_actor.turns = math.max(self.reaction_actor.turns or 0, turns) end

    if not was_hostile and self:reactionToward(src) < 0 then
		self.reaction_actor.turns = math.max(self.reaction_actor.turns or 0, 5)
        if self.emote_anger then
			self:doEmote(self.emote_anger, 30)
        --    self:doEmote(self.anger_emote:gsub("@himher@", src.female and "her" or "him"), 30)
        end
    end
end

--- Counts down timedEffects, but need to avoid the damaged A* pathing
function _M:timedEffects(filter)
    self._in_timed_effects = true
    mod.class.Actor.timedEffects(self, filter)
    self._in_timed_effects = nil

	--decay personal reaction towards 0 (from NPC Forgiveness addon)
	local Ractor = self.reaction_actor --NPF
	if Ractor and not self:attr("no_timeflow") then
		if Ractor.turns then
			Ractor.turns = Ractor.turns > 1 and Ractor.turns - 1 or nil
		else
			for rid, val in pairs(Ractor) do
				val = math.ceil(val * 0.9)
				if val == 0 then
					val = nil
					--eventually clear friendly ai targets
					if self.ai_target.actor and (self.ai_target.actor.name == rid or (rid == "player" and self.ai_target.actor.player)) and self:reactionToward(self.ai_target.actor) >=0 then
						self:setTarget()
					end
				end
				Ractor[rid] = val
			end
		end
	end
end

--- Called by ActorLife interface
-- We use it to pass aggression values to the AIs
function _M:onTakeHit(value, src)
    value = mod.class.Actor.onTakeHit(self, value, src)


    self.last_attacker = src
    if not self.ai_target.actor and src.targetable and value > 0 then
        self.ai_target.actor = src
    end

    -- Switch to astar pathing temporarily
    if src and src == self.ai_target.actor and not self._in_timed_effects then
        self.ai_state.damaged_turns = 10
    end

    -- Get angry if attacked by a friend
		if src and src ~= self and src.resolveSource and src.faction and value > 0 and engine.Faction:factionReaction(self.faction, src.faction) >= 0 then
--    if src and src ~= self and src.resolveSource and src.faction and self:reactionToward(src) >= 0 and value > 0 then
		local react = -math.min(100, 500*value/self.max_life)  -- NPC reaction depends on hit
		self:checkAngered(src, false, react)
	--	self:checkAngered(src, false, -50)

        -- Call for help if we become hostile
        for i = 1, #self.fov.actors_dist do
            local act = self.fov.actors_dist[i]
            if act and act ~= self and self:reactionToward(act) > 0 and not act.dead and act.checkAngered then
				act:checkAngered(src, false, react)
			--    act:checkAngered(src, false, -50)
            end
        end
    end


    return mod.class.Actor.onTakeHit(self, value, src)
end

--Detrimental status effects reduce reaction (from NPC Forgiveness)
function _M:on_set_temporary_effect(eff_id, e, p)
	mod.class.Actor.on_set_temporary_effect(self, eff_id, e, p)
	if p.src and e.status == "detrimental" and p.dur > 0 then --and not exclude_effects[eff_id] then
		self:checkAngered(p.src, false, -25)
	end
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

--- Make emotes appear in the log too
function _M:setEmote(e)
    game.logSeen(self, "%s says: '%s'", self.name:capitalize(), e.text)
    mod.class.Actor.setEmote(self, e)
end

--- Simple emote
function _M:doEmote(text, dur, color)
    self:setEmote(Emote.new(text, dur, color))
	print("[EMOTE] Text: ", text)
end


--[[local shove_algorithm = function(self)
    return 3 * self.rank + self.size_category * self.size_category
end]]

function _M:aiCanPass(x, y)
    --From ToME 4
    -- If there is a friendly actor, add shove_pressure to it
--[[    local target = game.level.map(x, y, engine.Map.ACTOR)
    if target and target ~= game.player and self:reactionToward(target) > 0 and not target:attr("never_move") and target.x then
        target.shove_pressure = (target.shove_pressure or 0) + shove_algorithm(self) + (self.shove_pressure or 0)
        -- Shove the target?
        if target.shove_pressure > shove_algorithm(target) * 1.7 then
            local dir = util.getDir(target.x, target.y, self.x, self.y)
            local sides = util.dirSides(dir, target.x, target.y)
            local check_order = {}
            if rng.percent(50) then
                table.insert(check_order, "left")
                table.insert(check_order, "right")
            else
                table.insert(check_order, "right")
                table.insert(check_order, "left")
            end
            if rng.percent(50) then
                table.insert(check_order, "hard_left")
                table.insert(check_order, "hard_right")
            else
                table.insert(check_order, "hard_right")
                table.insert(check_order, "hard_left")
            end
            for _, side in ipairs(check_order) do
                local check_dir = sides[side]
                local sx, sy = util.coordAddDir(target.x, target.y, check_dir)
                if target:canMove(sx, sy) and target:move(sx, sy) then
                    self:logCombat(target, "#Source# shoves #Target# forward.")
                    target.shove_pressure = nil
                    target._last_shove_pressure = nil
                    break
                end
            end
            return true
        end
    end]]

    --Stop walking into lava/fire/chasm etc.
    local terrain = game.level.map(x, y, Map.TERRAIN)
    --prevent weird off-map AI errors
    if terrain and terrain.on_stand and not terrain.on_stand_safe then return false end

    return engine.interface.ActorAI.aiCanPass(self, x, y)
end

--- Returns the seen coords of the target
-- This will usually return the exact coords, but if the target is only partially visible (or not at all)
-- it will return estimates, to throw the AI a bit off
-- @param target the target we are tracking
-- @return x, y coords to move/cast to
function _M:aiSeeTargetPos(target)
    if not target then return self.x, self.y end
    local tx, ty = target.x, target.y

    -- Special case, a boss that can pass walls can always home in on the target; otherwise it would get lost in the walls for a long while
    -- We check wall walking not on self but rather as a check if the target could reach us
--[[    if self.rank > 3 and target.canMove and not target:canMove(self.x, self.y, true) then
        return util.bound(tx, 0, game.level.map.w - 1), util.bound(ty, 0, game.level.map.h - 1)
    end]]
    return ActorAI.aiSeeTargetPos(self, target)
end

--- Responsible for clearing ai target if needed
-- Pass target to summoner if any
function _M:clearAITarget()
	if self.ai_target.actor and (self.ai_target.actor.dead or not game.level:hasEntity(self.ai_target.actor)) and self.ai_target.actor.summoner then
		self.ai_target.actor = self.ai_target.actor.summoner
		-- You think you can cheat with summons ? let's cheat back !
		-- yeah it's logical because .. hum .. yeah because the npc saw were the summon came from!
		local tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
		self.ai_state.target_last_seen = {x=tx, y=ty, turn=game.turn}
	end

--if self.ai_target.actor and self.ai_target.actor.dead then self.ai_target.actor = nil end
	--clear friendly ai targets
	if self.ai_target.actor and (self.ai_target.actor.dead or self:reactionToward(self.ai_target.actor) >= 0) then self.ai_target.actor = nil end

end



--NPC specific stuff the player will never use
--Make NPCs aware of objects on floor
function _M:getObjectonFloor(x, y)
    local z = game.level.map:getObjectTotal(x, y)

    if z >= 1 then return true end --game.log("AI spotted object on floor: %d, %d", x, y)
    return nil
end

function _M:pickupObject(x, y)
    --Taken from Player.lua
    -- Auto-pickup stuff from floor.
	--Check for inventory first
	if self:getInven(self.INVEN_INVEN) then
  		local i = 1
  		local obj = game.level.map:getObject(x, y, i)
  		while obj
			--let's ignore money and corpses
			and obj.type ~= "money" and obj.subtype ~= "corpse"
		do
   			if self:pickupFloor(i, true) then
				local o_name = obj.name
		--		game.log("AI tried to pick up object: %s", o_name)
      		-- Nothing to do.
    		else
      		i = i + 1
    		end
    	obj = game.level.map:getObject(x, y, i)
		end
	else
		game.log("AI has no inventory")
	end

end

--Swap weapons functions
function _M:wieldRanged()
	local weapon = self:getInven("MAIN_HAND")[1]
    local ammo = self:getInven("QUIVER")[1]

    local mh = self.inven[self.INVEN_MAIN_HAND]
    local am = self.inven[self.INVEN_QUIVER]
	local inven = self:getInven("INVEN")

	local weapon_inven, index = self:findInInventoryBy(inven, "ranged", true)
	local ammo, item = self:findInInventoryBy(inven, "ammo", true)

    --Do we have ammo in inventory?
    if ammo then
    	--check if types match
    	if weapon and weapon.ranged then
    		if not weapon.ammo_type == ammo.archery_ammo then return end
    	elseif weapon_inven then
    		if not weapon_inven.ammo_type == ammo.archery_ammo then return end
    	else end
    end

    if weapon_inven then
		self:doWear(inven, index, weapon_inven)
    end

    if ammo then
		self:doWear(inven, item, ammo)
    end
end

function _M:wieldMelee()
	local shield = self:getInven("OFF_HAND")[1]
    local weapon = self:getInven("MAIN_HAND")[1]

    local mh = self.inven[self.INVEN_MAIN_HAND]
    local oh = self.inven[self.INVEN_OFF_HAND]

	local inven = self:getInven("INVEN")
	local weapon_inven, index = self:findInInventoryBy(inven, ranged, false)

    if weapon_inven then
		self:doWear(inven, index, weapon_inven)
    end

end

--Dragon stuff
function _M:getBreathWeapon()
	local dice
	local dc

	if not self.age_cat then return end

	if self.age_cat == "hatchling" then dice = 2 dc = 14 end
	if self.age_cat == "very young" then dice = 4 dc = 16 end
	if self.age_cat == "young" then dice = 6 dc = 18 end
	if self.age_cat == "juvenile" then dice = 8 dc = 20 end
	if self.age_cat == "young adult" then dice = 10 dc = 23 end
	if self.age_cat == "adult" then dice = 12 dc = 25 end
	if self.age_cat == "mature adult" then dice = 14 dc = 27 end
	if self.age_cat == "old" then dice = 16 dc = 29 end
	if self.age_cat == "very old" then dice = 18 dc = 31 end
	if self.age_cat == "ancient" then dice = 20 dc = 33 end
	if self.age_cat == "wyrm" then dice = 22 dc = 36 end
	if self.age_cat == "great wyrm" then dice = 24 dc = 37 end

	--Failsafe
	if not dice or not dc then game.log("Wrong age category defined!")
		dice = 2 dc = 14
	end

	return dice, dc
end
