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
		slow = self:addTemporaryValue("movement_speed_bonus", -0.50),
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
	self:removeTemporaryValue("slow", p.slow)
	if p.infra then self:removeTemporaryValue("infravision", p.infra) end
	
	self:resetCanSeeCacheOf()
	return true
	end,
	info = function(self, t)
		return "Hides in shadows"
	end,
}