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

--Taken from ToME 4
local function restore(dest, backup)
    local bx, by = dest.x, dest.y
    backup.replacedWith = false
    dest:replaceWith(backup)
    dest.replacedWith = nil
    dest.x, dest.y = bx, by
    dest.changed = true
    dest:removeAllMOs()
    if game.level and dest.x then game.level.map:updateMap(dest.x, dest.y) end
end

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
	ride = '#TAN#Uses stat:#LAST##SANTIQUE_WHITE# Dexterity#LAST#\n\nUsed to ride mounts.',
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
	self.actor = actor
    self.actor_dup = actor:clone()
	Dialog.init(self, "Skills", game.w*0.5, game.h*0.6)
	self:generateList()
	
	self.c_points = Textzone.new{width=self.iw, height = 50, text = "Available skill points: #GOLD#"..self.player.skill_point.. " #LAST#Max skill ranks: #GOLD#"..self.player.max_skill_ranks.."\n#LAST#Only skill ranks are displayed.\n Skills in blue are cross-class skills."}
	self.c_list = List.new{width=self.iw/2, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end}
	self.c_desc = TextzoneList.new{width=self.iw/2-20, height = 400, text="Hello from description"}

	self:loadUI{
		{left=0, top=0, ui = self.c_points},
		{left=0, top=50, ui=self.c_list},
		{right=0, top=0, ui=self.c_desc}
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

--	self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
	--Taken from ToME 4
    self.key:addBinds{
        EXIT = function()
            if self.actor.skill_point~=self.actor_dup.skill_point then
                self:yesnocancelPopup("Finish","Do you accept changes?", function(yes, cancel)
                if cancel then
                    return nil
                else
                    if yes then ok = true else ok = true self:cancel() end
                end
                if ok then
                    game:unregisterDialog(self)
                    self.actor_dup = {}
                    if self.on_finish then self.on_finish() end
                end
                end)
            else
                game:unregisterDialog(self)
                self.actor_dup = {}
                if self.on_finish then self.on_finish() end
            end
        end,
    }

	self:on_select(self.list[1])
end

function _M:cancel()
    restore(self.actor, self.actor_dup)
end

function _M:use(item)
	if (self.player.skill_point or 0) > 0 then
		
	--Cross class skills
	if self.player:crossClass(item.skill) then
		if (self.player:attr("skill_"..item.skill) or 0) < self.player.cross_class_ranks then
		
		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		end
	else

	--Class skills	
	if (self.player:attr("skill_"..item.skill) or 0) < self.player.max_skill_ranks then

		--increase the skill by one
		self.player:attr("skill_"..item.skill, 1)

		self.player.skill_point = self.player.skill_point - 1
		self:update()
		end
	end
	end
end

function _M:on_select(item,sel)
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
    	local value = self.player:attr("skill_"..skill)
 		local color = {255, 255, 255}

 		local d = "#CHOCOLATE#"..skill:capitalize().."#LAST#\n\n"
 		d = d..description.."\n#WHITE#"
        if self.player:crossClass(skill) then name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..skill:capitalize()	
        else name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST#"..skill:capitalize()	
        end
        	list[#list+1] = {name=name, skill = skill,	 color = color, desc=d}
    end
    self.list = list
    table.sort(list, function(a,b) return a.skill < b.skill end)
end	
