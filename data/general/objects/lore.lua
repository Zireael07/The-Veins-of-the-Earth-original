--Veins of the Earth
--Zireael 2014-2016

newEntity{
	define_as = "BASE_LORE",
	type = "lore", subtype="lore", not_in_stores=true, no_unique_lore=true,
	unided_name = "parchment", identified=true,
	name = "parchment",
	display = "?", color=colors.ANTIQUE_WHITE, image="tiles/new/note.png",
	encumber = 0,
	checkFilter = function(self) if self.lore and game.player.lore_known and game.player.lore_known[self.lore] then print('[LORE] refusing', self.lore) return false else return true end end,
	desc = [[This parchment contains some lore.]],
	use_simple = { name="read it", use = function(self, who, inven, item)
		game.party:learnLore(self.lore)
		return {used=true, id=true, destroy=true}
	end}
}

newEntity{
	define_as = "BASE_LORE_RANDOM",
	type = "lore", subtype="lore", not_in_stores=true, no_unique_lore=true,
	unided_name = "parchment", identified=true,
	name = "parchment",
	display = "?", color=colors.ANTIQUE_WHITE, image="tiles/new/note.png",
	encumber = 0,
	checkFilter = function(self) if self.lore and game.player.lore_known and game.player.lore_known[self.lore] then print('[LORE] refusing', self.lore) return false else return true end end,
	desc = [[This parchment contains some lore.]],
	use_simple = { name="read it", use = function(self, who, inven, item)
		game.party:learnLore(self.lore)
		return {used=true, id=true, destroy=true}
	end}
}
