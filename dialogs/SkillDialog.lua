local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local TextzoneList = require "engine.ui.TextzoneList"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local ImageList = require "engine.ui.ImageList"
local Player = require "mod.class.Player"
local UI = require "engine.ui.Base"
local List = require "engine.ui.List"


module(..., package.seeall, class.inherit(Dialog))

local skills = {
	balance = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed for walking on dangerous terrain.',
	bluff = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Charisma#LAST#\n\nUsed when lying to NPCs.',
	climb = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Strength#LAST#\n\nUsed for climbing over chasms.',
	concentration = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Constitution#LAST#\n\nUsed when spellcasting under duress or while threatened.',
	diplomacy = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Charisma#LAST#\n\nUsed when negotiating or persuading NPCs.',
	disabledevice = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#\n\n#STEEL_BLUE#Rogues only!#LAST# Used to disable traps.',
	escapeartist = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed to avoid being entangled.',
	handleanimal = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#\n\nUsed when dealing with animals.',
	heal = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#\n\nUsed to heal yourself using a healer kit.',
	hide = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed to hide from enemies.',
	intimidate = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Charisma#LAST#\n\nUsed to frighten enemies or to intimidate others.',
	intuition = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#\n\nUsed for identifying items',
	jump = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Strength#LAST#\n\nUsed for clearing obstacles.',
	knowledge = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#\n\nUsed for various bits of lore.',
	listen = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#\n\nUsed to detect enemies from a distance.',
	movesilently = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed to hide from enemies.',
	openlock = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed to open locks.',
	pickpocket = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\n#STEEL_BLUE#Rogues only!#LAST# Used to steal from NPCs.',
	search = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#\n\nUsed to find traps. #STEEL_BLUE#Only rogues can find traps with a DC over 20.#LAST#',
	sensemotive = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#\n\nUsed to detect if someone is lying.',
	swim = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE#Strength#LAST#\n\nUsed to avoid drowning in water.',
	spellcraft = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#\n\nUsed to identify magical effects or spells being cast by others.',
	survival = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Wisdom#LAST#\n\nUsed to track, forage and to survive in the wild.',
	tumble = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed to avoid blows.',
	usemagic = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Intelligence#LAST#\n\n#STEEL_BLUE#Rogues only!#LAST# Used to manipulate magic items.',
}

