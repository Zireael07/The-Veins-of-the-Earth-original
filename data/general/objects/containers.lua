--Veins of the Earth
--Zireael

newEntity{
	define_as = "BASE_CONTAINER",
	type = "container", subtype = "container",
	level_range = {1, nil},
	image = "tiles/newtiles/bag.png",
	display = "Δ", color=colors.SLATE,
	rarity = 2,
	encumber = 15,
	identified = false,
	desc = [[A container.]],
	iscontainer = true,
}

newEntity{
	base = "BASE_CONTAINER",
	name = "bag of holding",
	unided_name = "bag",
	cost = 2500,
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
	unided_name = "bag",
	cost = 1500,
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
	unided_name = "bag",
	cost = 1500,
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
	unided_name = "bag",
	cost = 1500,
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
	unided_name = "bag",
	cost = 1500,
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