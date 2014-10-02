-- based on Zizzo's 
-- ToME - Tales of Middle-Earth
-- Copyright (C) 2012 Scott Bigham
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
--
-- Scott Bigham "Zizzo"
-- dsb-tome@killerbbunnies.org

newFlavorSet {
  type = 'food',
  subtype = 'mushroom',
  values = {
    { "Blue", colors.BLUE, 'tiles/flavor/shroom_b.png' },
    { "Black", colors.BLACK, 'tiles/flavor/shroom_D.png' },
    { "Black Spotted", colors.BLACK, 'tiles/flavor/shroom_D.png' },
    { "Brown", colors.LIGHT_UMBER, 'tiles/flavor/shroom_u.png' },
    { "Dark Blue", colors.BLUE, 'tiles/flavor/shroom_b.png' },
    { "Dark Green", colors.GREEN, 'tiles/flavor/shroom_g.png' },
    { "Dark Red", colors.RED, 'tiles/flavor/shroom_r.png' },
    { "Yellow", colors.YELLOW, 'tiles/flavor/shroom_y.png' },
    { "Furry", colors.WHITE, 'tiles/flavor/shroom_W.png' },
    { "Green", colors.GREEN, 'tiles/flavor/shroom_g.png' },
    { "Grey", colors.LIGHT_SLATE, 'tiles/flavor/shroom_s.png' },
    { "Light Blue", colors.BLUE, 'tiles/flavor/shroom_B.png' },
    { "Light Green", colors.GREEN, 'tiles/flavor/shroom_G.png' },
    { "Violet", colors.VIOLET, 'tiles/flavor/shroom_v.png' },
    { "Red", colors.RED, 'tiles/flavor/shroom_r.png' },
    { "Slimy", colors.LIGHT_SLATE, 'tiles/flavor/shroom_s.png' },
    { "Tan", colors.LIGHT_UMBER, 'tiles/flavor/shroom_U.png' },
    { "White", colors.WHITE, 'tiles/flavor/shroom_w.png' },
    { "White Spotted", colors.WHITE, 'tiles/flavor/shroom_w.png' },
    { "Wrinkled", colors.LIGHT_UMBER, 'tiles/flavor/shroom_u.png' },
  }
}

