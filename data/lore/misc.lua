--This is where the text generator lives
monsters = {"kobolds", "drow", "goblins"}
possibility = {"can", "may", "might"}

local monster = rng.table(monsters)

kobold_abilities = { "set traps", "hide in shadows", "pepper you with projectiles"}
drow_abilities = { "envelop you in darkness", "hide in shadows", "use deadly toxins", "set ambushes"}
goblin_abilities = { "club you to death", "flee in fear"}

local function ability(monster)
	if not monster then return end

	if monster == "kobolds" then return rng.table(kobold_abilities) end
	if monster == "drow" then return rng.table(drow_abilities) end
	if monster == "goblins" then return rng.table(goblin_abilities) end
end



newLore{
	id = "misc-1",
	category = "misc",
	name = "Beware",
	lore = "Beware the "..monster.."! They "..rng.table(possibility).." "..ability(monster).."."
}

races = {"a drow", "a duergar", "a dwarf", "an elf"}

local race = rng.table(races)

drow_names = {"Vierna", "Zaknafein", "Drizzt", "Nalfein"}
dwarf_names = {"Thorik", "Roryn", "Belmara"}
elf_names = {"Talindra", "Alea", "Aravilar", "Rhistel", "Iliphar"}

local function name(race)
	if not race then return end

	if race == "a drow" then return rng.table(drow_names) end
	if race == "a duergar" then return rng.table(dwarf_names) end
	if race == "a dwarf" then return rng.table(dwarf_names) end
	if race == "an elf" then return rng.table(elf_names) end
end

drow_houses = {"Aleanrahel", "Auvryndar", "Despana", "Helviiryn", "Hune", "Illistyn", "Jaelre"}
dwarf_houses = {"Bladehammer", "Crownshield", "Skulldark", "Bladebite", "Stoneshield", "Stonehammer", "Battlehammer", "Battleshield", "Forgebrother", "Ironbrother", "Axebrother" }
elf_houses = {"Moonflower", "Eveningstar", "Starfall", "Diamondwhisper", "Nightdew", "Nightwhisper", "Blossomdew", "Goldbrook", "Silverbrook", "Silverwhisper"}

local function house(race)
	if not race then return end

	if race == "a drow" then return rng.table(drow_houses) end
	if race == "a duergar" then return rng.table(dwarf_houses) end
	if race == "a dwarf" then return rng.table(dwarf_houses) end
	if race == "an elf" then return rng.table(elf_houses) end
end

drow_gods = {"Khasrach", "the Multitude", "Xel", "Zurvash", "Maeve"}
dwarf_gods = {"Ekliazeh", "Immotian"}
elf_gods = {"Maeve"}

local function god(race)
	if not race then return end

	if race == "a drow" then return rng.table(drow_gods) end
	if race == "a duergar" then return rng.table(dwarf_gods) end
	if race == "a dwarf" then return rng.table(dwarf_gods) end
	if race == "an elf" then return rng.table(elf_gods) end
end


venerate = {"venerate", "pray to", "offer my sacrifices to", "offer my prayers to", "pay homage", "bow to"}

newLore{
	id = "misc-2",
	category = "misc",
	name = "Story",
	lore = "I am "..race.." named "..name(race).." from House "..house(race)..". I "..rng.table(venerate).." "..god(race).."."
}

--Purely random stuff
intro = {"I am", "My name is", "My name was"}
name = {"Vierna", "Zaknafein", "Drizzt", "Alak", "Nalfein", "Thorik", "Roryn", "Belmara"}

newLore{
	id = "misc-3",
	category = "misc",
	name = "...'s notes",
	lore = rng.table(intro).." "..rng.table(name)
}



name = {"Vierna", "Zaknafein", "Drizzt", "Alak", "Nalfein", "Thorik", "Roryn", "Belmara", "Gothog", "Harl", "Talindra", "Alea", "Aravilar", "Rhistel", "Iliphar"}

newLore{
	id = "misc-4",
	category = "misc",
	name = "... was here",
	lore = rng.table(name).." was here..",
}


--Informative background stuff
newLore{
	id = "misc-5",
	category = "misc",
	name = "Coins",
	lore = [[Many drow, elven, dwarven and duergar Houses mint their own coins. However, humans and other races generally use unified coinage.]],
}

newLore{
	id = "misc-6",
	category = "misc",
	name = "A Note on Names",
	lore = [[Many older names end in -zarr, for example, Symylazarr, Ansrivarr or Ignizarr. Such names are most common among the most-longlived races, that is, elves and drow. Even though, some half-elves bearing such names were seen. ]],
}

--Test stuff
newLore{
	id = "misc-7",
	category = "misc",
	name = "I was here",
	lore = [[I was here]],
}
