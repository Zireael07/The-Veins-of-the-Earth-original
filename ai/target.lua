--From Startide
-- Find an hostile target
-- this requires the ActorFOV interface, or an interface that provides self.fov.actors*
-- This overrides the engine default target_simple to account for lite, infravision, ...
newAI("target_simple", function(self)
	if not self.x then return end
	if self.ai_target.actor and not self.ai_target.actor.dead and game.level:hasEntity(self.ai_target.actor) and rng.percent(90) and not self.ai_target.actor:attr("invulnerable") then return true end

	-- Find closer enemy and target it
	-- Get list of actors ordered by distance
	local arr = self.fov.actors_dist
	local act
	local sqsense = math.max(self.lite or 0, self.infravision or 0)
	sqsense = sqsense * sqsense
	for i = 1, #arr do
		act = self.fov.actors_dist[i]
--		print("AI looking for target", self.uid, self.name, "::", act.uid, act.name, self.fov.actors[act].sqdist)
		-- find the closest enemy
		if act and self:reactionToward(act) < 0 and not act.dead and act.x and game.level.map:isBound(act.x, act.y) and
			(
				-- If it has lite we can always see it
				((act.lite or 0) > 0)
				or
				-- Otherwise check if we can see it with our "senses"
				(self:canSee(act) and (self.fov.actors[act].sqdist <= sqsense) or game.level.map.lites(act.x, act.y))
			) and not act:attr("invulnerable") then

			self:setTarget(act)
			self:check("on_acquire_target", act)
			act:check("on_targeted", self)
			print("AI took for target", self.uid, self.name, "::", act.uid, act.name, self.fov.actors[act].sqdist, "<", sqsense)
			return true
		end
	end
end)

-- Target the player if within sense radius
newAI("target_player_radius", function(self)
	if not game.player.x then return end
	if self.ai_target.actor and not self.ai_target.actor.dead and rng.percent(90) then return true end

	if core.fov.distance(self.x, self.y, game.player.x, game.player.y) < self.ai_state.sense_radius then
		self:setTarget(game.player)
		self:check("on_acquire_target", game.player)
		return true
	end
end)

-- Target the player if within sense radius or if in sight
newAI("target_simple_or_player_radius", function(self)
	if self:runAI("target_simple") then return true end

	if game.player.x and core.fov.distance(self.x, self.y, game.player.x, game.player.y) < self.ai_state.sense_radius then
		self:setTarget(game.player)
		return true
	end
end)

-- Special targetting for charred scar, select a normal target, if none is found go for the player
newAI("charred_scar_target", function(self)
	if self:runAI("target_simple") then return true end
	self:setTarget(game.player)
	return true
end)