newFlavorSet {
  type = 'potion',
  subtype = 'potion',
  values = {
--    { "Strangely Phosphorescent", colors.C_multi, 'tiles/flavor/pot_m.png' },
    { "azure", colors.BLUE, 'tiles/flavors/PotionAquamarine.png' },
    { "blue", colors.DARK_BLUE, 'tiles/flavors/PotionTallBlue.png' },
    { "blue speckled", colors.ROYAL_BLUE, 'tiles/flavors/PotionTallBlue.png' },
    { "black", colors.BLACK, 'tiles/flavors/PotionTallGrey.png' },
    { "brown", colors.SANDY_BROWN, 'tiles/flavors/PotionShortBrown.png' },
    { "brown speckled", colors.SANDY_BROWN, 'tiles/flavors/PotionShortBrown.png' },
    { "bubbling", colors.WHITE, 'tiles/flavors/PotionTallWhite.png' },
    { "chartreuse", colors.GREEN, 'tiles/flavors/PotionLargeGreen.png' },
    { "cloudy", colors.ANTIQUE_WHITE, 'tiles/flavors/PotionTallWhite.png' },
    { "copper speckled", colors.LIGHT_UMBER, 'tiles/flavors/PotionLargeTan.png' },
    { "crimson", colors.CRIMSON, 'tiles/flavors/PotionRed.png' },
    { "cyan", colors.LIGHT_BLUE, 'tiles/flavors/PotionAquamarine.png' },
    { "dark Blue", colors.DARK_BLUE, 'tiles/flavors/PotionTallBlue.png' },
    { "dark Green", colors.DARK_GREEN, 'tiles/flavors/PotionEmerald2.png' },
    { "dark Red", colors.DARK_RED, 'tiles/flavors/PotionRed.png' },
    { "gold speckled", colors.YELLOW, 'tiles/flavors/PotionLargeYellow.png' },
    { "green", colors.GREEN, 'tiles/flavors/PotionEmerald2.png' },
    { "green speckled", colors.LIGHT_GREEN, 'tiles/flavors/PotionEmerald2.png' },
    { "grey", colors.DARK_GREY, 'tiles/flavors/PotionLargeGrey.png' },
    { "grey speckled", colors.LIGHT_GREY, 'tiles/flavors/PotionLargeGrey.png' },
    { "hazy", colors.ANTIQUE_WHITE, 'tiles/flavors/PotionTallWhite.png' },
    { "indigo", colors.VIOLET, 'tiles/flavors/PotionLargeViolet.png' },
    { "light blue", colors.LIGHT_BLUE, 'tiles/flavors/PotionAquamarine.png' },
    { "light green", colors.LIGHT_GREEN, 'tiles/flavors/PotionLargeGreen.png' },
    { "magenta", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "metallic blue", colors.DARK_BLUE, 'tiles/flavors/PotionTallBlue.png' },
    { "metallic red", colors.DARK_RED, 'tiles/flavors/PotionRed.png' },
    { "metallic green", colors.DARK_GREEN, 'tiles/flavors/PotionEmerald2.png' },
    { "metallic purple", colors.VIOLET, 'tiles/flavors/PotionPurple.png' },
    { "misty", colors.ANTIQUE_WHITE, 'tiles/flavors/PotionTallWhite.png' },
    { "orange", colors.ORANGE, 'tiles/flavors/PotionShortTan2.png' },
    { "orange speckled", colors.ORANGE, 'tiles/flavors/PotionShortTan2.png' },
    { "pink", colors.PINK, 'tiles/flavors/PotionRed.png' },
    { "pink speckled", colors.PINK, 'tiles/flavors/PotionRed.png' },
    { "puce", colors.VIOLET, 'tiles/flavors/PotionLargeViolet.png' },
    { "purple", colors.VIOLET, 'tiles/flavors/PotionPurple.png' },
    { "purple speckled", colors.VIOLET, 'tiles/flavors/PotionPurple.png' },
    { "red", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "red speckled", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "silver speckled", colors.WHITE, 'tiles/flavors/PotionShortSilver.png' },
    { "smoky", colors.BLACK, 'tiles/flavors/PotionTallGrey.png' },
    { "tangerine", colors.ORANGE, 'tiles/flavors/PotionShortTan2.png' },
    { "violet", colors.VIOLET, 'tiles/flavors/PotionLargeViolet.png' },
    { "vermilion", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "white", colors.WHITE, 'tiles/flavors/PotionTallWhite.png' },
    { "yellow", colors.YELLOW, 'tiles/flavors/PotionLargeYellow.png' },
    { "violet speckled", colors.VIOLET, 'tiles/flavors/PotionLargeViolet.png' },
    { "pungent", colors.RED, 'tiles/flavors/PotionTallRed.png' },
    { "clotted red", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "viscous pink", colors.RED, 'tiles/flavors/PotionTallRed.png' },
    { "oily yellow", colors.YELLOW, 'tiles/flavors/PotionLargeYellow.png' },
    { "gloopy green", colors.GREEN, 'tiles/flavors/PotionEmerald2.png' },
--    { "Shimmering", colors.C_multi, 'tiles/flavor/pot_m.png' },
    { "coagulated crimson", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "yellow speckled", colors.YELLOW, 'tiles/flavors/PotionLargeYellow.png' },
    { "gold", colors.GOLD, 'tiles/flavors/PotionLargeYellow.png' },
    { "manly", colors.LIGHT_UMBER, 'tiles/flavors/PotionLargeTan2.png' },
    { "stinking", colors.DARK_UMBER, 'tiles/flavors/PotionTinyBrown.png' },
    { "oily black", colors.BLACK, 'tiles/flavors/PotionTallGrey.png' },
    { "ichor", colors.RED, 'tiles/flavors/PotionRed.png' },
    { "ivory white", colors.WHITE, 'tiles/flavors/PotionTallWhite.png' },
    { "sky blue", colors.BLUE, 'tiles/flavors/PotionAquamarine.png' },
  },
--[[  assigned = {
    POT_WATER = { "Clear", colors.WHITE },
    POT_APPLE_JUICE = { "Light Brown", colors.LIGHT_UMBER },
    POT_SLIME_MOLD_JUICE = { "Icky Green", colors.GREEN },
  }]]
}

