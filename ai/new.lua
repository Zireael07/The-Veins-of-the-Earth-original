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

--NOTE: really new AI code
newAI("flee_if_wounded", function(self)
    if self.life == 0 and self.wounds and self.max_wounds and self.wounds < self.max_wounds then

		if self.wounds < self.max_wounds/2 then
			if not self.energy.used then
				if self.ai_target.actor then
	            	local tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
	                if self:isNear(tx, ty, 5) then
	                    self:runAI("flee_fear")
	                else
	                    self:runAI("dumb_talented_simple")
	                end
	            else
	                self:runAI("flee_dmap")
	            --    self.ai = "flee_dmap"
	            end
			end
		else

		local chance = rng.percent(50)
				if chance then
					if not self.energy.used then
						if self.ai_target.actor then
			            	local tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
			                if self:isNear(tx, ty, 5) then
			                    self:runAI("flee_fear")
			                else
			                    self:runAI("dumb_talented_simple")
			                end
			            else
			                self:runAI("flee_dmap")
			            --    self.ai = "flee_dmap"
			            end
					end
				end
		end
	end

	-- Ranged (based on DataQueen)
	if self.ranged and self:isNear(game.player.x, game.player.y, 10) then
        self:runAI("flee_dmap")
	--	self.ai = "flee_dmap"
	else
        self:runAI("dumb_talented_simple")
	--	self.ai = "dumb_talented_simple"
	end

--    self:runAI("dumb_talented_simple")
end)

newAI("pickup_items", function(self)
    if self:getInven(self.INVEN_INVEN) then
    	if not self:isThreatened() and self:getObjectonFloor(self.x, self.y) then
        	self:pickupObject(self.x, self.y)
    	end
    end
end)

newAI("swap_weapons", function(self)
    if self:getInven(self.INVEN_INVEN) then
        if self.ai_target.actor then
            local tx, ty = self:aiSeeTargetPos(self.ai_target.actor)
            if self:isNear(tx, ty, 3) then
                if self:getInven("MAIN_HAND") then
                    local weapon = self:getInven("MAIN_HAND")[1]
                --[[    if not self:getInven("MAIN_HAND")[1] then
                        game.log("Trying to wield melee weapon")
                        self:wieldMelee()
                    end]]
                    if weapon and weapon.ranged then
                        game.log("Trying to wield melee weapon")
                        self:wieldMelee()
                    end
                end
            else
                if self:getInven("QUIVER") and self:getInven("MAIN_HAND") then
                    local weapon = self:getInven("MAIN_HAND")[1]
                    if weapon and not weapon.ranged then
                        game.log("Trying to wield ranged weapon")
                        self:wieldRanged()
                    end
                end
            end
        end
    end
end)


--NOTE: three AI levels corresponding to Intelligence
--"humanoid_level" is humanoid and Int 3+
--"animal_level" is Int <3; human_level Int >3 but not humanoid;

newAI("animal_level", function(self)
    self:runAI("flee_if_wounded")
end)

newAI("human_level", function(self)
    self:runAI("flee_if_wounded")
end)

newAI("humanoid_level", function(self)
    self:runAI("pickup_items")

    self:runAI("swap_weapons")

    self:runAI("flee_if_wounded")
end)
