--Veins of the Earth
--Zireael

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"


module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Rules", game.w * 0.5, game.h * 0.5)
    
    self.text=[[
    HP, or hitpoints, are your life meter. When it falls to #LIGHT_RED#0#LAST# or lower, you're dead.

AC means #ORANGE#Armor Class#LAST#. The base number is #GOLD#10#LAST#. It can be increased by various means, such as Dexterity bonus, armor, shield or magic.

BAB is short for #ORANGE#Base Attack Bonus#LAST#. This number is added to a #GOLD#d20 roll#LAST# and your Strength bonus when you make an attack.

HD means #ORANGE#Hit Die#LAST#. It is the die that is rolled to determine the number of your hitpoints per level. In the #SANDY_BROWN#Veins of the Earth#LAST#, player characters get full hit points from a die. Monster hitpoints are still rolled, however.

In combat, the opponent's AC is compared to the attacker's roll and all the modifiers (BAB and Strength bonus). If the roll exceeds the AC, the attack hits. 
If you roll a 20, it is a critical hit, which deals twice as much damage. If your weapon has an increased #ORANGE#threat range#LAST#, it crits more often. If it has a #ORANGE#crit multiplier#LAST#, the damage is increased even more.

When making a saving throw, a #GOLD#d20#LAST# is rolled, the bonus is added and the result is compared with the spell or trap's #ORANGE#Difficulty Class#LAST#.    

A skill check means a #GOLD#d20#LAST# is rolled and the stat bonus is added and the result is compared to the #ORANGE#Difficulty Class#LAST#. 
If your armor has an #ORANGE#armor check penalty#LAST#, it means that the given number is subtracted from the skill check.

If you are a wizard and your armor has an #ORANGE#spell failure chance#LAST#, there is a given percentile chance that any arcane spell you try to cast will fail.

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