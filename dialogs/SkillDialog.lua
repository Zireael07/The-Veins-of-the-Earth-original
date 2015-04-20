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
	self.player = actor
	self.actor = actor
    self.actor_dup = actor:clone()
	Dialog.init(self, "Skills", game.w*0.5, game.h*0.6)
	self:generateList()

	self.c_points = Textzone.new{width=self.iw, auto_height=true, text = "Available skill points: #GOLD#"..self.player.skill_point.. " #LAST#Max skill ranks: #GOLD#"..self.player.max_skill_ranks.."\n#LAST#Only skill ranks are displayed.\n Skills in blue are cross-class skills."}
	self.c_list = List.new{width=self.iw/2, height=self.ih-self.c_points.h - 10, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}
	self.c_desc = TextzoneList.new{width=self.iw/2-20, height = 400, text="Hello from description"}

	self:loadUI{
		{left=0, top=0, ui = self.c_points},
		{left=0, top=self.c_points.h + 5, ui=self.c_list},
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
	--check that we don't get negative values AFTER deducting a point
	if (self.player.skill_point or 0) -1 >= 0 then

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

    for i, s in ipairs(ActorSkills.skill_defs) do
        local skill = s.id
    	local value = self.player:attr("skill_"..skill)
 		local color = {255, 255, 255}

        local d = "#CHOCOLATE#"..s.name:capitalize().."#LAST#\n\n"

        d = d.."#TAN#Uses stat:#LAST##SANTIQUE_WHITE# "..s.stat:capitalize().."#LAST#\n\n"..s.desc.."\n#WHITE#"
        if s.rogue_only then
            d = d.."#STEEL_BLUE#Rogues only!#LAST#"
        end

        if self.player:crossClass(skill) then
            --show value in gold if it's maxed out
            if (self.player:attr("skill_"..skill) or 0) == self.player.cross_class_ranks then
                name = "#SLATE#(#LAST##GOLD#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..s.name:capitalize()
            else
                name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST##LIGHT_BLUE#"..s.name:capitalize()
            end
        else
            --show value in gold if it's maxed out
            if (self.player:attr("skill_"..skill) or 0) == self.player.max_skill_ranks then
                name = "#SLATE#(#LAST##GOLD#"..(value or 0).."#LAST##SLATE#) #LAST#"..s.name:capitalize()
            else
                name = "#SLATE#(#LAST##ORANGE#"..(value or 0).."#LAST##SLATE#) #LAST#"..s.name:capitalize()
            end
        end
        	list[#list+1] = {name=name, skill = skill, color = color, desc=d}
    end
    self.list = list
    table.sort(list, function(a,b) return a.skill < b.skill end)
end
