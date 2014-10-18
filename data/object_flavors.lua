-- based on Zizzo's code
-- Veins of the Earth
-- Zireael 2014
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
    { "Azure", colors.BLUE, 'tiles/flavors/PotionAquamarine.png' },
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

--From Incursion & ToME 2
newFlavorSet{
    type = "ring",
    subtype = "ring",
    values = {
    { "adamant", colors.DARK_SLATE, 'tiles/flavors/ring_s.png' },
    { "agate", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "alexandrite", colors.GREEN, 'tiles/flavors/ring_g.png' },
    { "amethyst", colors.VIOLET, 'tiles/flavors/ring_v.png' },
    { "amber", colors.YELLOW, 'tiles/flavors/ring_D.png' },
    { "ancestral", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "aquamarine", colors.BLUE, 'tiles/flavors/ring_B.png' },
    { "azurite", colors.BLUE, 'tiles/flavors/ring_B.png' },
    { "beryl", colors.GREEN, 'tiles/flavors/ring_G.png' },
    { "black", colors.BLACK, 'tiles/flavors/ring_s.png' },
    { "blood-stained", colors.DARK_RED, 'tiles/flavors/ring_r.png' },
    { "bloodstone", colors.RED, 'tiles/flavor/ring_r.png' },
    { "Bone", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "brass", colors.ORANGE, 'tiles/flavors/ring_o.png' },
    { "bronze", colors.LIGHT_BROWN, 'tiles/flavors/ring_U.png' },
    { "bloody", colors.DARK_RED, 'tiles/flavors/ring_r.png' },
    { "carved", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "Copper", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "crudely made", colors.LIGHT_UMBER, 'tiles/flavors/ring_B.png' },
    { "crystal", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "calcite", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "carnelian", colors.RED, 'tiles/flavors/ring_r.png' },
    { "corundum", colors.LIGHT_SLATE, 'tiles/flavors/ring_s.png' },
    { "diamond", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "double-banded", colors.ORANGE, 'tiles/flavors/ring_o.png' },
    { "dwarven", colors.LIGHT_SLATE, 'tiles/flavors/ring_s.png' },
    { "electrum", colors.BLUE, 'tiles/flavors/ring_B.png' },
    { "elven", colors.BLACK, 'tiles/flavors/wand_D.png' },
    { "emerald", colors.GREEN, 'tiles/flavors/ring_g.png' },
    { "engraved", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "gem-studded", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "fluorite", colors.GREEN, 'tiles/flavors/ring_G.png' },
    { "Fluorspar", colors.BLUE, 'tiles/flavors/ring_b.png' },
    { "garnet", colors.RED, 'tiles/flavors/ring_r.png' },
    { "glass", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "granite", colors.BLACK, 'tiles/flavors/ring_D.png' },
    { "grass", colors.GREEN, 'tiles/flavors/ring_G.png' },
    { "gold", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "hand-made", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "inscribed", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "iron", colors.DARK_SLATE, 'tiles/flavors/ring_s.png' },
    { "Jade", colors.GREEN, 'tiles/flavors/ring_G.png' },
    { "Jasper", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "Jet", colors.BLACK, 'tiles/flavors/ring_D.png' },
    { "kinship", colors.BLUE, 'tiles/flavors/wand_B.png' },
    { "Lapis Lazuli", colors.BLUE, 'tiles/flavors/ring_b.png' },
    { "large", colors.ORANGE, 'tiles/flavors/ring_o.png' },
    { "Malachite", colors.GREEN, 'tiles/flavors/ring_g.png' },
    { "Marble", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "Mithril", colors.BLUE, 'tiles/flavors/ring_B.png' },
    { "monogrammed", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "moonstone", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "Nickel", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "obsidian", colors.BLACK, 'tiles/flavors/ring_D.png' },
    { "Onyx", colors.RED, 'tiles/flavors/ring_R.png' },
    { "white opal", colors.BLACK, 'tiles/flavors/ring_D.png' },
    { "Black opal", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "ornate", colors.LIGHT_SLATE, 'tiles/flavors/ring_s.png' },
    { "Pearl", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "plain", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "platinum", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "Quartz", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "Quartzite", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "Rhodonite", colors.RED, 'tiles/flavors/ring_R.png' },
    { "ruby", colors.RED, 'tiles/flavors/ring_r.png' },
    { "rune-covered", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "Rusty", colors.RED, 'tiles/flavors/ring_r.png' },
    { "sapphire", colors.BLUE, 'tiles/flavors/ring_b.png' },
    { "Scarab", colors.GREEN, 'tiles/flavors/ring_G.png' },
    { "Shining", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "silver", colors.WHITE, 'tiles/flavors/ring_W.png' },
    { "sigil", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "Serpent", colors.GREEN, 'tiles/flavors/ring_g.png' },
    { "slender", colors.BLUE, 'tiles/flavors/ring_B.png' },
    { "steel", colors.BLUE, 'tiles/flavors/ring_B.png' },
    { "stylized", colors.BLACK, 'tiles/flavors/ring_D.png' },
    { "tarnished", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "Tortoise Shell", colors.GREEN, 'tiles/flavors/ring_g.png' },
    { "thick", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "thin", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "Tiger Eye", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "topaz", colors.YELLOW, 'tiles/flavors/ring_y.png' },
    { "translucent", colors.WHITE, 'tiles/flavors/ring_w.png' },
    { "Turquoise", colors.BLUE, 'tiles/flavor/ring_B.png' },
    { "Wire", colors.LIGHT_UMBER, 'tiles/flavors/ring_u.png' },
    { "wooden", colors.LIGHT_BROWN, 'tiles/flavors/ring_u.png' },
    { "woven wine", colors.DARK_GREEN, 'tiles/flavors/ring_G.png' },  
    { "Zircon", colors.LIGHT_UMBER, 'tiles/flavors/ring_U.png' },

--    { "Wedding", colors.YELLOW, 'tiles/flavor/ring_y.png' },   
--    { "Engagement", colors.YELLOW, 'tiles/flavors/ring_y.png' },
--    { "Adamantite", colors.VIOLET, 'tiles/flavors/ring_v.png' },

--    { "Dilithium", colors.WHITE, 'tiles/flavors/ring_W.png' },
--    { "Spikard", colors.BLUE, 'tiles/flavor/ring_b.png' },
  }
}

