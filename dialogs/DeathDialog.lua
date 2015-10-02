-- Veins of the Earth
-- Zireael 2013-2015
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
local Textzone = require "engine.ui.Textzone"
local Separator = require "engine.ui.Separator"
local List = require "engine.ui.List"
local Savefile = require "engine.Savefile"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	self.actor = actor
--	self.ui = "deathbox"
	self.ui = "tombstone"

	Dialog.init(self, "Death!", 600, 300)

	self:generateList()

	self.text = ([[%s the %s %s

%s]]):format(actor.name, actor.descriptor.race, actor.descriptor.subclass,
	game.calendar:getTimeDate(game.turn)
	)

	self.c_stat = Textzone.new{width=self.iw, auto_height=true, text=self.text}

	self.c_desc = Textzone.new{width=self.iw, auto_height=true, text=[[You have #LIGHT_RED#died#LAST#!
Death in #SANDY_BROWN#the Veins of the Earth#LAST# is usually permanent.
Luckily, you can review your character sheet and try once again to survive in the wilds!
]]}
	self.c_list = List.new{width=self.iw, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_stat},
		{left=5, top=self.c_stat.h, padding_h=10, ui=Separator.new{dir="vertical", size=self.iw - 10}},
		{left=0, top=self.c_stat.h+10, ui=self.c_desc},
		{left=5, top=self.c_stat.h + 10 + self.c_desc.h, padding_h=10, ui=Separator.new{dir="vertical", size=self.iw - 10}},
		{left=0, bottom=0, ui=self.c_list},
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)
end

--- Clean the actor from debuffs/buffs
function _M:cleanActor()
	local effs = {}

	-- Go through all spell effects
	for eff_id, p in pairs(self.actor.tmp) do

		local e = self.actor.tempeffect_def[eff_id]
		effs[#effs+1] = {"effect", eff_id}
	end

	-- Go through all sustained spells
	for tid, act in pairs(self.actor.sustain_talents) do
		if act then
			effs[#effs+1] = {"talent", tid}
		end
	end

	while #effs > 0 do
		local eff = rng.tableRemove(effs)

		if eff[1] == "effect" then
			self.actor:removeEffect(eff[2])
		else
			local old = self.actor.energy.value
			self.actor:useTalent(eff[2])
			-- Prevent using energy
			self.actor.energy.value = old
		end
	end
end

--- Restore resources
function _M:restoreResources()
	self.actor.life = self.actor.max_life
	if self.actor.mana then
		self.actor.mana = self.actor.max_mana
	end
	self.actor.power = self.actor.max_power
	--restore wounds
	self.actor.wounds = self.actor.max_wounds
	self.actor.energy.value = game.energy_to_act
end

--- Basic resurrection
function _M:resurrectBasic()
	self.actor.dead = false
	self.actor.died = (self.actor.died or 0) + 1

	if self.actor.encumbered then
		self.actor:removeEffect(EFF_ENCUMBERED, true)
	end

	local x, y = util.findFreeGrid(self.actor.x, self.actor.y, 20, true, {[Map.ACTOR]=true})
	if not x then x, y = self.actor.x, self.actor.y end
	self.actor.x, self.actor.y = nil, nil

	self.actor:move(x, y, true)
	game.level:addEntity(self.actor)
	game:unregisterDialog(self)
	game.level.map:redisplay()
end

function _M:placeNew(actor)
	local x, y = util.findFreeGrid(self.actor.x, self.actor.y, 20, true, {[Map.ACTOR]=true})
	if not x then x, y = self.actor.x, self.actor.y end
	self.actor.x, self.actor.y = nil, nil

	actor:move(x, y, true)
	game.level:addEntity(actor)
	game.level.map:redisplay()
end

function _M:use(item)
	if not item then return end
	local act = item.action

	if act == "exit" then
		local save = Savefile.new(game.save_name)
	--	save:delete()
		save:close()
		util.showMainMenu()
	elseif act == "dump" then
		game:registerDialog(require("mod.dialogs.CharacterSheet").new(self.actor))
	elseif act == "log" then
		game:registerDialog(require("mod.dialogs.ShowChatLog").new("Message Log", 0.6, game.uiset.logdisplay, profile.chat))
	elseif act:find("^kid") then
		local actor = item.actor

		game:unregisterDialog(self)
		self:placeNew(actor)
		game.player:kidTakeover(actor)
	elseif act == "self-resurrect" then
		game.logPlayer(self.actor, "#LIGHT_RED#You use your resurrection crystal to come back to life!")
		self:cleanActor()
		self:restoreResources()
		self:resurrectBasic()
		--should only happen once per week
		--remove the crystal
		local crystal_o, crystal_item, crystal_inven_id = self.actor:findInAllInventories("resurrection diamond")

		self.actor:removeObject(crystal_inven_id, crystal_item)

	elseif act == "cheat" then
		game.logPlayer(self.actor, "#LIGHT_BLUE#You resurrect! CHEATER !")

		self:cleanActor()
		self:restoreResources()
		self:resurrectBasic()
	end
end

function _M:generateList()
	local list = {}

	-- Pause the game
	game:onTickEnd(function()
		game.paused = true
		game.player.energy.value = game.energy_to_act
	end)

	--keep playing
	if self.actor.kids and self.actor:hasKids() then
		for i, e in ipairs(self.actor.kids) do
			list[#list+1] = {name= "#GOLD#Take over as ".. e.name.." the "..e.alignment.." "..e.subtype.." STR "..e:getStr().." DEX "..e:getDex().." CON "..e:getCon().." INT "..e:getInt().." WIS "..e:getWis().." CHA "..e:getCha().." LUC "..e:getLuc().."#WHITE#",
			 action="kid "..e.name, actor = e }
		end
	end

	if self.actor:findInAllInventories("resurrection diamond") then
		list[#list+1] = {name="#LIGHT_RED#Use a resurrection diamond#WHITE#", action="self-resurrect"}
	end
	list[#list+1] = {name="#LIGHT_BLUE#Resurrect by cheating#WHITE#", action="cheat"}
	--normal stuff
	list[#list+1] = {name=(not profile.auth and "Message Log" or "Message/Chat log (allows to talk)"), action="log"}
	list[#list+1] = {name="Character dump", action="dump"}
	list[#list+1] = {name="Exit to main menu", action="exit"}

	self.list = list
end
