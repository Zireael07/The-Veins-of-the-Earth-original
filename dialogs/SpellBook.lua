--Veins of the Earth
--Zireael 2013-2014

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
	if self.actor:casterLevel("arcane") > 0 then
		types[#types+1]= {title="Arcane", kind="arcane"}
	end
	if self.actor:casterLevel("divine") > 0 then
		types[#types+1] = {title="Divine", kind="divine"}
	end

    --self.iw-450 lets spell images overlap with text list
	--local wide = math.max(650, self.iw-450)
    local wide = 650

	self.c_tabs = Tabs.new{width=wide, tabs=types, on_change=function(kind) self:switchTo(kind) end}

	self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}
	self.c_decline = Button.new{text="Decline",fct=function() self:onEnd("decline") end}
	self.c_reset = Button.new{text="Reset", fct=function() self:onReset() end}

	--Needs a safeguard for a case when you do not know any spells for some reason
	self.spells = {}
	for i=1, 9 do
		self.spells[i] = ImageList.new{width=wide, height=64, tile_w=48, tile_h=48, padding=5, force_size=true, selection="simple", list=self.list[i],
			fct=function(item, button) self:onSpell(item, button) end,
--            on_select=function(item,sel) self:on_select(item) end,
		}
	end

	self.c_desc = SurfaceZone.new{width=500, height=500,alpha=1.0}
	self.c_charges = SurfaceZone.new{width=wide, height=500, alpha=1.0}

	--Spell info stuff
	self.c_spell = List.new{width=200, nb_items=#self.list_spellsinfo, height = self.ih*0.8, list=self.list_spellsinfo, all_clicks=true,
		select=function(item, sel) self:on_select(item, sel) end,
		fct=function(item, sel, button) self:onSpell(item, button) end,
		scrollbar=true}
	self.c_info = TextzoneList.new{ scrollbar = true, width=200, height = self.ih }

	--Tabsception!

	self.t_leveltwo = Tab.new {
    title = 'Levels 1-2',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchLevels('leveltwo') end end,
  }
    self.t_levelfour = Tab.new {
    title = 'Levels 3-4',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchLevels('levelfour') end end,
  }

	self:generateList(types[1].kind)

	self.t_leveltwo:select()

	self.key:addBinds{
		EXIT = function() self:onEnd("decline") end,
	}
end

function _M:switchLevels(tab)
	self.t_leveltwo.selected = tab == 'leveltwo'
    self.t_levelfour.selected = tab == 'levelfour'

    self:drawDialog(tab)
end

function _M:drawDialog(tab)

    if tab == "leveltwo" then

    self:loadUI{
       	{left=0, top=0, ui=self.c_tabs},
		{left=0, bottom=0, ui=self.c_accept},
		{left=self.c_accept, bottom=0, ui=self.c_decline},
		{right=0, bottom=0, ui=self.c_reset},
		{top=self.c_tabs, ui=self.t_leveltwo},
		{left=self.t_leveltwo, top=self.c_tabs, ui=self.t_levelfour},
		{top=self.t_leveltwo, ui=self.c_desc},
		{top=self.c_desc,ui=self.spells[1]},
		{top=self.spells[1].h+100,ui=self.spells[2]},
		{top=self.c_desc,ui=self.c_charges},
		{left=self.c_desc.w + 150, top=0, ui=self.c_spell},
		{left=self.c_desc.w + 150 + self.c_spell.w, top=70, ui=self.c_info}, 
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
		{left=self.t_leveltwo, top=self.c_tabs, ui=self.t_levelfour},
		{top=self.t_leveltwo, ui=self.c_desc},
		{top=self.c_desc,ui=self.spells[3]},
		{top=self.spells[3].h+100,ui=self.spells[4]},
		{top=self.c_desc,ui=self.c_charges},
		{left=self.c_desc.w + 150, top=0, ui=self.c_spell},
		{left=self.c_desc.w + 150 + self.c_spell.w, top=70, ui=self.c_info}, 
    }
    
    self:setupUI()
    self:drawGeneral(tab)
    end
    
end

function _M:drawGeneral(tab)
	local s = self.c_desc.s
	local c = self.c_charges.s
	s:erase(0,0,0,0)
	c:erase(0,0,0,0)
	--local frame = UI:makeFrame("ui/icon-frame/frame", 48, 48)

	local x = self.spells[1].x
	local y = self.spells[1].y
	--s:drawFrame(300, 300, 1,1,1,1)

	if self.spell_frame and false then
		local i_frame = UI:makeFrame("ui/icon-frame/frame",64,64)
		local x = self.spell_frame[1] or 50
		local y = self.spell_frame[2] or 50
		s:drawFrame(i_frame, x, y, 1,1,1, 1)
	end
	

	local max_charges = game.player:getMaxMaxCharges()

	local w = 0
	local h = 0

	local font = core.display.newFont("/data/font/DroidSans-Bold.ttf", 12)

	for i, v in ipairs(self.list) do
		--Account for first tab
		if tab == "leveltwo" then
			if i > 2 then
				break
			end
		end

		if not max_charges[i] then
			break
		end

		--Account for other tabs
		if tab == "leveltwo" or (tab == "levelfour" and i == 3 or i == 4) then

		local charges_used = game.player:getAllocatedCharges(self.spell_list, i) --TODO: Fix this function (getAllocatedCharges)
		local str = "Level-"..i.." Spells "..(charges_used or 0).."/"..(max_charges[i] or 0)
		s:drawString(self.font, str, w, h, 255, 255, 255, true)

		local ww = w
		local hh = h
		for _, t in pairs(v) do
			local p = game.player
			local num = p:getCharges(t) or 0
			local max = p:getMaxCharges(t) or 0
			local str = "#STEEL_BLUE#"..num.."#LIGHT_STEEL_BLUE#".."/".."#STEEL_BLUE#"..max
			c:drawColorString(font, str, ww, hh, 255, 255, 255, true)
			ww = ww + self.spells[i].tile_w + self.spells[i].padding 
		end  
		h = h + 110 

		end
	end

	self.c_desc:generate()
	self.c_charges:generate()
	for i=1,9 do
		self.spells[i]:generate()
	end


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
	self:drawGeneral("leveltwo")
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
			s = player:getTalentReqDesc(t.id):toString()
			d = d..s.."\n#WHITE#"
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
