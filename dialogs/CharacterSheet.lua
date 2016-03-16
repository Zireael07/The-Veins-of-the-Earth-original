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

local ActorSkills = require 'mod.class.interface.ActorSkills'

module(..., package.seeall, class.inherit(Dialog, mod.class.interface.TooltipsData))

function _M:init(actor)
    self.actor = actor

    local actor = game.player

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

    self:generateList()
    self.c_list = ListColumns.new{width=self.iw, height=self.ih - 50, scrollbar=true, columns={
        {name="Name", width=20, display_prop="name"},
        {name="Total", width=10, display_prop="total"},
        {name="Ranks", width=10, display_prop="ranks"},
        {name="Stat", width=10, display_prop="stat"},
        {name="Feat/kit bonus", width=14, display_prop="bonus"},
        {name="Armor penalty", width=14, display_prop="acp"},
        {name="Load penalty", width=11, display_prop="load"},
    },
    list = self.list_skills,
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
        {left=self.t_skill, top=0, ui=self.t_effect},
        {left=self.t_effect, top=0, ui=self.t_cosmetic},
        {left=0, top=self.t_general.h, ui=self.vs},
    --    {left=0, top=self.t_general.h+5+self.vs.h, ui=self.c_playtime},
        {left=0, top=self.t_general.h+5+self.vs.h, ui=self.c_desc},
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
        {left=self.t_skill, top=0, ui=self.t_effect},
        {left=self.t_effect, top=0, ui=self.t_cosmetic},
        {left=0, top=self.t_general.h, ui=self.vs},
        {left=0, top=50, ui=self.c_list},
    }

    self:setupUI()
    game.tooltip:erase()
    end

    if tab == "effect" then
    self:loadUI{
        {left=0, top=0, ui=self.t_general},
        {left=self.t_general, top=0, ui=self.t_skill},
        {left=self.t_skill, top=0, ui=self.t_effect},
        {left=self.t_effect, top=0, ui=self.t_cosmetic},
        {left=0, top=self.t_general.h, ui=self.vs},
        {left=0, top=50, ui=self.c_eff}
    }

    self:setupUI()
    self:drawEffect()
    end

    if tab == "cosmetic" then
        self:loadUI{
            {left=0, top=0, ui=self.t_general},
            {left=self.t_general, top=0, ui=self.t_skill},
            {left=self.t_skill, top=0, ui=self.t_effect},
            {left=self.t_effect, top=0, ui=self.t_cosmetic},
            {left=0, top=self.t_general.h, ui=self.vs},
            {left=0, top=self.t_general.h+5+self.vs.h, ui=self.c_playtime},
            {left=0, top=self.t_general.h+5+self.vs.h+self.c_playtime.h, ui=self.c_cosmetic}
        }

    self:setupUI()
    self:drawKid()

    end

end

