--Veins of the Earth
--Zireael

newEntity{
	define_as = "BASE_CONTAINER",
	type = "container", subtype = "container",
	image = "tiles/newtiles/bag.png",
	display = "Δ", color=colors.SLATE,
	unided_name = "a bag",
	name = "bag",
	encumber = 2,
	identified = false,
	desc = [[A container.]],
	iscontainer = true,
}

newEntity{
	base = "BASE_CONTAINER",
	name = "bag of holding",
	unided_name = "a bag",
	level_range = {1, nil},
	rarity = 2,
--	cost = 2500,
	cost = resolvers.value{platinum=2500},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "ammo belt",
	unided_name = "a bag",
	level_range = {1, nil},
	rarity = 2,
--	cost = 1500,
	cost = resolvers.value{platinum=1500},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "gem pouch",
	unided_name = "a pouch",
	level_range = {1, nil},
	rarity = 2,
--	cost = 1500,
	cost = resolvers.value{platinum=1500},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "potion case",
	unided_name = "a bag",
	level_range = {1, nil},
	rarity = 2,
--	cost = 1500,
	cost = resolvers.value{platinum=1500},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "scroll case",
	unided_name = "a bag",
	level_range = {1, nil},
	rarity = 2,
--	cost = 1500,
	cost = resolvers.value{platinum=1500},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

--EVIL!!
--[[newEntity{
	base = "BASE_CONTAINER",
	name = "bag of devouring",
	unided_name = "bag",
	cost = 1000,
	use_simple = { name = "put in", use = function(self, who)
		--adapted from putIn - this omits the part where you actually put the object in!
		local inven = who:getInven(who.INVEN_INVEN)
		local d d = who:showInventory("Put in", inven, nil, function(o, item)
			if not o.iscontainer then
				if not self:isIdentified() then self:identify(true) end
				--remove the item
				who:removeObject(inven, item, true)
				who:sortInven(inven)
				who:useEnergy()
				who.changed = true
				return true
			else
				game.logSeen(who, "You can't put a container in another container.")
				return true
				--you can switch these around to dump them out of the "insert objects in pot" screen.
			end
		end)
		return {used=true}
	end},
}]]

--Incursion's backpacks
newEntity{
	base = "BASE_CONTAINER",
	name = "small backpack",
	unided_name = "a backpack",
	display = "Δ", color=colors.LIGHT_BROWN,
	level_range = {1, nil},
--	rarity = 2,
--	cost = 4,
	cost = resolvers.value{silver=7},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "medium backpack",
	unided_name = "a backpack",
	display = "Δ", color=colors.LIGHT_BROWN,
	level_range = {1, nil},
--	rarity = 2,
--	cost = 2,
	cost = resolvers.value{silver=5},
	--Based on Baldur's Gate bag of holding
	body = { INVEN = 20 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "gnomish backpack",
	unided_name = "a backpack",
	display = "Δ", color=colors.YELLOW,
	level_range = {1, nil},
--	rarity = 2,
--	cost = 12,
	cost = resolvers.value{silver=30},
	--Increased by 1/3
	body = { INVEN = 30 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}

newEntity{
	base = "BASE_CONTAINER",
	name = "force backpack",
	unided_name = "a backpack",
	display = "Δ", color=colors.BLUE,
	level_range = {1, nil},
--	rarity = 2,
--	cost = 5000,
	cost = resolvers.value{platinum=5000},
	--Twice as much as a normal pack
	body = { INVEN = 40 },
	use_simple = { name = "put in", use = function(self, who)
		who:putIn(self)
		return {used=true}
	end},
}