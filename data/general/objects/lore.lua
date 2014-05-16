--Veins of the Earth 
--Zireael 2014

newEntity{
	define_as = "BASE_LORE",
	type = "lore", subtype="lore", not_in_stores=true, no_unique_lore=true,
	unided_name = "parchment", identified=true,
	display = "?", color=colors.ANTIQUE_WHITE, --image="object/scroll-lore.png",
	encumber = 0,
	checkFilter = function(self) if self.lore and game.player.lore_known and game.player.lore_known[self.lore] then print('[LORE] refusing', self.lore) return false else return true end end,
	desc = [[This parchment contains some lore.]],
}

newEntity{
	define_as = "BASE_LORE_RANDOM",
	type = "lore", subtype="lore", not_in_stores=true, no_unique_lore=true,
	unided_name = "parchment", identified=true,
	display = "?", color=colors.ANTIQUE_WHITE, --image="object/scroll.png",
	encumber = 0,
	checkFilter = function(self) if self.lore and game.player.lore_known and game.player.lore_known[self.lore] then print('[LORE] refusing', self.lore) return false else return true end end,
	desc = [[This parchment contains some lore.]],
}