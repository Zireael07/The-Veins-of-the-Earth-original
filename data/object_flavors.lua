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
    { "Blue", colors.BLUE, 'object/flavor/shroom_b.png' },
    { "Black", colors.BLACK, 'object/flavor/shroom_D.png' },
    { "Black Spotted", colors.BLACK, 'object/flavor/shroom_D.png' },
    { "Brown", colors.LIGHT_UMBER, 'object/flavor/shroom_u.png' },
    { "Dark Blue", colors.BLUE, 'object/flavor/shroom_b.png' },
    { "Dark Green", colors.GREEN, 'object/flavor/shroom_g.png' },
    { "Dark Red", colors.RED, 'object/flavor/shroom_r.png' },
    { "Yellow", colors.YELLOW, 'object/flavor/shroom_y.png' },
    { "Furry", colors.WHITE, 'object/flavor/shroom_W.png' },
    { "Green", colors.GREEN, 'object/flavor/shroom_g.png' },
    { "Grey", colors.LIGHT_SLATE, 'object/flavor/shroom_s.png' },
    { "Light Blue", colors.BLUE, 'object/flavor/shroom_B.png' },
    { "Light Green", colors.GREEN, 'object/flavor/shroom_G.png' },
    { "Violet", colors.VIOLET, 'object/flavor/shroom_v.png' },
    { "Red", colors.RED, 'object/flavor/shroom_r.png' },
    { "Slimy", colors.LIGHT_SLATE, 'object/flavor/shroom_s.png' },
    { "Tan", colors.LIGHT_UMBER, 'object/flavor/shroom_U.png' },
    { "White", colors.WHITE, 'object/flavor/shroom_w.png' },
    { "White Spotted", colors.WHITE, 'object/flavor/shroom_w.png' },
    { "Wrinkled", colors.LIGHT_UMBER, 'object/flavor/shroom_u.png' },
  }
}

