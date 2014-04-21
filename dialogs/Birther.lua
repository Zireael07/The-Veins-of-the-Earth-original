require "engine.class"

local Dialog = require "engine.ui.Dialog"
local Birther = require "engine.Birther"

local SurfaceZone = require "engine.ui.SurfaceZone"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local Tab = require 'engine.ui.Tab'

local Textbox = require "engine.ui.Textbox"
local Checkbox = require "engine.ui.Checkbox"
local ListColumns = require "engine.ui.ListColumns"

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

local NameGenerator = require "engine.NameGenerator"

module(..., package.seeall, class.inherit(Birther))

--For stats
local _points_text = "Points left: #00FF00#%d#WHITE#"

function _M:init(title, actor, order, at_end, quickbirth, w, h)
    self.quickbirth = quickbirth
    self.actor = actor
    self.order = order
    self.at_end = at_end
    
    self.font = core.display.newFont("/data/font/VeraMono.ttf", 12)
    Dialog.init(self, "Character Creation", math.max(game.w * 0.7, 950), game.h*0.8, nil, nil, font)

    --Birther stuff
    self.descriptors = {}
    self.descriptors_by_type = {}

    --Name stuff
    self.max = 30
    self.min = 2

    --UI starts here
--    self.c_name = Textbox.new{title="Name: ", text="", chars=30, max_len=self.max, fct=function(text) self:okclick() end, on_mouse = function(button) if button == "right" then self:randomName() end end}

    self.c_name = Textbox.new{title="Name: ", text="", chars=30, max_len=self.max, fct=function() end, on_change=function() self:setDescriptor() end, on_mouse = function(button) if button == "right" then self:randomName() end end}

    self.c_female = Checkbox.new{title="Female", default=true,
        fct=function() end,
        on_change=function(s) self.c_male.checked = not s self:setDescriptor("sex", s and "Female" or "Male") end
    }
    self.c_male = Checkbox.new{title="Male", default=false,
        fct=function() end,
        on_change=function(s) self.c_female.checked = not s self:setDescriptor("sex", s and "Male" or "Female") end
    }