newFlavorSet{
    type = "amulet",
    subtype = "amulet",
    values = {
    { "Adamantite", colors.VIOLET, 'tiles/flavors/amulet_v.png' },
    { "Agate", colors.WHITE, 'tiles/flavors/amulet_W.png' },
    { "agni mani", colors.YELLOW, 'tiles/flavors/amulet_y.png' },
    { "amber", colors.ORANGE, 'tiles/flavors/amulet_o.png' },
    { "Amethyst", colors.VIOLET, 'tiles/flavors/amulet_v.png' },
    { "andar", colors.DARK_SLATE, 'tiles/flavors/cloak_W.png' },
    { "Azure", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "Beryl", colors.GREEN, 'tiles/flavors/amulet_G.png' },
    { "black opal", colors.BLACK, 'tiles/flavors/amulet_r.png' },
    { "bloodstone", colors.RED, 'tiles/flavors/amulet_r.png' },
    { "bone", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "Brass", colors.ORANGE, 'tiles/flavors/amulet_o.png' },
    { "Bronze", colors.LIGHT_UMBER, 'tiles/flavors/amulet_U.png' },
    { "Carved Oak", colors.LIGHT_UMBER, 'tiles/flavors/amulet_u.png' },
    { "chrysoberyl", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "clasped", colors.YELLOW, 'tiles/flavors/amulet_y.png' },
    { "Copper", colors.LIGHT_UMBER, 'tiles/flavors/amulet_U.png' },
    { "Coral", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "cracked", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "Crystal", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "Dragon Tooth", colors.WHITE, 'tiles/flavor/amulet_W.png' },
    { "Driftwood", colors.LIGHT_UMBER, 'tiles/flavors/amulet_U.png' }, 
    { "emerald", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "Flint Stone", colors.LIGHT_SLATE, 'tiles/flavors/amulet_s.png' },
    { "fragile", colors.YELLOW, 'tiles/flavors/amulet_y.png' },
    { "Glass", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "golden", colors.YELLOW, 'tiles/flavors/amulet_y.png' },
    { "hand-carved", colors.WHITE, 'tiles/flavors/amulet_W.png' },
    { "heavy", colors.LIGHT_BROWN, 'tiles/flavors/amulet_U.png' },
    { "high", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "iol", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "Ivory", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "jade", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "jasper", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "large", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "Malachite", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "Meteoric Iron", colors.BLACK, 'tiles/flavors/amulet_D.png' },
    { "Mithril", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "moonsilver", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "Mother-of-pearl", colors.WHITE, 'tiles/flavors/amulet_W.png' },
    { "Obsidian", colors.BLACK, 'tiles/flavors/amulet_D.png' },
    { "painted", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "pearl", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "Pewter", colors.LIGHT_SLATE, 'tiles/flavors/amulet_s.png' },
    { "Platinum", colors.WHITE, 'tiles/flavors/amulet_W.png' },
    { "primitive", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "Ruby", colors.RED, 'tiles/flavors/amulet_r.png' },
    { "ruby-inset", colors.RED, 'tiles/flavors/amulet_r.png' },
    { "runic", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "Sapphire", colors.BLUE, 'tiles/flavors/amulet_b.png' },
    { "Scarab", colors.GREEN, 'tiles/flavors/amulet_G.png' },
    { "scented", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "Sea Shell", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "shamanic", colors.BLUE, 'tiles/flavors/amulet_B.png' },
    { "Silver", colors.WHITE, 'tiles/flavors/amulet_W.png' },
    { "skull", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "skydrop", colors.BLUE, 'tiles/flavors/amulet_b.png' },
    { "sphere", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "steel", colors.DARK_SLATE, 'tiles/flavors/amulet_D.png' },
    { "tchazar", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "Tortoise Shell", colors.GREEN, 'tiles/flavors/amulet_g.png' },
    { "water opal", colors.BLUE, 'tiles/flavors/amulet_b.png' },
    { "waterstar", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "wrought iron", colors.DARK_SLATE, 'tiles/flavors/amulet_s.png' },
    { "ziose", colors.WHITE, 'tiles/flavors/amulet_w.png' },
    { "zircon", colors.ORANGE, 'tiles/flavors/amulet_o.png' },
}
}
    
    
        
    
    