newFlavorSet {
  type = 'potion',
  subtype = 'potion',
  values = {
--    { "Strangely Phosphorescent", colors.C_multi, 'object/flavor/pot_m.png' },
    { "Azure", colors.BLUE, 'object/flavor/pot_B.png' },
    { "Blue", colors.DARK_BLUE, 'object/flavor/pot_b.png' },
    { "Blue Speckled", colors.ROYAL_BLUE, 'object/flavor/pot_b.png' },
    { "Black", colors.BLACK, 'object/flavor/pot_D.png' },
    { "Brown", colors.SANDY_BROWN, 'object/flavor/pot_u.png' },
    { "Brown Speckled", colors.SANDY_BROWN, 'object/flavor/pot_u.png' },
    { "Bubbling", colors.WHITE, 'object/flavor/pot_W.png' },
    { "Chartreuse", colors.GREEN, 'object/flavor/pot_G.png' },
    { "Cloudy", colors.ANTIQUE_WHITE, 'object/flavor/pot_w.png' },
    { "Copper Speckled", colors.LIGHT_UMBER, 'object/flavor/pot_U.png' },
    { "Crimson", colors.CRIMSON, 'object/flavor/pot_r.png' },
    { "Cyan", colors.LIGHT_BLUE, 'object/flavor/pot_B.png' },
    { "Dark Blue", colors.DARK_BLUE, 'object/flavor/pot_b.png' },
    { "Dark Green", colors.DARK_GREEN, 'object/flavor/pot_g.png' },
    { "Dark Red", colors.DARK_RED, 'object/flavor/pot_r.png' },
    { "Gold Speckled", colors.YELLOW, 'object/flavor/pot_y.png' },
    { "Green", colors.GREEN, 'object/flavor/pot_g.png' },
    { "Green Speckled", colors.LIGHT_GREEN, 'object/flavor/pot_g.png' },
    { "Grey", colors.DARK_GREY, 'object/flavor/pot_s.png' },
    { "Grey Speckled", colors.LIGHT_GREY, 'object/flavor/pot_s.png' },
    { "Hazy", colors.ANTIQUE_WHITE, 'object/flavor/pot_W.png' },
    { "Indigo", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Light Blue", colors.LIGHT_BLUE, 'object/flavor/pot_B.png' },
    { "Light Green", colors.LIGHT_GREEN, 'object/flavor/pot_G.png' },
    { "Magenta", colors.RED, 'object/flavor/pot_r.png' },
    { "Metallic Blue", colors.DARK_BLUE, 'object/flavor/pot_b.png' },
    { "Metallic Red", colors.DARK_RED, 'object/flavor/pot_r.png' },
    { "Metallic Green", colors.DARK_GREEN, 'object/flavor/pot_g.png' },
    { "Metallic Purple", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Misty", colors.ANTIQUE_WHITE, 'object/flavor/pot_W.png' },
    { "Orange", colors.ORANGE, 'object/flavor/pot_o.png' },
    { "Orange Speckled", colors.ORANGE, 'object/flavor/pot_o.png' },
    { "Pink", colors.PINK, 'object/flavor/pot_R.png' },
    { "Pink Speckled", colors.PINK, 'object/flavor/pot_R.png' },
    { "Puce", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Purple", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Purple Speckled", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Red", colors.RED, 'object/flavor/pot_r.png' },
    { "Red Speckled", colors.RED, 'object/flavor/pot_r.png' },
    { "Silver Speckled", colors.WHITE, 'object/flavor/pot_W.png' },
    { "Smoky", colors.BLACK, 'object/flavor/pot_D.png' },
    { "Tangerine", colors.ORANGE, 'object/flavor/pot_o.png' },
    { "Violet", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Vermilion", colors.RED, 'object/flavor/pot_r.png' },
    { "White", colors.WHITE, 'object/flavor/pot_w.png' },
    { "Yellow", colors.YELLOW, 'object/flavor/pot_y.png' },
    { "Violet Speckled", colors.VIOLET, 'object/flavor/pot_v.png' },
    { "Pungent", colors.RED, 'object/flavor/pot_R.png' },
    { "Clotted Red", colors.RED, 'object/flavor/pot_r.png' },
    { "Viscous Pink", colors.RED, 'object/flavor/pot_R.png' },
    { "Oily Yellow", colors.YELLOW, 'object/flavor/pot_y.png' },
    { "Gloopy Green", colors.GREEN, 'object/flavor/pot_g.png' },
--    { "Shimmering", colors.C_multi, 'object/flavor/pot_m.png' },
    { "Coagulated Crimson", colors.RED, 'object/flavor/pot_r.png' },
    { "Yellow Speckled", colors.YELLOW, 'object/flavor/pot_y.png' },
    { "Gold", colors.GOLD, 'object/flavor/pot_y.png' },
    { "Manly", colors.LIGHT_UMBER, 'object/flavor/pot_U.png' },
    { "Stinking", colors.LIGHT_UMBER, 'object/flavor/pot_u.png' },
    { "Oily Black", colors.BLACK, 'object/flavor/pot_D.png' },
    { "Ichor", colors.RED, 'object/flavor/pot_r.png' },
    { "Ivory White", colors.WHITE, 'object/flavor/pot_w.png' },
    { "Sky Blue", colors.BLUE, 'object/flavor/pot_B.png' },
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
    local Object = require('mod.class.Object')
    local fl_def = Object.flavors_def[type][subtype]
    -- The Adam Bolt tileset has four tiles for scrolls.  All the other
    -- flavored-object tiles are keyed by color, but all scrolls are white,
    -- so we choose one at random to assign to this flavor.
    local tile = ('object/flavor/scroll_%d.png'):format(rng.range(1, 4))
    -- Collect a list of titles we've already generated for comparision
    -- to avoid collisions.
    local seen = {}
    local used = game.state.flavors_assigned[type][subtype]
    for _, title in pairs(used) do seen[title] = true end
    -- As per object1.c:flavor_init(), we assemble a list of one- or two-
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
    { "Alexandrite", colors.GREEN, 'object/flavor/ring_g.png' },
    { "Amethyst", colors.VIOLET, 'object/flavor/ring_v.png' },
    { "Aquamarine", colors.BLUE, 'object/flavor/ring_B.png' },
    { "Azurite", colors.BLUE, 'object/flavor/ring_B.png' },
    { "Beryl", colors.GREEN, 'object/flavor/ring_G.png' },
    { "Bloodstone", colors.RED, 'object/flavor/ring_r.png' },
    { "Calcite", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Carnelian", colors.RED, 'object/flavor/ring_r.png' },
    { "Corundum", colors.LIGHT_SLATE, 'object/flavor/ring_s.png' },
    { "Diamond", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Emerald", colors.GREEN, 'object/flavor/ring_g.png' },
    { "Fluorite", colors.GREEN, 'object/flavor/ring_G.png' },
    { "Garnet", colors.RED, 'object/flavor/ring_r.png' },
    { "Granite", colors.BLACK, 'object/flavor/ring_D.png' },
    { "Jade", colors.GREEN, 'object/flavor/ring_G.png' },
    { "Jasper", colors.LIGHT_UMBER, 'object/flavor/ring_u.png' },
    { "Lapis Lazuli", colors.BLUE, 'object/flavor/ring_b.png' },
    { "Malachite", colors.GREEN, 'object/flavor/ring_g.png' },
    { "Marble", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Moonstone", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Onyx", colors.RED, 'object/flavor/ring_R.png' },
    { "Opal", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Pearl", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Quartz", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Quartzite", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Rhodonite", colors.RED, 'object/flavor/ring_R.png' },
    { "Ruby", colors.RED, 'object/flavor/ring_r.png' },
    { "Sapphire", colors.BLUE, 'object/flavor/ring_b.png' },
    { "Tiger Eye", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Topaz", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Turquoise", colors.BLUE, 'object/flavor/ring_B.png' },
    { "Zircon", colors.LIGHT_UMBER, 'object/flavor/ring_U.png' },
    { "Platinum", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Bronze", colors.LIGHT_UMBER, 'object/flavor/ring_U.png' },
    { "Gold", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Obsidian", colors.BLACK, 'object/flavor/ring_D.png' },
    { "Silver", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Tortoise Shell", colors.GREEN, 'object/flavor/ring_g.png' },
    { "Mithril", colors.BLUE, 'object/flavor/ring_B.png' },
    { "Jet", colors.BLACK, 'object/flavor/ring_D.png' },
    { "Engagement", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Adamantite", colors.VIOLET, 'object/flavor/ring_v.png' },
    { "Wire", colors.LIGHT_UMBER, 'object/flavor/ring_u.png' },
    { "Dilithium", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Bone", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Wooden", colors.LIGHT_UMBER, 'object/flavor/ring_u.png' },
    { "Spikard", colors.BLUE, 'object/flavor/ring_b.png' },
    { "Serpent", colors.GREEN, 'object/flavor/ring_g.png' },
    { "Wedding", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Double", colors.ORANGE, 'object/flavor/ring_o.png' },
    { "Plain", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Brass", colors.ORANGE, 'object/flavor/ring_o.png' },
    { "Scarab", colors.GREEN, 'object/flavor/ring_G.png' },
    { "Shining", colors.YELLOW, 'object/flavor/ring_y.png' },
    { "Rusty", colors.RED, 'object/flavor/ring_r.png' },
    { "Transparent", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'object/flavor/ring_u.png' },
    { "Black Opal", colors.BLACK, 'object/flavor/ring_D.png' },
    { "Nickel", colors.WHITE, 'object/flavor/ring_W.png' },
    { "Glass", colors.WHITE, 'object/flavor/ring_w.png' },
    { "Fluorspar", colors.BLUE, 'object/flavor/ring_b.png' },
    { "Agate", colors.WHITE, 'object/flavor/ring_W.png' },
  }
}

newFlavorSet {
  type = 'amulet',
  subtype = 'amulet',
  values = {
    { "Amber", colors.YELLOW, 'object/flavor/amulet_y.png' },
    { "Driftwood", colors.LIGHT_UMBER, 'object/flavor/amulet_U.png' },
    { "Coral", colors.WHITE, 'object/flavor/amulet_w.png' },
    { "Agate", colors.WHITE, 'object/flavor/amulet_W.png' },
    { "Ivory", colors.WHITE, 'object/flavor/amulet_w.png' },
    { "Obsidian", colors.BLACK, 'object/flavor/amulet_D.png' },
    { "Bone", colors.WHITE, 'object/flavor/amulet_w.png' },
    { "Brass", colors.ORANGE, 'object/flavor/amulet_o.png' },
    { "Bronze", colors.LIGHT_UMBER, 'object/flavor/amulet_U.png' },
    { "Pewter", colors.LIGHT_SLATE, 'object/flavor/amulet_s.png' },
    { "Tortoise Shell", colors.GREEN, 'object/flavor/amulet_g.png' },
    { "Golden", colors.YELLOW, 'object/flavor/amulet_y.png' },
    { "Azure", colors.BLUE, 'object/flavor/amulet_B.png' },
    { "Crystal", colors.BLUE, 'object/flavor/amulet_B.png' },
    { "Silver", colors.WHITE, 'object/flavor/amulet_W.png' },
    { "Copper", colors.LIGHT_UMBER, 'object/flavor/amulet_U.png' },
    { "Amethyst", colors.VIOLET, 'object/flavor/amulet_v.png' },
    { "Mithril", colors.BLUE, 'object/flavor/amulet_B.png' },
    { "Sapphire", colors.BLUE, 'object/flavor/amulet_b.png' },
    { "Dragon Tooth", colors.WHITE, 'object/flavor/amulet_W.png' },
    { "Carved Oak", colors.LIGHT_UMBER, 'object/flavor/amulet_u.png' },
    { "Sea Shell", colors.BLUE, 'object/flavor/amulet_B.png' },
    { "Flint Stone", colors.LIGHT_SLATE, 'object/flavor/amulet_s.png' },
    { "Ruby", colors.RED, 'object/flavor/amulet_r.png' },
    { "Scarab", colors.GREEN, 'object/flavor/amulet_G.png' },
    { "Origami Paper", colors.WHITE, 'object/flavor/amulet_w.png' },
    { "Meteoric Iron", colors.BLACK, 'object/flavor/amulet_D.png' },
    { "Platinum", colors.WHITE, 'object/flavor/amulet_W.png' },
    { "Glass", colors.WHITE, 'object/flavor/amulet_w.png' },
    { "Beryl", colors.GREEN, 'object/flavor/amulet_G.png' },
    { "Malachite", colors.GREEN, 'object/flavor/amulet_g.png' },
    { "Adamantite", colors.VIOLET, 'object/flavor/amulet_v.png' },
    { "Mother-of-pearl", colors.WHITE, 'object/flavor/amulet_W.png' },
    { "Runed", colors.LIGHT_UMBER, 'object/flavor/amulet_u.png' },
  }
}

newFlavorSet {
  type = 'wand',
  subtype = 'wand',
  values = {
    { "Aluminium", colors.BLUE, 'object/flavor/wand_B.png' },
    { "Cast Iron", colors.BLACK, 'object/flavor/wand_D.png' },
    { "Chromium", colors.WHITE, 'object/flavor/wand_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'object/flavor/wand_u.png' },
    { "Gold", colors.YELLOW, 'object/flavor/wand_y.png' },
    { "Iron", colors.LIGHT_SLATE, 'object/flavor/wand_s.png' },
    { "Magnesium", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Molybdenum", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Nickel", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Rusty", colors.RED, 'object/flavor/wand_r.png' },
    { "Silver", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Steel", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Tin", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Titanium", colors.WHITE, 'object/flavor/wand_w.png' },
    { "Tungsten", colors.WHITE, 'object/flavor/wand_w.png' },
    { "Zirconium", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Zinc", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Aluminium-Plated", colors.BLUE, 'object/flavor/wand_B.png' },
    { "Copper-Plated", colors.LIGHT_UMBER, 'object/flavor/wand_U.png' },
    { "Gold-Plated", colors.YELLOW, 'object/flavor/wand_y.png' },
    { "Nickel-Plated", colors.LIGHT_UMBER, 'object/flavor/wand_U.png' },
    { "Silver-Plated", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Steel-Plated", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Tin-Plated", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Zinc-Plated", colors.WHITE, 'object/flavor/wand_W.png' },
    { "Mithril-Plated", colors.BLUE, 'object/flavor/wand_B.png' },
    { "Mithril", colors.BLUE, 'object/flavor/wand_B.png' },
    { "Runed", colors.LIGHT_UMBER, 'object/flavor/wand_u.png' },
    { "Bronze", colors.LIGHT_UMBER, 'object/flavor/wand_U.png' },
    { "Brass", colors.LIGHT_UMBER, 'object/flavor/wand_U.png' },
    { "Platinum", colors.WHITE, 'object/flavor/wand_w.png' },
    { "Lead", colors.LIGHT_SLATE, 'object/flavor/wand_s.png' },
    { "Lead-Plated", colors.LIGHT_SLATE, 'object/flavor/wand_s.png' },
    { "Ivory" , colors.WHITE, 'object/flavor/wand_w.png' },
    { "Adamantite", colors.VIOLET, 'object/flavor/wand_v.png' },
    { "Uridium", colors.RED, 'object/flavor/wand_R.png' },
    { "Long", colors.BLUE, 'object/flavor/wand_B.png' },
    { "Short", colors.BLUE, 'object/flavor/wand_b.png' },
    { "Hexagonal", colors.RED, 'object/flavor/wand_r.png' },
  }
}

newFlavorSet {
  type = 'utility',
  subtype = 'staff',
  values = {
    { "Aspen", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Balsa", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Banyan", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Birch", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Cedar", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Cottonwood", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Cypress", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Dogwood", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Elm", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Eucalyptus", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Hemlock", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Hickory", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Ironwood", colors.LIGHT_UMBER, 'object/flavor/staff_u.png' },
    { "Locust", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Mahogany", colors.LIGHT_UMBER, 'object/flavor/staff_u.png' },
    { "Maple", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Mulberry", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Oak", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Pine", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Redwood", colors.RED, 'object/flavor/staff_r.png' },
    { "Rosewood", colors.RED, 'object/flavor/staff_r.png' },
    { "Spruce", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Sycamore", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Teak", colors.DARK_UMBER, 'object/flavor/staff_U.png' },
    { "Walnut", colors.DARK_UMBER, 'object/flavor/staff_u.png' },
    { "Mistletoe", colors.GREEN, 'object/flavor/staff_g.png' },
    { "Hawthorn", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Bamboo", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
    { "Silver", colors.WHITE, 'object/flavor/staff_W.png' },
    { "Runed", colors.LIGHT_UMBER, 'object/flavor/staff_u.png' },
    { "Golden", colors.YELLOW, 'object/flavor/staff_y.png' },
    { "Ashen", colors.LIGHT_SLATE, 'object/flavor/staff_s.png' },
    { "Gnarled", colors.LIGHT_UMBER, 'object/flavor/staff_u.png' },
    { "Ivory", colors.WHITE, 'object/flavor/staff_W.png' },
    { "Willow", colors.LIGHT_UMBER, 'object/flavor/staff_U.png' },
  }
}

newFlavorSet {
  type = 'wand',
  subtype = 'rod',
  values = {
    { "Aluminium", colors.BLUE, 'object/flavor/rod_tip_B.png' },
    { "Cast Iron", colors.BLACK, 'object/flavor/rod_tip_D.png' },
    { "Chromium", colors.WHITE, 'object/flavor/rod_tip_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'object/flavor/rod_tip_u.png' },
    { "Gold", colors.YELLOW, 'object/flavor/rod_tip_y.png' },
    { "Iron", colors.LIGHT_SLATE, 'object/flavor/rod_tip_s.png' },
    { "Magnesium", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Molybdenum", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Nickel", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Rusty", colors.RED, 'object/flavor/rod_tip_r.png' },
    { "Silver", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Steel", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Tin", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Titanium", colors.WHITE, 'object/flavor/rod_tip_w.png' },
    { "Tungsten", colors.WHITE, 'object/flavor/rod_tip_w.png' },
    { "Zirconium", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Zinc", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Aluminium-Plated", colors.BLUE, 'object/flavor/rod_tip_B.png' },
    { "Copper-Plated", colors.LIGHT_UMBER, 'object/flavor/rod_tip_U.png' },
    { "Gold-Plated", colors.YELLOW, 'object/flavor/rod_tip_y.png' },
    { "Nickel-Plated", colors.LIGHT_UMBER, 'object/flavor/rod_tip_U.png' },
    { "Silver-Plated", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Steel-Plated", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Tin-Plated", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Zinc-Plated", colors.WHITE, 'object/flavor/rod_tip_W.png' },
    { "Mithril-Plated", colors.BLUE, 'object/flavor/rod_tip_B.png' },
    { "Mithril", colors.BLUE, 'object/flavor/rod_tip_B.png' },
    { "Runed", colors.LIGHT_UMBER, 'object/flavor/rod_tip_u.png' },
    { "Bronze", colors.LIGHT_UMBER, 'object/flavor/rod_tip_U.png' },
    { "Brass", colors.LIGHT_UMBER, 'object/flavor/rod_tip_U.png' },
    { "Platinum", colors.WHITE, 'object/flavor/rod_tip_w.png' },
    { "Lead", colors.LIGHT_SLATE, 'object/flavor/rod_tip_s.png' },
    { "Lead-Plated", colors.LIGHT_SLATE, 'object/flavor/rod_tip_s.png' },
    { "Ivory" , colors.WHITE, 'object/flavor/rod_tip_w.png' },
    { "Adamantite", colors.VIOLET, 'object/flavor/rod_tip_v.png' },
    { "Uridium", colors.RED, 'object/flavor/rod_tip_R.png' },
    { "Long", colors.BLUE, 'object/flavor/rod_tip_B.png' },
    { "Short", colors.BLUE, 'object/flavor/rod_tip_b.png' },
    { "Hexagonal", colors.RED, 'object/flavor/rod_tip_r.png' },
  }
}
