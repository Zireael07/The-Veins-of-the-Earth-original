-- Veins of the Earth
-- Copyright (C) 2013 Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even th+e implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.


require "engine.class"

local Birther = require "engine.Birther"

local Dialog = require "engine.ui.Dialog"
local ListColumns = require "engine.ui.ListColumns"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"
local Button = require "engine.ui.Button"

--local LevelupTalentsDialog = require "mod.dialogs.LevelupTalentsDialog"

module(..., package.seeall, class.inherit(Dialog))

local _points_text = "Points left: #00FF00#%d#WHITE#"


-- Based on ToME's SentientWeapon.lua
function _M:init(actor, on_finish)
	self.actor = actor
	self.actor_dup = self.actor:clone()
	self.unused_stats = self.unused_stats or 32
	Dialog.init(self, "Point Buy", 500, 300)

	self.sel = 1

	self.c_tut = Textzone.new{width=math.floor(self.iw / 2 - 10), auto_height=true, no_color_bleed=true, text=[[
Keyboard: #00FF00#up key/down key#FFFFFF# to select a stat; #00FF00#right key#FFFFFF# to increase stat; #00FF00#left key#FFFFFF# to decrease a stat.
Mouse: #00FF00#Left click#FFFFFF# to increase a stat; #00FF00#right click#FFFFFF# to decrease a stat.
Press #00FF00#Enter#FFFFFF# when done to start creating your character.
]]}
	self.c_desc = TextzoneList.new{width=math.floor(self.iw - 10), height=self.ih - self.c_tut.h - 20, no_color_bleed=true}
	self.c_points = Textzone.new{width=math.floor(self.iw - 10), auto_height=true, no_color_bleed=true, text=_points_text:format(self.unused_stats)}
	self.c_reset = Button.new{text="Reset", fct=function() self:onReset() end}
	self.c_birth = Button.new{text="Birth", fct=function() self:onBirth() end}
	
	self.c_list = ListColumns.new{width=math.floor((self.iw/2)- 10), height=self.ih - 10, all_clicks=true, columns={
		{name="Stat", width=30, display_prop="name"},
		{name="Value", width=30, display_prop="val"},
	}, list={
		{name="STR", val=self.actor:getStr(), stat_id=self.actor.STAT_STR, delta = 1},
		{name="DEX", val=self.actor:getDex(), stat_id=self.actor.STAT_DEX, delta = 1},
		{name="CON", val=self.actor:getCon(), stat_id=self.actor.STAT_CON, delta = 1},
		{name="INT", val=self.actor:getInt(), stat_id=self.actor.STAT_INT, delta = 1},
		{name="WIS", val=self.actor:getWis(), stat_id=self.actor.STAT_WIS, delta = 1},
		{name="CHA", val=self.actor:getCha(), stat_id=self.actor.STAT_CHA, delta = 1},
	}, fct=function(item, _, v)
		self:incStat(v == "left" and 1 or -1, item.stat_id)
	end, select=function(item, sel) self.sel = sel self.val = item.val self.id = item.stat_id self.delta = item.delta end}
	self:loadUI{
		{left=0, top=0, ui=self.c_birth},
		{left=self.c_birth, top=0, ui=self.c_reset},
		{left=0, top=25, ui=self.c_points},
		{left=0, top=55, ui=self.c_list},

		{hcenter=0, top=5, ui=Separator.new{dir="horizontal", size=self.ih - 10}},

		{right=0, top=self.c_tut.h + 20, ui=self.c_desc},
		{right=0, top=0, ui=self.c_tut},
	}
	self:setFocus(self.c_list)
	self:setupUI()

	self:update()

	self.key:addBinds{
		EXIT = function()
			game:unregisterDialog(self)
			game:registerDialog(require("mod.dialogs.Birther").new(game.player))
		end,
	}
end

function _M:onReset()
--[[	for i, s in ipairs(self.actor.stats_def) do
        self.actor.stats[i] = 10
    end
    self.c_list:generate()]]
    game:unregisterDialog(self)
	game:registerDialog(require("mod.dialogs.Birther").new(game.player))
end

function _M:onBirth()
	self.creating_player = true
    local birth = Birther.new(nil, self.actor, {"base", 'sex', 'race', 'class', 'alignment', 'domains', 'domains'}, function()
        game:changeLevel(1, "dungeon")
        print("[PLAYER BIRTH] resolve...")
        game.player:resolve()
        game.player:resolve(nil, true)
        game.player.energy.value = game.energy_to_act
        game.paused = true
        game.creating_player = false
        game.player:levelPassives()
        game.player.changed = true
        game.player:onBirth()
        print("[PLAYER BIRTH] resolved!")
        end)

    game:registerDialog(birth)
end

function _M:getCost(val)
	--Handle differing costs (PF style)
	-- 7 = -4; 8 = -2; 9 = -1; 10 = 0; 11 = 1; 12 = 2; 13 = 3; 14 = 5; 15 = 7; 16 = 10; 17 = 13; 18 = 17
	local costs = { -4, -2, -1, 0, 1, 2, 3, 5, 7, 10, 13, 17 }


	return costs[val-6]
end

function _M:incStat(v, id)
	print("inside incStat. self.sel is", self.sel)
	print("inside incStat. id is", self.id)
	local id = self.id
	local val = self.val

	local delta = self:getCost(val) * v

	--Limits
	if v == 1 then
		if delta > self.unused_stats then
			self:simplePopup("Not enough stat points", "You have no stat points left!")
			return
		end
		if self.unused_stats <= 0 then
			self:simplePopup("Not enough stat points", "You have no stat points left!")
			return
		end
		if self.actor.stats[id] >= 18 then
			self:simplePopup("Max stat value reached", "You cannot increase a stat above 18")
			return
		end
	else return end
--[[		if self.unused_stats >= 32 then
			self:simplePopup("Max stat points reached", "You can't have more stat points!")
			return
		end
		if self.actor.stats[id] <= 3 then
			self:simplePopup("Min stat value reached", "You cannot decrease a stat below 3")
			return
		end
	end]]

	local sel = self.sel
--	self.actor.stats[id] = self.actor.stats[id] + v

	self.actor:incStat(sel, v)
	self.unused_stats = self.unused_stats - delta
	self.c_list.list[sel].val = self.actor.stats[id]
	self.c_list:generate()
	self.c_list.sel = sel
	self.c_list:onSelect()
	self.c_points.text = _points_text:format(self.unused_stats)
	self.c_points:generate()
	self:update()
end

function _M:update()
	self.c_list.key:addBinds{
		ACCEPT = function() self.key:triggerVirtual("EXIT") end,
		MOVE_LEFT = function() self:incStat(-1) end,
		MOVE_RIGHT = function() self:incStat(1) end,
	}
end
