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
    s:drawStringBlended(self.font, "Name : "..(player.name or "Unnamed"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Class : "..(player.descriptor.class or "None"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Race : "..(player.descriptor.race or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Level : "..(player.level or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "EXP : "..(player.exp or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "EXP to level up: "..(player:getExpChart(player.level+1) or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Gold : "..(player.money or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "AC : "..(player.combat_def or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "BAB : "..(player.combat_attack or "0"), w, h, 255, 255, 255, true) h = h + self.font_h


    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Hit Dice : d"..(player.hd_size or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Hit Points : "..(math.floor(player.life) or "Unknown"), w, h, 255, 57, 57, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Max Hit Points : "..(player.max_life or "Unknown"), w, h, 255, 0, 0, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Fortitude bonus: "..(player.fortitude_save or "0"), w, h, 0, 239, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Reflex bonus : "..(player.reflex_save or "0"), w, h, 0, 239, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Will bonus : "..(player.will_save or "0"), w, h, 0, 239, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Special qualities", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Darkvision : "..(player.infravision or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = 0
    w = self.w * 0.25 
    -- start on second column
        
    s:drawStringBlended(self.font, "STR : "..(player:getStr()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "DEX : "..(player:getDex()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CON : "..(player:getCon()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "INT : "..(player:getInt()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "WIS : "..(player:getWis()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CHA : "..(player:getCha()), w, h, 255, 255, 0, true) h = h + self.font_h
    s:drawStringBlended(self.font, "LUC : "..(player:getLuc()), w, h, 255, 255, 0, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "Encumbrance : "..(player:getEncumbrance()).."/"..(player:getMaxEncumbrance()), w, h, 255, 255, 255, true) h = h + self.font_h


    h = 0
    w = self.w * 0.50 
    -- start on third column
    --Ideally, class-restricted skills should show up only if you have that class
    s:drawStringBlended(self.font, "Skills", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Balance : "..(player:getSkill("balance") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Bluff : "..(player:getSkill("bluff") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Climb : "..(player:getSkill("climb") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Concentration : "..(player:getSkill("concentration") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Diplomacy : "..(player:getSkill("diplomacy") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Disable Device : "..(player:getSkill("disabledevice") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Escape Artist : "..(player:getSkill("escapeartist") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Handle Animal : "..(player:getSkill("handleanimal") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Heal : "..(player:getSkill("heal") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Hide : "..(player:getSkill("hide") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Intimidate : "..(player:getSkill("intimidate") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Intuition : "..(player:getSkill("intuition") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Jump : "..(player:getSkill("jump") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Knowledge : "..(player:getSkill("knowledge") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Listen : "..(player:getSkill("listen") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Move Silently : "..(player:getSkill("movesilently") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Open Lock : "..(player:getSkill("openlock") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Search : "..(player:getSkill("search") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Sense Motive : "..(player:getSkill("sensemotive") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Pick Pocket : "..(player:getSkill("pickpocket") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Spellcraft : "..(player:getSkill("spellcraft") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Survival : "..(player:getSkill("survival") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Tumble : "..(player:getSkill("tumble") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Use Magic : "..(player:getSkill("usemagic") or "0"), w, h, 255, 255, 255, true) h = h + self.font_h



    h = 0
    w = self.w * 0.75 
    -- start on last column
    s:drawStringBlended(self.font, "Feats", w, h, 255, 255, 255, true) h = h + self.font_h
    --uh, a list of feats?

    self.c_desc:generate()
    self.changed = false
end