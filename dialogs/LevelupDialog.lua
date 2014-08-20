require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"

module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    self.actor = game.player

    self:generateList()
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Level Up: "..self.actor.name, math.max(game.w * 0.7, 950), game.h*0.5, nil, nil, font)
    
    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}

    self.c_accept = Button.new{text="Accept",fct=function() self:onEnd("accept") end}

    self.c_classes = Button.new{text="Classes",fct=function() self:onClass() end}

    self.c_feats = Button.new{text="Feats", fct=function() self:onFeat() end}

    self.c_skills = Button.new{text="Skills", fct=function() self:onSkill() end}

    self.c_stats = Button.new{text="Stats", fct=function() self:onStats() end}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
        {left=0, bottom=0, ui=self.c_accept},
        {left=self.c_accept, bottom=0, ui=self.c_classes},
        {left=self.c_classes, bottom=0, ui=self.c_feats},
        {left=self.c_feats, bottom=0, ui=self.c_skills},
        {left=self.c_skills, bottom=0, ui=self.c_stats},

    }
    
    self:setupUI()

    self:drawDialog()
    
    self.key:addBind("EXIT", function() cs_player_dup = game.player:clone() game:unregisterDialog(self) end)
end

function _M:drawDialog()
    local player = self.actor
    local s = self.c_desc.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0
    
 --Display 7 stats
    s:drawColorStringBlended(self.font, "STR : #YELLOW#"..(player:getStr().." #SANDY_BROWN#"..(math.floor((player:getStr()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "DEX : #YELLOW#"..(player:getDex().." #SANDY_BROWN#"..(math.floor((player:getDex()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "CON : #YELLOW#"..(player:getCon().." #SANDY_BROWN#"..(math.floor((player:getCon()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "INT : #YELLOW#"..(player:getInt().." #SANDY_BROWN#"..(math.floor((player:getInt()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "WIS : #YELLOW#"..(player:getWis().." #SANDY_BROWN#"..(math.floor((player:getWis()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "CHA : #YELLOW#"..(player:getCha().." #SANDY_BROWN#"..(math.floor((player:getCha()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "LUC : #YELLOW#"..(player:getLuc().." #SANDY_BROWN#"..(math.floor((player:getLuc()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    --Display any unused level-up stuff
    s:drawColorStringBlended(self.font, "Available skill points: #GOLD#"..(player.skill_point.. " #LAST#Max skill ranks: #GOLD#"..player.max_skill_ranks), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Available class points: #GOLD#"..(player.class_points or 0), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Available feat points: #GOLD#"..(player.feat_point or 0), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Available stat points: #GOLD#"..(player.stat_point or 0), w, h, 255, 255, 255, true) h = h + self.font_h

    h = 0
    w = self.w * 0.25 
    -- start on second column
    s:drawColorStringBlended(self.font, "You can use the buttons below to pick your #ORANGE#skills#LAST# or #ORANGE#feats#LAST#.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "You can also use the #ORANGE#class#LAST# button to choose the class you advance.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Note that you are not limited to advancing a single class.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "You need to advance a class in order to receive any bonuses from gaining a level.", w, h, 255, 255, 255, true) h = h + self.font_h

    self.c_desc:generate()
    self.changed = false
end

function _M:generateList()
    local player = game.player
    local list = {}
    for tid, _ in pairs(player.talents) do
        local t = player:getTalentFromId(tid)
        if t.is_feat then 
            list[#list+1] = t
        end
    end
    self.list = list
end

function _M:onFeat()
    game:unregisterDialog(self)
    game:registerDialog(require("mod.dialogs.FeatDialog").new(game.player))
end
function _M:onSkill()
    game:unregisterDialog(self)
    game:registerDialog(require("mod.dialogs.SkillDialog").new(game.player))
end

function _M:onClass()
    game:unregisterDialog(self)
    game:registerDialog(require("mod.dialogs.ClassLevelupDialog").new(game.player))
end

function _M:onStats()
    game:unregisterDialog(self)
    game:registerDialog(require("mod.dialogs.StatsDialog").new(game.player))
end

function _M:onEnd(result)
    game:unregisterDialog(self)
end