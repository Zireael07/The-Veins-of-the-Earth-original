--Veins of the Earth
--Zireael 2013-2015

--TO DO: Implement tooltips using mousezones

require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local ImageList = require "engine.ui.ImageList"
local Player = require "mod.class.Player"
local UI = require "engine.ui.Base"
local Tabs = require "engine.ui.Tabs"
local TextzoneList = require "engine.ui.TextzoneList"
local Textzone = require "engine.ui.Textzone"
local Separator = require "engine.ui.Separator"
local List = require "engine.ui.List"
local Image = require "engine.ui.Image"
local Tab = require 'engine.ui.Tab'

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
	self.actor = actor

	self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
	Dialog.init(self, "Spellbook: "..self.actor.name, math.max(game.w * 0.8, 700), math.max(game.h*0.6, 500), nil, nil, font)

	self:generateSpell()

	local types = {}
	if self.actor:casterLevel("arcane") > 0 and not self.actor.classes["Sorcerer"] then
		types[#types+1]= {title="Arcane", kind="arcane"}
	end
	if self.actor:casterLevel("divine") > 0 and not self.actor.classes["Shaman"] then
		types[#types+1] = {title="Divine", kind="divine"}
	end

	--48+5 = 53 is the space one spell takes up; use multiplies of 53 to avoid spells/charges misalignment
	local wide = 530

	self.c_tabs = Tabs.new{width=wide, tabs=types, on_change=function(kind) self:switchTo(kind) end}

	--Needs a safeguard for a case when you do not know any spells for some reason
	self.spells = {}
	for i=1, 9 do
		self.spells[i] = ImageList.new{width=wide, height=300, tile_w=48, tile_h=48, padding=5, force_size=true, selection="simple", list=self.list[i], --scrollbar = true,
			fct=function(item, button) self:onSpell(item, button) end,
--            on_select=function(item,sel) self:on_select(item) end,
		}
	end


	self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}
	self.c_decline = Button.new{text="Decline",fct=function() self:onEnd("decline") end}
	self.c_reset = Button.new{text="Reset", fct=function() self:onReset() end}

	self.c_level = Textzone.new{width=self.iw, auto_height=true, text = ""}
	self.c_charges = SurfaceZone.new{width=wide, height=500, alpha=1.0}

	--Spell info stuff
	self.c_spell = List.new{width=200, nb_items=#self.list_spellsinfo, height = self.ih*0.8, list=self.list_spellsinfo, all_clicks=true,
		select=function(item, sel) self:on_select(item, sel) end,
		fct=function(item, sel, button) self:onSpell(item, button) end,
		scrollbar=true}
	self.c_info = TextzoneList.new{ scrollbar = true, width=200, height = self.ih }


	--Tabsception!
	self.t_levelone = Tab.new {
    title = 'Level 1',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchLevels('levelone') end end,
  }

	self.t_leveltwo = Tab.new {
    title = 'Level 2',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchLevels('leveltwo') end end,
  }
  self.t_levelthree = Tab.new {
  title = 'Level 3',
  default = true,
  fct = function() end,
  on_change = function(s) if s then self:switchLevels('levelthree') end end,
}
    self.t_levelfour = Tab.new {
    title = 'Level 4',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchLevels('levelfour') end end,
  }
	  self.t_levelsix = Tab.new {
	  title = 'Levels 5-6',
	  default = false,
	  fct = function() end,
	  on_change = function(s) if s then self:switchLevels('levelsix') end end,
	}

	self.t_leveleight = Tab.new {
	title = 'Levels 7-8',
	default = false,
	fct = function() end,
	on_change = function(s) if s then self:switchLevels('leveleight') end end,
  }

  self.t_levelnine = Tab.new {
  title = 'Level 9',
  default = false,
  fct = function() end,
  on_change = function(s) if s then self:switchLevels('levelnine') end end,
}


	self:generateList(types[1].kind)

	self.t_levelone:select()

	self.key:addBinds{
		EXIT = function() self:onEnd("decline") end,
	}
end

function _M:switchLevels(tab)
	self.t_levelone.selected = tab == 'levelone'
	self.t_leveltwo.selected = tab == 'leveltwo'
	self.t_levelthree.selected = tab == 'levelthree'
    self.t_levelfour.selected = tab == 'levelfour'
	self.t_levelsix.selected = tab == 'levelsix'
	self.t_leveleight.selected = tab == 'leveleight'
	self.t_levelnine.selected = tab == 'levelnine'

    self:drawDialog(tab)
end

function _M:drawDialog(tab)
	local draw_start = self.c_tabs.h + self.t_levelone.h + 25

	if tab == "levelone" then
		self:loadUI{
	       	{left=0, top=0, ui=self.c_tabs},
			{left=0, bottom=0, ui=self.c_accept},
			{left=self.c_accept, bottom=0, ui=self.c_decline},
			{right=0, bottom=0, ui=self.c_reset},
			{top=self.c_tabs, ui=self.t_levelone},
			{left=self.t_levelone, top=self.c_tabs, ui=self.t_leveltwo},
		--	{left=self.t_leveltwo, top=self.c_tabs, ui=self.t_levelfour},
			{top=self.t_leveltwo, ui=self.c_level},
			{top=draw_start, ui=self.spells[1]},
			{top=draw_start, ui=self.c_charges},
			{left=self.c_charges.w + 150, top=0, ui=self.c_spell},
			{left=self.c_charges.w + 150 + self.c_spell.w, top=70, ui=self.c_info},
	    }

	    self:setupUI()
	    self:drawGeneral(tab)
	    end

    if tab == "leveltwo" then

    self:loadUI{
       	{left=0, top=0, ui=self.c_tabs},
		{left=0, bottom=0, ui=self.c_accept},
		{left=self.c_accept, bottom=0, ui=self.c_decline},
		{right=0, bottom=0, ui=self.c_reset},
	--	{top=self.c_tabs, ui=self.c_spelllevels},
		{top=self.c_tabs, ui=self.t_levelone},
		{left=self.t_levelone, top=self.c_tabs, ui=self.t_leveltwo},
	--	{left=self.t_leveltwo, top=self.c_tabs, ui=self.t_levelfour},
		{top=self.t_leveltwo, ui=self.c_level},
		{top=draw_start, ui=self.spells[2]},
		{top=draw_start, ui=self.c_charges},
		{left=self.c_charges.w + 150, top=0, ui=self.c_spell},
		{left=self.c_charges.w + 150 + self.c_spell.w, top=70, ui=self.c_info},
    }

    self:setupUI()
    self:drawGeneral(tab)
    end

	if tab == "levelthree" then

    self:loadUI{
       	{left=0, top=0, ui=self.c_tabs},
		{left=0, bottom=0, ui=self.c_accept},
		{left=self.c_accept, bottom=0, ui=self.c_decline},
		{right=0, bottom=0, ui=self.c_reset},
		{top=self.c_tabs, ui=self.t_levelone},
		{left=self.t_levelone, top=self.c_tabs, ui=self.t_leveltwo},
		{left=self.t_levelwo, top=self.c_tabs, ui=self.t_levelthree},
		{top=self.t_leveltwo, ui=self.c_level},
		{top=draw_start, ui=self.spells[3]},
		{top=draw_start, ui=self.c_charges},
		{left=self.c_charges.w + 150, top=0, ui=self.c_spell},
		{left=self.c_charges.w + 150 + self.c_spell.w, top=70, ui=self.c_info},
    }

    self:setupUI()
    self:drawGeneral(tab)
    end

    if tab == "levelfour" then

    self:loadUI{
       	{left=0, top=0, ui=self.c_tabs},
		{left=0, bottom=0, ui=self.c_accept},
		{left=self.c_accept, bottom=0, ui=self.c_decline},
		{right=0, bottom=0, ui=self.c_reset},
		{top=self.c_tabs, ui=self.t_leveltwo},
		{top=self.t_leveltwo, ui=self.c_level},
		{top=draw_start, ui=self.spells[4]},
		{top=draw_start, ui=self.c_charges},
		{left=self.c_charges.w + 150, top=0, ui=self.c_spell},
		{left=self.c_charges.w + 150 + self.c_spell.w, top=70, ui=self.c_info},
    }

    self:setupUI()
    self:drawGeneral(tab)
    end

end

local tabs_to_numbers = {
	levelone = 1,
	leveltwo = 2,
	levelthree = 3,
	levelfour = 4,
}

local numbers_to_tabs = {
--	table.keys_to_values[tabs_to_numbers]
	[1] = "levelone",
	[2] = "leveltwo",
	[3] = "levelthree",
	[4] = "levelfour",
}

function _M:drawGeneral(tab)
	self:generateCharges(tab)

	local i = tabs_to_numbers[tab]
	self.spells[i]:generate()

	self.changed = false
end

function _M:switchTo(kind)
	self.spell_list = kind
	self:generateList(kind)
	self.arcane = kind
end

function _M:onSpell(item, button)
	local v = 1
	if button == "right" then
		v = -1
	end
	local p = game.player
	if item then
		p:incMaxCharges(item.data, v, self.spell_list)
--        self.c_info.text = item.desc
	end

	local spell_level = item.data.level
	self:generateCharges(numbers_to_tabs[spell_level])
--	self:drawGeneral("levelone")
end

function _M:onReset()
	local p = game.player
	p:allocatedChargesReset()
	self:drawGeneral("leveltwo")
end

function _M:generateList(kind)
	local player = game.player
	local list = {}
	for i = 1, 9 do
		list[i] = {}
	end

	for tid, _ in pairs(player.talents) do
		local t = player:getTalentFromId(tid)
		if t.is_spell and t.spell_kind and t.show_in_spellbook and t.spell_kind[kind] then
			local slist = list[t.level]
			table.insert(list[t.level], t)
			end
	end

	if self.spells then
		for i = 1, 9 do
			table.sort(list[i], "name")
			self.spells[i].list = list[i]
		end
		self:drawDialog()
	end
	self.list = list
end

function _M:generateCharges(tab)
	local c = self.c_charges.s
	c:erase(0,0,0,0)
	--local frame = UI:makeFrame("ui/icon-frame/frame", 48, 48)

	local x = self.spells[1].x
	local y = self.spells[1].y
	--s:drawFrame(300, 300, 1,1,1,1)

--[[	if self.spell_frame and false then
		local i_frame = UI:makeFrame("ui/icon-frame/frame",64,64)
		local x = self.spell_frame[1] or 50
		local y = self.spell_frame[2] or 50
		s:drawFrame(i_frame, x, y, 1,1,1, 1)
	end]]


	local max_charges = game.player:getMaxMaxCharges()

	local w = 0
	local h = 0

	local font_spells = core.display.newFont("/data/font/DroidSans-Bold.ttf", 16)

	for i, v in ipairs(self.list) do

		if not max_charges[i] then
			break
		end

		--Account for other tabs
		if (tab == "levelone" and i == 1) or (tab == "leveltwo" and i == 2) or (tab == "levelthree" and i == 3) or (tab == "levelfour" and i == 4) then

		local charges_used = game.player:getAllocatedCharges(self.spell_list, i) --TODO: Fix this function (getAllocatedCharges)
		local str = "Level-"..i.." Spells "..(charges_used or 0).."/"..(max_charges[i] or 0)
		self.c_level.text = str


		local ww = w
		local hh = h --+ 10
		for _, t in pairs(v) do
			local p = game.player
			local num = p:getCharges(t) or 0
			local max = p:getMaxCharges(t) or 0
			local str = "#STEEL_BLUE#"..num.."#LIGHT_STEEL_BLUE#".."/".."#STEEL_BLUE#"..max
			c:drawColorString(font_spells, str, ww, hh, 255, 255, 255, true)
			ww = ww + self.spells[i].tile_w + self.spells[i].padding

			--start drawing in the next line if spells wrap over
			--530 -> wide
			if ww >= 530 then
				ww = w
				hh = hh + self.spells[i].tile_h + self.spells[i].padding
			end
		end
		--height to start drawing a new level
	--	h = h + 140

		end
	end

	self.c_level:generate()
	self.c_charges:generate()
end

--Spell info stuff
function _M:generateSpell()
	local player = game.player
	local list = {}
	  for tid, _ in pairs(player.talents_def) do
		local t = player:getTalentFromId(tid)
		if player:knowTalent(t) and t.is_spell and t.spell_kind and t.show_in_spellbook then
	  		--TO DO: get rid of duplicates
			local color
			if player:knowTalent(t) then color = {255,255,255}
			else color = {0, 187, 187} end
			local d = "#GOLD#"..t.name.."#LAST#\n"
			--show school
			local tt = player:getTalentTypeFrom(t.type[1])
			d = d.."#CHOCOLATE#"..tt.name.."#LAST#\n"
			d = d..t.info(player,t)
			list[#list+1] = {name=t.name, color = color, desc=d, data=t, image=t.image }
		end
	end
	self.list_spellsinfo = list
	table.sort(self.list_spellsinfo, function (a,b) return a.name < b.name end)
end

function _M:on_select(item, sel)
	if self.c_info then self.c_info:switchItem(item, item.desc) end
	self.selection = sel

	--Taken from ToME 4's show lore
	if item.image then
		if type(item.image) == "string" then
			self.image = Image.new{file=item.image, auto_width=true, auto_height=true}
			local r = self.image.w / self.image.h
			self.image.w = 64
			self.image.h = 64
			item.image = self.image
		else
			self.image = item.image
		end
	else
		self.image = nil
	end
end

--[[function _M:on_select(item)
	print("on select reached! description", item)
	if item then self.c_info:switchItem(item, item.desc) end
--    if item then self.c_info.text = item.desc end
	self.selection = sel
end]]

--From ToME 4's Show Lore
function _M:innerDisplay(x, y, nb_keyframes)
	if self.image then
		self.image:display(x + self.iw - self.image.w*2, y + 5)
	end
end

function _M:onEnd(result)
	game:unregisterDialog(self)
end
