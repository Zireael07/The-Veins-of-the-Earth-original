require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local Separator = require "engine.ui.Separator"
local Tab = require 'engine.ui.Tab'
local ListColumns = require "engine.ui.ListColumns"
local List = require "engine.ui.List"
local TextzoneList = require "engine.ui.TextzoneList"
local TreeList = require "engine.ui.TreeList"

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

    self:generateClassList()
    self:generateSkillLists()
    self:generateFeatLists()
    self:generateStats()

    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)

    Dialog.init(self, "Level Up: "..self:getTitle(), math.max(game.w * 0.7, 950), game.h*0.8, nil, nil, font)

    self.c_surface = SurfaceZone.new{width=self.iw, height=self.ih*0.9,alpha=0}

    self.vs = Separator.new{dir="vertical", size=self.iw}
    self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}


    self.t_classes = Tab.new {
    title = 'Classes',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('classes') end end,
  }

  self.t_feats = Tab.new {
  title = 'Feats',
  default = true,
  fct = function() end,
  on_change = function(s) if s then self:switchTo('feats') end end,
}

    self.t_skills = Tab.new {
    title = 'Skills',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('skills') end end,
    }

    self.t_stats = Tab.new {
    title = 'Stats',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('stats') end end,
    }

    local start = self.t_feats.h+5+self.vs.h
    --Classes
    self.c_class_points = Textzone.new{width=self.iw/2, height = 50, text = "Available class points: "..actor.class_points}
    self.c_class_list = List.new{width=self.iw/2, height = self.ih*0.8, scrollbar=true, nb_items=#self.class_list, list=self.class_list, fct=function(item) self:useClass(item) end, select=function(item,sel) self:on_select(item,sel) end}
    self.c_desc = TextzoneList.new{width=self.iw/4-20, height = (self.ih*0.8), scrollbar=true, text="Hello from description"}

    --Skills
    self.c_skill_points = Textzone.new{width=self.iw, auto_height=true, text = "Available skill points: #GOLD#"..actor.skill_point.. " #LAST# Background skill points: #GOLD#"..actor.background_points.." #LAST# Max skill ranks: #GOLD#"..actor.max_skill_ranks.."\n#LAST# Max cross class ranks: #GOLD#"..(self.actor.max_skill_ranks/2).."\n#LAST#Only skill ranks are displayed.\n Skills in blue are cross-class skills."}
	self.c_adventure = Textzone.new{width=self.iw/3, auto_height=true, text=[[Adventuring skills]]}
    self.c_background = Textzone.new{width=self.iw/3, auto_height=true, text=[[Background skills]]}
    self.c_skills_list = List.new{width=self.iw/3, height=self.ih-start-self.c_skill_points.h - 10, nb_items=#self.skill_list, list=self.skill_list, fct=function(item) self:useSkill(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}
	self.c_list_background = List.new{width=self.iw/3, height=self.ih-start-self.c_skill_points.h - 10, nb_items=#self.list_background, list=self.list_background, fct=function(item) self:useSkill(item) end, select=function(item,sel) self:on_select(item,sel) end, scrollbar=true}
--    self.c_desc_skills = TextzoneList.new{width=self.iw/3-20, height = self.ih-self.c_skill_points.h - 10, text="Hello from description"}

    --Feats
    self.c_feat_points = Textzone.new{width=self.iw, height = 30, text = "Available feat points: "..actor.feat_point}
	self.c_learned_text = Textzone.new{auto_width=true, auto_height=true, text="#SANDY_BROWN#Learned feats#LAST#"}
	self.c_avail_text = Textzone.new{auto_width=true, auto_height=true, text="#SANDY_BROWN#Available feats#LAST#"}
	self.c_barred_text = Textzone.new{auto_width=true, auto_height=true, text="#SANDY_BROWN#Barred feats#LAST#"}
--    self.c_desc_feats = TextzoneList.new{width=self.iw/4-20, height = 400, text="Hello from description"}

	self.c_learned = List.new{width=250, height=self.ih*0.8, scrollbar=true,
		list=self.learned_feats,
		fct=function() end,
		select=function(item, sel) self:on_select(item) end,
	}

	self.c_avail = TreeList.new{width=250, height=self.ih*0.8, scrollbar=true, columns={
		{width=100, display_prop="name"},
	}, tree=self.all_feats,
		fct=function(item, sel, v) self:featUse(item, sel, v) end,
		select=function(item, sel) self:on_select(item) end,
		on_expand=function(item) end,
		on_drawitem=function(item) end,
	}

	self.c_barred = TreeList.new{width=250, height=self.ih*0.8, scrollbar=true, columns={
		{width=100, display_prop="name"},
	}, tree=self.barred_feats,
		fct=function(item, sel, v) end,
		select=function(item, sel) self:on_select(item) end,
		on_expand=function(item) end,
		on_drawitem=function(item) end,
	}

	self.c_bonus = Button.new{text="Bonus feats", fct=function() self:onBonus() end}

    --Stats
    self.c_stats = ListColumns.new{
        width=self.iw/6,
        height=200,
        all_clicks=true,
        columns={
            {name="Stat", width=40, display_prop="name"},
            {name="Value", width=50, display_prop="val"},
        },
        list=self.list_stats,
        fct=function(item, _, v)
            self:incStat(v == "left" and 1 or -1, item.stat_id)
        end,
        select=function(item, sel)
            self.sel = sel
            -- extract the actual val from the formatted string containing it
            self.val = string.match(item.val, "%d+")
            self.id = item.stat_id
            self:updateDesc(item)
        end
    }

    self.c_plan = Button.new{text="Plan", fct=function() self:onPlan() end}

  --  self.key:addBind("EXIT", function() cs_player_dup = game.player:clone() game:unregisterDialog(self) end)
  --Taken from ToME 4
    self.key:addBinds{
        EXIT = function()
            if self.actor.class_points~=self.actor_dup.class_points
                or self.actor.feat_point~=self.actor_dup.feat_point
                or self.actor.skill_point~=self.actor_dup.skill_point
                or self.actor.fighter_bonus~=self.actor_dup.fighter_bonus
                or self.actor.stat_point~=self.actor_dup.stat_point
                then
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


    self.t_stats:select()
end

function _M:cancel()
    restore(self.actor, self.actor_dup)
end

function _M:switchTo(tab)
    self.t_classes.selected = tab == 'classes'
    self.t_feats.selected = tab == 'feats'
    self.t_skills.selected = tab == 'skills'
    self.t_stats.selected = tab == 'stats'

    self:drawDialog(tab)
end

function _M:drawDialog(tab)
    local start = self.t_feats.h+5+self.vs.h

    if tab == "classes" then
        self:loadUI{
            {left=0, top=0, ui=self.t_classes},
            {left=self.t_classes, top=0, ui=self.t_feats},
            {left=self.t_feats, top=0, ui=self.t_skills},
            {left=self.t_skills, top=0, ui=self.t_stats},
            {left=0, top=self.t_classes.h, ui=self.vs},
            {left=0, top=start + 5, ui=self.c_class_points},
            {left=0, top=start + 50, ui=self.c_class_list},
            {right=0, top=start + 50, ui=self.c_desc},
        --    {left=0, bottom=0, ui=self.c_accept},
        }

        self:setupUI()

    end

    if tab == "feats" then
        local tree_start = self.c_feat_points.h + 5 + self.c_bonus.h + 5 + self.c_learned_text.h + 15
        self:loadUI{
            {left=0, top=0, ui=self.t_classes},
            {left=self.t_classes, top=0, ui=self.t_feats},
            {left=self.t_feats, top=0, ui=self.t_skills},
            {left=self.t_skills, top=0, ui=self.t_stats},
            {left=0, top=self.t_classes.h, ui=self.vs},
            {left=0, top=start, ui = self.c_feat_points},
    		{left=0, top=start+40, ui = self.c_bonus},
    		{left=0, top=start+90, ui=self.c_learned_text},
    		{left=250, top=start+90, ui=self.c_avail_text},
    		{left=500, top=start+90, ui=self.c_barred_text},
    		{left=0, top=start + tree_start, ui=self.c_learned},
    		{left=250, top=start + tree_start, ui=self.c_avail},
    		{left=500, top=start + tree_start, ui=self.c_barred},
    		{left=750, top=start + tree_start, ui=self.c_desc},
        --    {left=0, bottom=0, ui=self.c_accept},
        }
        self:hideButton()

        self:setupUI()

    end

    if tab == "skills" then
        self:loadUI{
            {left=0, top=0, ui=self.t_classes},
            {left=self.t_classes, top=0, ui=self.t_feats},
            {left=self.t_feats, top=0, ui=self.t_skills},
            {left=self.t_skills, top=0, ui=self.t_stats},
            {left=0, top=self.t_classes.h, ui=self.vs},
            {left=0, top=start, ui = self.c_skill_points},
            {left=0, top=start + self.c_skill_points.h + 5, ui=self.c_adventure},
    		{left=0, top=start + self.c_skill_points.h + 25, ui=self.c_skills_list},
            {left=self.c_skills_list.w + 5, top=start + self.c_skill_points.h + 5, ui=self.c_background},
            {left=self.c_skills_list.w + 5, top=start + self.c_skill_points.h + 25, ui=self.c_list_background},
    		{right=0, top=start + self.c_skill_points.h + 5, ui=self.c_desc},
        --    {left=0, bottom=0, ui=self.c_accept},
        }

        self:setupUI()

    end

    if tab == "stats" then
        self:loadUI{
            {left=0, top=0, ui=self.t_classes},
            {left=self.t_classes, top=0, ui=self.t_feats},
            {left=self.t_feats, top=0, ui=self.t_skills},
            {left=self.t_skills, top=0, ui=self.t_stats},
            {left=0, top=self.t_classes.h, ui=self.vs},
            {left=0, top=start, ui=self.c_stats},
            {left=0, top=start + self.c_stats.h, ui=self.c_surface},
            {right=0, top=start, ui=self.c_desc},
            {left=0, bottom=0, ui=self.c_plan},
        }

        self:setupUI()
        self:hidePlan()
        self:drawGeneral()

    end

end

--Common stuff
function _M:cancel()
    restore(self.actor, self.actor_dup)
end

function _M:on_select(item,sel)
    if self.c_desc then self.c_desc:switchItem(item, item.desc) end
    self.selection = sel
end

function _M:updateDesc(item)
    if item and item.desc then
       if self.c_desc then self.c_desc:switchItem(item, item.desc) end
    --   if self.c_desc_feats then self.c_desc_feats:switchItem(item, item.desc) end
    end
end

--General stuff
function _M:drawGeneral()
    local actor = self.actor
    local s = self.c_surface.s

    s:erase(0,0,0,0)

    local h = 2
    local w = 0

    h = h + self.font_h -- Adds an empty row
    if actor.class_points > 0 then
        s:drawColorStringBlended(self.font, "#LIGHT_GREEN#You have unspent class points! Spend them to receive level up bonuses!#LAST#", w, h, 255, 255, 255, true) h = h + self.font_h
    end
    --Display any unused level-up stuff
    s:drawColorStringBlended(self.font, "Available skill points: #GOLD#"..(actor.skill_point.. " #LAST#Max skill ranks: #GOLD#"..actor.max_skill_ranks), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Available class points: #GOLD#"..(actor.class_points or 0), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Available feat points: #GOLD#"..(actor.feat_point or 0), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Available stat points: #GOLD#"..(actor.stat_point or 0), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
--    h = 50
--    w = self.w * 0.25
    -- start on second column
    s:drawColorStringBlended(self.font, "You #ORANGE#need#LAST# to advance a class in order to receive any bonuses from gaining a level.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "You can use the tabs to pick your #ORANGE#class#LAST#, #ORANGE#skills#LAST# or #ORANGE#feats#LAST#.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Note that you are not limited to advancing a single class.", w, h, 255, 255, 255, true) h = h + self.font_h

    self.c_surface:generate()
    self.changed = false
end

--Classes
function _M:useClass(item)
    if self.actor.class_points <= 0 then
        self:simplePopup("Not enough class points", "You need a class point!")
        return end
    if not item.can_level then
        self:simplePopup("Requirements not met", "You don't fulfill all the requirements for this class")
        return end

    self.actor:levelClass(item.real_name)

    self:updateClass()
end

function _M:updateClass()
    local sel = self.selection
    self:generateClassList() -- Slow! Should just update the one changed and sort again
    self.c_class_points.text = "Available class points: "..self.actor.class_points
    self.c_class_points:generate()
    self.c_class_list.list = self.class_list
    self.c_class_list:generate()
    if sel then self.c_class_list:select(sel) end
end


function _M:generateClassList()
    local act = self.actor
    local Birther = require "engine.Birther"

    local list = {}

    for i, d in ipairs(Birther.birth_descriptor_def.subclass) do
    --    local level = self.player.classes[d.name] or 0
        local level = self.actor.classes[d.name] or 0
        local can_level = d.can_level(self.actor)
        local prestige = false
        local name = ""

        --generate description
        local desc = "#KHAKI#"..d.name.."#LAST#"
        if d.prestige then
            desc = desc.."\n#ORCHID#Prestige class#LAST#"
            prestige = true
        end

        local core_desc = d.desc
        if self:descText(d) then core_desc = self:descText(d) end
        desc = desc.."\n\n"..core_desc

        if can_level then
            name = "#SLATE#(#LAST##AQUAMARINE#"..level.."#LAST##SLATE#) #LAST#"..d.name
        else
            name = "#SLATE#(#LAST##AQUAMARINE#"..level.."#LAST##SLATE#) #DARK_GREY#"..d.name
        end
        table.insert(list, {name = name, desc = desc, level = level, real_name = d.name, can_level = can_level, prestige = prestige})
    end

    self.class_list = list

    table.sort(self.class_list, function (a,b)
        --Can I level it?
        if not a.can_level == b.can_level then
            return a.can_level
        end
        --Prestige classes after normal classes
        if not a.prestige and b.prestige then return true
        elseif a.prestige and not b.prestige then return false end
        if a.level == b.level then
            return a.name < b.name
        else
            return a.level > b.level
        end
    end)

end

function _M:descText(t)
	local actor = self.actor
	local d = t.desc(actor,t)
	return d
end

--Skills
function _M:useSkill(item)
	--check that we don't get negative values AFTER deducting a point
	if (not item.background and (self.actor.skill_point or 0) -1 >= 0)
        or (item.background and (self.actor.background_points or 0) -1 >= 0)
     then

    	--Cross class skills
    	if self.actor:crossClass(item.skill) then
    		if (self.actor:attr("skill_"..item.skill) or 0) < (self.actor.max_skill_ranks/2) then

    		    --increase the skill by one
    		    self.actor:attr("skill_"..item.skill, 1)

                if not item.background then
        		    self.actor.skill_point = self.actor.skill_point - 1
                else
                    self.actor.background_points = self.actor.background_points - 1
                end
        		self:updateSkills()
                --end
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
    		self:updateSkills()
    		--end
        else
            self:simplePopup("Max skill points", "You cannot increase this skill further!")
    	end
    end
    else
        self:simplePopup("Not enough skill points", "You need a skill point!")
	end
end

function _M:updateSkills()
	local sel = self.selection
	self:generateSkillLists() -- Slow! Should just update the one changed and sort again
	self.c_skill_points.text = "Available skill points: #GOLD#"..self.actor.skill_point.." #LAST# Background skill points: #GOLD#"..self.actor.background_points.." #LAST#Max skill ranks: #GOLD#"..self.actor.max_skill_ranks.."\n#LAST# Max cross class ranks: #GOLD#"..(self.actor.max_skill_ranks/2).."\n#LAST#Only skill ranks are displayed.\n Skills in blue are cross-class skills."
	self.c_skill_points:generate()
	self.c_skills_list.list = self.skill_list
	self.c_skills_list:generate()
    self.c_list_background.list = self.list_background
    self.c_list_background:generate()
	if sel then self.c_skills_list:select(sel) end
end

function _M:generateSkillLists()
    self:generateSkillList()
    self:generateBackgroundList()
end

function _M:generateSkillList()
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
                if (self.actor:attr("skill_"..skill) or 0) >= (self.actor.max_skill_ranks/2) then
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
    self.skill_list = list
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
                if (self.actor:attr("skill_"..skill) or 0) >= (self.actor.max_skill_ranks/2) then
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
    self.list_background = list
end

--Feats
function _M:hideButton()
	local ok = self.actor.fighter_bonus and self.actor.fighter_bonus > 0
	self:toggleDisplay(self.c_bonus, ok)
end


function _M:useFeat(item)
	if self.actor.feat_point > 0 then
		local t = item.talent
		local tid = item.talent.id
		--Have we already learned it?
		if self.actor:getTalentLevelRaw(tid) >= t.points then
			return nil
		end

		-- Alright, lets learn it if we can
		local learned = self.actor:learnTalent(item.talent.id) --returns false if not learned due to requirements
		if learned then
			self.actor.feat_point = self.actor.feat_point - 1
			self:updateFeats()
		end
	end
end

function _M:featUse(item, sel, v)
	if not item then return end
	if item.nodes then
		for _, other in ipairs(self.c_avail.tree) do
			if other.shown then self.c_avail:treeExpand(false, other) end
		end
		self.c_avail:treeExpand(true, item)
	elseif item.talent and self.actor:canLearnTalent(item.talent) then
		self:useFeat(item)
	end
end


function _M:updateFeats()
	local sel = self.selection
	self:generateFeatLists() -- Slow! Should just update the one changed and sort again
	self.c_feat_points.text = "Available feat points: "..self.actor.feat_point
	self.c_feat_points:generate()
	self.c_avail.tree = self.all_feats
	self.c_barred.tree = self.barred_feats
	self.c_avail:generate()
	self.c_barred:generate()
--	if sel then self.c_list:select(sel) end
end

function _M:generateFeatLists()
	self:generateLearned()
	self:generateAvail()
	self:generateBarred()
end

function _M:talentTextBlock(t)
	local actor = self.actor
	local d = "#GOLD#"..t.name.."#LAST#\n"
	-- Workaround for double newline bug in T-Engine's getTalentReqDesc
	local s = actor:getTalentReqDesc(t.id):toString():gsub('\n\n', '\n')
	d = d..s.."\n#WHITE#"
	d = d..t.info(actor,t)
	return d
end

function _M:generateAvail()
	local actor = self.actor
	local oldtree = {}
	for i, t in ipairs(self.all_feats or {}) do oldtree[t.id] = t.shown end

	local tree = {}
	local newsel = nil
	for i, tt in ipairs(self.actor.talents_types_def) do
		if self.actor:knowTalentType(tt.type) then
			--exclude some categories
			if tt.type ~= "special/special" and tt.type ~= "arcane/arcane" and tt.type ~= "divine" and tt.type ~= "arcane_divine"
				--exclude spells
				and tt.name ~= "abjuration" and tt.name ~= "conjuration" and tt.name ~= "divination" and tt.name ~= "enchantment" and tt.name ~= "evocation" and tt.name ~= "illusion" and tt.name ~= "necromancy" and tt.name ~= "transmutation"

				--exclude class skills categories
				and tt.type ~= "barbarian/barbarian" and tt.type ~= "cleric/cleric" and tt.type ~= "druid/druid" and tt.type ~= "eldritch/eldritch" and tt.type ~= "paladin/paladin" and tt.type ~= "ranger/ranger"
				then

				local nodes = {}

				for j, t in ipairs(tt.talents) do
					if t.is_feat and actor:canLearnTalent(t) and not actor:knowTalent(t) then
						nodes[#nodes+1] = {
							name = t.name,
							id = t.name,
							pid = tt.name,
							desc = self:talentTextBlock(t),
							talent = t,
						}

						if self.sel_feat and self.sel_feat.id == sd.name then newsel = nodes[#nodes] end
					end
				end

				if #nodes > 0 then
					tree[#tree+1] = {
						name = tt.name,
						id = tt.name,
						shown = oldtree[tt.name],
						nodes = nodes,
					}
				end
			end
		end
	end

	self.all_feats = tree
	if self.c_avail then
		self.c_avail.tree = self.all_feats
		self.c_avail:generate()
		if newsel then self:featUse(newsel)
		else
			self.sel_feat = nil
		end
	end
end


--[[ --Sort it alphabetically
	table.sort(self.list_avail, function (a,b)
			return a.name < b.name
	end)]]

function _M:generateBarred()
	local actor = self.actor
	local oldtree = {}
	for i, t in ipairs(self.barred_feats or {}) do oldtree[t.id] = t.shown end

	local tree = {}
	local newsel = nil
	for i, tt in ipairs(self.actor.talents_types_def) do
		if self.actor:knowTalentType(tt.type) then
			 --exclude some categories
			if tt.type ~= "special/special" and tt.type ~= "arcane/arcane" and tt.type ~= "divine" and tt.type ~= "arcane_divine"

				--exclude spells
				and tt.type ~= "abjuration" and tt.type ~= "conjuration" and tt.type ~= "divination" and tt.type ~= "enchantment" and tt.type ~= "evocation" and tt.type ~= "illusion" and tt.type ~= "necromancy" and tt.type ~= "transmutation"

				--exclude class skills categories
				and tt.type ~= "barbarian/barbarian" and tt.type ~= "cleric/cleric" and tt.type ~= "druid/druid" and tt.type ~= "eldritch/eldritch" and tt.type ~= "paladin/paladin" and tt.type ~= "ranger/ranger"
				then

				local nodes = {}

				for j, t in ipairs(tt.talents) do
					if t.is_feat and not actor:canLearnTalent(t) and not actor:knowTalent(t) then
						nodes[#nodes+1] = {
							name = t.name,
							id = t.name,
							pid = tt.name,
							desc = self:talentTextBlock(t),
							talent = t,
						--	color = color,
						}

						if self.sel_barred and self.sel_barred.id == sd.name then newsel = nodes[#nodes] end
					end
				end

				if #nodes > 0 then
					tree[#tree+1] = {
						name = tt.name,
						id = tt.name,
						shown = oldtree[tt.name],
						nodes = nodes,
					}
				end
			end
		end
	end

	self.barred_feats = tree
	if self.c_barred then
		self.c_barred.tree = self.barred_feats
		self.c_barred:generate()
		if newsel then self:featUse(newsel)
		else
			self.sel_barred = nil
		end
	end

end

function _M:onBonus()
	--pop the are you sure thing
	if self.actor.feat_point~=self.actor_dup.feat_point then
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

	game:unregisterDialog(self)
	game:registerDialog(require("mod.dialogs.BonusFeatDialog").new(game.player))
end

function _M:mouseZones(t, no_new)
	-- Offset the x and y with the window position and window title
	if not t.norestrict then
		for i, z in ipairs(t) do
			if not z.norestrict then
				z.x = z.x + self.display_x + 5
				z.y = z.y + self.display_y + 20 + 3
			end
		end
	end

	if not no_new then self.mouse = engine.Mouse.new() end
	self.mouse:registerZones(t)
end

function _M:mouseTooltip(text, _, _, _, w, h, x, y)
	self:mouseZones({
		{ x=x, y=y, w=w, h=h, fct=function(button) game.tooltip_x, game.tooltip_y = 100, 100; game:tooltipDisplayAtMap(game.w*0.8, game.h*0.8, text) end},
	}, true)
end

function _M:generateLearned()
	local actor = self.actor
	local list = {}
	for j, t in pairs(actor.talents_def) do
		if actor:knowTalent(t.id) and t.is_feat then
			if actor:classFeat(t.id) then name = "#GOLD#"..t.name
			else name = ("%s"):format(t.name) end

			list[#list+1] = {
				name = name,
				desc = self:talentTextBlock(t),
			}
		end
	end

	table.sort(list, function(a,b) return a.name < b.name end)

	self.learned_feats = list
end

--Stats
function _M:generateStats()
    local list = {}

    list =
    {
        {name="STR", val=self.actor:getStr(), stat_id=self.actor.STAT_STR, desc="#GOLD#Strength (STR)#LAST# is important for melee fighting."},
        {name="DEX", val=self.actor:getDex(), stat_id=self.actor.STAT_DEX, desc="You'll want to increase #GOLD#Dexterity (DEX)#LAST# if you want to play a ranger or a rogue. It's less important for fighters, who wear heavy armor."},
        {name="CON", val=self.actor:getCon(), stat_id=self.actor.STAT_CON, desc="#GOLD#Constitution (CON)#LAST# is vital for all characters, since it affects your hitpoints."},
        {name="INT", val=self.actor:getInt(), stat_id=self.actor.STAT_INT, desc="#GOLD#Intelligence (INT)#LAST# is a key attribute for wizards, since it affects their spellcasting. If it's lower than #LIGHT_RED#9#LAST#, you won't be able to cast spells if you're a wizard."},
        {name="WIS", val=self.actor:getWis(), stat_id=self.actor.STAT_WIS, desc="#GOLD#Wisdom (WIS)#LAST# is a key attribute for clerics and rangers, since it affects their spellcasting. If it's lower than #LIGHT_RED#9#LAST#, you won't be able to cast spells if you're a divine spellcaster."},
        {name="CHA", val=self.actor:getCha(), stat_id=self.actor.STAT_CHA, desc="#GOLD#Charisma (CHA)#LAST# is a key attribute for shamans or sorcerers, since it affects their spellcasting. If it's lower than #LIGHT_RED#9#LAST#, you won't be able to cast spells."},
    --    {name="LUC", val=self.actor:getLuc(), stat_id=self.actor.STAT_LUC, desc="#GOLD#Luck (LUC)#LAST# is special stat introduced in #TAN#Incursion#LAST# and borrowed by #SANDY_BROWN#the Veins of the Earth.#LAST# It affects the quality of loot drops."},
        }

    self.list_stats = list
end

function _M:incStat(v, id)
	if not self.actor.stat_point then
        self:simplePopup("Not enough stat points", "You have no stat points left!")
        return end

	if v == 1 then
		if self.actor.stat_point <= 0 then
			self:simplePopup("Not enough stat points", "You have no stat points left!")
			return
		end
		if self.actor:isStatMax(self.sel) then
			self:simplePopup("Stat is at the maximum", "You can not increase this stat further!")
			return
		end
	else
		if self.actor_dup:getStat(self.sel, nil, nil, true) == self.actor:getStat(self.sel, nil, nil, true) then
			self:simplePopup("Impossible", "You cannot take out more points!")
			return
		end
	end
    local sel = self.sel
    
	self.actor:incStat(self.sel, v)
	self.actor.stat_point = self.actor.stat_point - v

    self.c_stats.list[sel].val = self.actor.stats[id]
    self.c_stats:generate()
    self.c_stats.sel = sel
--    self.c_stats:onSelect()
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end

function _M:hidePlan()
    local ok = not self.actor.planning
    self:toggleDisplay(self.c_plan, ok)
end

function _M:getTitle()
    if self.actor.planning == true then return self.actor.name.." [Plan]"
    else return self.actor.name end
end

function _M:onPlan()
    local LevelupDialog = require 'mod.dialogs.LevelupDialog'
    game:unregisterDialog(self)

    local high_lvl_dup = game.player:cloneFull()
    -- Don't want this player swapped onto the map.
    high_lvl_dup.x = nil
    high_lvl_dup.y = nil
    -- Nor do we want any level-up achievements.
    high_lvl_dup.silent_levelup = true
    --mark the fact we're planning
    high_lvl_dup.planning = true

    --Level-up the duplicate
    high_lvl_dup:forceLevelup(3)
    high_lvl_dup:gainExp(30000)

    --set a baseline
    self.dup_baseline = high_lvl_dup:cloneFull()

    local d = LevelupDialog.new(high_lvl_dup)
    d.actor_dup = self.dup_baseline

    game:registerDialog(d)
end
