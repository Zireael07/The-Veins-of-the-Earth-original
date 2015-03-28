--Veins of the Earth 2014-2015
--Zireael

--Based on ToME fear code
newAI("flee_fear", function(self)
    if self.ai_target.actor then
        local a = self.ai_target.actor
        local ax, ay = self:aiSeeTargetPos(a)

        local distance = core.fov.distance(self.x, self.y, ax, ay)
        if distance <= 5 then

            local bestX, bestY
            local bestDistance = 0
            local start = rng.range(0, 8)
            for i = start, start + 8 do
                local x = self.x + (i % 3) - 1
                local y = self.y + math.floor((i % 9) / 3) - 1

                if x ~= self.x or y ~= self.y then
                    local distance = core.fov.distance(x, y, ax, ay)
                    if distance > bestDistance
                        and game.level.map:isBound(x, y)
                        and not game.level.map:checkAllEntities(x, y, "block_move", self)
                        and not game.level.map(x, y, Map.ACTOR) then
                            bestDistance = distance
                            bestX = x
                            bestY = y
                    end
                end
            end

            if bestX then
                self:move(bestX, bestY, false)
            else
                 self:useEnergy(game.energy_to_act * self:combatMovementSpeed(bestX, bestY))
            end
        end
    end
end)
