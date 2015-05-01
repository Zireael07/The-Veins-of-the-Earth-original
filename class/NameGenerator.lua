-- Veins of the Earth
-- Copyright (C) 2015 Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.

require "engine.class"
require "engine.NameGenerator"

module(..., package.seeall, class.inherit(engine.NameGenerator))

function _M:init(lang_def)
    engine.NameGenerator.init(self, lang_def)
end

--Expanded with some Incursion names that matched the theme
_M.human_male_def = {
syllablesStart ="Aethelmed, Aeron, Courynn, Blath, Bran, Lander, Luth, Daelric, Darvin, Dorn, Evendur, Grim, Jon, Helm, Morn, Randal, Lynneth, Rowan, Sealmyd, Borivik, Fyodor, Grigor, Ivor, Pavel, Vladislak, Anton, Marcon, Pieron, Rimardo, Romero, Salazar, Khalid, Rasheed, Zasheir, Pradir, Rajaput, Sikhir, Aoth, Ehput-Ki, Kethoth, Ramas, So-Kehur, Sammal, Kierny, Rathmere, Michealis, Matthais, Achrim, David, Quinn, Abrash, Pavrash, Vorkai",
syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Wyndael, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag",
rules = "$s $e",
}
--Expanded with some Incursion names that matched the theme
_M.human_female_def = {
syllablesStart ="Ariadne, Courynna, Daelra, Lynneth, Betha, Kethra, Miri, Rowan, Shandri, Shandril, Sealmyd, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Dona, Luisa, Marta, Selise, Mara, Natali, Olga, Zofia, Jaheira, Zasheira, Nismet, Ril, Tiket, Chathi, Nephis, Sefris, Thola",
syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Wyndael, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Ringal, Wernast, Onhalm, Faravis, Ferholm, Oswin, Hisham, Ullast, Senovise, Achabald",
rules = "$s $e",
}

_M.halfelf_male_def = {
syllablesStart ="Aethelmed, Aeron, Courynn, Lander, Luth, Daelric, Darvin, Dorn, Evendur, Jon, Joneleth, Helm, Morn, Randal, Lynneth, Rowan, Sealmyd, Romero, Salazar, Khalid, Zasheir, Pradir, Rajaput, Sikhir, Aoth, Kethoth, Ramas, So-Kehur",
syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Wyndael, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
rules = "$s $e",
}

_M.halfelf_female_def = {
syllablesStart ="Ariadne, Courynna, Lynneth, Miri, Rowan, Sealmyd, Shandri, Shandril, Smylla, Wydda, Fyevarra, Immith, Shevarra, Tammith, Katernin, Dona, Luisa, Selise, Mara, Natali, Zofia, Jaheira, Zasheira, Nismet, Ril, Nephis, Sefris, Laele, Larynda, Talice, Malice",
syllablesEnd ="Dulsaer, Jacerryl, Telstaer, Uthelienn, Pashar, Aporos, Nathos, Zora, Amblecrown, Duskman, Dundragon, Evenwood, Greycastle, Tallstag, Moonblade, Moonflower, Eveningstar",
rules = "$s $e",
}

--Expanded with some Incursion names that matched the theme
_M.elf_male_def = {
syllablesStart ="Aravilar, Faelar, Saevel, Rhistel, Taeghen, Iliphar, Othorion, Aramil, Enialis, Ivellios, Laucian, Quarion, Selasia, Faridhir, Semirathis, Agorna, Disead, Cassius, Lachin, Tesserath, Amakiir, Holimion, Meliamne, Siannodel, Ilphukiir, Naofindel, Dios, Celebrand",
syllablesMiddle = "Moon, Evening, Star, Gem, Diamond, Silver, Night, Blossom, Gold",
syllablesEnd ="flower, blade, star, fall, whisper, dew, frond, child, heel, breeze, brook, petal",
rules = "$s $m$e",
}

--Expanded with some Incursion names that matched the theme
_M.elf_female_def = {
syllablesStart ="Hacathra, Imizael, Jhaumrithe, Quamara, Talindra, Vestele, Alea, Eoslin, Sephira, Selasia, Anastrianna, Antinua, Drusilia, Felosial, Ielenia, Lia, Qillathe, Silaqui, Valanthe, Xanaphia, Amastacia, Galanodel, Liadon, Xiloscient, Iosefel, Samariel, Morwen, Raelin, Vaegwal",
syllablesMiddle = "Moon, Evening, Star, Gem, Diamond, Silver, Night, Blossom, Gold",
syllablesEnd ="flower, blade, star, fall, whisper, dew, frond, child, heel, breeze, brook, petal",
rules = "$s $m$e",
}

