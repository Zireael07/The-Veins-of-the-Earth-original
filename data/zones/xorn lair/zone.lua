-- Veins of the Earth
-- Zireael 2014
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

return {
	name = "Xorn Lair",
	level_range = {1, 1},
	max_level = 10,
--	decay = {300, 800},
	width = 80, height = 80,
	persistent = "zone",
	no_level_connectivity = true,
	no_autoexplore = true,
	generator =  {
		map = {
			class = "mod.class.generator.map.Roomer",
		--	class = "engine.generator.map.Roomer",
			no_tunnels = true,
			nb_rooms = 10,
			lite_room_chance = 0,
		--	rooms = {"simple"},
			rooms = {"forest_clearing"},
			['.'] = "FLOOR",
			['#'] = "WALL",
			up = "UP",
			down = "DOWN",
			door = "FLOOR",
		},
		actor = {
		--	class = "mod.class.generator.actor.EncounterRandom",
			class = "mod.class.generator.actor.XornTunnelers",
			nb_npc = {10, 20},
			-- Number of tunnelers + 2 (one per stair)
			nb_tunnelers = 7,
		},
		object = {
            class = "engine.generator.object.Random",
            nb_object = {20, 30},
        },
	},
	levels =
	{
	--Place exit to worldmap on level 1
		[1] = { 
		generator = { map = { 
		up = "EXIT",
		},},
	},
	--No shaft up on level 2
		[2] = { 
		generator = { map = { 
		up = "UP",
		},},
	},

	},

	post_process = function(level)
		-- Put lore near the up stairs
		game:placeRandomLoreObject("NOTE"..level.level)

		--Pick spots for xorn tunnelers
		local spots = {}
		for i, spot in ipairs(level.spots) do
			if spot.type == "room" and spot.subtype:find("^forest_clearing") then
			local _, _, w, h = spot.subtype:find("^forest_clearing([0-9]+)x([0-9]+)$")
			if w and h then spots[#spots+1] = {x=spot.x, y=spot.y, w=tonumber(w), h=tonumber(h)} end
			end
		end
		table.sort(spots, "x")
		level.ordered_spots = spots
		level.default_up = {x=spots[1].x, y=spots[1].y}
		level.default_down = {x=spots[#spots].x, y=spots[#spots].y}
	--	level.map(level.default_up.x, level.default_up.y, engine.Map.TERRAIN, game.zone.grid_list.SAND_LADDER_UP_WILDERNESS)
	--	level.map(level.default_down.x, level.default_down.y, engine.Map.TERRAIN, game.zone.grid_list.SAND_LADDER_DOWN)

		local tx, ty = util.findFreeGrid(level.default_up.x+2, level.default_up.y, 5, true, {[engine.Map.ACTOR]=true})
		if not tx then level.force_recreate = true return end
		local m = game.zone:makeEntityByName(level, "actor", "XORN_TUNNELER")
		if not m then level.force_recreate = true return end
		game.zone:addEntity(level, m, "actor", tx, ty)

	end,

	last_worm_turn = 0,
	on_turn = function(self)
		if game.turn % 100 ~= 0 or game.level.level ~= 1 then return end
		if game.level.data.last_worm_turn > game.turn - 800 then return end

--		for uid, e in pairs(game.level.entities) do if e.define_as == "SANDWORM_TUNNELER_HUGE" then return end end

		local tx, ty = util.findFreeGrid(game.level.default_up.x+2, game.level.default_up.y, 5, true, {[engine.Map.ACTOR]=true})
		if not tx then return end
		local m = game.zone:makeEntityByName(game.level, "actor", "XORN_TUNNELER")
		if not m then return end
		game.zone:addEntity(game.level, m, "actor", tx, ty)
		game.log("#OLIVE_DRAB#You feel the ground shaking from the west.")
		game.level.data.last_worm_turn = game.turn
	end,
}
