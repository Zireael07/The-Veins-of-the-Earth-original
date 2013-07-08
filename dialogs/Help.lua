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
    Dialog.init(self, "HELP: "..self.actor.name, math.max(game.w * 0.7, 950), 500, nil, nil, font)
    
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
    
    s:drawStringBlended(self.font, "HP, or hitpoints, are your life meter. When it falls to 0 or lower, you're dead."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "AC means Armor Class. The base number is 10. It can be increased by various means, including your Dexterity bonus, armor, shield or magic."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "BAB is short for Base Attack Bonus. This number is added to a d20 roll and your Strength bonus when you make an attack."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "HD means Hit Die. It is the die that is rolled to determine the number of your hitpoints per level. In Underdark, characters get full hit points from a die."), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawStringBlended(self.font, "In combat, the opponent's AC is compared to the attacker's roll and all the modifiers (BAB and Strength bonus)."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Saving throws, on the other hand, protect you from spells or traps. A d20 is rolled, the bonus is added and the result is compared with the spell or trap's Difficulty Class."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "There are three types of saving throws, each one representing avoiding a different danger."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Reflex represents avoiding dangers by moving. For example, it protects you from a grease spell."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Fortitude is all about resistance. For example, it allows you resist poison or sickness."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Will saving throw is about your willpower. It helps you resist charm spells or a vampire's gaze, among others."), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row

    s:drawStringBlended(self.font, "You choose gender, class, race and alignment for your character at game start."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Gender does not affect anything. Alignment only affects clerical domains."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Class and race both affect your character's stats, including his or her abilities, feats and skills."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Abilities and special abilities are displayed in the character sheet (press c to access it)."), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row

    s:drawStringBlended(self.font, "The character's abilities are STR, DEX, CON, INT, WIS, CHA and LUC."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "STR is short for Strength. It affects the damage your character deals in combat, as well as his melee attacks."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "DEX is short for Dexterity. It affects how well your character can dodge blows in combat, as well as his ranged attacks."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CON is short for Constitution. It affects your character's hitpoints and Fortitude."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "INT is short for Intelligence. It determines how hard it is to withstand a mage's spells."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "WIS is short for Wisdom. It affects your character's willpower and clerical powers."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "CHA is short for Charisma. It affects your character's interactions with others."), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "LUC is short for Luck. It has no effects presently. In the future, it will influence most statistics, as well as loot drops and enemies appearing."), w, h, 255, 255, 255, true) h = h + self.font_h

    self.c_desc:generate()
    self.changed = false
end