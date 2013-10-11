require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"
local Button = require "engine.ui.Button"


module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Controls", game.w * 0.6, game.h * 0.6)
    
    self.text=[[    
    CONTROLS
    Use arrow keys or mouse to move. Press shift + direction to run. The mouse wheel scrolls the log.
    Click on a spell or skill in the hotbar to use it. Alternately, you can use the hotkeys (displayed on the bar). Use the mouse to target skills or ranged attacks.
    Attack by bumping the enemies.
    Press #YELLOW#ESC#LAST# to access the game menu.
    Press #YELLOW#'c'#LAST# to display character sheet.
    Press #YELLOW#'p'#LAST# to display level-up screen.
    Press #YELLOW#'r'#LAST# to rest.
    Press #YELLOW#'i'#LAST# to display inventory screen.
    Press #YELLOW#'g'#LAST# to pick up items.
    Press #YELLOW#'d'#LAST# to drop items.


    Press #YELLOW#'h'#LAST# to display this screen again.
    Press #YELLOW#'b'#LAST# to diplay your spellbook, if you have it.
]]
        
    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}
    self.c_legend = Button.new{text="Legend", fct=function() self:onLegend() end}
    

    self:loadUI{
        {left=0, bottom=0, ui=self.c_legend},
        {left=0, top=0, ui=self.c_desc},
    }
    self:setupUI(false, true)
    
    self:setFocus(self.c_desc)
    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end

function _M:onLegend()
game:unregisterDialog(self)
game:registerDialog(require("mod.dialogs.Legend").new(game.player))
end