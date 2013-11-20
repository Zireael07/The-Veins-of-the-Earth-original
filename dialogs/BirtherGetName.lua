--Veins of the Earth
--Zireael
--adapted from Qi Daozei
-- Copyright (C) 2013 Josh Kelley

require "engine.class"
local Module = require "engine.Module"
local Dialog = require "engine.ui.Dialog"
local Button = require "engine.ui.Button"
local Textbox = require "engine.ui.Textbox"
--local NameGenerator = require "mod.class.NameGenerator"
local NameGenerator = require "engine.NameGenerator"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(actor, action, cancel)
    self.actor = actor
    self.action = action
    self.cancel = cancel
    self.min = 2
    self.max = 25

    Dialog.init(self, "Character Creation", 320, 110)

    local c_box = Textbox.new{title="Enter your character's name: ", text="", chars=30, max_len=self.max, fct=function(text) self:okclick() end}
    self.c_box = c_box
    local ok = Button.new{text="Accept", fct=function() self:okclick() end}
    local cancel = Button.new{text="Cancel", fct=function() self:cancelclick() end}
    local random = Button.new{text="Random", fct=function() self:randomName() end}

    self:loadUI{
        {left=0, top=0, padding_h=10, ui=c_box},
        {right=0, top=0, ui=random},
        {left=0, bottom=0, ui=ok},
        {right=0, bottom=0, ui=cancel},
    }
	self:setFocus(c_box)
    self:setupUI(true, true)

    self.key:addBinds{
        EXIT = function() if self.cancel then self.cancel() end game:unregisterDialog(self) end,
    }
end

function _M:okclick()
    local name = self.c_box.text

    if name:len() < self.min or name:len() > self.max then
        Dialog:simplePopup("Error", ("Must be between %i and %i characters."):format(self.min, self.max))
        return
    end

    self:checkNew(name, function()
        game:unregisterDialog(self)
        self.action(name)
    end)
end

function _M:cancelclick()
    self.key:triggerVirtual("EXIT")
end

function _M:checkNew(name, fct)
	local savename = name:gsub("[^a-zA-Z0-9_-.]", "_")
	if fs.exists(("/save/%s/game.teag"):format(savename)) then
		Dialog:yesnoPopup("Overwrite character?", "There is already a character with this name, do you want to overwrite it?", function(ret)
			if not ret then fct() end
		end, "No", "Yes")
	else
		fct()
	end
end
--self:setName
function _M:randomName()

  self.actor = actor
