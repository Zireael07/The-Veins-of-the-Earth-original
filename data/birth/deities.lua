--For players who don't want to follow a deity
newBirthDescriptor{
	type = "deity",
	name = 'None',
	desc = 'You do not follow a deity',
}



--Taken from Incursion by Julian Mensch
newBirthDescriptor {
  type = 'deity',
  name = 'Aiswin',
  desc = [[#GOLD#God of Secrets, Vengeance and Shadows#LAST#
  Domains: #LIGHT_BROWN#Fate, Knowledge, Night, Planning, Retribution, Trickery.#LAST#

  Favored weapon: short sword

  Alignment: Neutral
  Accepts clerics of any alignment]],
  descriptor_choices =
	{
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Hatred = "forbid",
	      Healing = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Nobility = "forbid",
	      Pain = "forbid",
	      Passion = "forbid",
	      Protection = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Asherath',
  desc = [[#GOLD#God of War, Scholarship, Time and History#LAST#
  Domains: #LIGHT_BROWN#Knowledge, Planning, Strength, Time, Trickery, War.#LAST#

  Favored weapon: long sword

  Alignment: Neutral
  Accepts clerics of any alignment]],
  descriptor_choices =
	{
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Hatred = "forbid",
	      Healing = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Pain = "forbid",
	      Passion = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Travel = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Ekliazeh',
  desc = [[#GOLD#God of Stone and Strength#LAST#
  Domains: #LIGHT_BROWN#Craft, Community, Earth, Law, Strength, Protection.#LAST#

  Favored weapon: war hammer

  Alignment: Lawful Neutral
  Accepts clerics of any non-Chaotic alignment]],
  descriptor_choices =
	{
	alignment = 
		{ 
		  ['Chaotic Good'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Hatred = "forbid",
	      Healing = "forbid",
	      Knowledge = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Pain = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Trickery = "forbid",
	      Travel = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

--Note to self: he's LE not LG as flavor description would suggest!!!
newBirthDescriptor {
  type = 'deity',
  name = 'Erich',
  desc = [[#GOLD#God of Chivalry, Honor and Social Hierarchy#LAST#
  Domains: #LIGHT_BROWN#Domination, Guardian, Law, Nobility, Protection, War.#LAST#

  Favored weapon: lance

  Alignment: ?
  Accepts clerics of any Lawful alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Chaotic Good'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",		
	      ['Neutral Good'] = "forbid",
	      ['Neutral Evil'] = "forbid",
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Hatred = "forbid",
	      Healing = "forbid",
	      Knowledge = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Pain = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Strength = "forbid",
	      Spider = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Trickery = "forbid",
	      Travel = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Essiah',
  desc = [[#GOLD#Goddess of Life, Journeys, Joy and Erotic Love#LAST#
  Domains: #LIGHT_BROWN#Beauty, Good, Liberation, Luck, Passion, Travel.#LAST#

  Favored weapon: scourge

  Alignment: Chaotic Good
  Accepts clerics of any Good alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fire = "forbid",
	      Guardian = "forbid",
	      Hatred = "forbid",
	      Healing = "forbid",
	      Knowledge = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Pain = "forbid",
	      Planning = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Hesani',
  desc = [[#GOLD#God of Light, Balance and Cycles#LAST#
  Domains: #LIGHT_BROWN#Fate, Healing, Magic, Succor, Sun, Weather.#LAST#

  Favored weapon: N/A

  Alignment: Neutral Good
  Accepts clerics of any Good alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Hatred = "forbid",
	      Knowledge = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Pain = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Water = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Immotian',
  desc = [[#GOLD#God of Purity and Community Cleanliness#LAST#
  Domains: #LIGHT_BROWN#Community, Fire, Knowledge, Law, Protection, Succor.#LAST#

  Favored weapon: heavy mace

  Alignment: Lawful Neutral
  Accepts clerics of any Lawful alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Chaotic Good'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral Good'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Hatred = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Pain = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Sun = "forbid",
	      Strength = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Khasrach',
  desc = [[#GOLD#Goddess of the Blood#LAST#
  Domains: #LIGHT_BROWN#Destruction, Hatred, Mysticism, Strength, Pain, War.#LAST#

  Favored weapon: long spear

  Alignment: Chaotic Neutral
  Accepts clerics of any alignment]],
  descriptor_choices =
	{
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Moon = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Kysul',
  desc = [[#GOLD#The Watcher Beneath the Waves#LAST#
  Domains: #LIGHT_BROWN#Fate, Good, Mysticism, Planning, Slime, Water.#LAST#

  Favored weapon: trident

  Alignment: Lawful Good
  Accepts clerics of any non-Evil alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fire = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Moon = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Nobility = "forbid",
	      Passion = "forbid",
	      Pain = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Maeve',
  desc = [[#GOLD#Queen of the Faeries#LAST#
  Domains: #LIGHT_BROWN#Beauty, Chaos, Domination, Magic, Moon, Nobility.#LAST#

  Favored weapon: short bow

  Alignment: Chaotic Evil
  Accepts clerics of any non-Good Chaotic alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Good'] = "forbid",
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Good'] = "forbid",
	      ['Neutral Good'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Healing = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Passion = "forbid",
	      Pain = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Mara',
  desc = [[#GOLD#Goddess of Death, Stillness and Romantic Love#LAST#
  Domains: #LIGHT_BROWN#Beauty, Death, Good, Healing, Night, Succor.#LAST#

  Favored weapon: scythe

  Alignment: Lawful Good
  Accepts clerics of any non-Evil alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Destruction = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Luck = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Passion = "forbid",
	      Pain = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

--Removed an 'e' because otherwise it sounds like a feminine name
newBirthDescriptor {
  type = 'deity',
  name = 'Sabin',
  desc = [[#GOLD#God of Storms, Athletics, Prophecy and Transformations#LAST#
  Domains: #LIGHT_BROWN#Air, Chaos, Destruction, Luck, Time, Weather.#LAST#

  Favored weapon: javelin

  Alignment: Chaotic Neutral
  Accepts clerics of any alignment]],
  descriptor_choices =
	{
	    domains =
	    {
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Liberation = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Passion = "forbid",
	      Pain = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Retribution = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Water = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Semirath',
  desc = [[#GOLD#God of Justice, Laughter and Freedom#LAST#
  Domains: #LIGHT_BROWN#Chaos, Good, Liberation, Luck, Retribution, Trickery.#LAST#

  Favored weapon: chakram

  Alignment: Chaotic Good
  Accepts clerics of any Good alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Guardian = "forbid",
	      Knowledge = "forbid",
	      Law = "forbid",
	      Magic = "forbid",
	      Mysticism = "forbid",
	      Moon = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Passion = "forbid",
	      Pain = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

--An excuse to get domains otherwise unavailable
newBirthDescriptor {
  type = 'deity',
  name = 'Multitude',
  desc = [[#GOLD#Gods of Darkness, Blood, Cruelty, Power, Atrocity, Murder, etc.#LAST#
  Domains: #LIGHT_BROWN#Blood, Chaos, Destruction, Death, Evil, Pain, Spider, Strength, Air, Earth, Fire.#LAST#

  Favored weapon: N/A
  Alignment: Chaotic Evil
  Accept clerics of any evil alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Good'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Good'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Good'] = "forbid",		
		},
	    domains =
	    {
	      Animal = "forbid",
	      Beauty = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Fate = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Knowledge = "forbid",
	      Law = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Slime = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Xavias',
  desc = [[#GOLD#God of Science and the Mysteries#LAST#
  Domains: #LIGHT_BROWN#Craft, Fate, Knowledge, Magic, Mysticism, Planning.#LAST#

  Favored weapon: crossbows
  Alignment: Neutral Good
  Accept clerics of any good alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Evil'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Evil'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Beauty = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Death = "forbid",
	      Destruction = "forbid",
	      Earth = "forbid",
	      Evil = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Moon = "forbid",
	      Nature = "forbid",
	      Night = "forbid",
	      Passion = "forbid",
	      Pain = "forbid",
	      Protection = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      Trickery = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Xel',
  desc = [[#GOLD#God of the Harvest#LAST#
  Domains: #LIGHT_BROWN#Community, Death, Evil, Pain, Nature, Trickery.#LAST#

  Favored weapon: sickle
  Alignment: Lawful Evil
  Accept clerics of any non-Good alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Good'] = "forbid",
	      ['Chaotic Good'] = "forbid",
	      ['Neutral Good'] = "forbid",		
		},
	    domains =
	    {
	      Air = "forbid",
	      Animal = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Craft = "forbid",
	      Destruction = "forbid",
	      Domination = "forbid",
	      Earth = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Night = "forbid",
	      Passion = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Strength = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}

newBirthDescriptor {
  type = 'deity',
  name = 'Zurvash',
  desc = [[#GOLD#God of Animals and the Hunt#LAST#
  Domains: #LIGHT_BROWN#Animal, Night, Domination, Passion, Pain, Strength.#LAST#

  Favored weapon: N/A
  Alignment: Chaotic Evil
  Accept clerics of Chaotic Evil or Neutral Evil alignment]],
  descriptor_choices =
	{
		alignment = 
		{ 
		  ['Lawful Neutral'] = "forbid",
		  ['Lawful Evil'] = "forbid",
	      ['Chaotic Neutral'] = "forbid",
	      ['Chaotic Good'] = "forbid",
	      ['Neutral'] = "forbid",
	      ['Neutral Good'] = "forbid",	
	      ['Lawful Good'] = "forbid",	
		},
	    domains =
	    {
	      Air = "forbid",
	      Blood = "forbid",
	      Chaos = "forbid",
	      Community = "forbid",
	      Craft = "forbid",
	      Destruction = "forbid",
	      Earth = "forbid",
	      Fate = "forbid",
	      Fire = "forbid",
	      Good = "forbid",
	      Guardian = "forbid",
	      Law = "forbid",
	      Magic = "forbid",
	      Moon = "forbid",
	      Mysticism = "forbid",
	      Nature = "forbid",
	      Planning = "forbid",
	      Protection = "forbid",
	      Slime = "forbid",
	      Spider = "forbid",
	      Succor = "forbid",
	      Sun = "forbid",
	      Time = "forbid",
	      Travel = "forbid",
	      War = "forbid",
	      Water = "forbid",
	      Weather = "forbid",
	    }
	},
}