newAI("ally", function(self)
	-- If we are a summoned ally, handle summon time
	if self.summon_time then 
		self.summon_time = self.summon_time - 1
		if self.summon_time <= 0 then
			self:die()
		end
	end

	if not self:runAI("target_simple") then
		self:setTarget(self.summoner)
	end

	return self:runAI("dumb_talented_simple")
end)