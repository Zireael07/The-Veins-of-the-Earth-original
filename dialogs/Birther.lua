require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Birther = require "engine.Birther"

local SurfaceZone = require "engine.ui.SurfaceZone"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local Tab = require 'engine.ui.Tab'

local Stats = require "engine.interface.ActorStats"
local Talents = require "engine.interface.ActorTalents"
local Player = require "mod.class.Player"

--Required for the premades
local Savefile = require "engine.Savefile"
local Module = require "engine.Module"
local CharacterVaultSave = require "engine.CharacterVaultSave"
local TextzoneList = require "engine.ui.TextzoneList"
local Separator = require "engine.ui.Separator"
local List = require "engine.ui.List"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor)
    self.actor = actor
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Attributes Roller", math.max(game.w * 0.7, 950), game.h*0.5, nil, nil, font)

    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih,alpha=0}

    --Reroll button
    self.c_reroll = Button.new{text="Reroll",fct=function() self:onRoll() end}

     --Pointbuy button
    self.c_pointbuy = Button.new{text="Next",fct=function() self:onPointBuy() end}

    self.t_roll = Tab.new {
    title = 'Roller',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('roll') end end,
  }
    self.t_pointbuy = Tab.new {
    title = 'Point buy',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('pointbuy') end end,
  }

    self.player = Player.new{name=self.player_name, game_ender=true}

    --Birth button
    self.c_save = Button.new{text="Next", fct=function() self:onBirth() end}
    self.c_premade = Button.new{text="Load premade", fct=function() self:loadPremadeUI() end}

    self.t_roll:select()

    self:onRoll()
end

function _M:switchTo(tab)
    self.t_roll.selected = tab == 'roll'
    self.t_pointbuy.selected = tab == 'pointbuy'

    self:drawDialog(tab)
end

function _M:drawDialog(tab)

    if tab == 'roll' then
        self:loadUI {
        {left=0, top=0, ui=self.t_roll},
        {left=self.t_roll, top=0, ui=self.t_pointbuy},
        {left=0, top=10, ui=self.c_desc},
        {left=0, bottom=100, ui=self.c_reroll},
        {left=0, bottom=0, ui=self.c_save},
        {left=self.c_save, bottom=0, ui=self.c_premade},
        {left=0, bottom=self.c_save.h + 5, ui=Separator.new{dir="vertical", size=self.iw - 10}},
    }
    
    self:setupUI()
    self:onRoll()
    self:drawTab()
end

    if tab == 'pointbuy' then
        self:loadUI {
        {left=0, top=0, ui=self.t_roll},
        {left=self.t_roll, top=0, ui=self.t_pointbuy},
        {left=0, top=10, ui=self.c_desc},
        {left=0, bottom=0, ui=self.c_pointbuy},
     --   {left=self.c_pointbuy, bottom=0, ui=self.c_save},
    }

    self:setupUI()
    self:onSetupPB()
    self:drawTab()
end    

end


function _M:onBirth()

    game:unregisterDialog(self)
    self.creating_player = true
    local birth = Birther.new(nil, self.actor, {"base", 'sex', 'race', 'class', 'background', 'deity', 'alignment', 'domains', 'domains'}, function()
        game:changeLevel(1, "dungeon")
        print("[PLAYER BIRTH] resolve...")
        game.player:resolve()
        game.player:resolve(nil, true)
        game.player.energy.value = game.energy_to_act
        game.paused = true
        game.player.changed = true
        print("[PLAYER BIRTH] resolved!")
        
        game.player:onBirth()
        local d = require("engine.dialogs.ShowText").new("Welcome to Veins of the Earth", "intro-"..game.player.starting_intro, {name=game.player.name}, nil, nil, function()
--self.player:playerLevelup() 
         game.creating_player = false

        game.player:levelPassives()
        game.player.changed = true
        end, true)
        game:registerDialog(d)

        end, quickbirth, game.w*0.6, game.h*0.6)

    game:registerDialog(birth)
end