--[[newFlavorSet {
  type = 'utility',
  subtype = 'scroll',
  pop_flavor = function(type, subtype)
    local tiles = require('mod.class.tiles')
    local fl_def = tiles.flavors_def[type][subtype]
    -- The Adam Bolt tileset has four tiles for scrolls.  All the other
    -- flavored-tiles tiles are keyed by color, but all scrolls are white,
    -- so we choose one at random to assign to this flavor.
    local tile = ('tiles/flavor/scroll_%d.png'):format(rng.range(1, 4))
    -- Collect a list of titles we've already generated for comparision
    -- to avoid collisions.
    local seen = {}
    local used = game.state.flavors_assigned[type][subtype]
    for _, title in pairs(used) do seen[title] = true end
    -- As per tiles1.c:flavor_init(), we assemble a list of one- or two-
    -- syllable words, stopping before we exceed 15 characters.
    while true do
      local words = {}
      local len = 0
      while true do
	local word = ''
	local nsyl = rng.range(1,100) < 30 and 1 or 2
	for _ = 1, nsyl do word = word..rng.table(fl_def.syllables) end
	if #words > 0 and len + word:len() + 1 > 15 then break end
	len = len + word:len() + (#words > 0 and 1 or 0)
	words[#words+1] = word
      end
      local title = table.concat(words, ' ')
      if not seen[title] then return { title, colors.WHITE, tile } end
    end
  end,
  syllables = {
    "a", "ab", "ag", "aks", "ala", "an", "ankh", "app",
    "arg", "arze", "ash", "aus", "ban", "bar", "bat", "bek",
    "bie", "bin", "bit", "bjor", "blu", "bot", "bu",
    "byt", "comp", "con", "cos", "cre", "dalf", "dan",
    "den", "der", "doe", "dok", "eep", "el", "eng", "er", "ere", "erk",
    "esh", "evs", "fa", "fid", "flit", "for", "fri", "fu", "gan",
    "gar", "glen", "gop", "gre", "ha", "he", "hyd", "i",
    "ing", "ion", "ip", "ish", "it", "ite", "iv", "jo",
    "kho", "kli", "klis", "la", "lech", "man", "mar",
    "me", "mi", "mic", "mik", "mon", "mung", "mur", "nag", "nej",
    "nelg", "nep", "ner", "nes", "nis", "nih", "nin", "o",
    "od", "ood", "org", "orn", "ox", "oxy", "pay", "pet",
    "ple", "plu", "po", "pot", "prok", "re", "rea", "rhov",
    "ri", "ro", "rog", "rok", "rol", "sa", "san", "sat",
    "see", "sef", "seh", "shu", "ski", "sna", "sne", "snik",
    "sno", "so", "sol", "sri", "sta", "sun", "ta", "tab",
    "tem", "ther", "ti", "tox", "trol", "tue", "turs", "u",
    "ulk", "um", "un", "uni", "ur", "val", "viv", "vly",
    "vom", "wah", "wed", "werg", "wex", "whon", "wun", "x",
    "yerg", "yp", "zun", "tri", "blaa", "jah", "bul", "on",
    "foo", "ju", "xuxu"
  }
}]]

newFlavorSet {
  type = 'ring',
  subtype = 'ring',
  values = {
    { "Alexandrite", colors.GREEN, 'tiles/flavor/ring_g.png' },
    { "Amethyst", colors.VIOLET, 'tiles/flavor/ring_v.png' },
    { "Aquamarine", colors.BLUE, 'tiles/flavor/ring_B.png' },
    { "Azurite", colors.BLUE, 'tiles/flavor/ring_B.png' },
    { "Beryl", colors.GREEN, 'tiles/flavor/ring_G.png' },
    { "Bloodstone", colors.RED, 'tiles/flavor/ring_r.png' },
    { "Calcite", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Carnelian", colors.RED, 'tiles/flavor/ring_r.png' },
    { "Corundum", colors.LIGHT_SLATE, 'tiles/flavor/ring_s.png' },
    { "Diamond", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Emerald", colors.GREEN, 'tiles/flavor/ring_g.png' },
    { "Fluorite", colors.GREEN, 'tiles/flavor/ring_G.png' },
    { "Garnet", colors.RED, 'tiles/flavor/ring_r.png' },
    { "Granite", colors.BLACK, 'tiles/flavor/ring_D.png' },
    { "Jade", colors.GREEN, 'tiles/flavor/ring_G.png' },
    { "Jasper", colors.LIGHT_UMBER, 'tiles/flavor/ring_u.png' },
    { "Lapis Lazuli", colors.BLUE, 'tiles/flavor/ring_b.png' },
    { "Malachite", colors.GREEN, 'tiles/flavor/ring_g.png' },
    { "Marble", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Moonstone", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Onyx", colors.RED, 'tiles/flavor/ring_R.png' },
    { "Opal", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Pearl", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Quartz", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Quartzite", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Rhodonite", colors.RED, 'tiles/flavor/ring_R.png' },
    { "Ruby", colors.RED, 'tiles/flavor/ring_r.png' },
    { "Sapphire", colors.BLUE, 'tiles/flavor/ring_b.png' },
    { "Tiger Eye", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Topaz", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Turquoise", colors.BLUE, 'tiles/flavor/ring_B.png' },
    { "Zircon", colors.LIGHT_UMBER, 'tiles/flavor/ring_U.png' },
    { "Platinum", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Bronze", colors.LIGHT_UMBER, 'tiles/flavor/ring_U.png' },
    { "Gold", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Obsidian", colors.BLACK, 'tiles/flavor/ring_D.png' },
    { "Silver", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Tortoise Shell", colors.GREEN, 'tiles/flavor/ring_g.png' },
    { "Mithril", colors.BLUE, 'tiles/flavor/ring_B.png' },
    { "Jet", colors.BLACK, 'tiles/flavor/ring_D.png' },
    { "Engagement", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Adamantite", colors.VIOLET, 'tiles/flavor/ring_v.png' },
    { "Wire", colors.LIGHT_UMBER, 'tiles/flavor/ring_u.png' },
    { "Dilithium", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Bone", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Wooden", colors.LIGHT_UMBER, 'tiles/flavor/ring_u.png' },
    { "Spikard", colors.BLUE, 'tiles/flavor/ring_b.png' },
    { "Serpent", colors.GREEN, 'tiles/flavor/ring_g.png' },
    { "Wedding", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Double", colors.ORANGE, 'tiles/flavor/ring_o.png' },
    { "Plain", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Brass", colors.ORANGE, 'tiles/flavor/ring_o.png' },
    { "Scarab", colors.GREEN, 'tiles/flavor/ring_G.png' },
    { "Shining", colors.YELLOW, 'tiles/flavor/ring_y.png' },
    { "Rusty", colors.RED, 'tiles/flavor/ring_r.png' },
    { "Transparent", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'tiles/flavor/ring_u.png' },
    { "Black Opal", colors.BLACK, 'tiles/flavor/ring_D.png' },
    { "Nickel", colors.WHITE, 'tiles/flavor/ring_W.png' },
    { "Glass", colors.WHITE, 'tiles/flavor/ring_w.png' },
    { "Fluorspar", colors.BLUE, 'tiles/flavor/ring_b.png' },
    { "Agate", colors.WHITE, 'tiles/flavor/ring_W.png' },
  }
}

newFlavorSet {
  type = 'amulet',
  subtype = 'amulet',
  values = {
    { "Amber", colors.YELLOW, 'tiles/flavor/amulet_y.png' },
    { "Driftwood", colors.LIGHT_UMBER, 'tiles/flavor/amulet_U.png' },
    { "Coral", colors.WHITE, 'tiles/flavor/amulet_w.png' },
    { "Agate", colors.WHITE, 'tiles/flavor/amulet_W.png' },
    { "Ivory", colors.WHITE, 'tiles/flavor/amulet_w.png' },
    { "Obsidian", colors.BLACK, 'tiles/flavor/amulet_D.png' },
    { "Bone", colors.WHITE, 'tiles/flavor/amulet_w.png' },
    { "Brass", colors.ORANGE, 'tiles/flavor/amulet_o.png' },
    { "Bronze", colors.LIGHT_UMBER, 'tiles/flavor/amulet_U.png' },
    { "Pewter", colors.LIGHT_SLATE, 'tiles/flavor/amulet_s.png' },
    { "Tortoise Shell", colors.GREEN, 'tiles/flavor/amulet_g.png' },
    { "Golden", colors.YELLOW, 'tiles/flavor/amulet_y.png' },
    { "Azure", colors.BLUE, 'tiles/flavor/amulet_B.png' },
    { "Crystal", colors.BLUE, 'tiles/flavor/amulet_B.png' },
    { "Silver", colors.WHITE, 'tiles/flavor/amulet_W.png' },
    { "Copper", colors.LIGHT_UMBER, 'tiles/flavor/amulet_U.png' },
    { "Amethyst", colors.VIOLET, 'tiles/flavor/amulet_v.png' },
    { "Mithril", colors.BLUE, 'tiles/flavor/amulet_B.png' },
    { "Sapphire", colors.BLUE, 'tiles/flavor/amulet_b.png' },
    { "Dragon Tooth", colors.WHITE, 'tiles/flavor/amulet_W.png' },
    { "Carved Oak", colors.LIGHT_UMBER, 'tiles/flavor/amulet_u.png' },
    { "Sea Shell", colors.BLUE, 'tiles/flavor/amulet_B.png' },
    { "Flint Stone", colors.LIGHT_SLATE, 'tiles/flavor/amulet_s.png' },
    { "Ruby", colors.RED, 'tiles/flavor/amulet_r.png' },
    { "Scarab", colors.GREEN, 'tiles/flavor/amulet_G.png' },
    { "Origami Paper", colors.WHITE, 'tiles/flavor/amulet_w.png' },
    { "Meteoric Iron", colors.BLACK, 'tiles/flavor/amulet_D.png' },
    { "Platinum", colors.WHITE, 'tiles/flavor/amulet_W.png' },
    { "Glass", colors.WHITE, 'tiles/flavor/amulet_w.png' },
    { "Beryl", colors.GREEN, 'tiles/flavor/amulet_G.png' },
    { "Malachite", colors.GREEN, 'tiles/flavor/amulet_g.png' },
    { "Adamantite", colors.VIOLET, 'tiles/flavor/amulet_v.png' },
    { "Mother-of-pearl", colors.WHITE, 'tiles/flavor/amulet_W.png' },
    { "Runed", colors.LIGHT_UMBER, 'tiles/flavor/amulet_u.png' },
  }
}

newFlavorSet {
  type = 'wand',
  subtype = 'wand',
  values = {
    { "Aluminium", colors.BLUE, 'tiles/flavor/wand_B.png' },
    { "Cast Iron", colors.BLACK, 'tiles/flavor/wand_D.png' },
    { "Chromium", colors.WHITE, 'tiles/flavor/wand_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'tiles/flavor/wand_u.png' },
    { "Gold", colors.YELLOW, 'tiles/flavor/wand_y.png' },
    { "Iron", colors.LIGHT_SLATE, 'tiles/flavor/wand_s.png' },
    { "Magnesium", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Molybdenum", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Nickel", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Rusty", colors.RED, 'tiles/flavor/wand_r.png' },
    { "Silver", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Steel", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Tin", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Titanium", colors.WHITE, 'tiles/flavor/wand_w.png' },
    { "Tungsten", colors.WHITE, 'tiles/flavor/wand_w.png' },
    { "Zirconium", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Zinc", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Aluminium-Plated", colors.BLUE, 'tiles/flavor/wand_B.png' },
    { "Copper-Plated", colors.LIGHT_UMBER, 'tiles/flavor/wand_U.png' },
    { "Gold-Plated", colors.YELLOW, 'tiles/flavor/wand_y.png' },
    { "Nickel-Plated", colors.LIGHT_UMBER, 'tiles/flavor/wand_U.png' },
    { "Silver-Plated", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Steel-Plated", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Tin-Plated", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Zinc-Plated", colors.WHITE, 'tiles/flavor/wand_W.png' },
    { "Mithril-Plated", colors.BLUE, 'tiles/flavor/wand_B.png' },
    { "Mithril", colors.BLUE, 'tiles/flavor/wand_B.png' },
    { "Runed", colors.LIGHT_UMBER, 'tiles/flavor/wand_u.png' },
    { "Bronze", colors.LIGHT_UMBER, 'tiles/flavor/wand_U.png' },
    { "Brass", colors.LIGHT_UMBER, 'tiles/flavor/wand_U.png' },
    { "Platinum", colors.WHITE, 'tiles/flavor/wand_w.png' },
    { "Lead", colors.LIGHT_SLATE, 'tiles/flavor/wand_s.png' },
    { "Lead-Plated", colors.LIGHT_SLATE, 'tiles/flavor/wand_s.png' },
    { "Ivory" , colors.WHITE, 'tiles/flavor/wand_w.png' },
    { "Adamantite", colors.VIOLET, 'tiles/flavor/wand_v.png' },
    { "Uridium", colors.RED, 'tiles/flavor/wand_R.png' },
    { "Long", colors.BLUE, 'tiles/flavor/wand_B.png' },
    { "Short", colors.BLUE, 'tiles/flavor/wand_b.png' },
    { "Hexagonal", colors.RED, 'tiles/flavor/wand_r.png' },
  }
}

newFlavorSet {
  type = 'utility',
  subtype = 'staff',
  values = {
    { "Aspen", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Balsa", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Banyan", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Birch", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Cedar", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Cottonwood", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Cypress", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Dogwood", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Elm", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Eucalyptus", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Hemlock", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Hickory", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Ironwood", colors.LIGHT_UMBER, 'tiles/flavor/staff_u.png' },
    { "Locust", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Mahogany", colors.LIGHT_UMBER, 'tiles/flavor/staff_u.png' },
    { "Maple", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Mulberry", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Oak", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Pine", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Redwood", colors.RED, 'tiles/flavor/staff_r.png' },
    { "Rosewood", colors.RED, 'tiles/flavor/staff_r.png' },
    { "Spruce", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Sycamore", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Teak", colors.DARK_UMBER, 'tiles/flavor/staff_U.png' },
    { "Walnut", colors.DARK_UMBER, 'tiles/flavor/staff_u.png' },
    { "Mistletoe", colors.GREEN, 'tiles/flavor/staff_g.png' },
    { "Hawthorn", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Bamboo", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
    { "Silver", colors.WHITE, 'tiles/flavor/staff_W.png' },
    { "Runed", colors.LIGHT_UMBER, 'tiles/flavor/staff_u.png' },
    { "Golden", colors.YELLOW, 'tiles/flavor/staff_y.png' },
    { "Ashen", colors.LIGHT_SLATE, 'tiles/flavor/staff_s.png' },
    { "Gnarled", colors.LIGHT_UMBER, 'tiles/flavor/staff_u.png' },
    { "Ivory", colors.WHITE, 'tiles/flavor/staff_W.png' },
    { "Willow", colors.LIGHT_UMBER, 'tiles/flavor/staff_U.png' },
  }
}

newFlavorSet {
  type = 'wand',
  subtype = 'rod',
  values = {
    { "Aluminium", colors.BLUE, 'tiles/flavor/rod_tip_B.png' },
    { "Cast Iron", colors.BLACK, 'tiles/flavor/rod_tip_D.png' },
    { "Chromium", colors.WHITE, 'tiles/flavor/rod_tip_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'tiles/flavor/rod_tip_u.png' },
    { "Gold", colors.YELLOW, 'tiles/flavor/rod_tip_y.png' },
    { "Iron", colors.LIGHT_SLATE, 'tiles/flavor/rod_tip_s.png' },
    { "Magnesium", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Molybdenum", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Nickel", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Rusty", colors.RED, 'tiles/flavor/rod_tip_r.png' },
    { "Silver", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Steel", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Tin", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Titanium", colors.WHITE, 'tiles/flavor/rod_tip_w.png' },
    { "Tungsten", colors.WHITE, 'tiles/flavor/rod_tip_w.png' },
    { "Zirconium", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Zinc", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Aluminium-Plated", colors.BLUE, 'tiles/flavor/rod_tip_B.png' },
    { "Copper-Plated", colors.LIGHT_UMBER, 'tiles/flavor/rod_tip_U.png' },
    { "Gold-Plated", colors.YELLOW, 'tiles/flavor/rod_tip_y.png' },
    { "Nickel-Plated", colors.LIGHT_UMBER, 'tiles/flavor/rod_tip_U.png' },
    { "Silver-Plated", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Steel-Plated", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Tin-Plated", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Zinc-Plated", colors.WHITE, 'tiles/flavor/rod_tip_W.png' },
    { "Mithril-Plated", colors.BLUE, 'tiles/flavor/rod_tip_B.png' },
    { "Mithril", colors.BLUE, 'tiles/flavor/rod_tip_B.png' },
    { "Runed", colors.LIGHT_UMBER, 'tiles/flavor/rod_tip_u.png' },
    { "Bronze", colors.LIGHT_UMBER, 'tiles/flavor/rod_tip_U.png' },
    { "Brass", colors.LIGHT_UMBER, 'tiles/flavor/rod_tip_U.png' },
    { "Platinum", colors.WHITE, 'tiles/flavor/rod_tip_w.png' },
    { "Lead", colors.LIGHT_SLATE, 'tiles/flavor/rod_tip_s.png' },
    { "Lead-Plated", colors.LIGHT_SLATE, 'tiles/flavor/rod_tip_s.png' },
    { "Ivory" , colors.WHITE, 'tiles/flavor/rod_tip_w.png' },
    { "Adamantite", colors.VIOLET, 'tiles/flavor/rod_tip_v.png' },
    { "Uridium", colors.RED, 'tiles/flavor/rod_tip_R.png' },
    { "Long", colors.BLUE, 'tiles/flavor/rod_tip_B.png' },
    { "Short", colors.BLUE, 'tiles/flavor/rod_tip_b.png' },
    { "Hexagonal", colors.RED, 'tiles/flavor/rod_tip_r.png' },
  }
}
