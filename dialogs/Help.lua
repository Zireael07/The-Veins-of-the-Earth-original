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
    Use #YELLOW#arrow keys#LAST# or mouse to move. Press #YELLOW#Shift + direction#LAST# to run. The mouse wheel scrolls the log.
    Click on a spell or skill in the hotbar to use it. Alternately, you can use the hotkeys (displayed on the bar). Use the mouse to target skills or ranged attacks.
    Attack by bumping the enemies.

    Press #YELLOW#PageUp#LAST# or #YELLOW#PageDown#LAST# to scroll the hotbar pages, should you get so many spells that they don't fit on a single page.

    Press #YELLOW#'.'#LAST# (dot) to wait for a turn. It might be useful if you cannot move otherwise.

    Press #YELLOW#ESC#LAST# to access the game menu.
    Press #YELLOW#'c'#LAST# to display character sheet.
    Press #YELLOW#'p'#LAST# to display level-up screen.
    Press #YELLOW#'m'#LAST# to display a list of your activable abilities (shoot, polearm & any spells you might have)
    Press #YELLOW#'r'#LAST# to rest.
    Press #YELLOW#'i'#LAST# to display inventory screen.
    Press #YELLOW#'g'#LAST# to pick up items.
    Press #YELLOW#'d'#LAST# to drop items.
    Press #YELLOW#'b'#LAST# to diplay your spellbook, if you have it.

    Press #YELLOW#'F1'#LAST# or #YELLOW#h#LAST# to display this screen again.
    Press #YELLOW#'F2'#LAST# to display the message log.

    Press #YELLOW#'Space'#LAST# to bring up the chatbox.
    Press #YELLOW#'Tab'#LAST# to choose the chat channels.
 
    To use debug functions, press #YELLOW#Shift + b#LAST# to see a list of all entities on a level.
    If you happen to run into an unkillable monster, press #YELLOW#Ctrl + c#LAST# to run a script which kills all such entities.
    To flush the te4_log.txt file, press #YELLOW#Shift + f#LAST#.
]]
        
    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}
    self.c_legend = Button.new{text="ASCII legend", fct=function() self:onLegend() end}
    self.c_rules = Button.new{text="Rules", fct=function() self:onRules() end}

    self:loadUI{
             {left=0, top=0, ui=self.c_desc},
             {left=0, bottom=0, ui=self.c_legend},
             {left=100, bottom=0, ui=self.c_rules},
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

function _M:onRules()
game:unregisterDialog(self)
game:registerDialog(require("mod.dialogs.Rules").new(game.player))
end