function _M:init(actor)
	self.player = actor
	Dialog.init(self, "Skills", game.w*0.5, game.h*0.6)
	self:generateList()
	
	self.c_points = Textzone.new{width=self.iw, height = 50, text = "Available skill points: #GOLD#"..self.player.skill_point.. " #LAST#Max skill ranks: #GOLD#"..self.player.max_skill_ranks.."\n#LAST#Skill ranks + all modifiers (stats, armor penalty)\n are displayed."}
	self.c_list = List.new{width=self.iw/2, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end}
	self.c_desc = TextzoneList.new{width=self.iw/2-20, height = 400, text="Hello from description"}

	self:loadUI{
		{left=0, top=0, ui = self.c_points},
		{left=0, top=50, ui=self.c_list},
		{right=0, top=0, ui=self.c_desc}
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
	self:on_select(self.list[1])
end

function _M:use(item)
	if (self.player.skill_point or 0) > 0 then
		
	local skill = self.player:attr("skill_"..item.skill)
		
	--List class skills for every class 
	local c_barbarian = { balance = "no", bluff = "no", climb = "yes", concentration = "no", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "no", jump = "yes", knowledge = "no", listen = "yes", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "yes", tumble = "no", usemagic = "no" }
	local c_bard = { balance = "yes", bluff = "yes", climb = "yes", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "no", pickpocket = "yes", search = "no", sensemotive = "yes", spot = "no", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "yes", usemagic = "yes" }
	local c_cleric = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "no", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	local c_druid = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "yes", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "yes", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "no", spot = "yes", swim = "yes", spellcraft = "yes", survival = "yes", tumble = "no", usemagic = "no" }
	local c_fighter = { balance = "no", bluff = "no", climb = "yes", concentration = "no", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "no", hide = "no", intimidate = "yes", intuition = "no", jump = "yes", knowledge = "no", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "no", spot = "no", swim = "yes", spellcraft = "no", survival = "no", tumble = "no", usemagic = "no" }
	local c_ranger = { balance = "no", bluff = "no", climb = "yes", concentration = "yes", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "yes", heal = "yes", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "no", pickpocket = "no", search = "yes", sensemotive = "no", spot = "yes", swim = "yes", spellcraft = "no", survival = "yes", tumble = "no", usemagic = "no" }
	local c_rogue = { balance = "yes", bluff = "yes", climb = "yes", concentration = "no", diplomacy = "yes", disabledevice = "yes", escapeartist = "yes", handleanimal = "no", heal = "no", hide = "yes", intimidate = "no", intuition = "yes", jump = "yes", knowledge = "yes", listen = "yes", movesilently = "yes", openlock = "yes", pickpocket = "yes", search = "yes", sensemotive = "yes", spot = "yes", swim = "no", spellcraft = "no", survival = "no", tumble = "yes", usemagic = "yes" }
	local c_sorcerer = { balance = "no", bluff = "yes", climb = "no", concentration = "yes", diplomacy = "yes", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	local c_wizard = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	local c_warlock = { balance = "no", bluff = "no", climb = "no", concentration = "yes", diplomacy = "no", disabledevice = "no", escapeartist = "no", handleanimal = "no", heal = "no", hide = "no", intimidate = "no", intuition = "yes", jump = "no", knowledge = "yes", listen = "no", movesilently = "no", openlock = "no", pickpocket = "no", search = "no", sensemotive = "yes", spot = "no", swim = "no", spellcraft = "yes", survival = "no", tumble = "no", usemagic = "no" }
	
	--Cross class skills
	if self.classes and self.classes["Barbarian"] then if c_barbarian[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
	
	elseif self.classes and self.classes["Bard"] then if c_bard[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		
	
	
	elseif self.classes and self.classes["Cleric"] then if c_cleric[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		
	elseif self.classes and self.classes["Druid"] then if c_druid[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
	
	elseif self.classes and self.classes["Fighter"] then if c_fighter[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
	
	elseif self.classes and self.classes["Rogue"] then if c_rogue[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		
	elseif self.classes and self.classes["Sorcerer"] then if c_sorcerer[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		
	elseif self.classes and self.classes["Wizard"] then if c_wizard[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		
	elseif self.classes and self.classes["Warlock"] then if c_warlock[skill] == "no" and (self.player:attr("skill_"..item.skill) or 0)  <= self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		
		
	--Class skills	
	else (self.player:attr("skill_"..item.skill) or 0) <= self.player.max_skill_ranks then

		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
	end
	end
end

function _M:on_select(item,sel)
	--if item.info then self.c_desc.text = item.info end
	--if item.name and self.c_desc then self.c_desc.text = item.name end
	if self.c_desc then self.c_desc:switchItem(item, item.desc) end
	self.selection = sel	
end

function _M:update()
	local sel = self.selection
	self:generateList() -- Slow! Should just update the one changed and sort again
	self.c_points.text = "Available skill points: #GOLD#"..self.player.skill_point.." #LAST#Max skill ranks: #GOLD#"..self.player.max_skill_ranks.."\n#LAST#Skill ranks + all modifiers (stats, armor penalty)\n are displayed."
	self.c_points:generate()
	self.c_list.list = self.list
	self.c_list:generate()
	if sel then self.c_list:select(sel) end
end

function _M:generateList()
	local player = game.player
    local list = {}
    for skill, description in pairs(skills) do
    	local value = player:getSkill(skill)
 		local color = {255, 255, 255}
 		local d = "#CHOCOLATE#"..skill:capitalize().."#LAST#\n\n"
 		d = d..description.."\n#WHITE#"
        list[#list+1] = {name="#SLATE#(#LAST##AQUAMARINE#"..(value or 0).."#LAST##SLATE#) #LAST#"..skill:capitalize(), skill = skill,	 color = color, desc=d}
    end
    self.list = list
    table.sort(list, function(a,b) return a.skill < b.skill end)
end	
