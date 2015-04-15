require "engine.class"
require "mod.class.interface.TooltipsData"

local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local SurfaceZone = require "engine.ui.SurfaceZone"
local Separator = require "engine.ui.Separator"
local Stats = require "engine.interface.ActorStats"
local Textzone = require "engine.ui.Textzone"
local Tab = require 'engine.ui.Tab'
local ListColumns = require "engine.ui.ListColumns"
local Button = require "engine.ui.Button"

module(..., package.seeall, class.inherit(Dialog, mod.class.interface.TooltipsData))

function _M:init(actor)
    self.actor = actor

    local player = game.player

    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Character Sheet: "..self.actor.name, math.max(game.w * 0.7, 950), math.max(game.h*0.6, 550), nil, nil, font)

    --Let's show game stats!
    game.total_playtime = (game.total_playtime or 0) + (os.time() - (game.last_update or game.real_starttime))
    game.last_update = os.time()

    local playtime = ""
    local days = math.floor(game.total_playtime/86400)
    local hours = math.floor(game.total_playtime/3600) % 24
    local minutes = math.floor(game.total_playtime/60) % 60
    local seconds = game.total_playtime % 60

    if days > 0 then
        playtime = ("%i day%s %i hour%s %i minute%s %s second%s"):format(days, days > 1 and "s" or "", hours, hours > 1 and "s" or "", minutes, minutes > 1 and "s" or "", seconds, seconds > 1 and "s" or "")
    elseif hours > 0 then
        playtime = ("%i hour%s %i minute%s %s second%s"):format(hours, hours > 1 and "s" or "", minutes, minutes > 1 and "s" or "", seconds, seconds > 1 and "s" or "")
    elseif minutes > 0 then
        playtime = ("%i minute%s %s second%s"):format(minutes, minutes > 1 and "s" or "", seconds, seconds > 1 and "s" or "")
    else
        playtime = ("%s second%s"):format(seconds, seconds > 1 and "s" or "")
    end

