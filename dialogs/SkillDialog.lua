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

local ActorSkills = require "mod.class.interface.ActorSkills"


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

function _M:init(actor)
	self.actor = actor
    self.actor_dup = actor:clone()
	Dialog.init(self, "Skills", game.w*0.5, game.h*0.6)
	self:generateLists()

	self.c_points = Textzone.new{width=self.iw, auto_height=true, text = "Available skill points: #GOLD#"..self.actor.skill_point.. " #LAST# Background skill points: #GOLD#"..self.actor.background_points.." #LAST# Max skill ranks: #GOLD#"..self.actor.max_skill_ranks.."\n#LAST# Max cross class ranks: #GOLD#"..self.actor.cross_class_ranks.."\n#LAST#Only skill ranks are displayed.\n Skills in blue are cross-class skills."}
	self.c_adventure = Textzone.new{width=self.iw/3, auto_height=true, text=[[Adventuring skills]]}
    self.c_background = Textzone.new{width=self.iw/3, auto_height=true, text=[[Background skills]]}
    self.c_list = List.new{width=self.iw/3, height=self.ih-self.c_points.h - 10, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}
	self.c_list_background = List.new{width=self.iw/3, height=self.ih-self.c_points.h - 10, nb_items=#self.list_background, list=self.list_background, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}
    self.c_desc = TextzoneList.new{width=self.iw/3-20, height = self.ih-self.c_points.h - 10, text="Hello from description"}

	self:loadUI{
		{left=0, top=0, ui = self.c_points},
        {left=0, top=self.c_points.h + 5, ui=self.c_adventure},
		{left=0, top=self.c_points.h + 25, ui=self.c_list},
        {left=self.c_list.w + 5, top=self.c_points.h + 5, ui=self.c_background},
        {left=self.c_list.w + 5, top=self.c_points.h + 25, ui=self.c_list_background},
		{right=0, top=self.c_points.h + 5, ui=self.c_desc}
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
	--check that we don't get negative values AFTER deducting a point
	if (not item.background and (self.actor.skill_point or 0) -1 >= 0)
        or (item.background and (self.actor.background_points or 0) -1 >= 0)
     then

    	--Cross class skills
    	if self.actor:crossClass(item.skill) then
    		if (self.actor:attr("skill_"..item.skill) or 0) < self.actor.cross_class_ranks then

    		--increase the skill by one
    		self.actor:attr("skill_"..item.skill, 1)

                if not item.background then
        		    self.actor.skill_point = self.actor.skill_point - 1
                else
                    self.actor.background_points = self.actor.background_points - 1
                end
        		self:update()
            else
                self:simplePopup("Max skill points", "You cannot increase this skill further!")
            end
    	else

    	--Class skills
    	if (self.actor:attr("skill_"..item.skill) or 0) < self.actor.max_skill_ranks then

    		--increase the skill by one
    		self.actor:attr("skill_"..item.skill, 1)

            if not item.background then
    		    self.actor.skill_point = self.actor.skill_point - 1
            else
                self.actor.background_points = self.actor.background_points - 1
            end
    		self:update()
        else
            self:simplePopup("Max skill points", "You cannot increase this skill further!")
        end
    end
    else
        self:simplePopup("Not enough skill points", "You need a skill point!")
    end

end

function _M:on_select(item,sel)
	if self.c_desc then self.c_desc:switchItem(item, item.desc) end
	self.selection = sel
end

function _M:update()
	local sel = self.selection
	self:generateLists() -- Slow! Should just update the one changed and sort again
	self.c_points.text = "Available skill points: #GOLD#"..self.actor.skill_point.." #LAST# Background skill points: #GOLD#"..self.actor.background_points.." #LAST#Max skill ranks: #GOLD#"..self.actor.max_skill_ranks.."\n#LAST# Max cross class ranks: #GOLD#"..self.actor.cross_class_ranks.."\n#LAST#Only skill ranks are displayed.\n Skills in blue are cross-class skills."
	self.c_points:generate()
	self.c_list.list = self.list
	self.c_list:generate()
    self.c_list_background.list = self.list_background
    self.c_list_background:generate()
	if sel then self.c_list:select(sel) end
end

function _M:generateLists()
    self:generateList()
    self:generateBackgroundList()
end

function _M:generateList()
    local list = {}

    for i, s in ipairs(ActorSkills.skill_defs) do
        if not s.background then
            local skill = s.id
        	local value = self.actor:attr("skill_"..skill)
     		local color = {255, 255, 255}
            local background = s.background

            local d = "#CHOCOLATE#"..s.name:capitalize().."#LAST#\n\n"

            d = d.."#TAN#Uses stat:#LAST##SANTIQUE_WHITE# "..s.stat:capitalize().."#LAST#\n\n"..s.desc.."\n#WHITE#"
            if s.rogue_only then
                d = d.."#STEEL_BLUE#Rogues only!#LAST#"
            end

            if self.actor:crossClass(skill) then
                --show value in gold if it's maxed out
                if (self.actor:attr("skill_"..skill) or 0) >= self.actor.cross_class_ranks then
                    name = "#SLATE#(#LAST##GOLD#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..s.name:capitalize()
                else
                    name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..s.name:capitalize()
                end
            else
                --show value in gold if it's maxed out
                if (self.actor:attr("skill_"..skill) or 0) >= self.actor.max_skill_ranks then
                    name = "#SLATE#(#LAST##GOLD#"..(value or 0).."#LAST##SLATE#) #LAST#"..s.name:capitalize()
                else
                    name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST#"..s.name:capitalize()
                end
            end

        	list[#list+1] = {name=name, skill = skill, color = color, desc=d, background=background}
        end
    end

    table.sort(list, function(a,b) return a.skill < b.skill end)
    self.list = list
end

function _M:generateBackgroundList()
    local list = {}

    for i, s in ipairs(ActorSkills.skill_defs) do
        if s.background then
            local skill = s.id
        	local value = self.actor:attr("skill_"..skill)
     		local color = {255, 255, 255}
            local background = s.background

            local d = "#CHOCOLATE#"..s.name:capitalize().."#LAST#\n\n"

            d = d.."#TAN#Uses stat:#LAST##SANTIQUE_WHITE# "..s.stat:capitalize().."#LAST#\n\n"..s.desc.."\n#WHITE#"
            if s.rogue_only then
                d = d.."#STEEL_BLUE#Rogues only!#LAST#"
            end

            if self.actor:crossClass(skill) then
                --show value in gold if it's maxed out
                if (self.actor:attr("skill_"..skill) or 0) == self.actor.cross_class_ranks then
                    name = "#SLATE#(#LAST##GOLD#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..s.name:capitalize()
                else
                    name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..s.name:capitalize()
                end
            else
                --show value in gold if it's maxed out
                if (self.actor:attr("skill_"..skill) or 0) == self.actor.max_skill_ranks then
                    name = "#SLATE#(#LAST##GOLD#"..(value or 0).."#LAST##SLATE#) #LAST#"..s.name:capitalize()
                else
                    name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST#"..s.name:capitalize()
                end
            end

        	list[#list+1] = {name=name, skill = skill, color = color, desc=d, background=background}
        end
    end

    table.sort(list, function(a,b) return a.skill < b.skill end)
    self.list_background = list
end
