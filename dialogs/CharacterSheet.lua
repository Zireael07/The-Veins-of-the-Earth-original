require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Character Sheet: "..self.actor.name, math.max(game.w * 0.7, 950), 500, nil, nil, font)
    
    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
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
    s:drawColorStringBlended(self.font, "#SLATE#Name : "..(player.name or "Unnamed"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#Class : "..(player.descriptor.class or "None"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#Race : "..(player.descriptor.race or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "Character level: "..(player.level or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "EXP : "..(player.exp or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "EXP to level up: "..(player:getExpChart(player.level+1) or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#GOLD#Gold : "..(player.money or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "AC : "..(player.combat_def or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "BAB : "..(player.combat_attack or "0"), w, h, 255, 255, 255, true) h = h + self.font_h


    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "#SLATE#Hit Dice : d"..(player.hd_size or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Hit Points : #RED#"..(math.floor(player.life) or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Max Hit Points : #LIGHT_RED#"..(player.max_life or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "Fortitude bonus: #LIGHT_BLUE#"..(player.fortitude_save or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Reflex bonus : #LIGHT_BLUE#"..(player.reflex_save or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Will bonus : #LIGHT_BLUE#"..(player.will_save or "0"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "#CHOCOLATE#Special qualities", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Darkvision : "..(player.infravision or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = 0
    w = self.w * 0.25 
    -- start on second column
        
    s:drawColorStringBlended(self.font, "#SLATE#STR : #YELLOW#"..(player:getStr().." #SANDY_BROWN#"..(math.floor((player:getStr()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#DEX : #YELLOW#"..(player:getDex().." #SANDY_BROWN#"..(math.floor((player:getDex()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#CON : #YELLOW#"..(player:getCon().." #SANDY_BROWN#"..(math.floor((player:getCon()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#INT : #YELLOW#"..(player:getInt().." #SANDY_BROWN#"..(math.floor((player:getInt()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#WIS : #YELLOW#"..(player:getWis().." #SANDY_BROWN#"..(math.floor((player:getWis()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#CHA : #YELLOW#"..(player:getCha().." #SANDY_BROWN#"..(math.floor((player:getCha()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#LUC : #YELLOW#"..(player:getLuc().." #SANDY_BROWN#"..(math.floor((player:getLuc()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Encumbrance : "..(player:getEncumbrance()).."/"..(player:getMaxEncumbrance()), w, h, 255, 255, 255, true) h = h + self.font_h


    h = 0
    w = self.w * 0.50 
    -- start on third column
    --Ideally, class-restricted skills should show up only if you have that class
    s:drawColorStringBlended(self.font, "#CHOCOLATE#Skills", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Balance : #SANDY_BROWN#"..(player:getSkill("balance") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Bluff : #SANDY_BROWN#"..(player:getSkill("bluff") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Climb : #SANDY_BROWN#"..(player:getSkill("climb") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Concentration : #SANDY_BROWN#"..(player:getSkill("concentration") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Diplomacy : #SANDY_BROWN#"..(player:getSkill("diplomacy") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Disable Device : #SANDY_BROWN#"..(player:getSkill("disabledevice") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Escape Artist : #SANDY_BROWN#"..(player:getSkill("escapeartist") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Handle Animal : #SANDY_BROWN#"..(player:getSkill("handleanimal") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Heal : #SANDY_BROWN#"..(player:getSkill("heal") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Hide : #SANDY_BROWN#"..(player:getSkill("hide") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Intimidate : #SANDY_BROWN#"..(player:getSkill("intimidate") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Intuition : #SANDY_BROWN#"..(player:getSkill("intuition") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Jump : #SANDY_BROWN#"..(player:getSkill("jump") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Knowledge : #SANDY_BROWN#"..(player:getSkill("knowledge") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Listen : #SANDY_BROWN#"..(player:getSkill("listen") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Move Silently : #SANDY_BROWN#"..(player:getSkill("movesilently") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Open Lock : #SANDY_BROWN#"..(player:getSkill("openlock") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Pick Pocket : #SANDY_BROWN#"..(player:getSkill("pickpocket") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Search : #SANDY_BROWN#"..(player:getSkill("search") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Sense Motive : #SANDY_BROWN#"..(player:getSkill("sensemotive") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Swim : #SANDY_BROWN#"..(player:getSkill("swim") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Spellcraft : #SANDY_BROWN#"..(player:getSkill("spellcraft") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Survival : #SANDY_BROWN#"..(player:getSkill("survival") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Tumble : #SANDY_BROWN#"..(player:getSkill("tumble") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Use Magic : #SANDY_BROWN#"..(player:getSkill("usemagic") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h



    h = 0
    w = self.w * 0.75 
    -- start on last column
    s:drawColorStringBlended(self.font, "#CHOCOLATE#Feats", w, h, 255, 255, 255, true) h = h + self.font_h
    --uh, a list of feats?

    self.c_desc:generate()
    self.changed = false
end