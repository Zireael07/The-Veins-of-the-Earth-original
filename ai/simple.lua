-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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

-- Defines a simple AI building blocks
-- Target nearest and move/attack it
local Astar = require "engine.Astar"

newAI("move_simple", function(self)
    if self.ai_target.actor then
        local tx, ty
        -- Move towards the last seen position if we have one
        if self.ai_state.target_last_seen and type(self.ai_state.target_last_seen) == "table" then
            tx, ty = self.ai_state.target_last_seen.x, self.ai_state.target_last_seen.y
        else
            tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
        end
        return self:moveDirection(tx, ty)
    end
end)

newAI("move_dmap", function(self)
    if self.ai_target.actor and self.x and self.y then
        local a = self.ai_target.actor
        local ax, ay = self:aiSeeTargetPos(a)

        -- If we have a vision, go straight towards the target
        if self:hasLOS(ax, ay) then
            return self:runAI("move_simple")
        end

        local c = a:distanceMap(self.x, self.y)
        local dir = 5

        if c and ax == a.x and ay == a.y then
            for _, i in ipairs(util.adjacentDirs()) do
                local sx, sy = util.coordAddDir(self.x, self.y, i)
                local cd = a:distanceMap(sx, sy)
--              print("looking for dmap", dir, i, "::", c, cd)
                local tile_available = self:canMove(sx, sy) or (sx == ax and sy == ay)
                if cd and cd > c and tile_available then c = cd; dir = i end
            end
            return self:moveDirection(util.coordAddDir(self.x, self.y, dir))
        else
            return self:runAI("move_simple")
        end
    end
end)

newAI("flee_simple", function(self)
    if self.ai_target.actor then
        local a = self.ai_target.actor
        local ax, ay = self:aiSeeTargetPos(a)
        local dir = util.opposedDir(util.getDir(ax, ay, self.x, self.y), self.x, self.y)
        local sx, sy = util.coordAddDir(self.x, self.y, dir)

        -- If we cannot move directly away, try to move to the sides
        if not self:canMove(sx, sy) then
            local sides = util.dirSides(dir, self.x, self.y)
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
                local sx, sy = util.coordAddDir(self.x, self.y, check_dir)
                if self:canMove(sx, sy) then
                    dir = check_dir
                    break
                end
            end
        end
        return self:moveDirection(util.coordAddDir(self.x, self.y, dir))
    end
end)

newAI("flee_dmap", function(self)
    if self.ai_target.actor then
        local a = self.ai_target.actor
        local ax, ay = self:aiSeeTargetPos(a)

        local c = a:distanceMap(self.x, self.y)
        local dir = 5

        if c and ax == a.x and ay == a.y then
            for _, i in ipairs(util.adjacentDirs()) do
                local sx, sy = util.coordAddDir(self.x, self.y, i)
                local cd = a:distanceMap(sx, sy)
--              print("looking for dmap", dir, i, "::", c, cd)
                if not cd or (c and (cd < c and self:canMove(sx, sy))) then c = cd; dir = i end
            end
        end

        -- If we do not accurately know the targets position, move away from where we think it is
        if  dir == 5 then
            return self:runAI("flee_simple")
        -- Otherwise, move in the dmap direction
        else
            return self:moveDirection(util.coordAddDir(self.x, self.y, dir))
        end

    end
end)

newAI("move_astar", function(self, add_check)
    if self.ai_target.actor then
        local tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
        local a = Astar.new(game.level.map, self)
        local path = a:calc(self.x, self.y, tx, ty, nil, nil, add_check)
        if not path then
            return self:runAI("move_simple")
        else
            local moved = self:move(path[1].x, path[1].y)
            if not moved then return self:runAI("move_simple") end
        end
    end
end)