local random_name = {
  human_male = {
  syllablesStart ="Aeron, Courynn, Daelric, Dorn, Helm, Lynneth, Rowan, Sealmyd, Borivik, Fyodor, Vladislak, Khalid, Rasheed, Zasheir, Zasheira",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag",
  rules = "$s $e",
  },
  human_female = {
  syllablesStart ="Ariadne, Courynna, Daelra, Lynneth, Sealmyd, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Mara, Natali, Zofia, Jaheira, Zasheira",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag",
  rules = "$s $e",
  },
  halfelf_male = {
  syllablesStart ="Aeron, Courynn, Daelric, Dorn, Evendur, Helm, Lynneth, Rowan, Sealmyd, Khalid, Zasheir",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
  rules = "$s $e",
  },

  halfelf_female = {
  syllablesStart ="Ariadne, Courynna, Lynneth, Rowan, Sealmyd, Shandri, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Mara, Natali, Zofia, Jaheira",
  syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
  rules = "$s $e",
  },

  elf_male = {
  syllablesStart ="Aravilar, Faelar, Saevel, Rhistel",
  syllablesMiddle = "Moon, Evening",
  syllablesEnd ="flower, blade, star, fall",
  rules = "$s $m$e",
  },

  elf_female = {
  syllablesStart ="Hacathra, Imizael, Talindra, Vestele",
  syllablesMiddle = "Moon, Evening",
  syllablesEnd ="flower, blade, star, fall",
  rules = "$s $m$e",
  },

  halforc_male = {
  syllablesStart ="Durth, Fang, Gothog, Harl, Orrusk, Orik, Thog",
  syllablesEnd ="Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
  rules = "$s $e",
  },

  halforc_female = {
  syllablesStart ="Orvaega, Duvaega, Varra",
  syllablesEnd ="Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
  rules = "$s $e",
  },

  dwarf_male = {
  syllablesStart ="Dorn, Khondar, Thorik",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold",
  syllablesEnd ="bite, shield, dark",
  rules = "$s $m$e",
  },

  dwarf_female = {
  syllablesStart ="Belmara, Dorna",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold",
  syllablesEnd ="bite, shield, dark",
  rules = "$s $m$e",
  },

  drow_male = { 
  syllablesStart ="Alak, Drizzt, Ilmryn, Khalazza, Merinid, Mourn, Nym, Pharaun, Rizzen, Solaufein, Tebryn, Zaknafein",
  syllablesMiddle = "",
  syllablesEnd ="Abaeir, Baenre, Coloara, Glannath, Hune, Illistyn, Khalazza, Pharn, Seerear, Vrinn, Xiltyn",
  rules = "$s $m$e",
  },

  drow_female = { 
  syllablesStart ="Akordia, Chalithra, Chalinthra, Eclavdra, Nedylene, Qilue, SiNafay",
  syllablesMiddle = "",
  syllablesEnd ="Abaeir, Baenre, Coloara, Glannath, Hune, Illistyn, Khalazza, Pharn, Seerear, Vrinn, Xiltyn",
  rules = "$s $m$e",
  },

  duergar_male = {
  syllablesStart = "Thorik, Dorn",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark",
  syllablesEnd = "bite, shield, dark",
  rules = "$s $m$e",
  },

  duergar_female = {
  syllablesStart = "Belmara, Dorna",
  syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark",
  syllablesEnd = "bite, shield, dark",
  rules = "$s $m$e",
  },

  gnome_male = {
  syllablesStart = "Colmarr, Falrinn, Halbrinn",
  syllablesMiddle = "Black, Great, Riven, White",
  syllablesEnd = "orm, rock, stone, horn",
  rules = "$s $m$e",
  },
  gnome_female = {
  syllablesStart = "Eliss, Lissa, Meree, Nathee",
  syllablesMiddle = "Black, Great, Riven, White",
  syllablesEnd = "orm, rock, stone, horn",
  rules = "$s $m$e",
  }
} 

  local player = game.player

    if player.descriptor.race == "Human" then
      if player.descriptor.sex == "Female" then 
      local ng = NameGenerator.new(random_name.human_female) 
      self.c_box:setText(ng:generate()) 
      else local ng = NameGenerator.new(random_name.human_male)
        self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Half-Elf" or player.descriptor.race == "Half-Drow" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halfelf_female)
        self.c_box:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.halfelf_male) 
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Elf" then
      if player.descriptor.sex == "Female" then
      local ng = NameGenerator.new(random_name.elf_female)
      self.c_box:setText(ng:generate()) 
      else 
      local ng = NameGenerator.new(random_name.elf_male)
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Half-Orc" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halforc_female)
        self.c_box:setText(ng:generate())
      else
      local ng = NameGenerator.new(random_name.halforc_male)
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Dwarf" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.dwarf_female)
        self.c_box:setText(ng:generate()) 
      else 
      local ng = NameGenerator.new(random_name.dwarf_male) 
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Drow" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.drow_female)
        self.c_box:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.drow_male)
      self:setName(ng:generate()) end
    elseif player.descriptor.race == "Duergar" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.duergar_female)
        self.c_box:setText(ng:generate())
      else
      local ng = NameGenerator.new(random_name.duergar_male) 
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Deep gnome" or player.descriptor.race == "Gnome" or player.descriptor.race == "Halfling" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.gnome_female)
        self.c_box:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.gnome_male) 
      self.c_box:setText(ng:generate()) end
    end

--    self.c_box:setText(namegen:generate())
end
