newEntity{
	define_as = "GENERAL",
	name = "general store",
	display = '2', color=colors.UMBER,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="weapon", subtype="shortsword", id=true },
			{type="weapon", subtype="sword", id=true, },
			{type="weapon", subtype="waraxe", id=true, },
			{type="weapon", subtype="battleaxe", id=true, },
			{type="weapon", subtype="mace", id=true,},
			{type="weapon", subtype="dagger", id=true, },
			{type="weapon", subtype="staff", id=true, },
			{type="weapon", subtype="crossbow", id=true, },
			{type="weapon", subtype="bow", id=true, },
			{type="weapon", subtype="sling", id=true, },
			{type="ammo", id=true, },
			{type="ammo", id=true, },
			{type="armor", subtype="heavy", id=true, },
			{type="armor", subtype="shield", id=true, },
			{type="armor", subtype="light", id=true, },
			{type="armor", subtype="medium", id=true, },
		},
	},
}

newEntity{
	define_as = "ARMORY",
	name = "armory",
	display = '2', color=colors.UMBER,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="armor", subtype="heavy", id=true, },
			{type="armor", subtype="shield", id=true, },
			{type="armor", subtype="light", id=true, },
			{type="armor", subtype="medium", id=true, },
		},
	},
}

newEntity{
	define_as = "WEAPONSMITH",
	name = "weaponsmith",
	display = '2', color=colors.UMBER,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="weapon", subtype="shortsword", id=true },
			{type="weapon", subtype="sword", id=true, },
			{type="weapon", subtype="waraxe", id=true, },
			{type="weapon", subtype="battleaxe", id=true, },
			{type="weapon", subtype="mace", id=true,},
			{type="weapon", subtype="dagger", id=true, },
			{type="weapon", subtype="staff", id=true, },
			{type="weapon", subtype="crossbow", id=true, },
			{type="weapon", subtype="bow", id=true, },
			{type="weapon", subtype="sling", id=true, },
			{type="ammo", id=true, },
			{type="ammo", id=true, },
		},
	},
}

newEntity{
	define_as = "ADVENTURER",
	name = "adventuring gear",
	display = '2', color=colors.UMBER,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="torch", id=true},
			{type="container", id=true},
			{type="food", subtype="food", id=true},
			{type="food", subtype="food", id=true},
			{type="food", subtype="food", id=true},
			{type="tool", id=true},
			{type="tool", id=true},
			{type="tool", id=true},
			{type="ammo", id=true, },
			{type="ammo", id=true, },
		},
	},
}

newEntity{
	define_as = "MAGIC",
	name = "magic item shop",
	display = "*", color=colors.LIGHT_RED,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="amulet", id=true},
			{type="ring", id=true},
			{type="bracer", id=true},
			{type="cloak", id=true, },
			{type="boots", id=true, },
			{type="belt", id=true },
			{type="wand", id=true},
			{type="scroll", id=true},
		},
	},
}

newEntity{
	define_as = "POTION",
	name = "potion shop",
	display = "*", color=colors.LIGHT_GREEN,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="potion", id=true},
			{type="potion", id=true},
			{type="potion", id=true},
			{type="potion", id=true, },
			{type="potion", id=true, },
			{type="potion", id=true },
			{type="potion", id=true},
			{type="potion", id=true},
		},
	},
}

newEntity{
	define_as = "LIBRARY",
	name = "library",
	display = "*", color=colors.LIGHT_BLUE,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="lore", subtype="lore", id=true },
		},
	},
}
