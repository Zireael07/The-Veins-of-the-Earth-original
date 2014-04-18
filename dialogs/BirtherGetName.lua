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
    elseif player.descriptor.race == "Half-Orc" or player.descriptor.race == "Orc" or player.descriptor.race == "Lizardfolk" then 
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
    elseif player.descriptor.race == "Deep gnome" or player.descriptor.race == "Gnome" then 
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.gnome_female)
        self.c_box:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.gnome_male) 
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Halfling" then
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.halfling_female)
        self.c_box:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.halfling_male) 
      self.c_box:setText(ng:generate()) end
    elseif player.descriptor.race == "Kobold" then
      if player.descriptor.sex == "Female" then
        local ng = NameGenerator.new(random_name.kobold_female)
        self.c_box:setText(ng:generate()) 
      else
      local ng = NameGenerator.new(random_name.kobold_male) 
      self.c_box:setText(ng:generate()) end
    end

--    self.c_box:setText(namegen:generate())
end
