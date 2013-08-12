require "engine.class"
local Dialog = require "engine.ui.Dialog"
local Textzone = require "engine.ui.Textzone"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"


module(..., package.seeall, class.inherit(Dialog))

function _M:init()
    Dialog.init(self, "Help", game.w * 0.8, game.h * 0.8)
    
    self.text=[[
    #GOLD#HP#LIGHT_SLATE#, or hitpoints, are your life meter. When it falls to #LIGHT_RED#0 #LAST#or lower, you're dead.
    #GOLD#AC#LAST# means #ORANGE#Armor Class#LAST#. The base number is #GOLD#10#LAST#. It can be increased by various means, such as Dexterity bonus, armor, shield or magic.
    #GOLD#BAB#LAST# is short for #ORANGE#Base Attack Bonus#LAST#. This number is added to a #GOLD#d20 roll#LAST# and your Strength bonus when you make an attack.
    #GOLD#HD#LAST# means #ORANGE#Hit Die#LAST#. It is the die that is rolled to determine the number of your hitpoints per level.
    In the #SANDY_BROWN#Veins of the Earth#LAST#, characters get full hit points from a die.

    In combat, the opponent's AC is compared to the attacker's roll and all the modifiers (BAB and Strength bonus).
    When making a saving throw, a #GOLD#d20 #LAST#is rolled, the bonus is added and the result is compared with the spell or trap's #GOLD#Difficulty Class.
    #LAST#There are three types of saving throws, each one representing avoiding a different danger.
    #GOLD#Reflex #LAST#represents avoiding dangers by moving. For example, it protects you from a grease spell.
    #GOLD#Fortitude #LAST#is all about resistance. For example, it allows you resist poison or sickness.
    #GOLD#Will #LAST#saving throw is about your willpower. It helps you resist charm spells or a vampire's gaze, among others.

    You choose gender, class, race and alignment for your character at game start.
    Gender does not affect anything. Alignment only affects clerical domains.
    Class and race both affect your character's stats, including his or her abilities, feats and skills.
    Abilities and special abilities are displayed in the character sheet (press #YELLOW#c#LAST# to access it).

    Upon creating a character, you should press #YELLOW#p#LAST# to open level up menu. Here, you can choose your feats and skills.

    The character's abilities are #GOLD#STR, DEX, CON, INT, WIS, CHA#LAST# and #GOLD#LUC#LAST#.
    #GOLD#STR#LAST# is short for #ORANGE#Strength#LAST#. It affects the damage your character deals in combat, as well as his melee attacks.
    #GOLD#DEX#LAST# is short for #ORANGE#Dexterity#LAST#. It represents how well your character can dodge blows in combat, as well as his ranged attacks.
    #GOLD#CON#LAST# is short for #ORANGE#Constitution#LAST#. It affects your character's hitpoints and Fortitude.
    #GOLD#INT#LAST# is short for #ORANGE#Intelligence#LAST#. It determines how hard it is to withstand a mage's spells.
    #GOLD#WIS#LAST# is short for #ORANGE#Wisdom#LAST#. It affects your character's willpower and clerical powers.
    #GOLD#CHA#LAST# is short for #ORANGE#Charisma#LAST#. It affects your character's interactions with others.
    #GOLD#LUC#LAST# is short for #ORANGE#Luck#LAST#. It has no effects presently.
    In the future, it will influence most statistics, as well as loot drops and enemies appearing.
]]
        
    self.c_desc = Textzone.new{width=self.iw, height=self.ih, scrollbar=true, text = self.text}
    --self.c_desc = TextzoneList.new{width=math.floor(self.iw / 2 - 10), scrollbar=true, height=self.ih, text = self.text}

    self:loadUI{
        {left=0, top=0, ui=self.c_desc},
    }
    self:setupUI(false, true)
    
    self:setFocus(self.c_desc)
    self.key:addBinds{
        EXIT = function() game:unregisterDialog(self) end,
    }
end