--    self:onRoll()
    self:onSetupPB()

    --Stats list

    self.unused_stats = self.unused_stats or 32
    self.c_points = Textzone.new{width=self.iw/6, height=15, no_color_bleed=true, text=_points_text:format(self.unused_stats)}

    self.c_stats = ListColumns.new{width=self.iw/6, height=200, all_clicks=true, columns={
        {name="Stat", width=30, display_prop="name"},
        {name="Value", width=30, display_prop="val"},
    }, list={
        {name="STR", val=self.actor:getStr(), stat_id=self.actor.STAT_STR, delta = 1},
        {name="DEX", val=self.actor:getDex(), stat_id=self.actor.STAT_DEX, delta = 1},
        {name="CON", val=self.actor:getCon(), stat_id=self.actor.STAT_CON, delta = 1},
        {name="INT", val=self.actor:getInt(), stat_id=self.actor.STAT_INT, delta = 1},
        {name="WIS", val=self.actor:getWis(), stat_id=self.actor.STAT_WIS, delta = 1},
        {name="CHA", val=self.actor:getCha(), stat_id=self.actor.STAT_CHA, delta = 1},
        {name="LUC", val=self.actor:getLuc(), stat_id=self.actor.STAT_LUC, delta = 1},
    }, fct=function(item, _, v)
        self:incStat(v == "left" and 1 or -1, item.stat_id)
    end, select=function(item, sel) self.sel = sel self.val = item.val self.id = item.stat_id self.delta = item.delta end}

    self.c_reroll = Button.new{text="Reroll",fct=function() self:onRoll() end}


    --Lists --self:use(item)
    self:setDescriptor("base", "base")


    self:generateClasses()
    self.c_class = List.new{width=self.iw/6, nb_items=#self.list_class, list=self.list_class, fct=function(item) self:ClassUse(item) end, select=function(item,sel) self:updateDesc(item) end}--self:on_select(item,sel) end}

    self:generateRaces()
    self.c_race = List.new{width=self.iw/6, nb_items=#self.list_race, list=self.list_race, fct=function(item) self:RaceUse(item) end, select=function(item,sel) self:updateDesc(item) end} --self:on_select(item,sel) end}

    self:generateBackgrounds()
    self.c_background = List.new{width=self.iw/6, nb_items=#self.list_background, list=self.list_background, fct=function(item) self:BackgroundUse(item) end, select=function(item,sel) self:on_select(item,sel) end}

    self:generateAlignment()
    self.c_alignment = List.new{width=self.iw/6, nb_items=#self.list_alignment, list=self.list_alignment, fct=function(item) self:AlignmentUse(item) end, select=function(item,sel) self:on_select(item,sel) end}

    self.c_desc = TextzoneList.new{width=self.iw - ((self.iw/6)*4)-20, height = 400, scrollbar=true, text="Hello from description"}

    self.c_premade = Button.new{text="Load premade", fct=function() self:loadPremadeUI() end}
    self.c_save = Button.new{text="     Play!     ", fct=function() self:atEnd() end}

    self:loadUI{
        -- First line
        {left=0, top=0, ui=self.c_name},
        {left=self.c_name, top=0, ui=self.c_female},
        {left=self.c_female, top=0, ui=self.c_male},

        {left=0, top=self.c_name.h + 5, ui=Separator.new{dir="vertical", size=self.iw - 10}},
        --Second line (stats)
        {left=0, top=self.c_name.h + 20, ui=self.c_points},
        {left=0, top=self.c_name.h + 20 + self.c_points.h, ui=self.c_stats},
        {left=self.c_stats.w + 5, top = self.c_name.h + 20, ui=self.c_reroll},
        {left=0, top=self.c_name.h + 20 + self.c_points.h + self.c_stats.h, ui=Separator.new{dir="vertical", size=((self.iw/6)*4)}},

   --     topstuff self.c_name.h + 15 + self.c_points.h + self.c_stats.h
        --Third line (lists)
        {left=0, top=self.c_name.h + 20 + self.c_points.h + self.c_stats.h + 10, ui=self.c_class},
        {left=self.c_class, top=self.c_name.h + 20 + self.c_points.h + self.c_stats.h + 10, ui=self.c_race},
        {left=self.c_race, top=self.c_name.h + 20 + self.c_points.h + self.c_stats.h + 10, ui=self.c_background},
        {left=self.c_background, top=self.c_name.h + 20 + self.c_points.h + self.c_stats.h + 10, ui=self.c_alignment},

        --Description
        {right=0, top=self.c_name.h + 15, ui=self.c_desc},

        --Buttons
        {left=0, bottom=0, ui=self.c_premade},
        {right=0, bottom=0, ui=self.c_save},
        {left=0, bottom=self.c_save.h + 5, ui=Separator.new{dir="vertical", size=self.iw - 10}},

    }
    self:setFocus(self.c_stats)
    self:setFocus(self.c_name)

    self:setupUI()

--    self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
    
--        self:onRoll()
--    self:onSetupPB()

end

--Ensure stats at start
function _M:onSetupPB()
    for i, s in ipairs(self.actor.stats_def) do
        self.actor.stats[i] = 10
    end
end


function _M:atEnd()
    game:unregisterDialog(self)
    self:apply()
    self.at_end()
    print("[BIRTHER] Finished!")
end

--Name stuffs 
function _M:checkNew(fct)
    local savename = self.c_name.text:gsub("[^a-zA-Z0-9_-.]", "_")
    if fs.exists(("/save/%s/game.teag"):format(savename)) then
        Dialog:yesnoPopup("Overwrite character?", "There is already a character with this name, do you want to overwrite it?", function(ret)
            if not ret then fct() end
        end, "No", "Yes")
    else
        fct()
    end
end

function _M:okclick()
    local name = self.c_name.text

    if name:len() < self.min or name:len() > self.max then
        Dialog:simplePopup("Error", ("Must be between %i and %i characters."):format(self.min, self.max))
        return
    end

    self:checkNew(name, function()
        game:unregisterDialog(self)
        self.action(name)
    end)
end

--Add tip for naming
function _M:on_focus(id, ui)
    if self.focus_ui and self.focus_ui.ui == self.c_name then self.c_desc:switchItem(self.c_name, "This is the name of your character.\nRight mouse click to generate a random name based on race and sex.") end
end

--List stuff
function _M:updateDesc(item)
    if item and item.desc then
       if self.c_desc then self.c_desc:switchItem(item, item.desc) end
    end
end

--[[function _M:use(item)
end]]

function _M:on_select(item,sel)
--    if self.c_desc then self.updateDesc(item) end
    if self.c_desc then self.c_desc:switchItem(item, item.desc) end
    self.selection = sel    
end

function _M:updateDescriptors()
    self.descriptors = {}
    table.insert(self.descriptors, self.birth_descriptor_def.base[self.descriptors_by_type.base])
    table.insert(self.descriptors, self.birth_descriptor_def.sex[self.descriptors_by_type.sex])
    table.insert(self.descriptors, self.birth_descriptor_def.race[self.descriptors_by_type.race])
    table.insert(self.descriptors, self.birth_descriptor_def.class[self.descriptors_by_type.class])
    table.insert(self.descriptors, self.birth_descriptor_def.background[self.descriptors_by_type.background])   
    table.insert(self.descriptors, self.birth_descriptor_def.alignment[self.descriptors_by_type.alignment])
end

function _M:setDescriptor(key, val)
    if key then
        self.descriptors_by_type[key] = val
        print("[BIRTHER] set descriptor", key, val)
    end
   self:updateDescriptors()

   local ok --= self.c_name.text:len() >= 2
--[[   for i, o in ipairs(self.order) do
        if not self.descriptors_by_type[o] then
            ok = false
            print("Missing ", o)
            break
        end
    end
    self:toggleDisplay(self.c_save, ok) ]] 
end

function _M:isDescriptorAllowed(d, ignore_type)
    self:updateDescriptors()

    if type(ignore_type) == "string" then
        ignore_type = {[ignore_type] = true}
    end
    ignore_type = ignore_type or {}

    local allowed = true
    local type = d.type
    print("[BIRTHER] checking allowance for ", d.name)
    for j, od in ipairs(self.descriptors) do
            if od.descriptor_choices and od.descriptor_choices[type] then
                local what = util.getval(od.descriptor_choices[type][d.name], self) or util.getval(od.descriptor_choices[type].__ALL__, self)
                if what and what == "allow" then
                    allowed = true
                elseif what and (what == "never" or what == "disallow") then
                    allowed = false
                elseif what and what == "forbid" then
                    allowed = nil
                end
                print("[BIRTHER] test against ", od.name, "=>", what, allowed)
                if allowed == nil then break end
            end
    end
return allowed
end

--Generate the lists
function _M:generateClasses()
    local list = {}
    for i, d in ipairs(Birther.birth_descriptor_def.class) do
        if self:isDescriptorAllowed(d) then

          local color = {255,255,255}
          list[#list+1] = {name=d.name, color = color, desc=d.desc, d = d}
        end
    end
    self.list_class = list
end 

function _M:generateRaces()
    local list = {}
    for i, d in ipairs(Birther.birth_descriptor_def.race) do
        if self:isDescriptorAllowed(d) then
          local color = {255,255,255}

          list[#list+1] = {name=d.name, color = color, desc=d.desc, d = d}
        end
    end
    self.list_race = list
end 

function _M:generateBackgrounds()
    local list = {}
    for i, d in ipairs(Birther.birth_descriptor_def.background) do
        if self:isDescriptorAllowed(d) then

          local color = {255,255,255}

          list[#list+1] = {name=d.name, color = color, desc=d.desc, d = d}
        end
    end
    self.list_background = list
end   

function _M:generateAlignment()
    local list = {}
    for i, d in ipairs(Birther.birth_descriptor_def.alignment) do
        if self:isDescriptorAllowed(d) then

          local color = {255,255,255}

          list[#list+1] = {name=d.name, color = color, desc=d.desc, d = d}
        end
    end
    self.list_alignment = list
end   

function _M:RaceUse(item, sel)
    if not item then return end
    self:setDescriptor("race", item.name)
    self.sel_race = item
    self.sel_race.color = {255, 215, 0}
    self.c_race:drawItem(item)
--    self:generateRaces()
end

function _M:ClassUse(item, sel)
    if not item then return end
    self:setDescriptor("class", item.name)
    self.sel_class = item
    self.sel_class.color = {255, 215, 0}
    self.c_class:drawItem(item)
--[[    self.generateClasses()

    self:generateBackgrounds()
    self:generateAlignment()]]
end

function _M:AlignmentUse(item, sel)
    if not item then return end
    self:setDescriptor("alignment", item.name)
    self.sel_alignment = item
    self.sel_alignment.color = {255, 215, 0}
    self.c_alignment:drawItem(item)

--[[    self:generateClasses()
    self:generateAlignment()]]
end

function _M:BackgroundUse(item, sel)
    if not item then return end
    self:setDescriptor("background", item.name)
    self.sel_background = item
    self.sel_background.color = {255, 215, 0}
    self.c_background:drawItem(item)
--[[    self:generateBackgrounds()

    self:generateClasses()]]
end

--Stats stuff
function _M:getCost(val)
    --Handle differing costs (PF style)
    -- 7 = -4; 8 = -2; 9 = -1; 10 = 0; 11 = 1; 12 = 2; 13 = 3; 14 = 5; 15 = 7; 16 = 10; 17 = 13; 18 = 17
    local costs = { -4, -2, -1, 0, 1, 2, 3, 5, 7, 10, 13, 17 }


    return costs[val-6]
end

function _M:incStat(v, id)
    print("inside incStat. self.sel is", self.sel)
    print("inside incStat. id is", self.id)
    local id = self.id
    local val = self.val

    local delta = self:getCost(val) * v

    --Limits
    if v == 1 then
        if delta > self.unused_stats then
            self:simplePopup("Not enough stat points", "You have no stat points left!")
            return
        end
        if self.unused_stats <= 0 then
            self:simplePopup("Not enough stat points", "You have no stat points left!")
            return
        end
        if self.actor.stats[id] >= 18 then
            self:simplePopup("Max stat value reached", "You cannot increase a stat above 18")
            return
        end
    else return end
--[[        if self.unused_stats >= 32 then
            self:simplePopup("Max stat points reached", "You can't have more stat points!")
            return
        end
        if self.actor.stats[id] <= 3 then
            self:simplePopup("Min stat value reached", "You cannot decrease a stat below 3")
            return
        end
    end]]

    local sel = self.sel
--  self.actor.stats[id] = self.actor.stats[id] + v

    self.actor:incStat(sel, v)
    self.unused_stats = self.unused_stats - delta
    self.c_stats.list[sel].val = self.actor.stats[id]
    self.c_stats:generate()
    self.c_stats.sel = sel
    self.c_stats:onSelect()
    self.c_points.text = _points_text:format(self.unused_stats)
    self.c_points:generate()
    self:update()
end

function _M:update()
    self.c_stats.key:addBinds{
    --    ACCEPT = function() self.key:triggerVirtual("EXIT") end,
        MOVE_LEFT = function() self:incStat(-1) end,
        MOVE_RIGHT = function() self:incStat(1) end,
    }
end

--Roller stuff now
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
    else self.c_stats:generate() end


    --self:drawTab() end
end


-- Disable stuff from the base Birther
function _M:updateList() end
function _M:selectType(type) end

function _M:on_register()
    if __module_extra_info.auto_quickbirth then
        local qb_short_name = __module_extra_info.auto_quickbirth:gsub("[^a-zA-Z0-9_-.]", "_")
        local lss = Module:listVaultSavesForCurrent()
        for i, pm in ipairs(lss) do
            if pm.short_name == qb_short_name then
                self:loadPremade(pm)
                break
            end
        end
    end
end


--Adjusted from ToME 4 - load premade
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
    --    game:registerDialog(require("mod.dialogs.Birther").new(game.player))
        game:registerDialog(self) 
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

--Random names
function _M:randomName()

local random_name = {
  --Expanded with some Incursion names that matched the theme
  human_male = {
  syllablesStart ="Aethelmed, Aeron, Courynn, Blath, Bran, Lander, Luth, Daelric, Darvin, Dorn, Evendur, Grim, Jon, Helm, Morn, Randal, Lynneth, Rowan, Sealmyd, Borivik, Fyodor, Grigor, Ivor, Pavel, Vladislak, Anton, Marcon, Pieron, Rimardo, Romero, Salazar, Khalid, Rasheed, Zasheir, Pradir, Rajaput, Sikhir, Aoth, Ehput-Ki, Kethoth, Ramas, So-Kehur, Sammal, Kierny, Rathmere, Michealis, Matthais, Achrim, David, Quinn, Abrash, Pavrash, Vorkai",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Wyndael, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag",
  rules = "$s $e",
  },
  --Expanded with some Incursion names that matched the theme
  human_female = {
  syllablesStart ="Ariadne, Courynna, Daelra, Lynneth, Betha, Kethra, Miri, Rowan, Shandri, Shandril, Sealmyd, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Dona, Luisa, Marta, Selise, Mara, Natali, Olga, Zofia, Jaheira, Zasheira, Nismet, Ril, Tiket, Chathi, Nephis, Sefris, Thola",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Wyndael, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Ringal, Wernast, Onhalm, Faravis, Ferholm, Oswin, Hisham, Ullast, Senovise, Achabald",
  rules = "$s $e",
  },
  halfelf_male = {
  syllablesStart ="Aethelmed, Aeron, Courynn, Lander, Luth, Daelric, Darvin, Dorn, Evendur, Jon, Joneleth, Helm, Morn, Randal, Lynneth, Rowan, Sealmyd, Romero, Salazar, Khalid, Zasheir, Pradir, Rajaput, Sikhir, Aoth, Kethoth, Ramas, So-Kehur",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Wyndael, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
  rules = "$s $e",
  },

  halfelf_female = {
  syllablesStart ="Ariadne, Courynna, Lynneth, Miri, Rowan, Sealmyd, Shandri, Shandril, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Dona, Luisa, Selise, Mara, Natali, Zofia, Jaheira, Zasheira, Nismet, Ril, Nephis, Sefris, Laele, Larynda, Talice, Malice",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
  rules = "$s $e",
  },

  --Expanded with some Incursion names that matched the theme
  elf_male = {
  syllablesStart ="Aravilar, Faelar, Saevel, Rhistel, Taeghen, Iliphar, Othorion, Aramil, Enialis, Ivellios, Laucian, Quarion, Selasia, Faridhir, Semirathis, Agorna, Disead, Cassius, Lachin, Tesserath, Amakiir, Holimion, Meliamne, Siannodel, Ilphukiir, Naofindel, Dios, Celebrand",
  syllablesMiddle = "Moon, Evening, Star, Gem, Diamond, Silver, Night, Blossom, Gold",
  syllablesEnd ="flower, blade, star, fall, whisper, dew, frond, child, heel, breeze, brook, petal",
  rules = "$s $m$e",
  },

  --Expanded with some Incursion names that matched the theme
  elf_female = {
  syllablesStart ="Hacathra, Imizael, Jhaumrithe, Quamara, Talindra, Vestele, Alea, Eoslin, Sephira, Selasia, Anastrianna, Antinua, Drusilia, Felosial, Ielenia, Lia, Qillathe, Silaqui, Valanthe, Xanaphia, Amastacia, Galanodel, Liadon, Xiloscient, Iosefel, Samariel, Morwen, Raelin, Vaegwal",
  syllablesMiddle = "Moon, Evening, Star, Gem, Diamond, Silver, Night, Blossom, Gold",
  syllablesEnd ="flower, blade, star, fall, whisper, dew, frond, child, heel, breeze, brook, petal",
  rules = "$s $m$e",
  },

  drow_male = { 
  syllablesStart ="Alak, Drizzt, Ilmryn, Khalazza, Merinid, Mourn, Nym, Pharaun, Rizzen, Solaufein, Sorn, Veldrin, Tebryn, Zaknafein, Dhauntel, Gomur'ss, Sornrak, Sszerin, Adinirahc, Belgos, Antatlab, Calimar, Duagloth, Elkantar, Filraen, Gelroos, Houndaer, Ilphrin, Kelnozz, Krondorl, Nalfein, Nilonim, Ryltar, Olgoloth, Quevven, Ryld, Sabrar, Nadal, Tarlyn, Tsabrak, Urlryn, Valas, Vorn, Vuzlyn, Zakfienal",
  syllablesMiddle = "",
  syllablesEnd ="Abaeir, Aleanrahel, Arabani, Arkhenneld, Auvryndar, Baenre, Coloara, Despana, Freth, Glannath, Helviiryn, Hune, Illistyn, Jaelre, Kilsek, Khalazza, Noquar, Pharn, Seerear, Vrinn, Xiltyn, Zauvirr, Zuavirr, Drannor, Alerae, Aleanana, Barriund, Eilsarn, Eilsath, Freana, Hlath, Hunath, Hlarae, Maeund, Melrae, Maearn, Maeani, Melath, Melund, Melth, Oussani, Oussvirr, Orlyth, Torana, Zauneld, Argith, Blundyth, Cormrael, Dhuunyl, Elpragh, Gellaer, Ghaun, Hyluan, Jhalavar, Olonrae, Philliom, Quavein, Ssambra, Tilntarn, Uloavae, Zolond, Zaphresz",
  rules = "$s $m$e",
  },

  drow_female = { 
  syllablesStart ="Akordia, Chalithra, Chalinthra, Eclavdra, Faere, Nedylene, Phaere, Qilue, SiNafay, Waerva, Umrae, Yasraena, Viconia, Veldrin, Vlondril, Akorae, Ilmiira, Ilphyrr, Inala, Luavrae, Nullynrae, Talthrae, Yasril, Aunrae, Burryna, Charinida, Chessintra, Dhaunae, Dilynrae, Drisinil, Drisnil, Elvraema, Faeryl, Ginafae, Haelra, Halisstra, Imrae, Inidil, Irae, Iymril, Jhaelryna, Minolin, Molvayas, Nathrae, Olorae, Quave, Sabrae, Shi'nayne, Ssapriina, Talabrina, Wuyondra, Xullrae, Xune, Zesstra",
  syllablesMiddle = "",
  syllablesEnd ="Abaeir, Aleanrahel, Arabani, Arkhenneld, Auvryndar, Baenre, Coloara, Despana, Freth, Glannath, Helviiryn, Hune, Illistyn, Jaelre, Kilsek, Khalazza, Noquar, Pharn, Seerear, Vrinn, Xiltyn, Zauvirr, Zuavirr, Drannor, Alerae, Aleanana, Barriund, Eilsarn, Eilsath, Freana, Hlath, Hunath, Hlarae, Maeund, Melrae, Maearn, Maeani, Melath, Melund, Melth, Oussani, Oussvirr, Orlyth, Torana, Zauneld, Argith, Blundyth, Cormrael, Dhuunyl, Elpragh, Gellaer, Ghaun, Hyluan, Jhalavar, Olonrae, Philliom, Quavein, Ssambra, Tilntarn, Uloavae, Zolond, Zaphresz",
  rules = "$s $m$e",
  },

  --Expanded with some Incursion names that matched the theme
  halforc_male = {
  syllablesStart ="Durth, Fang, Gothog, Harl, Orrusk, Orik, Thog, Dench, Feng, Gell, Henk, Holg, Imsh, Kesh, Ront, Shump, Thokk, Vang, Lothgar, Grognard, Shagga, Mogg, Shobri, Rathak, Volgar, Krang, Hurk, Ulgen, Varag, Maasdi, Garta, Zol",
  syllablesEnd ="Dummik, Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
  rules = "$s $e",
  },

  --Expanded with some Incursion names that matched the theme
  halforc_female = {
  syllablesStart ="Creske, Duvaega, Neske, Orvaega, Varra, Yeskarra, Baggi, Engong, Myev, Neega, Ovak, Ownka, Shautha, Rutha, Wargi, Wesk, Dultha, Ruulam, Tautha, Vooga, Ilnush, Sawmi, Lenk, Lisva, Suubi, Rangka, Gaashi, Vuulga",
  syllablesEnd ="Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
  rules = "$s $e",
  },

  --Names taken from Incursion
  kobold_male = { 
  syllablesStart = "Izi, Vucha, Tizzit, Zik, Zzas, Olik, Szissrit, Viska, Kissi, Wixel, Zichna, Ezzan, Kitz, Quizzit, Zazel, Igniz, Zigrat, Gizgaz, Rozrim, Zorbin, Aztan, Uzi, Ognin",
  syllablesEnd = "",
  rules = "$s $e",
  },

  kobold_female = { 
  syllablesStart = "Izi, Vucha, Tizzit, Zik, Zzas, Olik, Szissrit, Viska, Kissi, Wixel, Zichna, Ezzan, Kitz, Quizzit, Zazel, Igniz, Zigrat, Gizgaz, Rozrim, Zorbin, Aztan, Uzi, Ognin",
  syllablesEnd = "",
  rules = "$s $e",
  },


  --Expanded with some Incursion names that matched the theme
  dwarf_male = {
  syllablesStart ="Barundar, Dorn, Jovin, Khondar, Roryn, Storn, Thorik, Barendd, Brottor, Eberk, Einkil, Oskar, Ragnar, Rurik, Taklinn, Traubon, Ulfgar, Veit, Balderk, Dankil, Gorunn, Holderhek, Loderr, Lutgehr, Ungart, Orgil, Maenlin, Shaldar, Holdgen, Urthak, Gromlin, Makki",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Sky, Wind, Bright, Steel, True, Oaken, Blood, Deep",
  syllablesEnd ="bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
  rules = "$s $m$e",
  },

  --Expanded with some Incursion names that matched the theme
  dwarf_female = {
  syllablesStart ="Belmara, Dorna, Sambril, Artin, Audhild, Dagnal, Diesa, Gunnloda, Hlin, Ilde, Liftrasa, Sannl, Torgga, Rumnahiem, Esgelt, Sansi, Terra, Relnan, Holdgen, Shamlir, Vaslin",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Sky, Wind, Bright, Steel, True, Oaken, Blood, Deep",
  syllablesEnd ="bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
  rules = "$s $m$e",
  },

  duergar_male = {
  syllablesStart ="Barundar, Dorn, Jovin, Khondar, Roryn, Storn, Thorik",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Steel, True, Oaken, Blood, Deep",
  syllablesEnd = "bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
  rules = "$s $m$e",
  },

  duergar_female = {
  syllablesStart = "Belmara, Dorna, Sambril",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Steel, True, Oaken, Blood, Deep",
  syllablesEnd = "bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
  rules = "$s $m$e",
  },

  --Names taken from Incursion
  gnome_male = {
  syllablesStart = "Brundner, Ferris, Boddynock, Dimble, Fonkin, Gerbo, Jebeddo, Namfoodle, Nailo, Roondar, Seebo, Zook",
--  syllablesMiddle = "Black, Great, Riven, White",
  syllablesEnd = "Baren, Daergal, Folkor, Garrick, Nackle, Murnig, Ningel, Raulnor, Scheppen, Turen, Aleslosh, Ashhearth, Badger, Cloak, Doublelock, Filchbatter, Fnipper, Oneshoe, Sparklegem, Stumbleduck",
  rules = "$s $e",
  },
  gnome_female = {
  syllablesStart = "Eliss, Lissa, Meree, Nathee, Bimpnottin, Caramip, Duvamil, Ellywick, Loopmottin, Mardnab, Roywin, Shamil, Waywocket",
--  syllablesMiddle = "Black, Great, Riven, White",
    syllablesEnd = "Baren, Daergal, Folkor, Garrick, Nackle, Murnig, Ningel, Raulnor, Scheppen, Turen, Aleslosh, Ashhearth, Badger, Cloak, Doublelock, Filchbatter, Fnipper, Oneshoe, Sparklegem, Stumbleduck",
  rules = "$s $e",
  },

  --Expanded with some Incursion names that matched the theme
  halfling_male = {
  syllablesStart = "Dalabrac, Halandar, Omberc, Roberc, Thiraury, Willimac, Cade, Eldon, Garret, Lyle, Milo, Osborn, Roscoe, Wellby, Randy, Mitchel, Fairday, Hennit, Fenwell, Tristan, Geory, Gabe, Tanis, Brandy, Regis, Sheldon, Milton, Sanderson",
  syllablesMiddle = "Bramble, Dar, Harding, Merry, Starn, Brush, Bush, Good, Green, High, Under, Hill, Leaf, Tea, Thorn, Toss, Winter, Snow, Brandy, Stone, Tree, Blue",
  syllablesEnd = "foot, dragon, dale, mar, hap, gather, bother, barrel, bottle, hill, valley, topple, gallow, cobble, bough, crest, son, glide, field, hearth, buck, spirit, wine, top",
  rules = "$s $m$e",
  },

  --Expanded with some Incursion names that matched the theme
  halfling_female = {
  syllablesStart = "Deldira, Melinden, Olpara, Rosinden, Tara, Cora, Euphemia, Jillian, Lavinia, Merla, Portia, Seraphina, Verna, Agatha, Cecily, Gaimoina, Melody, Corianne, Jadis, Mabeline, Adele, Amile, Whitney",
  syllablesMiddle = "Bramble, Dar, Harding, Merry, Starn, Brush, Bush, Good, Green, High, Under, Hill, Leaf, Tea, Thorn, Toss, Winter, Snow, Brandy, Stone, Tree, Blue",
  syllablesEnd = "foot, dragon, dale, mar, hap, gather, bother, barrel, bottle, hill, valley, topple, gallow, cobble, bough, crest, son, glide, field, hearth, buck, spirit, wine, top",
  rules = "$s $m$e",
  }
} 

  local player = game.player

    if player.descriptor.race == "Human" then
      if player.descriptor.sex == "Female" then 
      local ng = NameGenerator.new(random_name.human_female) 
      self.c_name:setText(ng:generate()) 
      else local ng = NameGenerator.new(random_name.human_male)
        self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Half-Elf" or player.descriptor.race == "Half-Drow" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halfelf_female)
        self.c_name:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.halfelf_male) 
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Elf" then
      if player.descriptor.sex == "Female" then
      local ng = NameGenerator.new(random_name.elf_female)
      self.c_name:setText(ng:generate()) 
      else 
      local ng = NameGenerator.new(random_name.elf_male)
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Half-Orc" or player.descriptor.race == "Orc" or player.descriptor.race == "Lizardfolk" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halforc_female)
        self.c_name:setText(ng:generate())
      else
      local ng = NameGenerator.new(random_name.halforc_male)
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Dwarf" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.dwarf_female)
        self.c_name:setText(ng:generate()) 
      else 
      local ng = NameGenerator.new(random_name.dwarf_male) 
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Drow" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.drow_female)
        self.c_name:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.drow_male)
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Duergar" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.duergar_female)
        self.c_name:setText(ng:generate())
      else
      local ng = NameGenerator.new(random_name.duergar_male) 
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Deep gnome" or player.descriptor.race == "Gnome" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.gnome_female)
        self.c_name:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.gnome_male) 
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Halfling" then
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halfling_female)
        self.c_name:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.halfling_male) 
      self.c_name:setText(ng:generate()) end
    elseif player.descriptor.race == "Kobold" then
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.kobold_female)
        self.c_name:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.kobold_male) 
      self.c_name:setText(ng:generate()) end
    end

--    self.c_name:setText(namegen:generate())
end


--- Apply all birth options to the actor
function _M:apply()
    self.actor.descriptor = {}
    local stats, inc_stats = {}, {}
    for i, d in ipairs(self.descriptors) do
        print("[BIRTHER] Applying descriptor "..(d.name or "none"))
        self.actor.descriptor[d.type or "none"] = (d.name or "none")

        if d.copy then
            local copy = table.clone(d.copy, true)
            -- Append array part
            while #copy > 0 do
                local f = table.remove(copy)
                table.insert(self.actor, f)
            end
            -- Copy normal data
            table.merge(self.actor, copy, true)
        end
        if d.copy_add then
            local copy = table.clone(d.copy_add, true)
            -- Append array part
            while #copy > 0 do
                local f = table.remove(copy)
                table.insert(self.actor, f)
            end
            -- Copy normal data
            table.mergeAdd(self.actor, copy, true)
        end
        -- Change stats
        if d.stats then
            for stat, inc in pairs(d.stats) do
                stats[stat] = (stats[stat] or 0) + inc
            end
        end
        if d.inc_stats then
            for stat, inc in pairs(d.inc_stats) do
                inc_stats[stat] = (inc_stats[stat] or 0) + inc
            end
        end
        if d.talents_types then
            local tt = d.talents_types
            if type(tt) == "function" then tt = tt(self) end
            for t, v in pairs(tt) do
                local mastery
                if type(v) == "table" then
                    v, mastery = v[1], v[2]
                else
                    v, mastery = v, 0
                end
                self.actor:learnTalentType(t, v)
                self.actor.talents_types_mastery[t] = (self.actor.talents_types_mastery[t] or 0) + mastery
            end
        end
        if d.talents then
            for tid, lev in pairs(d.talents) do
                for i = 1, lev do
                    self.actor:learnTalent(tid, true)
                end
            end
        end
        if d.experience then self.actor.exp_mod = self.actor.exp_mod * d.experience end
        if d.body then
            self.actor.body = d.body
            self.actor:initBody()
        end
        if self.applyingDescriptor then self:applyingDescriptor(i, d) end
    end

    -- Apply stats now to not be overridden by other things
    for stat, inc in pairs(stats) do
        self.actor:incStat(stat, inc)
    end
    for stat, inc in pairs(inc_stats) do
        self.actor:incIncStat(stat, inc)
    end
end