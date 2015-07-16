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
			{type="weapon", subtype="shortsword", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="sword", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="waraxe", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="battleaxe", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="mace", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},},},
			{type="weapon", subtype="dagger", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="staff", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="crossbow", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="bow", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="weapon", subtype="sling", id=true,  veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="ammo", id=true, not_properties={"cursed"} },
			{type="ammo", id=true, not_properties={"cursed"} },
			{type="armor", subtype="heavy", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="armor", subtype="shield", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="armor", subtype="light", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
			{type="armor", subtype="medium", id=true, veins_level=5, ego_filter = {add_levels=10, not_properties={"cursed"},}, },
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
			{type="food", subtype="ration", id=true},
			{type="food", subtype="ration", id=true},
			{type="food", subtype="ration", id=true},
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

newEntity{
	define_as = "FOOD",
	name = "food shop",
	display = "*", color=colors.DARK_GREEN,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="food", subtype="food", id=true},
			{type="food", subtype="food", id=true},
			{type="food", subtype="food", id=true},
			{type="food", subtype="food", id=true, },
			{type="food", subtype="food", id=true, },
			{type="food", subtype="food", id=true },
			{type="food", subtype="food", id=true},
			{type="food", subtype="food", id=true},
		},
	},
}

newEntity{
	define_as = "FOOD",
	name = "tavern",
	display = "*", color=colors.DARK_RED,
	store = {
		purse = 100000,
--		nb_fill = 20,
		restock_after = 100,
		empty_before_restock = false,
		filters = {
			{type="drink", id=true},
			{type="drink", id=true},
			{type="drink", id=true},
			{type="drink", id=true, },
			{type="drink", id=true, },
			{type="drink", id=true },
			{type="drink", id=true},
			{type="drink", id=true},
		},
	},
}
