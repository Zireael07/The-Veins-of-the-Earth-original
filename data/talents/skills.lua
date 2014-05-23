newTalentType{ type="skill/skill", name = "skill", description = "Skills" }

newTalent{
	name = "Intuition", image = "talents/intuition.png",
	type = {"skill/skill",1},
	mode = "activated",
	points = 1,
	cooldown = 20,
	range = 0,
	action = function(self, t)
	local list = {}
	local inven = game.player:getInven("INVEN")
		i = rng.range(1, #inven)
		local o = inven[i]
			if o.identified == false then
				local check = self:skillCheck("intuition", 10)
				if check then
					o.identified = true
				end	
			else 
				game.log("You pick an item which has already been identified") end
			 return true
	end,
	info = function(self, t )
		return "Attempt to identify items in your inventory"
	end,
}


local function stealthTest(self)
    if not self.x then return nil end
    local dist = 0
    for i, act in ipairs(self.fov.actors_dist) do
        dist = core.fov.distance(self.x, self.y, act.x, act.y)
        if dist > 4 then break end
        if act ~= self and act:reactionToward(self) < 0 and not act:attr("blind") then --and (not act.fov or not act.fov.actors or act.fov.actors[self]) then
            local check1 = self:opposedCheck("hide", act, "spot")
            local check2 = self:opposedCheck("movesilently", act, "listen")

            --if check1 and check2 then return true
            if check1 then return true
            else return false end
        end
    end

    return true
end

local function canHide(self)
	if not self.x then return nil end
	for i, act in ipairs(self.fov.actors_dist) do
        dist = core.fov.distance(self.x, self.y, act.x, act.y)
        if act ~= self and act:reactionToward(self) < 0 and not act:attr("blind") then
        	if dist <= 2 then return false
        	else return true end
    	end
    end

    return true
end


newTalent{
	name = "Stealth", image = "talents/stealth.png",
	type = {"skill/skill",1},
	mode = "sustained",
	points = 1,
	cooldown = 20,
	on_pre_use = function(self, t, silent)
	if self:isTalentActive(t.id) then 
			return true end
	--[[		if stealthTest(self) then return true 
			else return nil end
		end]]

		if not self.x or not self.y or not game.level then return end
		
		if canHide(self) then return true
		else 
			if not silent then game.logPlayer(self, "You cannot hide in plain sight") end
			return nil 
		end
	end,
--[[	on_post_use = function(self, t, silent)
	if stealthTest(self) then return true
	else return nil end
	end,]]
	activate = function(self, t)
		local res = { 
		stealth_slow = self:addTemporaryValue("movement_speed_bonus", -0.50),
		stealth = self:addTemporaryValue("stealth", 1),
		lite = self:addTemporaryValue("lite", -1000),
		}
		self:resetCanSeeCacheOf()
		
		--Account for Underdark races
		if self.infravision < 3 then infra = self:addTemporaryValue("infravision", 3) end
		
		return res 
	end,
		
	deactivate = function(self, t, p)
	self:removeTemporaryValue("stealth", p.stealth)
	self:removeTemporaryValue("lite", p.lite)
	self:removeTemporaryValue("stealth_slow", p.stealth_slow)
	if p.infra then self:removeTemporaryValue("infravision", p.infra) end
	
	self:resetCanSeeCacheOf()
	return true
	end,
	info = function(self, t)
		return "Hides in shadows"
	end,
}

newTalent{
	name = "Diplomacy", image = "talents/diplomacy.png",
	type = {"skill/skill",1},
	mode = "activated",
	points = 1,
	cooldown = 20,
	range = 5,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		

		if target.type == "humanoid" then

			local check = self:skillCheck("diplomacy", 15)
			if check then --target:setPersonalReaction(game.player, 150) --makes it neutral
			target.faction = "neutral"
			--From Qi Daozei
		 	-- Reset NPCs' targets.  Otherwise, they follow the player around
        	-- like a puppy dog.
        	for uid, e in pairs(game.level.entities) do
            print(e.name)
            	if e.setTarget and e ~= game.player then
                	e:setTarget(nil)
            	end
        	end
			else game.log("The target resists your attempts to influence it") end
		else game.log("You pick a wrong target") end

		
		return true
	end,
	info = function(self, t)
		return "Talk to a sentient creature"
	end,
}

newTalent{
	name = "Animal Empathy", image = "talents/animal_empathy.png",
	type = {"skill/skill",1},
	mode = "activated",
	points = 1,
	cooldown = 20,
	range = 5,
	target = function(self, t)
		return {type="hit", range=self:getTalentRange(t), selffire=false, talent=t}
	end,
	action = function(self, t)
		local tg = self:getTalentTarget(t)
		local x, y, target = self:getTarget(tg)
		if not x or not y or not target then return nil end

		

		if target.type == "animal" then
			local check = self:skillCheck("handleanimal", 15)
			if check then --target:setPersonalReaction(game.player, 150) --makes it neutral
			target.faction = "neutral"
			--From Qi Daozei
		 -- Reset NPCs' targets.  Otherwise, they follow the player around
        	-- like a puppy dog.
        	for uid, e in pairs(game.level.entities) do
            print(e.name)
            	if e.setTarget and e ~= game.player then
                	e:setTarget(nil)
           		end
        	end

			else game.log("The target resists your attempts to influence it") end
		else game.log("You pick a wrong target") end
		
		return true
	end,
	info = function(self, t)
		return "Attempt to influence an animal"
	end,
}

newTalent{
	name = "Mount", image = "talents/mount.png",
	type = {"skill/skill",1},
	mode = "sustained",
	points = 1,
	cooldown = 0,
	on_pre_use = function(self, t, silent)
		local ride = self.skill_ride

		if ride > 0 then return true
		else 
			if not silent then
                game.log("You need at least 1 rank in Ride to use this")
            end
            return false
        end
	end,
	activate = function(self, t)
	local res = {
        mount_speed = self:addTemporaryValue("movement_speed_bonus", 0.33)
	}
        return res

	end,
	deactivate = function(self, t, p)
        self:removeTemporaryValue("movement_speed_bonus", p.mount_speed)

		return true
	end,

	info = function(self, t)
		return "Ride on your mount"
	end,
}