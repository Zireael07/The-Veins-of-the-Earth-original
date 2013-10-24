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
    Dialog.init(self, "Attributes Roller", math.max(game.w * 0.7, 950), 500, nil, nil, font)

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
    self.creating_player = true
    local birth = Birther.new(nil, self.actor, {"base", 'sex', 'race', 'class', 'background', 'alignment', 'domains', 'domains'}, function()
        game:changeLevel(1, "dungeon")
        print("[PLAYER BIRTH] resolve...")
        game.player:resolve()
        game.player:resolve(nil, true)
        game.player.energy.value = game.energy_to_act
        game.paused = true
        game.creating_player = false
        game.player:levelPassives()
        game.player.changed = true
        game.player:onBirth()
        print("[PLAYER BIRTH] resolved!")
        end)

    game:registerDialog(birth)
end

function _M:onRoll()
    local player = self.actor
    --Unlearn any talent you might know to ensure you get only 1 perk ever
    for j, t in pairs(player.talents_def) do
            if player:knowTalent(t.id) then
            player:unlearnTalent(t.id) end
    end
    
    
    player:randomPerk()

    --Generate stats
    for i, s in ipairs(self.actor.stats_def) do
        self.actor.stats[i] = rng.dice(3,6)
    end
    
    --Make sure that the highest stat is not =< than 13 and that the sum of all modifiers isn't =< 0
   
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
    s:drawColorStringBlended(self.font, "STR : #YELLOW#"..(player:getStr().." #SANDY_BROWN#"..(math.floor((player:getStr()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "DEX : #YELLOW#"..(player:getDex().." #SANDY_BROWN#"..(math.floor((player:getDex()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "CON : #YELLOW#"..(player:getCon().." #SANDY_BROWN#"..(math.floor((player:getCon()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "INT : #YELLOW#"..(player:getInt().." #SANDY_BROWN#"..(math.floor((player:getInt()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "WIS : #YELLOW#"..(player:getWis().." #SANDY_BROWN#"..(math.floor((player:getWis()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "CHA : #YELLOW#"..(player:getCha().." #SANDY_BROWN#"..(math.floor((player:getCha()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "LUC : #YELLOW#"..(player:getLuc().." #SANDY_BROWN#"..(math.floor((player:getLuc()-10)/2))), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    
       --Display random perk
    local list = {}
        for j, t in pairs(player.talents_def) do
            if player:knowTalent(t.id) then

                list[#list+1] = {
                    name = ("%s"):format(t.name),
                    desc = player:getTalentFullDescription(t):toString(),
                }
            end
        end

        for i, t in ipairs(list) do
            s:drawColorStringBlended(self.font, ("#LIGHT_BLUE#%s#LAST#"):format(t.name), w, h, 255, 255, 255, true) h = h + self.font_h

           if h + self.font_h >= self.c_desc.h then h = 0 w = w + self.c_desc.w / 6 end
        end


    h = 0
    w = self.w * 0.25
    -- start on second column
    s:drawColorStringBlended(self.font, "#GOLD#Strength (STR)#LAST# is important for melee fighting.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "You'll want to increase #GOLD#Dexterity (Dex)#LAST# if you want to play a ranger or a rogue.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "It's less important for fighters, who wear heavy armor.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#GOLD#Constitution (CON)#LAST# is vital for all characters, since it affects your hitpoints.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#GOLD#Intelligence (INT)#LAST# is a key attribute for wizards, since it affects their spellcasting.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "If it's lower than #LIGHT_RED#9#LAST#, you won't be able to cast spells if you're a wizard.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#GOLD#Wisdom (WIS)#LAST# is a key attribute for clerics and rangers, since it affects their spellcasting.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "If it's lower than #LIGHT_RED#9#LAST#, you won't be able to cast spells if you're a divine spellcaster.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Most interactions with NPCs depend on #GOLD#Charisma (CHA)#LAST#-related skills.", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#GOLD#Luck (LUC)#LAST# is special stat introduced in #TAN#Incursion#LAST# and borrowed by #SANDY_BROWN#the Veins of the Earth.#LAST#", w, h, 255, 255, 255, true) h = h + self.font_h




 



--Generates values used in-game

    self.c_desc:generate()
    self.changed = false
end