_M.drow_male_def = {
syllablesStart ="Alak, Drizzt, Ilmryn, Khalazza, Merinid, Mourn, Nym, Pharaun, Rizzen, Solaufein, Sorn, Veldrin, Tebryn, Zaknafein, Dhauntel, Gomur'ss, Sornrak, Sszerin, Adinirahc, Belgos, Antatlab, Calimar, Duagloth, Elkantar, Filraen, Gelroos, Houndaer, Ilphrin, Kelnozz, Krondorl, Nalfein, Nilonim, Ryltar, Olgoloth, Quevven, Ryld, Sabrar, Nadal, Tarlyn, Tsabrak, Urlryn, Valas, Vorn, Vuzlyn, Zakfienal",
syllablesMiddle = "",
syllablesEnd ="Abaeir, Aleanrahel, Arabani, Arkhenneld, Auvryndar, Baenre, Coloara, Despana, Freth, Glannath, Helviiryn, Hune, Illistyn, Jaelre, Kilsek, Khalazza, Noquar, Pharn, Seerear, Vrinn, Xiltyn, Zauvirr, Zuavirr, Drannor, Alerae, Aleanana, Barriund, Eilsarn, Eilsath, Freana, Hlath, Hunath, Hlarae, Maeund, Melrae, Maearn, Maeani, Melath, Melund, Melth, Oussani, Oussvirr, Orlyth, Torana, Zauneld, Argith, Blundyth, Cormrael, Dhuunyl, Elpragh, Gellaer, Ghaun, Hyluan, Jhalavar, Olonrae, Philliom, Quavein, Ssambra, Tilntarn, Uloavae, Zolond, Zaphresz",
rules = "$s $m$e",
}

_M.drow_female_def = {
syllablesStart ="Akordia, Chalithra, Chalinthra, Eclavdra, Faere, Nedylene, Phaere, Qilue, SiNafay, Waerva, Umrae, Yasraena, Viconia, Veldrin, Vlondril, Akorae, Ilmiira, Ilphyrr, Inala, Luavrae, Nullynrae, Talthrae, Yasril, Aunrae, Burryna, Charinida, Chessintra, Dhaunae, Dilynrae, Drisinil, Drisnil, Elvraema, Faeryl, Ginafae, Haelra, Halisstra, Imrae, Inidil, Irae, Iymril, Jhaelryna, Minolin, Molvayas, Nathrae, Olorae, Quave, Sabrae, Shi'nayne, Ssapriina, Talabrina, Wuyondra, Xullrae, Xune, Zesstra",
syllablesMiddle = "",
syllablesEnd ="Abaeir, Aleanrahel, Arabani, Arkhenneld, Auvryndar, Baenre, Coloara, Despana, Freth, Glannath, Helviiryn, Hune, Illistyn, Jaelre, Kilsek, Khalazza, Noquar, Pharn, Seerear, Vrinn, Xiltyn, Zauvirr, Zuavirr, Drannor, Alerae, Aleanana, Barriund, Eilsarn, Eilsath, Freana, Hlath, Hunath, Hlarae, Maeund, Melrae, Maearn, Maeani, Melath, Melund, Melth, Oussani, Oussvirr, Orlyth, Torana, Zauneld, Argith, Blundyth, Cormrael, Dhuunyl, Elpragh, Gellaer, Ghaun, Hyluan, Jhalavar, Olonrae, Philliom, Quavein, Ssambra, Tilntarn, Uloavae, Zolond, Zaphresz",
rules = "$s $m$e",
}

--Expanded with some Incursion names that matched the theme
_M.halforc_male_def = {
syllablesStart ="Durth, Fang, Gothog, Harl, Orrusk, Orik, Thog, Dench, Feng, Gell, Henk, Holg, Imsh, Kesh, Ront, Shump, Thokk, Vang, Lothgar, Grognard, Shagga, Mogg, Shobri, Rathak, Volgar, Krang, Hurk, Ulgen, Varag, Maasdi, Garta, Zol",
syllablesEnd ="Dummik, Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
rules = "$s $e",
}

--Expanded with some Incursion names that matched the theme
_M.halforc_female_def = {
syllablesStart ="Creske, Duvaega, Neske, Orvaega, Varra, Yeskarra, Baggi, Engong, Myev, Neega, Ovak, Ownka, Shautha, Rutha, Wargi, Wesk, Dultha, Ruulam, Tautha, Vooga, Ilnush, Sawmi, Lenk, Lisva, Suubi, Rangka, Gaashi, Vuulga",
syllablesEnd ="Horthor, Lammar, Turnskull, Ulkrunnar, Zorgar",
rules = "$s $e",
}

--Names taken from Incursion
_M.kobold_male_def = {
syllablesStart = "Izi, Vucha, Tizzit, Zik, Zzas, Olik, Szissrit, Viska, Kissi, Wixel, Zichna, Ezzan, Kitz, Quizzit, Zazel, Igniz, Zigrat, Gizgaz, Rozrim, Zorbin, Aztan, Uzi, Ognin",
syllablesEnd = "",
rules = "$s $e",
}

_M.kobold_female_def = {
syllablesStart = "Izi, Vucha, Tizzit, Zik, Zzas, Olik, Szissrit, Viska, Kissi, Wixel, Zichna, Ezzan, Kitz, Quizzit, Zazel, Igniz, Zigrat, Gizgaz, Rozrim, Zorbin, Aztan, Uzi, Ognin",
syllablesEnd = "",
rules = "$s $e",
}