--From Incursion
newFlavorSet{
    type = "cloak",
    subtype = "cloak",
    values = {
    { "hand-made", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "silk", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "reinforced", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "satin", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "jeweled", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
    { "thick black", colors.DARK_SLATE, 'tiles/flavors/cloak_D.png' },
    { "dark crimson", colors.RED, 'tiles/flavors/cloak_r.png' },
    { "thick", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "expensive", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "dark navy", colors.DARK_BLUE, 'tiles/flavors/cloak_B.png' },
    { "long", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "stylized", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "tattered", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "ragged", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "fur-trimmed", colors.LIGHT_BROWN, 'tiles/flavors/cloak_U.png' },
    { "glossy black", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "winter", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "rune-trimmed", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "star-covered", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "patterned", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
    { "heraldic", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
}
}

newFlavorSet{
    type = "bracer",
    subtype = "bracer",
    values = {
    { "adamant-gilded", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "banded", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "chipped", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "cloth", colors.LIGHT_BROWN, 'tiles/flavors/cloak_v.png' },
    { "copper-gilded", colors.ORANGE, 'tiles/flavors/cloak_y.png' },
    { "firm", colors.DARK_SLATE, 'tiles/flavors/cloak_D.png' },
    { "gold-gilded", colors.YELLOW, 'tiles/flavors/cloak_r.png' },
    { "heavy", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "inscribed", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "jeweled", colors.DARK_BLUE, 'tiles/flavors/cloak_B.png' },
    { "leather", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "light", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "loose", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "mithril-gilded", colors.BLUE, 'tiles/flavors/cloak_v.png' },
    { "fur-trimmed", colors.LIGHT_BROWN, 'tiles/flavors/cloak_U.png' },
    { "ornate", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "ornately carved", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "plate", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "pliant", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "polished", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
    { "rune-covered", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
    { "rusted", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "sharp-edged", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "silver-gilded", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "spiked", colors.BLACK, 'tiles/flavors/cloak_D.png' },
    { "stained", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
    { "steel-gilded", colors.DARK_SLATE, 'tiles/flavors/cloak_D.png' },
    { "sturdy", colors.RED, 'tiles/flavors/cloak_r.png' },
    { "tight-fitting", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "well-worn", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
}
}

newFlavorSet{
    type = "boots",
    subtype = "boots",
    values = {
    { "leather", colors.DARK_SLATE, 'tiles/flavors/cloak_s.png' },
    { "steel-toed", colors.DARK_SLATE, 'tiles/flavors/cloak_W.png' },
    { "sturdy", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "decorative", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "soft-solved", colors.YELLOW, 'tiles/flavors/cloak_y.png' },
    { "tanned", colors.DARK_SLATE, 'tiles/flavors/cloak_D.png' },
    { "primitive", colors.RED, 'tiles/flavors/cloak_r.png' },
    { "tall", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "deerskin", colors.VIOLET, 'tiles/flavors/cloak_v.png' },
    { "well-worn", colors.DARK_BLUE, 'tiles/flavors/cloak_B.png' },
    { "rune-covered", colors.GREEN, 'tiles/flavors/cloak_g.png' },
    { "ankle-high", colors.WHITE, 'tiles/flavors/cloak_W.png' },
    { "work", colors.LIGHT_BROWN, 'tiles/flavors/cloak_g.png' },
    { "finely crafted", colors.GREEN, 'tiles/flavors/cloak_v.png' },
}
}