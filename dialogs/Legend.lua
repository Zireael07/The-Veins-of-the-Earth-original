--Veins of the Earth
--Zireael

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"


module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Legend", game.w * 0.5, game.h * 0.5)
    
    self.text=[[ Items
    = a belt
    σ a ring
    ♂ an amulet
    ♠ a cloak
    ω boots
    Ξ bracers
    - a wand
    ? a scroll
    ! a potion
    ~ torch

    $ money
    % food or corpse

    ( light armor
    ] medium armor
    [ heavy armor
    ) shield

    / polearms
    | edged weapon
    \ hafted weapon
    } launcher
    { ammo

]]
        
    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}
    

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
    }
    self:setupUI(false, true)
    
    self:setFocus(self.c_desc)
    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end