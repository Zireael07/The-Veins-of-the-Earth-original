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
    self.c_reroll = Button.new{text="Reroll",fct=function() self:drawDialog() end}

self.player = Player.new{name=self.player_name, game_ender=true}

    local birth = Birther.new(nil, self.actor, {"base", 'sex', 'race', 'class', }, function()
        game:changeLevel(1, "dungeon")
        print("[PLAYER BIRTH] resolve...")
        game.player:resolve()
        game.player:resolve(nil, true)
        game.player.energy.value = game.energy_to_act
        game.paused = true
        game.creating_player = false
        print("[PLAYER BIRTH] resolved!")
        end)

    --Birth button
    self.c_save = Button.new{text="Birth", fct=function() 
    game:unregisterDialog(self) game:registerDialog(birth) end}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
        {left=0, bottom=0, ui=self.c_reroll},
        {left=self.c_reroll, bottom=0, ui=self.c_save},

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
    s:drawStringBlended(self.font, "STR : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "DEX : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CON : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "INT : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "WIS : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CHA : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "LUC : "..(rng.dice(3,6)), w, h, 255, 255, 255, true) h = h + self.font_h

--Generates values used in-game
self.generatedstats = { str = rng.dice(3,6), dex = rng.dice(3,6), con = rng.dice(3,6), int = rng.dice(3,6), wis = rng.dice(3,6), cha = rng.dice(3,6), luc = rng.dice(3,6) }

    self.c_desc:generate()
    self.changed = false
end