function _M:mouseZones(t, no_new)
    -- Offset the x and y with the window position and window title
    if not t.norestrict then
        for i, z in ipairs(t) do
            if not z.norestrict then
                z.x = z.x + self.display_x + 5
                z.y = z.y + self.display_y + 80
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
    local actor = self.actor
    local s = self.c_desc.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0

    s:drawColorStringBlended(self.font, "#SLATE#Name : "..(actor.name or "Unnamed"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#Sex : "..(actor.descriptor and actor.descriptor.sex or "Unknown"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "#SLATE#Race : "..(actor.descriptor and actor.descriptor.race or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    --Automatically print out classes
    if actor == game.player then
        local Birther = require "engine.Birther"

        local list = {}
        for i, d in ipairs(Birther.birth_descriptor_def.subclass) do

        local level = game.player.classes[d.name] or 0
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

    end

    h = h + self.font_h -- Adds an empty row

    if actor == game.player then
        s:drawColorStringBlended(self.font, "#LIGHT_GREEN#"..(actor:levelTitles() or "None"), w, h, 255, 255, 255, true) h = h + self.font_h
    end

    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_LEVEL, s:drawColorStringBlended(self.font, "Character level: "..(actor.level or "Unknown"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_EXP, s:drawColorStringBlended(self.font, "EXP : "..(actor.exp.."/"..actor:getExpChart(actor.level+1)), w, h, 255, 255, 255, true)) h = h + self.font_h
    s:drawColorStringBlended(self.font, "ECL : "..(actor.ecl or "N/A") , w, h, 255, 255, 255, true) h = h + self.font_h


    h = h + self.font_h -- Adds an empty row
    if actor == game.player then
        self:mouseTooltip(self.TOOLTIP_MONEY, s:drawColorStringBlended(self.font, "#ANTIQUE_WHITE#Money : "..(actor.money or "Unknown").."/"..(actor.bank_money or 0), w, h, 255, 255, 255, true)) h = h + self.font_h
    end

    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_LIFE, s:drawColorStringBlended(self.font, "Hit Points : #RED#"..(math.floor(actor.life).."/"..math.floor(actor.max_life)), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_WOUNDS, s:drawColorStringBlended(self.font, "Wounds : #DARK_RED#"..actor.wounds.."/"..actor.max_wounds, w, h, 255, 255, 255, true)) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    ac, log_ac = actor:getAC(true)

    --Handle locational AC
    if config.settings.veins.body_parts then
        local locations = { "torso", "arms", "legs", "head" }
        list = {}

        for i, location in pairs(locations) do
            ac = actor:getAC(true, false, location) or 10
            list[#list+1] = {loc=location, ac=ac}
        end

        for i, t in ipairs(list) do
            self:mouseTooltip(self.TOOLTIP_AC, s:drawColorStringBlended(self.font, ("%s AC : %d"):format(t.loc, t.ac), w, h, 255, 255, 255, true)) h = h + self.font_h
        end
    else
    self:mouseTooltip(self.TOOLTIP_AC, s:drawColorStringBlended(self.font, "AC : "..(ac or "Unknown").." ("..log_ac.." )", w, h, 255, 255, 255, true)) h = h + self.font_h
    end

    h = 0
    w = self.w * 0.25
    -- start on second column

        self:mouseTooltip(self.TOOLTIP_STATS, s:drawColorStringBlended(self.font, "#CHOCOLATE#Stats", w, h, 255, 255, 255, true)) h = h + self.font_h
    if actor == game.player then
        self:mouseTooltip(self.TOOLTIP_STR, s:drawColorStringBlended(self.font, "#SLATE#STR : #YELLOW#"..(actor:sheetColorStats('str').." #SANDY_BROWN#"..actor:getStrMod().." #YELLOW#/"..actor.train_str.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_DEX, s:drawColorStringBlended(self.font, "#SLATE#DEX : #YELLOW#"..(actor:sheetColorStats('dex').." #SANDY_BROWN#"..actor:getDexMod().." #YELLOW#/"..actor.train_dex.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_CON, s:drawColorStringBlended(self.font, "#SLATE#CON : #YELLOW#"..(actor:sheetColorStats('con').." #SANDY_BROWN#"..actor:getConMod().." #YELLOW#/"..actor.train_con.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_INT, s:drawColorStringBlended(self.font, "#SLATE#INT : #YELLOW#"..(actor:sheetColorStats('int').." #SANDY_BROWN#"..actor:getIntMod().." #YELLOW#/"..actor.train_int.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_WIS, s:drawColorStringBlended(self.font, "#SLATE#WIS : #YELLOW#"..(actor:sheetColorStats('wis').." #SANDY_BROWN#"..actor:getWisMod().." #YELLOW#/"..actor.train_wis.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_CHA, s:drawColorStringBlended(self.font, "#SLATE#CHA : #YELLOW#"..(actor:sheetColorStats('cha').." #SANDY_BROWN#"..actor:getChaMod().." #YELLOW#/"..actor.train_cha.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_LUC, s:drawColorStringBlended(self.font, "#SLATE#LUC : #YELLOW#"..(actor:sheetColorStats('luc').." #SANDY_BROWN#"..actor:getLucMod().." #YELLOW#/"..actor.train_luc.."/#LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    else
        self:mouseTooltip(self.TOOLTIP_STR, s:drawColorStringBlended(self.font, "#SLATE#STR : #YELLOW#"..(actor:sheetColorStats('str').." #SANDY_BROWN#"..actor:getStrMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_DEX, s:drawColorStringBlended(self.font, "#SLATE#DEX : #YELLOW#"..(actor:sheetColorStats('dex').." #SANDY_BROWN#"..actor:getDexMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_CON, s:drawColorStringBlended(self.font, "#SLATE#CON : #YELLOW#"..(actor:sheetColorStats('con').." #SANDY_BROWN#"..actor:getConMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_INT, s:drawColorStringBlended(self.font, "#SLATE#INT : #YELLOW#"..(actor:sheetColorStats('int').." #SANDY_BROWN#"..actor:getIntMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_WIS, s:drawColorStringBlended(self.font, "#SLATE#WIS : #YELLOW#"..(actor:sheetColorStats('wis').." #SANDY_BROWN#"..actor:getWisMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_CHA, s:drawColorStringBlended(self.font, "#SLATE#CHA : #YELLOW#"..(actor:sheetColorStats('cha').." #SANDY_BROWN#"..actor:getChaMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
        self:mouseTooltip(self.TOOLTIP_LUC, s:drawColorStringBlended(self.font, "#SLATE#LUC : #YELLOW#"..(actor:sheetColorStats('luc').." #SANDY_BROWN#"..actor:getLucMod().." #LAST#"), w, h, 255, 255, 255, true)) h = h + self.font_h
    end


    h = h + self.font_h -- Adds an empty row
    h = h + self.font_h -- Adds an empty row
    local enc, max_enc = actor:getEncumbrance(), actor:getMaxEncumbrance()
    if enc > max_enc * 0.33 then self:mouseTooltip(self.TOOLTIP_ENC, s:drawColorStringBlended(self.font, "Encumbrance : #YELLOW#"..(actor:getEncumbrance()).."#LAST#/"..(actor:getMaxEncumbrance()), w, h, 255, 255, 255, true)) h = h + self.font_h
    elseif enc > max_enc * 0.66 then self:mouseTooltip(self.TOOLTIP_ENC, s:drawColorStringBlended(self.font, "Encumbrance : #RED#"..(actor:getEncumbrance()).."#LAST#/"..(actor:getMaxEncumbrance()), w, h, 255, 255, 255, true)) h = h + self.font_h
    else self:mouseTooltip(self.TOOLTIP_ENC, s:drawColorStringBlended(self.font, "Encumbrance : "..(actor:getEncumbrance()).."/"..(actor:getMaxEncumbrance()), w, h, 255, 255, 255, true)) h = h + self.font_h end

    s:drawColorStringBlended(self.font, "Load penalty: "..(actor.load_penalty or "0"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row

    s:drawColorStringBlended(self.font, "Speed bonus: +"..(actor.movement_speed_bonus or "0"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    h = h + self.font_h -- Adds an empty row
--    h = h + self.font_h -- Adds an empty row
--    h = h + self.font_h -- Adds an empty row

    --display attacks in a smart way!
    local weapon = (actor:getInven("MAIN_HAND") and actor:getInven("MAIN_HAND")[1]) or actor
    if weapon and not weapon.ranged then
        self:mouseTooltip(self.TOOLTIP_ATTACK_MELEE, s:drawColorStringBlended(self.font, ("#SANDY_BROWN#Melee attack#LAST#: %d = %s"):format(actor:combatAttack(weapon)), w, h, 255, 255, 255, true)) h = h + self.font_h
    else
        self:mouseTooltip(self.TOOLTIP_ATTACK_MELEE, s:drawColorStringBlended(self.font, "#SANDY_BROWN#Melee attack#LAST#: BAB "..(actor.combat_bab or "0").." + Str bonus: "..actor:getStrMod(), w, h, 255, 255, 255, true)) h = h + self.font_h
    end
    if weapon and weapon.ranged then
        self:mouseTooltip(self.TOOLTIP_ATTACK_RANGED, s:drawColorStringBlended(self.font, ("#SANDY_BROWN#Ranged attack#LAST#: %d = %s"):format(actor:combatAttack(weapon)), w, h, 255, 255, 255, true)) h = h + self.font_h
    else
        self:mouseTooltip(self.TOOLTIP_ATTACK_RANGED, s:drawColorStringBlended(self.font, "#SANDY_BROWN#Ranged attack#LAST#: BAB: "..(actor.combat_bab or "0").." + Dex bonus: "..actor:getDexMod(), w, h, 255, 255, 255, true)) h = h + self.font_h
    end
    
    h = 0
    w = self.w*0.5
    --start on third column
    h = h + self.font_h -- Adds an empty row
    self:mouseTooltip(self.TOOLTIP_FORTITUDE, s:drawColorStringBlended(self.font, "Fortitude save: #SANDY_BROWN#"..((actor.fortitude_save.." + "..math.max(actor:getStrMod(), actor:getConMod())) or "0"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_REFLEX, s:drawColorStringBlended(self.font, "Reflex bonus : #SANDY_BROWN#"..((actor.reflex_save.." + "..math.max(actor:getDexMod(), actor:getIntMod())) or "0"), w, h, 255, 255, 255, true)) h = h + self.font_h
    self:mouseTooltip(self.TOOLTIP_WILL, s:drawColorStringBlended(self.font, "Will bonus : #SANDY_BROWN#"..((actor.will_save.." + "..math.max(actor:getWisMod(), actor:getChaMod())) or "0"), w, h, 255, 255, 255, true)) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row
    s:drawColorStringBlended(self.font, "#CHOCOLATE#Special qualities", w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawColorStringBlended(self.font, "Low-light vision: "..(actor.low_light_vision or "None"), w, h, 255, 255, 255, true) h = h + self.font_h
    s:drawStringBlended(self.font, "Darkvision : "..(actor.infravision or "None"), w, h, 255, 255, 255, true) h = h + self.font_h

    h = h + self.font_h -- Adds an empty row

    --Display deity and favor
    if actor == game.player then
        s:drawColorStringBlended(self.font, "Deity : "..(actor.descriptor.deity or "None"), w, h, 255, 255, 255, true) h = h + self.font_h
        s:drawColorStringBlended(self.font, "Favor : "..(actor.favor or 0), w, h, 255, 255, 255, true) h = h + self.font_h
    end

    h = 0
    w = self.w * 0.75
    -- start on last column (feats)
    self:mouseTooltip(self.TOOLTIP_FEAT, s:drawColorStringBlended(self.font, "#CHOCOLATE#Feats", w, h, 255, 255, 255, true)) h = h + self.font_h
    local list = {}

        for j, t in pairs(actor.talents_def) do
          if actor:knowTalent(t.id) and t.is_feat then
                if actor:classFeat(t.id) then name = "#GOLD#"..t.name
                else name = ("%s"):format(t.name) end


                list[#list+1] = {
                    name = name,
                --    name = ("%s"):format(t.name),
                --    desc = actor:getTalentFullDescription(t):toString(),
                    desc = ("%s"):format(t.info(actor,t)),
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

function _M:generateList()
    local list = {}

    for i, s in ipairs(ActorSkills.skill_defs) do
        local actor = game.player
        local name = s.name:capitalize().." ("..s.stat:upper()..")"
        local total = actor:colorSkill(s.id) or "0"
        local ranks = actor:attr("skill_"..s.id) or "0"
        local bonus = actor:attr("skill_bonus_"..s.id) or "0"
        local stat = actor:getSkillMod(s.id)
        local acp = actor:isSkillPenalty(s.id) and actor:attr("armor_penalty") or "N/A"
        local load = actor:isSkillPenalty(s.id) and actor:attr("load_penalty") or "N/A"

        list[#list+1] = {name=name, total=total, ranks=ranks, bonus=bonus, stat=stat, acp=acp, load=load}
    end

    self.list_skills = list
end

function _M:drawEffect()
    local actor = self.actor
    local s = self.c_eff.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0

    s:drawColorStringBlended(self.font, "#CHOCOLATE#Current effects : #LAST#", w, h, 255, 255, 255, true) h = h + self.font_h

    --draw effect list
    local list = {}

	for eff_id, p in pairs(actor.tmp) do
		local e = actor.tempeffect_def[eff_id]


    --    local eff_subtype = table.concat(table.keys(e.subtype), "/")
        local desc = nil
        local dur = p.dur + 1
        local name = e.desc

        if e.long_desc then
            desc = ("#{bold}##GOLD#%s\n(%s)#WHITE##{normal}#\n"):format(name, e.type)..e.long_desc
        --    desc = name.." "..e.type..e.long_desc(actor, p)
        else
        --    desc = name.." "..e.type
            desc = ("#{bold}##GOLD#%s\n(%s)#WHITE##{normal}#\n"):format(name, e.type)
        end

        list[#list+1] = {
            name = name,
            dur = dur,
            desc = desc,
            status = e.status,
            decrease = e.decrease,
        }
	end

    table.sort(list, function(a,b) return a.name < b.name end)

    for i, t in ipairs(list) do
        if t.status == "detrimental" then
            self:mouseTooltip(desc, s:drawColorStringBlended(self.font, (t.decrease > 0) and ("#LIGHT_RED#%s(%d)"):format(t.name, t.dur) or ("#LIGHT_RED#%s"):format(t.name), w, h, 255, 255, 255, true)) h = h + self.font_h
        elseif t.status == "neutral" then
            self:mouseTooltip(desc, s:drawColorStringBlended(self.font, (t.decrease > 0) and ("%s(%d)"):format(t.name, t.dur) or ("%s"):format(t.name), w, h, 255, 255, 255, true)) h = h + self.font_h
        else
            self:mouseTooltip(desc, s:drawColorStringBlended(self.font, (t.decrease > 0) and ("#LIGHT_GREEN#%s(%d)"):format(t.name, t.dur) or ("#LIGHT_GREEN#%s"):format(t.name), w, h, 255, 255, 255, true)) h = h + self.font_h
        end
    end

self.c_eff:generate()
self.changed = false

end

function _M:drawKid()
    local actor = self.actor
    local s = self.c_cosmetic.s

    s:erase(0,0,0,0)

    local h = 0
    local w = 0

    h = 0
    w = 0

    s:drawColorStringBlended(self.font, "#CHOCOLATE#Languages: #LAST#", w, h, 255, 255, 255, true) h = h + self.font_h

    local list = {}

    for i, n in pairs(actor.languages) do
        list[#list+1] = {
            name = n
        }
    end

    table.sort(list, function(a,b) return a.name < b.name end)

    for i,t in ipairs(list) do
        s:drawColorStringBlended(self.font, "#GOLD#"..t.name, w, h, 255, 255, 255, true) h = h + self.font_h
    end

    h = h + self.font_h -- Adds an empty row


    s:drawColorStringBlended(self.font, "#CHOCOLATE#Offspring : #LAST#", w, h, 255, 255, 255, true) h = h + self.font_h

    	local list = {}

    	for i, e in pairs(actor.kids) do

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
    game:registerDialog(require("mod.dialogs.KillCount").new(game.actor))
end
