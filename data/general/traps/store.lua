--Veins of the Earth
--Zireael

- We do stores as "traps" to allow them to nicely overlay walls and such
newEntity{ define_as = "BASE_STORE",
	type = "store", subtype="store", identified=true,
	display = '1',
	knownBy = function() return true end,
	triggered = function() end,
	is_store = true,
	z = 18,
	_noalpha = true,
	on_added = function(self, level, x, y)
		-- Change the terrain to be passable since we are not
		game:onTickEnd(function()
			local g = level.map(x, y, engine.Map.TERRAIN)
			g = g:clone()
			g.does_block_move = false
			g.nice_tiler = nil
			level.map(x, y, engine.Map.TERRAIN, g)
		end)
	end,
}