--Expanded with some Incursion names that matched the theme
_M.dwarf_male_def = {
syllablesStart ="Barundar, Dorn, Jovin, Khondar, Roryn, Storn, Thorik, Barendd, Brottor, Eberk, Einkil, Oskar, Ragnar, Rurik, Taklinn, Traubon, Ulfgar, Veit, Balderk, Dankil, Gorunn, Holderhek, Loderr, Lutgehr, Ungart, Orgil, Maenlin, Shaldar, Holdgen, Urthak, Gromlin, Makki",
syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Sky, Wind, Bright, Steel, True, Oaken, Blood, Deep",
syllablesEnd ="bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
rules = "$s $m$e",
}

--Expanded with some Incursion names that matched the theme
_M.dwarf_female_def = {
syllablesStart ="Belmara, Dorna, Sambril, Artin, Audhild, Dagnal, Diesa, Gunnloda, Hlin, Ilde, Liftrasa, Sannl, Torgga, Rumnahiem, Esgelt, Sansi, Terra, Relnan, Holdgen, Shamlir, Vaslin",
syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Sky, Wind, Bright, Steel, True, Oaken, Blood, Deep",
syllablesEnd ="bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
rules = "$s $m$e",
}

_M.duergar_male_def = {
syllablesStart ="Barundar, Dorn, Jovin, Khondar, Roryn, Storn, Thorik",
syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Steel, True, Oaken, Blood, Deep",
syllablesEnd = "bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
rules = "$s $m$e",
}

_M.duergar_female_def = {
syllablesStart = "Belmara, Dorna, Sambril",
syllablesMiddle = "Blade, Crown, Skull, Stone, Battle, Dark, Gold, Gord, Forge, Iron, Axe, Ash, Mountain, Steel, True, Oaken, Blood, Deep",
syllablesEnd = "bite, shield, dark, rivver, hammer, clan, driver, brother, cleft, keeper, rager, fury, forge, breaker, axe, blade, strike, stone",
rules = "$s $m$e",
}

--Names taken from Incursion
_M.gnome_male_def = {
syllablesStart = "Brundner, Ferris, Boddynock, Dimble, Fonkin, Gerbo, Jebeddo, Namfoodle, Nailo, Roondar, Seebo, Zook",
--  syllablesMiddle = "Black, Great, Riven, White",
syllablesEnd = "Baren, Daergal, Folkor, Garrick, Nackle, Murnig, Ningel, Raulnor, Scheppen, Turen, Aleslosh, Ashhearth, Badger, Cloak, Doublelock, Filchbatter, Fnipper, Oneshoe, Sparklegem, Stumbleduck",
rules = "$s $e",
}

_M.gnome_female_def = {
syllablesStart = "Eliss, Lissa, Meree, Nathee, Bimpnottin, Caramip, Duvamil, Ellywick, Loopmottin, Mardnab, Roywin, Shamil, Waywocket",
--  syllablesMiddle = "Black, Great, Riven, White",
  syllablesEnd = "Baren, Daergal, Folkor, Garrick, Nackle, Murnig, Ningel, Raulnor, Scheppen, Turen, Aleslosh, Ashhearth, Badger, Cloak, Doublelock, Filchbatter, Fnipper, Oneshoe, Sparklegem, Stumbleduck",
rules = "$s $e",
}

--Expanded with some Incursion names that matched the theme
_M.halfling_male_def = {
syllablesStart = "Dalabrac, Halandar, Omberc, Roberc, Thiraury, Willimac, Cade, Eldon, Garret, Lyle, Milo, Osborn, Roscoe, Wellby, Randy, Mitchel, Fairday, Hennit, Fenwell, Tristan, Geory, Gabe, Tanis, Brandy, Regis, Sheldon, Milton, Sanderson",
syllablesMiddle = "Bramble, Dar, Harding, Merry, Starn, Brush, Bush, Good, Green, High, Under, Hill, Leaf, Tea, Thorn, Toss, Winter, Snow, Brandy, Stone, Tree, Blue",
syllablesEnd = "foot, dragon, dale, mar, hap, gather, bother, barrel, bottle, hill, valley, topple, gallow, cobble, bough, crest, son, glide, field, hearth, buck, spirit, wine, top",
rules = "$s $m$e",
}

--Expanded with some Incursion names that matched the theme
_M.halfling_female_def = {
syllablesStart = "Deldira, Melinden, Olpara, Rosinden, Tara, Cora, Euphemia, Jillian, Lavinia, Merla, Portia, Seraphina, Verna, Agatha, Cecily, Gaimoina, Melody, Corianne, Jadis, Mabeline, Adele, Amile, Whitney",
syllablesMiddle = "Bramble, Dar, Harding, Merry, Starn, Brush, Bush, Good, Green, High, Under, Hill, Leaf, Tea, Thorn, Toss, Winter, Snow, Brandy, Stone, Tree, Blue",
syllablesEnd = "foot, dragon, dale, mar, hap, gather, bother, barrel, bottle, hill, valley, topple, gallow, cobble, bough, crest, son, glide, field, hearth, buck, spirit, wine, top",
rules = "$s $m$e",
}
