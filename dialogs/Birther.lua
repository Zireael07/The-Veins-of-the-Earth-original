require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local Birther = require "engine.Birther"
local Player = require "mod.class.Player"


module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Attributes Roller: "..self.actor.name, math.max(game.w * 0.7, 950), 500, nil, nil, font)

    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}
    --Reroll button
    self.c_reroll = Button.new{text="Reroll",fct=function() self:onRoll() end}

    self.player = Player.new{name=self.player_name, game_ender=true}

    --Birth button
    self.c_save = Button.new{text="Birth", fct=function() self:onBirth() end}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
        {left=0, bottom=0, ui=self.c_reroll},
        {left=self.c_reroll, bottom=0, ui=self.c_save},

    }
    
    self:setupUI()

    self:onRoll()
    
 --   self.key:addBind("EXIT", function() cs_player_dup = game.player:clone() game:unregisterDialog(self) end)
end

function _M:onBirth()

    game:unregisterDialog(self)
    local birth = Birther.new(nil, self.actor, {"base", 'sex', 'race', 'class', 'alignment', 'domains', 'domains'}, function()
        game:changeLevel(1, "cavern")
        print("[PLAYER BIRTH] resolve...")
        game.player:resolve()
        game.player:resolve(nil, true)
        game.player.energy.value = game.energy_to_act
        game.paused = true
        game.creating_player = false
        game.player:levelPassives()
        print("[PLAYER BIRTH] resolved!")
        end)

    game:registerDialog(birth)
end

function _M:onRoll()
    for i, s in ipairs(self.actor.stats_def) do
        self.actor.stats[i] = rng.dice(3,6)
    end
    
    --Make sure that the highest stat is not =< than 13 and that the sum of all modifiers isn't =< 0
    local player = self.actor
    local mod_sum = (player:getStr()-10)/2 + (player:getDex()-10)/2 + (player:getCon()-10)/2 + (player:getInt()-10)/2 + (player:getWis()-10)/2 + (player:getCha()-10)/2 
    if mod_sum <= 0 or (math.max(player:getStr(), math.max(player:getDex(), math.max(player:getCon(), math.max(player:getInt(), math.max(player:getWis(), player:getCha()))))) <= 13) then self:onRoll()
    else 
    self:drawDialog() end
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
    s:drawStringBlended(self.font, "STR : "..(player:getStr()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "DEX : "..(player:getDex()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CON : "..(player:getCon()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "INT : "..(player:getInt()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "WIS : "..(player:getWis()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CHA : "..(player:getCha()), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "LUC : "..(player:getLuc()), w, h, 255, 255, 255, true) h = h + self.font_h

--Generates values used in-game

    self.c_desc:generate()
    self.changed = false
end