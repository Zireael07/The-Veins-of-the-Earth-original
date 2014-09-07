-- Taken from Marson's AWOL addon for ToME 4
-- Copyright (C) 2013 Marson
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


require "engine.class"
local Dialog = require "engine.ui.Dialog"
local ListColumns = require "engine.ui.ListColumns"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
--	if not config.settings.cheat then return end
	Dialog.init(self, "NPC List     Map Size: W="..game.level.map.w.." H="..game.level.map.h.."", game.w * 0.8, game.h * 0.8)
	self:generateList()
	--local name_width = math.floor(game.w * 0.8-20-100-120-100-75-50-75-50-120-130)
	--game.log("#ROYAL_BLUE#name_width %s: ", name_width)
	self.c_list = ListColumns.new{width=math.floor(self.iw - 10), height=self.ih - 10, scrollbar=true, sortable=true, columns={
		{name="UID", width={100,"fixed"}, display_prop="uid", sort="uid"},
		{name="Name", width=100, display_prop="name", sort="name"},
		{name="Unique", width={120,"fixed"}, display_prop="unique", sort="unique"},
		{name="CR", width={100, "fixed"}, display_prop="challenge", sort="challenge"},
	--	{name="Rank", width={100,"fixed"}, display_prop="rank", sort="rank"},
		{name="X", width={50,"fixed"}, display_prop="x", sort="x"},
		{name="Y", width={50,"fixed"}, display_prop="y", sort="y"},
		{name="Tile", width={100,"fixed"}, display_prop="index", sort="index"},
		{name="Type", width={120,"fixed"}, display_prop="type", sort="type"},
		{name="Allowed", width={130,"fixed"}, display_prop="allowed", sort="allowed"},
	}, list=self.list, fct=function(item) end, select=function(item, sel) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
	}
	self:setFocus(self.c_list)
	self:setupUI()
	--self:select(self.list[1])
	self.key:addBinds{
		EXIT = function() game:unregisterDialog(self) end,
	}
end


function _M:generateList()
	-- Makes up the list of NPC entities and player
	local list = {}
	local color_error = {colors.LIGHT_RED.r, colors.LIGHT_RED.g, colors.LIGHT_RED.b}
	for id, entity in pairs(game.level.entities) do
		local add_entity = false
		local color_entity = {colors.WHITE.r, colors.WHITE.g, colors.WHITE.b}
		local unique_text = ""
		if entity.__CLASSNAME == "mod.class.Player" then
			unique_text = "Player"
			color_entity = {colors.LIGHT_GREEN.r, colors.LIGHT_GREEN.g, colors.LIGHT_GREEN.b}
			add_entity = true
			entity.challenge = entity.level
		elseif entity.__CLASSNAME == "mod.class.NPC" then
			if entity.unique then
				unique_text = "Yes"
				color_entity = {colors.GOLD.r, colors.GOLD.g, colors.GOLD.b}
			end
			add_entity = true
		elseif entity.__CLASSNAME == "mod.class.PartyMember" then
			color_entity = {colors.LIGHT_BLUE.r, colors.LIGHT_BLUE.g, colors.LIGHT_BLUE.b}
			unique_text = "in Party"
			add_entity = true
			if not game.party.members[entity] then
				color_entity = color_error
				unique_text = "ex Party"
			end
		end
		if add_entity then
			local row_color = color_entity
			local tile
			local index
			if entity.x and entity.y then
				index = entity.x + entity.y * game.level.map.w
				tile = game.level.map.map[index]
			end
			local allowed = "true"
			if type(entity.x) ~= "number" or entity.x < 0 or entity.x >= game.level.map.w then
				row_color = color_error
			end
			if type(entity.y) ~= "number" or entity.y < 0 or entity.y >= game.level.map.h then
				row_color = color_error
			end
			if tile and tile[Map.TERRAIN] then
				if tile[Map.TERRAIN].does_block_move then
					if tile[Map.TERRAIN].can_pass and entity.can_pass then
						for what, check in pairs(tile[Map.TERRAIN].can_pass) do
							if entity.can_pass[what] then
								if entity.can_pass[what] <= check then
									allowed = "TERRAIN"
									row_color = color_error
								end
							else
								allowed = "TERRAIN"
								row_color = color_error
							end
						end
					else
						allowed = "TERRAIN"
						row_color = color_error
					end
				end
				if not tile[Map.ACTOR] or tile[Map.ACTOR] ~= entity then
					allowed = "NOT ON MAP"
					row_color = color_error
				end
			else
				allowed = "NO TERRAIN"
				row_color = color_error
			end
			if tile and tile[Map.OBJECT] and tile[Map.OBJECT].does_block_move then
				if tile[Map.OBJECT].can_pass and entity.can_pass then
					for what, check in pairs(tile[Map.OBJECT].can_pass) do
						if entity.can_pass[what] then
							if entity.can_pass[what] <= check then
								allowed = "OBJECT"
								row_color = color_error
							end
						else
							allowed = "OBJECT"
							row_color = color_error
						end
					end
				else
					allowed = "OBJECT"
					row_color = color_error
				end
			end
			local name = entity.name
			if entity.dead then
				name = name.." *DEAD*"
				row_color = color_error
			end
			list[#list+1] = { uid=entity.uid, name=name, unique=unique_text, challenge=entity:formatCR(), x=entity.x, y=entity.y, oldx=entity.old_x, oldy=entity.old_y, index=index, type=tile and tile[Map.TERRAIN] and tile[Map.TERRAIN].type or "INVALID", allowed=allowed, color=row_color }
		end
	end
  if #table > 0 then
    table.sort(list, function(a, b) return a.index < b.index end)
  end
	self.list = list
end