function _M:onPointBuy()
    game:unregisterDialog(self)
    game:registerDialog(require("mod.dialogs.PointBuy").new(game.player))
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
    local player = self.actor
    local mod_sum = (player:getStr()-10)/2 + (player:getDex()-10)/2 + (player:getCon()-10)/2 + (player:getInt()-10)/2 + (player:getWis()-10)/2 + (player:getCha()-10)/2 
    if mod_sum <= 0 or (math.max(player:getStr(), math.max(player:getDex(), math.max(player:getCon(), math.max(player:getInt(), math.max(player:getWis(), player:getCha()))))) <= 13) then self:onRoll()
    else 
    self:drawTab() end
end

function _M:onSetupPB()
    for i, s in ipairs(self.actor.stats_def) do
        self.actor.stats[i] = 10
    end
end

function _M:drawTab()
    local player = self.actor
    local s = self.c_desc.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 20
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

--    s:drawColorStringBlended(self.font, ""..(player:randomItem())    

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

--Adjusted from ToME 4
function _M:loadPremade(pm)
   local fallback = pm.force_fallback

    -- Load the entities directly
    if not fallback and pm.module_version and pm.module_version[1] == game.__mod_info.version[1] and pm.module_version[2] == game.__mod_info.version[2] and pm.module_version[3] == game.__mod_info.version[3] then
        savefile_pipe:ignoreSaveToken(true)
        local qb = savefile_pipe:doLoad(pm.short_name, "entity", "engine.CharacterVaultSave", "character")
        savefile_pipe:ignoreSaveToken(false)

        -- Load the player directly
        if qb then
            game:unregisterDialog(d)
            game.player = qb
            self:loadedPremade()
        else
            fallback = true
        end
    else
        fallback = true
    end

    -- Do nothing
    if fallback then
        local ok = 0    
    end
end

--Taken from ToME 4
function _M:loadPremadeUI()
    local lss = Module:listVaultSavesForCurrent()
    local d = Dialog.new("Characters Vault", 600, 550)

    local sel = nil
    local desc = TextzoneList.new{width=220, height=400}
    local list list = List.new{width=350, list=lss, height=400,
        fct=function(item)
            local oldsel, oldscroll = list.sel, list.scroll
            if sel == item then self:loadPremade(sel) game:unregisterDialog(d) end
            if sel then sel.color = nil end
            item.color = colors.simple(colors.LIGHT_GREEN)
            sel = item
            list:generate()
            list.sel, list.scroll = oldsel, oldscroll
        end,
        select=function(item) desc:switchItem(item, item.description) end
    }
    local sep = Separator.new{dir="horizontal", size=400}

    local load = Button.new{text=" Load ", fct=function() if sel then self:loadPremade(sel) game:unregisterDialog(d) end end}
    local del = Button.new{text="Delete", fct=function() if sel then
        self:yesnoPopup(sel.name, "Really delete premade: "..sel.name, function(ret) if ret then
            local vault = CharacterVaultSave.new(sel.short_name)
            vault:delete()
            vault:close()
            lss = Module:listVaultSavesForCurrent()
            list.list = lss
            list:generate()
            sel = nil
        end end)
    end end}

    d:loadUI{
        {left=0, top=0, ui=list},
        {left=list.w, top=0, ui=sep},
        {right=0, top=0, ui=desc},

        {left=0, bottom=0, ui=load},
        {right=0, bottom=0, ui=del},
    }
    d:setupUI(true, true)
    --Can now go back to roller
    d.key:addBind("EXIT", function() 
        game:unregisterDialog(d) 
        game:registerDialog(require("mod.dialogs.Birther").new(game.player)) 
    end)
    game:unregisterDialog(self)
    game:registerDialog(d)
end

function _M:loadedPremade()

    game:unregisterDialog(self)
--    game:unregisterDialog(d)
    self.creating_player = true
    game:changeLevel(1, "dungeon")
    print("[PLAYER BIRTH] resolve...")
    game.player:resolve()
    game.player:resolve(nil, true)
    game.player.changed = true
    game.player.energy.value = game.energy_to_act
    game.paused = true
        
    print("[PLAYER BIRTH] resolved!")

    game.player:onPremadeBirth()
    local d = require("engine.dialogs.ShowText").new("Welcome to Veins of the Earth", "intro-"..game.player.starting_intro, {name=game.player.name}, nil, nil, function()
--self.player:playerLevelup() 
    game.creating_player = false

    game.player:levelPassives()
    game.player.changed = true
    end, true)
    game:registerDialog(d)
end