-- Use A* pathing if we were blocked for several turns, to avoid stacking up in simple chokepoints
newAI("move_blocked_astar", function(self)
    if self.ai_target.actor then
        self.ai_state.blocked_turns = self.ai_state.blocked_turns - 1
        if self.ai_state.blocked_turns <= 0 then
            self.ai_state.ai_move = self.ai_state._old_ai_move
            self.ai_state._old_ai_move = nil
            self.ai_state.blocked_turns = nil
            return self:runAI(self.ai_state.ai_move or "move_simple")
        else
            local check_all_block_move = function(nx, ny)
                local actor = game.level.map(nx, ny, engine.Map.ACTOR)
                if actor and actor == self.ai_target.actor then
                    return true
                else
                    return not game.level.map:checkAllEntities(nx, ny, "block_move", self)
                end
            end
            local astar = self:runAI("move_astar", check_all_block_move)
            -- If A* did not work we add a penalty to trying A* again
            if not astar then
                self.ai_state.ai_move = self.ai_state._old_ai_move
                self.ai_state._old_ai_move = nil
                self.ai_state.blocked_turns = -5
            end
            return astar
        end
    end
end)

newAI("move_wander", function(self)
    local coords = {}
    for _, coor in pairs(util.adjacentCoords(self.x, self.y)) do
        if self:canMove(coor[1], coor[2]) then
            coords[#coords+1] = coor
        end
    end
    if #coords > 0 then
        local selected = rng.table(coords)
        return self:moveDirection(selected[1], selected[2])
    end
end)

newAI("move_complex", function(self)
    if self.ai_target.actor and self.x and self.y then
        local tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
        local moved

        -- Can we use A* due to damage?
        if not moved and self.ai_state.damaged_turns and self.ai_state.damaged_turns > 0 then
            moved = self:runAI("move_astar")
        end

        -- Wander if it has been a while since we last saw the target
        if not moved and self.ai_state.target_last_seen and (game.turn - (self.ai_state.target_last_seen.turn or game.turn)) / (game.energy_to_act / game.energy_per_tick) > 10 then
            moved = self:runAI("move_wander")
        end

        -- Check if we can use dmap
        if not moved then
            moved = self:runAI("move_dmap")
        end

        -- Check blocking
        if not moved and self:hasLOS(tx, ty) then
            -- Make sure that we are indeed blocked
            moved = self:runAI("move_simple")
            if not moved then
                -- Wait at least 5 turns of not moving before switching to blocked_astar
                -- add 2 since we remove 1 every turn
                self.ai_state.blocked_turns = (self.ai_state.blocked_turns or 0) + 2
                if self.ai_state.blocked_turns >= 5 then
                    self.ai_state._old_ai_move = self.ai_state.ai_move
                    self.ai_state.ai_move = "move_blocked_astar"
                    moved = self:runAI("move_blocked_astar")
                end
            end
        end

        -- Tick down the ai_state counters
        if self.ai_state.damaged_turns then
            self.ai_state.damaged_turns = self.ai_state.damaged_turns - 1
            if self.ai_state.damaged_turns <= 0 then self.ai_state.damaged_turns = nil end
        end
        if self.ai_state.blocked_turns then
            self.ai_state.blocked_turns = self.ai_state.blocked_turns - 1
            if self.ai_state.blocked_turns <= 0 then self.ai_state.blocked_turns = nil end
        end

        return moved
    end
end)

-- Find an hostile target
-- this requires the ActorFOV interface, or an interface that provides self.fov.actors*
--[[newAI("target_simple", function(self)
    if self.ai_target.actor and not self.ai_target.actor.dead and rng.percent(90) then return true end

    -- Find closer enemy and target it
    -- Get list of actors ordered by distance
    local arr = self.fov.actors_dist
    local act
    for i = 1, #arr do
        act = self.fov.actors_dist[i]
--      print("AI looking for target", self.uid, self.name, "::", act.uid, act.name, self.fov.actors[act].sqdist)
        -- find the closest enemy
        if act and self:reactionToward(act) < 0 and not act.dead then
            self:setTarget(act)
            self:check("on_acquire_target", act)
            return true
        end
    end
end)]]

newAI("target_player", function(self)
    self:setTarget(game.player)
    return true
end)

newAI("simple", function(self)
    if self:runAI(self.ai_state.ai_target or "target_simple") then
        return self:runAI(self.ai_state.ai_move or "move_simple")
    end
    return false
end)

newAI("dmap", function(self)
    if self:runAI(self.ai_state.ai_target or "target_simple") then
        return self:runAI(self.ai_state.ai_move or "move_dmap")
    end
    return false
end)

newAI("none", function(self) end)