--    local all_kills_kind = self.actor.all_kills_kind or {}
    local playtimetext = ([[#GOLD#Days adventuring / current month:#LAST# %d / %s
#GOLD#Time playing:#LAST# %s
]]):format(
        game.turn / game.calendar.DAY,
        game.calendar:getMonthName(game.calendar:getDayOfYear(game.turn)),
        playtime
    )

    self.c_playtime = Textzone.new{width=self.iw * 0.4, auto_height=true, no_color_bleed=true, font = self.font, text=playtimetext}

    self.vs = Separator.new{dir="vertical", size=self.iw}

    self.c_desc = SurfaceZone.new{width=self.iw, height=self.ih-self.c_playtime.h-15,alpha=0}
    self.c_kills = Button.new{text="Kills", fct=function() self:onKill() end}

    self.c_list = ListColumns.new{width=self.iw, height=self.ih - 50, scrollbar=true, columns={
        {name="Name", width=20, display_prop="name"},
        {name="Total", width=10, display_prop="total"},
        {name="Ranks", width=10, display_prop="ranks"},
        {name="Stat", width=10, display_prop="stat"},
        {name="Feat/kit bonus", width=14, display_prop="bonus"},
        {name="Armor penalty", width=14, display_prop="acp"},
        {name="Load penalty", width=11, display_prop="load"},
    },
    list={
        {name="Appraise (INT)", total=player:colorSkill("appraise") or "0", ranks=(player.skill_appraise or "0"), stat=player:getChaMod(), bonus=(player.skill_bonus_appraise or "0") },
        {name="Balance (DEX)", total=player:colorSkill("balance") or "0", ranks=(player.skill_balance or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_balance or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Bluff (CHA)", total=player:colorSkill("bluff") or "0", ranks=(player.skill_bluff or "0"), stat=player:getChaMod(), bonus=(player.skill_bonus_bluff or "0") },
        {name="Climb (STR)", total=player:colorSkill("climb") or "0", ranks=(player.skill_climb or "0"), stat=player:getStrMod(), bonus=(player.skill_bonus_climb or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Concentration (INT)", total=player:colorSkill("concentration") or "0", ranks=(player.skill_concentration or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_concentration or "0") },
        {name="Craft (INT)", total=player:colorSkill("craft") or "0", ranks=(player.skill_craft or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_craft or "0") },
        {name="Decipher Script (INT)", total=player:colorSkill("decipherscript") or "0", ranks=(player.skill_decipherscript or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_decipherscript or "0") },
        {name="Diplomacy (CHA)", total=player:colorSkill("diplomacy") or "0", ranks=(player.skill_diplomacy or "0"), stat=player:getChaMod(), bonus=(player.skill_bonus_diplomacy or "0") },
        {name="Disable Device (INT)", total=player:colorSkill("disabledevice") or "0", ranks=(player.skill_disabledevice or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_disabledevice or "0") },
        {name="Escape Artist (DEX)", total=player:colorSkill("escapeartist") or "0", ranks=(player.skill_escapeartist or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_escapeartist or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Handle Animal (WIS)", total=player:colorSkill("handleanimal") or "0", ranks=(player.skill_handleanimal or "0"), stat=player:getWisMod(), bonus=(player.skill_bonus_handleanimal or "0") },
        {name="Heal (WIS)", total=player:colorSkill("heal") or "0", ranks=(player.skill_heal or "0"), stat=player:getWisMod(), bonus=(player.skill_bonus_heal or "0") },
        {name="Hide (DEX)", total=player:colorSkill("hide") or "0", ranks=(player.skill_hide or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_hide or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Intimidate (CHA)", total=player:colorSkill("intimidate") or "0", ranks=(player.skill_intimidate or "0"), stat=player:getChaMod(), bonus=(player.skill_bonus_intimidate or "0") },
        {name="Intuition (INT)", total=player:colorSkill("intuition") or "0", ranks=(player.skill_intuition or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_intuition or "0") },
        {name="Jump (STR)", total=player:colorSkill("jump") or "0", ranks=(player.skill_jump or "0"), stat=player:getStrMod(), bonus=(player.skill_bonus_jump or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Knowledge (INT)", total=player:colorSkill("knowledge") or "0", ranks=(player.skill_knowledge or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_knowledge or "0") },
        {name="Listen (WIS)", total=player:colorSkill("listen") or "0", ranks=(player.skill_listen or "0"), stat=player:getWisMod(), bonus=(player.skill_bonus_listen or "0") },
        {name="Move Silently (DEX)", total=player:colorSkill("movesilently") or "0", ranks=(player.skill_movesilently or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_movesilently or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Open Lock (DEX)", total=player:colorSkill("openlock") or "0", ranks=(player.skill_openlock or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_openlock or "0") },
        {name="Pick Pocket (DEX)", total=player:colorSkill("pickpocket") or "0", ranks=(player.skill_pickpocket or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_pickpocket or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Ride (DEX)", total=player:colorSkill("ride") or "0", ranks=(player.skill_ride or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_ride or "0") },
        {name="Search (INT)", total=player:colorSkill("search") or "0", ranks=(player.skill_search or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_search or "0") },
        {name="Sense Motive (WIS)", total=player:colorSkill("sensemotive") or "0", ranks=(player.skill_sensemotive or "0"), stat=player:getWisMod(), bonus=(player.skill_bonus_sensemotive or "0") },
        {name="Spot (WIS)", total=player:colorSkill("spot") or "0", ranks=(player.skill_spot or "0"), stat=player:getWisMod(), bonus=(player.skill_bonus_spot or "0") },
        {name="Swim (STR)", total=player:colorSkill("swim") or "0", ranks=(player.skill_swim or "0"), stat=player:getStrMod(), bonus=(player.skill_bonus_swim or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Spellcraft (INT)", total=player:colorSkill("spellcraft") or "0", ranks=(player.skill_spellcraft or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_spellcraft or "0") },
        {name="Survival (WIS)", total=player:colorSkill("survival") or "0", ranks=(player.skill_survival or "0"), stat=player:getWisMod(), bonus=(player.skill_bonus_survival or "0") },
        {name="Tumble (DEX)", total=player:colorSkill("tumble") or "0", ranks=(player.skill_tumble or "0"), stat=player:getDexMod(), bonus=(player.skill_bonus_tumble or "0"), acp=(player.armor_penalty or "0"), load=(player.load_penalty or "0") },
        {name="Use Magic (INT)", total=player:colorSkill("usemagic") or "0", ranks=(player.skill_usemagic or "0"), stat=player:getIntMod(), bonus=(player.skill_bonus_usemagic or "0") },
    },
    fct=function(item) end, select=function(item, sel) end} --self:select(item) end

    self.c_eff = SurfaceZone.new{width=self.iw, height=self.ih-15,alpha=0}

    self.c_cosmetic = SurfaceZone.new{width=self.iw, height=self.ih-15,alpha=0}

    self.t_general = Tab.new {
    title = 'General',
    default = true,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('general') end end,
  }
    self.t_skill = Tab.new {
    title = 'Skills',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('skill') end end,
  }
    self.t_effect = Tab.new{
        title = "Effects",
        default = false,
        fct = function() end,
        on_change = function(s) if s then self:switchTo('effect') end end,
    }

    self.t_cosmetic = Tab.new{
        title = "Cosmetic",
        default = false,
        fct = function() end,
        on_change = function(s) if s then self:switchTo('cosmetic') end end,
    }

--[[    self.t_feats = Tab.new {
    title = 'Feats',
    default = false,
    fct = function() end,
    on_change = function(s) if s then self:switchTo('feats') end end,
  }]]

    self.t_general:select()

    self.key:addBind("EXIT", function() cs_player_dup = game.player:clone() game:unregisterDialog(self) end)
end

function _M:switchTo(tab)
    self.t_general.selected = tab == 'general'
    self.t_skill.selected = tab == 'skill'
    self.t_effect.selected = tab == 'effect'
    self.t_cosmetic.selected = tab == 'cosmetic'
--    self.t_feats.selected = tab == 'feats'

    self:drawDialog(tab)
end

function _M:drawDialog(tab)

    if tab == "general" then

    self:loadUI{
        {left=0, top=0, ui=self.t_general},
        {left=self.t_general, top=0, ui=self.t_skill},
        {left=self.t_skill, top=0, ui=self.t_cosmetic},
--        {left=self.t_skill, top=0, ui=self.t_effect},
        {left=0, top=self.t_general.h, ui=self.vs},
        {left=0, top=self.t_general.h+5+self.vs.h, ui=self.c_playtime},
        {left=0, top=self.t_general.h+5+self.vs.h+self.c_playtime.h, ui=self.c_desc},
        {left=0, bottom=0, ui=self.c_kills},
        {left=0, bottom=self.c_kills.h, ui=self.vs}
    }

    self:setupUI()
    self:drawGeneral()
    end

    if tab == "skill" then

    self:loadUI{
        {left=0, top=0, ui=self.t_general},
        {left=self.t_general, top=0, ui=self.t_skill},
        {left=self.t_skill, top=0, ui=self.t_cosmetic},
--        {left=self.t_skill, top=0, ui=self.t_effect},
        {left=0, top=50, ui=self.c_list},
    }

    self:setupUI()
    game.tooltip:erase()
    end

    if tab == "cosmetic" then
        self:loadUI{
            {left=0, top=0, ui=self.t_general},
            {left=self.t_general, top=0, ui=self.t_skill},
            {left=self.t_skill, top=0, ui=self.t_cosmetic},
            {left=0, top=50, ui=self.c_cosmetic}
        }

    self:setupUI()
    self:drawKid()

    end

    if tab == "effect" then
    self:loadUI{
        {left=0, top=0, ui=self.t_general},
        {left=self.t_general, top=0, ui=self.t_skill},
        {left=self.t_skill, top=0, ui=self.t_effect},
--        {left=0, top=50, ui=self.c_list_eff},
        {left=0, top=50, ui=self.c_eff}
    }

    self:setupUI()
    self:drawEffect()
    end
end

function _M:mouseZones(t, no_new)
    -- Offset the x and y with the window position and window title
    if not t.norestrict then
        for i, z in ipairs(t) do
            if not z.norestrict then
                z.x = z.x + self.display_x + 5
                z.y = z.y + self.display_y + 110 + 3
            end
        end
    end

    if not no_new then self.mouse = engine.Mouse.new() end
    self.mouse:registerZones(t)
end


function _M:mouseTooltip(text, _, _, _, w, h, x, y)
    self:mouseZones({
        { x=x, y=y, w=w, h=h, fct=function(button) game.tooltip_x, game.tooltip_y = 100, 100; game:tooltipDisplayAtMap(game.w*0.8, game.h*0.8, text) end},
    }, true)
end

--General tab
function _M:drawGeneral()
    local player = self.actor
    local s = self.c_desc.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0

    s:drawColorStringBlended(self.font, "#SLATE#Name : "..(player.name or "Unnamed"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#Race : "..(player.descriptor.race or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    --Automatically print out classes
    local Birther = require "engine.Birther"

    local list = {}
    local player = game.player
    for i, d in ipairs(Birther.birth_descriptor_def.class) do

    local level = player.classes[d.name] or 0
        if level > 0 then
        local name = ""
       name = "#WHITE#"..d.name.." #SANDY_BROWN#"..level.."#LAST#"

        table.insert(list, {name = name, desc = desc, level = level, real_name = d.name})
        end
    end

    self.list = list

    table.sort(self.list, function (a,b)
        if a.level == b.level then
            return a.name < b.name
        else
            return a.level > b.level
        end
    end)

    for i, d in ipairs(list) do
     s:drawColorStringBlended(self.font, ("%s"):format(d.name), w, h, 255, 255, 255, true) h = h + self.font_h
end

    h = h + self.font_h -- Adds an empty row

    s:drawColorStringBlended(self.font, "#LIGHT_GREEN#"..(player:levelTitles() or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_LEVEL, s:drawColorStringBlended(self.font, "Character level: "..(player.level or "Unknown"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_EXP, s:drawColorStringBlended(self.font, "EXP : "..(player.exp.."/"..player:getExpChart(player.level+1)), w, h, 255, 255, 255, true)) h = h + self.font_h
    s:drawColorStringBlended(self.font, "ECL : "..(player.ecl or "N/A") , w, h, 255, 255, 255, true) h = h + self.font_h


    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "#ANTIQUE_WHITE#Silver : "..(player.money or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_AC, s:drawColorStringBlended(self.font, "AC : "..(player:getAC() or "Unknown"), w, h, 255, 255, 255, true)) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_LIFE, s:drawColorStringBlended(self.font, "Hit Points : #RED#"..(math.floor(player.life).."/"..math.floor(player.max_life)), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_WOUNDS, s:drawColorStringBlended(self.font, "Wounds : #DARK_RED#"..player.wounds.."/"..player.max_wounds, w, h, 255, 255, 255, true)) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_ATTACK_MELEE, s:drawColorStringBlended(self.font, "#SANDY_BROWN#Melee attack#LAST#: BAB "..(player.combat_bab or "0").." + Str bonus: "..player:getStrMod(), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_ATTACK_RANGED, s:drawColorStringBlended(self.font, "#SANDY_BROWN#Ranged attack#LAST#: BAB: "..(player.combat_bab or "0").." + Dex bonus: "..player:getDexMod(), w, h, 255, 255, 255, true)) h = h + self.font_h


    h = 0
    w = self.w * 0.25
    -- start on second column
    self:mouseTooltip(self.TOOLTIP_STATS, s:drawColorStringBlended(self.font, "#CHOCOLATE#Stats", w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_STR, s:drawColorStringBlended(self.font, "#SLATE#STR : #YELLOW#"..(player:sheetColorStats('str').." #SANDY_BROWN#"..player:getStrMod().." #YELLOW#/"..player.train_str.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_DEX, s:drawColorStringBlended(self.font, "#SLATE#DEX : #YELLOW#"..(player:sheetColorStats('dex').." #SANDY_BROWN#"..player:getDexMod().." #YELLOW#/"..player.train_dex.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_CON, s:drawColorStringBlended(self.font, "#SLATE#CON : #YELLOW#"..(player:sheetColorStats('con').." #SANDY_BROWN#"..player:getConMod().." #YELLOW#/"..player.train_con.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_INT, s:drawColorStringBlended(self.font, "#SLATE#INT : #YELLOW#"..(player:sheetColorStats('int').." #SANDY_BROWN#"..player:getIntMod().." #YELLOW#/"..player.train_int.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_WIS, s:drawColorStringBlended(self.font, "#SLATE#WIS : #YELLOW#"..(player:sheetColorStats('wis').." #SANDY_BROWN#"..player:getWisMod().." #YELLOW#/"..player.train_wis.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_CHA, s:drawColorStringBlended(self.font, "#SLATE#CHA : #YELLOW#"..(player:sheetColorStats('cha').." #SANDY_BROWN#"..player:getChaMod().." #YELLOW#/"..player.train_cha.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_LUC, s:drawColorStringBlended(self.font, "#SLATE#LUC : #YELLOW#"..(player:sheetColorStats('luc').." #SANDY_BROWN#"..player:getLucMod().." #YELLOW#/"..player.train_luc.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    h = h + self.font_h -- Adds an empty row
    local enc, max_enc = player:getEncumbrance(), player:getMaxEncumbrance()
    if enc > max_enc * 0.33 then self:mouseTooltip(self.TOOLTIP_ENC, s:drawColorStringBlended(self.font, "Encumbrance : #YELLOW#"..(player:getEncumbrance()).."#LAST#/"..(player:getMaxEncumbrance()), w, h, 255, 255, 255, true)) h = h + self.font_h
    elseif enc > max_enc * 0.66 then self:mouseTooltip(self.TOOLTIP_ENC, s:drawColorStringBlended(self.font, "Encumbrance : #RED#"..(player:getEncumbrance()).."#LAST#/"..(player:getMaxEncumbrance()), w, h, 255, 255, 255, true)) h = h + self.font_h
    else self:mouseTooltip(self.TOOLTIP_ENC, s:drawColorStringBlended(self.font, "Encumbrance : "..(player:getEncumbrance()).."/"..(player:getMaxEncumbrance()), w, h, 255, 255, 255, true)) h = h + self.font_h end

    s:drawColorStringBlended(self.font, "Load penalty: "..(player.load_penalty or "0"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row

    s:drawColorStringBlended(self.font, "Speed bonus: +"..(player.movement_speed_bonus or "0"), w, h, 255, 255, 255, true) h = h + self.font_h


    h = 0
    w = self.w*0.5
    --start on third column
    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_FORTITUDE, s:drawColorStringBlended(self.font, "Fortitude save: #SANDY_BROWN#"..((player.fortitude_save.." + "..math.max(player:getStrMod(), player:getConMod())) or "0"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_REFLEX, s:drawColorStringBlended(self.font, "Reflex bonus : #SANDY_BROWN#"..((player.reflex_save.." + "..math.max(player:getDexMod(), player:getIntMod())) or "0"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_WILL, s:drawColorStringBlended(self.font, "Will bonus : #SANDY_BROWN#"..((player.will_save.." + "..math.max(player:getWisMod(), player:getChaMod())) or "0"), w, h, 255, 255, 255, true)) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "#CHOCOLATE#Special qualities", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Darkvision : "..(player.infravision or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row

    --Display deity and favor
    s:drawColorStringBlended(self.font, "Deity : "..(player.descriptor.deity or "None"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Favor : "..(player.favor or 0), w, h, 255, 255, 255, true) h = h + self.font_h


    h = 0
    w = self.w * 0.75
    -- start on last column (feats)
    self:mouseTooltip(self.TOOLTIP_FEAT, s:drawColorStringBlended(self.font, "#CHOCOLATE#Feats", w, h, 255, 255, 255, true)) h = h + self.font_h
    local list = {}

        for j, t in pairs(player.talents_def) do
          if player:knowTalent(t.id) and t.is_feat then
                if player:classFeat(t.id) then name = "#GOLD#"..t.name
                else name = ("%s"):format(t.name) end


                list[#list+1] = {
                    name = name,
                --    name = ("%s"):format(t.name),
                --    desc = player:getTalentFullDescription(t):toString(),
                    desc = ("%s"):format(t.info(player,t)),
                }
            end
        end




        table.sort(list, function(a,b) return a.name < b.name end)

        for i, t in ipairs(list) do
            self:mouseTooltip(t.desc, s:drawColorStringBlended(self.font, ("%s"):format(t.name), w, h, 255, 255, 255, true)) h = h + self.font_h

    --        if h + self.font_h >= self.c_desc.h then h = 0 w = w + self.c_desc.w / 6 end
        end

    self.c_desc:generate()
    self.changed = false
end

function _M:drawEffect()
    local player = self.actor
    local s = self.c_eff.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0

    s:drawColorStringBlended(self.font, "#CHOCOLATE#Effects : #LAST#", w, h, 255, 255, 255, true) h = h + self.font_h

    --draw effect list
--    local good_e, bad_e = {}, {}
	for eff_id, p in pairs(player.tmp) do
		local e = player.tempeffect_def[eff_id]


        local list = {}
    --    local eff_subtype = table.concat(table.keys(e.subtype), "/")
        local desc = nil
        local dur = p.dur + 1
        local name = e.desc

        if e.long_desc then
            desc = ("#{bold}##GOLD#%s\n(%s)#WHITE##{normal}#\n"):format(name, e.type)..e.long_desc(player, p)
        else
            desc = ("#{bold}##GOLD#%s\n(%s)#WHITE##{normal}#\n"):format(name, e.type)
        end


--[[        if e.status == "detrimental" then name = "#LIGHT_RED#"..e.desc
        else name = ("%s"):format(e.desc) end]]

        list[#list+1] = {
            name = name,
            dur = dur,
            desc = desc,
        }

	--	if e.status == "detrimental" then bad_e[eff_id] = p else good_e[eff_id] = p end
	end

    table.sort(list, function(a,b) return a.name < b.name end)

    for i, t in ipairs(list) do
        if e.status == "detrimental" then
            self:mouseTooltip(desc, s:drawColorStringBlended(self.font, (e.decrease > 0) and ("#LIGHT_RED#%s(%d)"):format(name, dur) or ("#LIGHT_RED#%s"):format(name), w, h, 255, 255, 255, true)) h = h + self.font_h
        else
            self:mouseTooltip(desc, s:drawColorStringBlended(self.font, (e.decrease > 0) and ("#LIGHT_GREEN#%s(%d)"):format(name, dur) or ("#LIGHT_GREEN#%s"):format(name), w, h, 255, 255, 255, true)) h = h + self.font_h
        end
    end

self.c_eff:generate()
self.changed = false

end

function _M:drawKid()
    local player = self.actor
    local s = self.c_cosmetic.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0

    s:drawColorStringBlended(self.font, "#CHOCOLATE#Kids : #LAST#", w, h, 255, 255, 255, true) h = h + self.font_h

    	local list = {}

    	for i, e in pairs(player.kids) do

    		list[#list+1] = {
    			name = e.name,
    			race = e.subtype,
    			alignment = e.alignment,
    			str = e:getStr(),
                dex = e:getDex(),
                con = e:getCon(),
                int = e:getInt(),
                wis = e:getWis(),
                cha = e:getCha(),
                luc = e:getLuc()
    		}
    	end

    	table.sort(list, function(a,b) return a.name < b.name end)

        for i, t in ipairs(list) do
            s:drawColorStringBlended(self.font, t.name.." the "..t.alignment.. " "..t.race, w, h, 255, 255, 255, true) h = h + self.font_h
            s:drawColorStringBlended(self.font, "STR "..t.str.." DEX "..t.dex.." CON "..t.con.." INT "..t.int.." WIS "..t.wis.." CHA "..t.cha.." LUC "..t.luc, w, h, 255, 255, 255, true) h = h + self.font_h
        end

self.c_cosmetic:generate()
self.changed = false

end


function _M:onKill()
    game:unregisterDialog(self)
    game:registerDialog(require("mod.dialogs.KillCount").new(game.player))
end
