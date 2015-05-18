CHANGELOG

* bug fix - made fire outsiders straight out immune to fire
* bug fix - wyvern now has poison
* bug fix - tendriculos and choker have proper descriptions
* bug fix - rejecting filters due to exceeding cost led to no filters being applied at all when creating loot
* bug fix - take into account item level ranges when creating loot
* bug fix - adjust item levels and rarities since some were out of whack with the item's real power
* bug fix - NPCs and monsters now drop level-appropriate gear
* bug fix - cost filters now operate on the baseline price in coppers (i.e. what e.cost is expressed in)

* new monsters: succubus, incubus; dragons (complete with age categories and breath weapons)
* new NPCs: drow house guard, drow house captain, drow priest
* new tiles: blood ape, formian, giant ant soldier, giant ant queen, will-o-wisp, grick, spectral panther; drow female noble, drow commoner, drow house guard; floor, worldmap floor, worldmap wall; glaive
* gave breath weapons to hell hound, dragon turtle
* gave immunities to delver, gibbering mouther, mimic, nagas; ghaele, lillend; tojanida; assasin vine, shambling mound, tendriculos; fire elementals, magmin; night hag
* marut and fire elementals now deal additional damage on hit
* implement Craft skill
* item creation feats now pick from all possible egos

0.27.0 - beta 8 - 01/05/2014

* bug fix - no more artifacts dropping on dlvl 1
* bug fix - init sound on loading game from a save
* bug fix - give humanoid NPCs weapon proficiencies
* bug fix - no more errors on log in healer chat
* bug fix - damage logged now includes all increases
* bug fix - effects outside sight range are now forced to be silent
* bug fix - shoot no longer throws a Lua error if you have a shooter but not ammo
* bug fix - can now drag items to hotbar without errors
* bug fix - hotbar will not burp errors when there are no charges at all
* bug fix - increase rarities of large+ vermin
* bug fix - amulet ASCII symbol not showing up
* bug fix - difficulty selection not being saved/displayed properly
* bug fix - Oathbow not counting as ranged weapon
* bug fix - personal reaction not used at all, leading to attacked neutrals not turning hostile
* bug fix - don't show talent cooldown if it's 0
* bug fix - no more option to wear things with INVEN slot
* bug fix - adjust food rarities and add a message on eating
* bug fix - spending a night with a courtesan counts now as resting
* bug fix - buttons overlapping in Help screen
* bug fix - encumbrance no longer considered detrimental
* bug fix - update the tutorial to mention wounds
* bug fix - add sex to character screen
* bug fix - wrap up Power Attack rework and update description
* bug fix - don't display pseudo ID tags on paperdoll
* bug fix - make the specific class resolver actually work
* bug fix - fix the HP allotted by both random and specific class resolver
* bug fix - don't show decimals in special damage messages
* bug fix - assorted spelling fixes
* bug fix - blindness/deafness now allows a save and uses the same TalentDialog code as other spells
* bug fix - cheat resurrect now restores mana, if any, and wounds

* added Symbola font and used it on map
* new zones: temple, drow temple
* new magic properties: weapons - bane corresponding to all monster types, aligned, elemental, elemental burst; wondrous items - of slow digestion
* uncommented fortification code, spiked armor and shields egos
* new item tiles: belt, girdle, club, helmet, mushroom, long composite bow, short composite bow, hand crossbow
* new NPC tiles: drow noble male, phantom fungus
* changed ASCII symbol for bullets
* changed ASCII symbols for grick, azer, djinn, efreet, xorn
* changed ASCII colors for lillend, barghest, some vermin
* changed ASCII symbols and colors for drider, will o'wisp, quasit, thoqqua
* added distinctive colors to individual mephit and formian classes
* added paperdoll graphics for almost all weapons (except double sword)
* added tips on loading zone level
* implemented the Luck stat
* implemented Monkey Grip feat
* implemented proper DC calculations for spells
* random and default buttons in character creation screen
* increase spellcaster classes skill points allotment to 4
* ammo capacity is now randomized
* some bags now limit what can be put in them (so an ammo belt will accept only ammo)
* the HUD now informs you that you are on the worldmap or gives you the zone name itself for other zones
* many dialog lists are now colored to help distinguish between good/bad/neutral options
* character sheet now takes all attack modifiers into account when displaying your attack
* the character screen now has a tab listing all effects you have
* the player character can now have children of his/her own
* if you die but have a child(ren), you can keep playing as one of the kids
* improved the loot generator
* skills are no longer hardcoded
* AI can now pick up items from the floor and swap weapons
* players can keep a ranged weapon in the shoulder slot and swap weapons with a keypress
* you can now wield, take off or use items with a keypress giving you a list of all applicable items
* improved combat messages
* neutral NPCs can now be told to move aside/swap places with you
* neutral NPCs who turned hostile due to attacks will slowly decay towards neutral again if not attacked
* add specific class levels to sages, courtesans, guards
* add more skill kits/update their descriptions
* giant ant queen CR bumped up and brought closer to PF version
* the player will now stop running automatically in some cases (chats, nasty stuff happening)
* worldmap now uses its own sight range
* code attacks of opportunity
* added outline to ASCII entities

0.26.0 - beta 7 - 21/03/2015

* bug fix - FBO lua error on save load
* bug fix - Lua error & nil exp for creatures with CR in-between table values
* bug fix - character creation screen now does check if a character save already exists
* bug fix - flavored amulets spelling
* bug fix - incorporate the engine fixes for ActorSeenDisplay, making the switch work
* bug fix - shooting not using the weapon's designated crit damage
* bug fix - flyers showing for critters outside lite range
* bug fix - assassin name typo
* bug fix - charges being displayed off or not displayed at all for multiple lines of spells in a spellbook
* bug fix - training stat tracker values are now properly zeroed when increasing stat
* bug fix - no more Lua errors on right clicking talents
* bug fix - no longer having to drop the fireball on yourself
* bug fix - visited zones not being saved leading to Lua errors when changing level
* bug fix - spell failure not canceling spells properly
* bug fix - cheat resurrect no longer throws errors if you happened to die while encumbered
* bug fix - Summon Monster I works as intended
* bug fix - used up arrows and/or thrown weapons are now properly removed
* bug fix - summons' tooltips no longer throws an error [Castler]
* bug fix - mage armor spell no longer warns you when you use it on yourself [Castler]
* bug fix - map no longer going under UI on left-hand side [kudos to Castler for pointing out the fix]
* bug fix - level up achievements now achievable

* update to T-Engine 1.3.0
* make use of engine updates, including room generator & ego functions
* enable sound capabilities
* new spells - divine favor, entropic shield, doom, shield of faith, deathwatch, summon monster II,
* new feats - Master Craftsman
* new NPC: human/dwarf/drow healer, drow tavernkeeper
* sorcerers and shamans now use a spell points system instead of Vancian spellcasting
* implement room descriptions
* hirelings now use party member code from ToME
* implement vitality/wounds system
* implement metamagic feats - Extend, Empower and Maximize Spell
* implement Precise Shot and Far Shot feats
* implement Jump, Intimidate, Heal skills
* implement spell points & psionic power
* consumables now stack
* humanoid NPCs now carry food & light sources
* some animals are now neutral and vermin now constitute their own faction
* unwearable items are highlighted in red; unusable ones in blue
* drow noble house is now named after the House that inhabits it
* can now throw thrown weapons
* low Int characters get separate answers now
* log message is shown when player gains EXP
* UI improvements and bugfixes for feat select screen [Castler]
* stair tooltips show where they lead to if you've been there at least once
* AI no longer walks into chasms/lava/water
* game options screen displayed before the first level is generated
* implement talent configuration from ToME
* item creation debug screen now allows hand-picking egos to be generated
* fixes and improvements to magic item generation

0.25.0 - beta 6.5 - 22/12/2014

* bug fix - fix the isThreatened() function
* bug fix - add "or 0" to item price appraisal
* bug fix - drow and elves now receive racial proficiencies properly
* bug fix - restore targeting display
* bug fix - stores for wandering shopkeepers now work as intended (no more insta-restocking)
* bug fix - no longer capitalizing target names in log
* bug fix - restore feat descriptions in feat select dialog

* new tiles: drow noble female, drow noble male
* new spells: expeditious retreat, dimension door, magic mapping, detect monsters, detect objects, know alignment
* new terrain: shallow water
* new zone: drow city, drow noble compound, tavern, brothel
* new NPC: drow sage; drow noble female/male, drow commoner, drow guard, drow courtesan
* implement class titles
* implement stats training
* implement trap sense for rogues
* display seen NPCs in a list on-screen
* implement racial dolls
* add towns to worldmap
* saves are now timestamped and time played is tracked
* good player characters of traditionally evil races have a special intro text
* randomize notes drop
* implement a level spots tracker debug functionality
* testing encounter-based generator

0.24.0 - beta 6.4 - 09/11/2014

* bug fix - ID counters don't tick down anymore when resting
* bug fix - hunger is properly reduced when resting
* bug fix - typo in zone definitions re: marble wall
* bug fix - starting mundane items being unidentified
* bug fix - give poison vials their proper unided name
* bug fix - no longer logging off-screen combat or damage
* bug fix - nix all references to default ToME from options
* bug fix - item level feelings now working as intended
* bug fix - combat log now hints at damage reduction if present
* bug fix - anger on hit properly
* bug fix - templated critters can no longer exceed a zone's max CR cap
* bug fix - some templates were missing HD bonuses
* bug fix - fix otyugh, satyr, aranea, chaos beast, janni, arrowhawk, achaierai, barghest, vargouille; orc, kobold, goblin, human, drow, hobgoblin; shocker lizard, basilisk, bulette, giant owl, purple worm XP rewards
* bug fix - give the inevitables their feats
* bug fix - change spider eater, dragonne, goblin tile
* bug fix - UI issues upon loading premade chars (except minimap dot wrong color)
* bug fix - bring save formulas in line with expected d20 values
* bug fix - Bard has Will as a good save now, as intended

* update to T-Engine 1.2.4
* new terrain - torch, faerie lantern, pillar, rock pillar
* new tiles - doppelganger, tiger, cobra, constrictor, xorn, troll
* new spells - detect evil/good/chaos/law
* new templates - shaman, curate, half-fey; outlaw, brigand; veteran, elite, master, paragon, legendary; feral, dire; flame, earthen, gaseous, aqueous; three-eyed, pseudonatural from Incursion
* new monsters - jackal, mastiff from Incursion; hyena, short-faced hyena from PF
* new feat - Stunning Fist
* angels, fey and unicorn no longer hostile to good or neutral characters
* implemented bonus spells for high stats
* implemented Appraise & Listen skills
* implemented monk class features
* increased starting food amount
* increased XP rewards for low CR monsters in line with Pathfinder rewards
* death messages
* use ToME log functions
* add path string, emotes support
* adapt ToME panic code as an AI
* use an UIset based on Classic ToME
* appraise, craft and decipher script skills added
* add more flavors from Incursion (cloaks, bracers, boots, rings, amulets)
* add object tracker to debug menu
* add code for ID'ing item schools, Incursion-style
* add lesser vaults code
* add entry chamber and hells entry chamber from Incursion
* implement fasting for rangers, Incursion-style



0.23.0 - beta 6.2 - 05/10/2014

* bug fix - spell image list no longer overlaps text spell list [Castler]
* bug fix - no longer able to bypass confirmation of Quit Permanently dialog [Castler]
* bug fix - fix some misspellings [Castler]
* bug fix - Lua error on cancelling mount skill [Castler]
* bug fix - Xavias godpulse causing Lua error [Castler]
* bug fix - fix corpse and bag weights
* bug fix - restore stat descriptions in char creation
* bug fix - DR check not working properly
* bug fix - no longer able to use ranged weapons in melee
* bug fix - pseudo-ID and auto-ID now work for worn/equipped items too [Castler]
* bug fix - saving throws logged properly [Castler]
* bug fix - skills logged properly on a 1 or a 20 [Castler]
* bug fix - proper skill points calculation [Castler]
* bug fix - definite fix for "fall-lock" on ice [Castler]
* bug fix - give subtypes to neutral NPCs
* bug fix - no more 'hit for 0 darkness damage' messages spam
* bug fix - no more being 2-hitted by some monsters with higher speeds
* bug fix - lock out of inventory after shopping bug
* bug fix - attacking or using a feat now breaks stealth
* bug fix - fixed some ASCII letters/colors

* difficulty level selection (easy mode forbids criticals by monsters on player)
* gameplay variant options (defensive roll)
* new magic properties: light/moderate/heavy fortification
* increased CR for some monsters: satyr is now CR 5 (was 3); razor boar is now CR 8 (was 5)
* you can now attack while dying
* weapons grant parry bonuses, Incursion-style
* object flavors, ToME 2/Angband style
* switch to silver-based economy
* color-code skills in character sheet Incursion-style
* color-code max skill ranks in skill dialog, UI improvements
* feat select dialog is now categorized
* backport ActorTalentDialog from ToME 1.2.4 [Castler]



0.22.0 - beta 6 - 14/09/2014

* bug fix - Lua errors in load premade
* bug fix - no more xorns showing up without a name
* bug fix - digging works properly now without errors
* bug fix - lance is now named properly
* bug fix - a rare possibility that a base weapon (without combat values defined) would spawn
* bug fix - outdated tiles after loading a premade/saved character
* bug fix - shopkeepers spewing their dialogue every time they bumped into you
* bug fix - tutorial boss not spawning
* bug fix - Lua error due to oversight in combat poison code
* bug fix - increasing stats throwing a Lua error [desophos]
* bug fix - ensured reachability and spawning of dungeon entrances in worldmap
* bug fix - getting messages about unseen enemies using spells/skills
* bug fix - proper tiles for the cavern zone
* bug fix - domain selection working as intended again (last seen in beta 5)
* bug fix - player tiles properly displaying dual-wielded weapons
* bug fix - nixed a debug message for ranger favored enemy
* bug fix - enabled drag and drop in inventory at last
* bug fix - heal log info shown only if you can see source actor
* bug fix - food items now have proper subtype defined instead of nil
* bug fix - no more searching for pseudo traps [kudos to StarKeep]

* new spell: transmute rock to mud
* new zones: labirynth, xorn lair, town, aberrant lair, arena
* new feats: Roll with It, Ignore Wound, Resillient [all from Incursion]
* new tiles: sand, ice; blink dog, barghest, hell hound, yeth hound
* new curse: of weakness
* hirelings
* deity system
* day/night cycle with exotic colors
* color code hit and miss messages
* add monster type to its tooltip
* spellcasters now get spells at start (except Sorcerers and Shamans)
* made character creation screen tabbed
* implement Zizzo's code allowing for hand-picking egos
* many improvements to debug screens
* overhaul actor tooltips code
* renamed existing zones: Upperdark -> compound; Middledark -> tunnels
* change starting zone to tunnels

0.21.0 - beta 5.7 - 07/08/2014

* bug fix - all skills triggering the spell failure checks
* bug fix - specific items had a typo in their on_wear
* bug fix - look around key throwing a lua error
* bug fix - locked out of inventory sometimes
* bug fix - plate armor being worn causing an error in the moddable tiles resolver
* bug fix - poison code not checking for immunity

* random worldmap
* humanoids now use A* pathing
* add ranged AI code inspired by DataQueen
* new monsters: babau, dretch, quasit
* new items: throwing axe, throwing knives; mushrooms, rods; enabled tattoos; mithril coins, emeralds, sapphires;
* new egos: dwarven, elven; of the Winterland, of the Druid, of the Hin; of brightness
* reduced the CR cap for dungeon level 1 to player level +1 and to player level +2 for dlvl 2-5
* tiles/ASCII switch finally works!
* split off thrown weapons into a separate file
* add a hint when a cursed item is auto-destroyed
* prevent clicking on learned feats in feat selection screens
* character creation screen improvements - highlight Cleric/Ranger/Paladin as newbie friendly; darkened Luck as it's not implemented yet; color-code high & low stats; highlight bad choices (spellcasting classes who wouldn't be able to cast spells) in dark red

0.20.0 - beta 5.6 - 29/06/2014

* bug fix - naming box not accepting keypresses [kudos to Castler]
* bug fix - bonus feats button now available only to fighters
* bug fix - no more lua error due to a typo in one of the poison defs
* bug fix - play button being unclickable in some resolutions
* bug fix - charges not shown for some spells in spellbook [Castler]
* bug fix - using Diplomacy/Animal Empathy on invalid target no longer wastes a turn [Castler]
* bug fix - using Diplomacy on yourself no longer leads to amusing stuff [Castler]
* bug fix - bards not receiving spells
* bug fix - paladins and rangers missing the spellbook button
* bug fix - club not being listed as simple weapon; dual-wielding quarterstaves
* bug fix - two last entries not clickable in stat increase dialog
* bug fix - typo in water elemental description
* bug fix - fireball and light spells working as intended
* bug fix - no more spellbooks for NPCs; clarified raven familiar description
* bug fix - give specific magic items unided names
* bug fix - correct lantern tile
* bug fix - make prestige class levels show up in character sheet


* update to T-Engine 1.2.2
* new spell: mount, haste
* new spell icons: mage armor, ghoul touch, alter self
* make player tiles change depending on player equipment ("moddable" as in ToME 4)
* add stack number display
* add settings
* integrate parts of Marson's UI addon
* add full framebuffer shaders
* rearrange the UI a bit; add log fade
* add equipdoll to inventory screen
* add information pop-ups to char creation screen
* enable right clicking when manually selecting attributes [Castler]
* add tutorial level
* shuffle events stuff to GameState.lua
* shuffle item perks stuff to Player.lua
* remove the flasher (top message bar) since it wouldn't clear properly
* clicking spell name in spellbook now has the same effect as clicking spell icon [Castler]
* display fractional CR as fractions not decimals [Castler]
* add spell level tabs to spellbook
* add tooltips to store interface


0.19.0 - beta 5.5 - 08/06/2014

* bug fix - character screen on 1366x768 and similar resolutions
* bug fix - not being able to close the load premade screen
* bug fix - party info not being saved leading to weird bugs [DarkGod]
* bug fix - no lua errors on clicking spell names in spellbook
* bug fix - no more silent lua errors due to an oversight in encumbrance logic
* bug fix - check if item exists before trying to ID it (kudos to lucianogml for reporting)
* bug fix - naming box in character creation now picks female names correctly
* bug fix - perks not being cleared correctly
* bug fix - skill points going into negatives if half-points are present
* bug fix - add shield proficiency to the classes that were missing it
* bug fix - no longer able to progress past char creation screen without a name

* update to T-Engine 1.2.1
* auto-explore [DarkGod]
* spell rework [framework by DarkGod]
* rework hunger clock
* silenced the pseudo-ID Intuition checks
* changed the font and background of lore notes
* add tooltips to attributes and feat/spell perks in character creation
* add 'are you sure?' pop-ups to feat, skill and class dialogs
* add healthbars display
* make the death dialog a tombstone
* make tooltips more informative
* axed the duplicate naming box


0.18.0 - beta 5.4 - 26/05/2014
* bug fix - nil table in EntityTracker
* bug fix - no more errors caused by mobs trying to level up
* bug fix - lua error on trying to manually adjust stats lower than 8
* bug fix - no longer possible to manually adjust stats that were rolled
* bug fix - spellbook now accounts for levels gained every 3rd level
* bug fix - no lua errors should spells gain and spell slots gain ever mismatch
* bug fix - plant critters no longer as fast; shrieker stuck down in a spot
* bug fix - lua errors on pressing Space

* new tiles - altar, note, horse, griffon
* new spell - Ignizarr's fire
* in-game user chat now works!
* chat keys added to Help
* polymorphing & wild shape
* Ride skill and mounts
* lore framework added
* DR x/magic implemented; framework ready for other DR types
* coded locked doors
* auto-search for traps coded
* coded party support
* calendar changed to match Incursion's
* enabled creature templates, both from SRD and from Incursion
* Knowledge check necessary to be aware that the monster *HAS* a template
* show lore and show achievements screens
* added a test zone
* change zone capacity added to debug menu
* revised the README to be more readable; split off complete features listing


0.17.0 - beta 5.2 - 12/05/2014
* bug fix - no more point buy popping back up after game start
* bug fix - fix oversight in naming function for drow females
* bug fix - no more "clones" (unkillable monsters)
* bug fix - no more sneaky lua errors related to temporary values
* bug fix - lizardfolk now get a torch
* bug fix - wands and scrolls now work properly
* bug fix - stores now stock properly

* overhauled character creation screen and dungeon generation
* handle animal and diplomacy skills
* item creation and enhancement
* new specific magic items: Holy Avenger, Dwarven Thrower, Flame Tongue, Luckblade, Nine Lives Stealer, Oathbow, Sunblade, Sword of the Planes
* new magic properties: of resistance, of the Endless Wave, of Detection, of the Eagle, of the Soul, of the Mantis, of the Spur, of Stability, of Contortion, of Magical Aptitude, of Arachnida, of the Bat, of SR 21, of Frostbite, of Fireburn
* new spells: create food and water, fly, levitate
* minimap now has background and shows level exits
* reduced the CR cap for dungeon level 1 to player level +3
* immunities or resistances as perks
* debug menu - includes adding creatures, removing them, killing off clones, adding XP, gold, or items to player, identifying all items in inventory, Lua console for other stuff
* cut down on flasher (top message bar) use
* add prompt to intro message and expand the pop-up border




0.16.0 beta 5 - 18/04/2014
* bug fix - summon monster dialog no longer appears if NPCs are trying to use it
* bug fix - fix trying to perform calculations on nil stat_points
* bug fix - wands and scrolls being unusable (but they don't work 100% properly yet)
* bug fix - negative damage when DR x/- is applied
* bug fix - load penalty is no longer incorrectly applied to skills such as Diplomacy or Intuition
* bug fix - finished implementing ghoul touch spell

* chests (and mimics)!
* you can now buy and sell from shopkeepers!
* poisons! watch out for spiders and centipedes
* implemented sneak attack and added flanking code in
* monsters now flee if reduced to below 50% max hp
* spellbook screen now contains spell information in a separate column
* kill count screen implemented; item manager screen implemented but non-functional yet
* implemented Spellcraft
* drow and duergar got (some) spell-like abilities
* new tiles: chest, bolas, shuriken, iron door, warded door, darkwood door
* new races: lizardfolk, kobold, orc
* new class: shaman (a divine equivalent of a sorcerer)
* new prestige classes: archmage, loremaster, blackguard, arcane archer
* new spells: darkness, faerie fire, invisibility, light, charm person
* character sheet now colors increased/decreased stats
* can go back to rolling/buying stats screen from the load character screen
* failure/success messages are now color-coded in log
* log messages no longer tell you what exactly damaged you if you can't see the source actor
* particle effects added to bleeding out and faerie fire



0.15.0 beta 4.7 - 31/03/2014
* bug fix - reverted Luck influencing items
* bug fix - undead, elementals and others made immune to criticals

* new tiles: centipede, krenshar, displacer beast
* new feats: Armor Optimisation, Shield Focus; Improved Strength, Improved Dexterity, Improved Constitution, Improved Intelligence, Improved Wisdom, Improved Charisma, Improved Luck
* fighter bonus feat selection
* wizards can now select familiars
* improved starting equipment selection, now taking race into account
* magic items as starting perks
* magic items can now increase Luck, too
* types and subtypes now influence immunities
* a batch of new rooms to see


0.14.0 beta 4.6 - 24/03/2014
* bug fix - no more monsters spawning in walls

* point buy now working as intended and resettable
* stat increases every 4th level now working
* d20-style encounters
* implemented Luck, which makes rare items more common
* ability to load/import/recreate older characters
* pseudo-ID, auto-destroying known cursed items
* item feelings when entering a level
* humanoid NPCs can now have character classes
* deities for clerics
* coded in a lot of new terrain


0.13.0 beta 4.5 - 17/03/2014
* bug fix: no longer freezing on actor gen
* bug fix: ranged combat now works properly again
* bug fix: decrease hp properly if your Con is lowered
* bug fix: right click menu now works properly
* bug fix: no more "unknown actor" spawning
* bug fix: no more trying to log on critters drowning

* XP awards for seeing first 4 monsters of a kind
* stealth
* you can now receive Weapon Focus in a random weapon as a random perk
* you can now check how many monsters of a type you've killed or seen
* in-character monster info screen
* class feats are now color-coded in character sheet
* implemented ASCII/tiles switch
* more work on poisons (don't work yet)


0.12.2 - 12/12/2013
* bug fix: kill lua error with magic missile
* first pass at auto-ID

0.12.1 - 5/12/2013
* bug fix: bags no longer bug out and block inventory

0.12.0 beta 4.4 - 30/11/2013
* bug fix: not being able to use the mouse in some parts of the map
* bug fix: map being covered by the log/HUD
* bug fix: cross-class code now checks for the last leveled class
* bug fix: encumbrance penalties no longer stack ad infinitum for some weird reason
* bug fix: no more freezes due to running out of potion flavor names
* bug fix: no more lua error on stack tooltip
* bug fix: all innate spells now have a cooldown of 5

* player tile changes depending on his/her race and class (from 2nd turn onwards)
* new monsters: all monsters from SRD except demons, devils, dragons, lycanthropes, swarms & most animals which don't fit the dungeon theme
* new classes: monk & paladin
* you can now name your character yourself and/or reroll the random name multiple times
* loading tips added
* lowered ice DC as a temporary solution to the "fall-lock"
* water and stale foodstuffs are now edible
* more randomized magic items
* added feat description tooltips to character sheet
* added loading screen to module file
* added intro depending on player race

0.11.0 beta 4.3 - 12/11/2013
* bug fix: shadow armor lua error fixed [Seb]
* bug fix: apply increased Str bonus to two-handed weapons
* bug fix: chasm displays its proper name in tooltip
* bug fix: hotbar no longer covers the log on some screens
* bug fix: random naming for potions and scrolls now works properly
* bug fix: you can no longer spend one more skill point per level than intended

* TILES - using David Gervais 32x32 tiles with some new tiles made by me
* new spells: identify; improved identify, mage armor [Seb]
* new items: cursed items (bracers of clumsiness, potion of poison, potion of inflict light wounds and others); ring of darkvision
* split feat dialog into 3 columns
* add proficiency requirement to shields
* adjusted magic item drops
* Balance DC 15 or Jump DC 30 to cross a chasm
* character sheet split into two tabs; skill breakdown as a table
* containers
* show message log screen finally works
* hunger counter & food rations now work
* multiclassing now requires 13 in core ability except for sorcerers and wizards, who require 16 in CHA or INT, respectively
* cross-class skills are now coded and working

0.10.0 beta 4 - 04/11/2013
* bug fix: eldritch blast lua error fixed
* bug fix: shield no longer counts as offhand weapon for TWF
* bug fix: druid skill points are now set to 2
* bug fix: dwarf fighters & drow clerics receive the proper amount of hp
* bug fix: apply skill bonuses properly in the checks
* bug fix: no more wielding two-handed weapons with one hand
* bug fix: all spells (including sorcerer and spell-like abilities) now display their proper icon
* bug fix: drowning and lava lua errors fixed

* new class: sorcerer
* chat code added
* highscores working & enabled (based on the number of total kills)
* made combat & skill logs clearer
* you can now talk to some NPCs
* new terrain and rooms: ice floor, shafts, swamp
* helpful information added to character creation
* character screen now displays ALL the classes you have
* expanded random feats list
* clerics can now turn undead
* point buy added for attributes generation
* archery feats coded in
* random perks part 2: you can now get a random spell as a perk, too
* wizards can now choose school specialization [Seb]
* right-clicking on map now brings up a context menu
* light & heavy load now works per SRD; implemented Loadbearer feat
* activable Power Attack and Combat Expertise feats

0.9.0 beta 3.75 - 28/10/2013
* bug fix: all dialogs now obey screen size
* bug fix: fire beetle AC is no longer through the roof
* bug fix: spells are now properly restricted [Seb]
* bug fix: no more freezes when trying to exit to Menu in some cases
* bug fix: no more lua errors with some spells
* bug fix: bard skill points
* bug fix: assassin and shadowdancer not giving level-up bonuses

* new monsters: aboleth, athach, choker, chuul, cloaker, drider, ettercap, otyugh; ankheg, aranea, arrowhawk, assassin vine, barghest
* survival kit, healing kit, lockpicking kit added - grant a +2 bonus to skill
* all characters now receive a single feat when rolling stats as a perk
* level-up screen now displays class points, feat points, skill points
* humanoids can now try to shoot the player
* increased inventory size slightly (from a to z instead of w)
* monsters bleed out quicker than the player
* implemented chasm & ice effects
* tooltips now describe whether a weapon is simple/martial, light/reach
* re-added a crash course to d20
* MODDING.md now contains information useful for prospective contributors
* reach weapons & talent added
* scrollbar added to feat select screen [Seb]
* spellbook now displays higher-level spells properly [Seb]
* tooltips now describe magic properties (except elemental resistances) for identified items

0.8.0 beta 3.5 - 21/10/2013
* bug fix: gain spellcasting properly if you multiclassed from a non-casting class
* bug fix: apply (uncapped) feat bonuses on top of skill ranks
* bug fix: Intuition now applies to a single item
* bug fix: ensure 1 damage unless Damage Reduction is applied
* new spells: inflict X wounds, fireball
* improved HUD - now with bars, changing color depending on the amount of HP left
* XP for descending & disarming traps added
* two weapon fighting penalties, feats & background
* death and dying closer to d20: death at -10 and detrimental effects both at 0 and in the -1 to -9 range
* level feelings (based on monster CR for now)
* changed wait a turn keybinding and added it to controls screen
* random naming for potions & scrolls


0.7.1 beta 3.25 - 12/10/2013
* bug fix for player leaving lit tiles behind himself (kudos to Castler)
* bug fix for new keybinds (spellbook and help) not being recognized at game start [Sebsebeleb]
* bug fixes
* new items: amulet of health, periapt of wisdom, gauntlets of ogre strength, gloves of dexterity, cloak of charisma; wands & scrolls (unusable for now)
* item tooltips now inform you of (some) magic properties if the item is identified
* expanded Quit dialog to allow discarding characters
* traps are coded in but do not spawn yet

0.7.0 beta 3.1 - 2/10/2013
* typo fixes
* bug fix: unintended bonuses at 1st character level
* backgrounds - for those who want quicker character creation
* new skill-enhancing feats: Artist, Investigator, Magical Aptitude, Magical Talent, Negotiator, Nimble Fingers, Persuasive, Self-sufficient, Silver Palm, Stealthy, Thug
* new feat (only as part of a background): Born Hero
* new spells: Bear's Endurance, Bull's Strength, Cat's Grace, Eagle's Splendor, Fox's Cunning, Owl's Wisdom,
* UI improvements: increased tooltip font size, moved tooltips
* new UI skin: old gold and black semi-transparent without shadows
* Toughness feat works as intended
* casters gain a new spell level every 3rd level; rangers become eligible for this rule from lvl 5 onwards

0.6.0 beta 3 - 26/09/2013
* typo fixes
* bugfix for magic items not showing up
* new spells: bardic cure light wounds; heal x wounds (heals a percentage of total hp); cure moderate/serious/critical wounds
* new icons for hotbar
* resting takes 8 hours if complete, less if interrupted; monsters respawn upon rest
* Light Sleeper feat implemented
* skills screen sorted alphabetically
* weapon focus, improved critical, favored enemy implemented
* no more magic items at game start
* Exotic Weapon Proficiency needed to wield exotic weapons
* weapon proficiencies implemented
* double weapons working as intended


0.5.5 beta 2.9 - 22/09/2013
* new races: half-drow, gnome, halfling
* revised AC (cannot exceed +5 from rings)
* revised BAB (BAB requirements for feats work now)
* magic weapons
* color-coded stats and CR in tooltips, relative to your stats and level
* favored classes
* fix vermin symbols
* update README & license & controls screen

0.5.1 - 19/09/2013
* fixed the monster stats being 0
* monster symbols overhauled & added to legend screen
* controls screen shown automatically after char creation, now includes 'r' for rest

0.5.0 beta 2.8 - 16/09/2013
* tooltips for character sheet, containing the info that used to be in the Help screen
* Help screen now shows controls
* luminescent moss is luminescent again; typo fix; some tweaks to level generation
* new magic items: belts of Strength, boots of dodging
* random name generator, taking into account your class and race

0.4.0 beta 2.7 - 12/09/2013
* fix for money bug
* code cleanup; undead moved to templates
* increased the number of items and monsters spawned
* new item: cord armor
* expanded saves listing in character screen
* working ECL
* [standalone version only] brand-new start-up screen and menu

0.3.6 beta 2.6 - 10/09/2013
* new class: bard
* level-up screen now contains tips
* healing now prints out a message in the log
* character sheet shows feats only
* tooltips added to inventory screen

0.3.5 beta 2.5 - 3/09/2013
* new magic items: boots of elvenkind, cloak of elvenkind, bracers of armor
* new monsters: giant eagle, shocker lizard, monitor lizard; wolf, raven, rat; monstrous centipede, monstrous scorpion, giant ant, fire beetle, stag beetle
* improved food descriptions
* rogue & wizard & ranger start with ammo now; ranger starts with offhand weapon
* removed highscores since they don't work
* working auto-ID on pickup
* offhand attack and iterative attacks

0.3.1 beta 2.3 - 28/08/2013
* bugfixes
* money
* more room types
* code cleanup
* improved skill select screen
* expanded item tooltips
* magic item properties
* humanoid templates coded in

0.3.0 beta 2.25 - 22/08/2013
* bugfixes
* new monsters: drow, goblin, human
* adjusted monster spawn rate
* no XP for monsters with CR < character level - 4
* resting takes longer
* saving throws take the better of two stats (Dex-Int for Ref; Con-Str for Fort; Wis-Cha for Will)
* changed map generator back due to performance issues
* new prestige classes: assassin, shadowdancer
* barbarian speed bonus implemented
* terrain effects implemented
* added tips to stat generator screen
* implemented Swim skill
* armor spell failure chance implemented
* cannot cast spells if key stat is equal or lower than 9

0.2.6 - 17/08/2013
* bugfixes
* monsters drop equipment and corpses
* working skill select screen
* added skill enhancing feats

0.2.5 beta 2 - 15/08/2013
* skill tests printed to log
* bugfixes
* working level-up bonuses
* halved the amount of XP needed to advance

0.2.2 beta 1.9 - 13/08/2013
* bugfixes
* ranger, rogue and wizard now get ranged weapons as starting equipment
* FOV fixes
* new items: amulet of natural armor
* deep-dwelling races no longer get a torch at game start
* colored help screen
* item identification
* usable Intuition skill
* item tooltips
* multiclassing
* first standalone version

0.2.1 - 8/08/2013
* implemented darkvision
* ranged attacks now use Dex instead of Str to determine bonus
* racial skill bonuses implemented

0.2.0 beta 1.75 - 5/08/2013
* bugfixes
* colored character sheet, tooltips and log messages
* encumbrance displayed in character sheet
* encumbrance displayed in log
* cavern map generator [Sebsebeleb]

0.1.5 beta 1.5 - 3/08/2013
* bugfixes
* stairs have a chance of not changing dungeon level [Sebsebeleb]
* armors limit Dex bonus to AC
* weapon finesse implemented [Sebsebeleb]
* armor check penalty is taken into account
* first draft for skill screen [Sebsebeleb]
* new items: magic armors and shields
* monster CR displayed in tooltips

0.1.0 beta 1 - 15/07/2013
* cleric and barbarian class qualities
* in-game help screen
* clerical domains [Sebsebeleb]
* alignment limited by some classes
* skills
* new items: shields
* opposed skill check
* ranged combat
* Open Game License


***
For historical purposes

ALPHA
0.0.1 - 24/06/2013
* 4 classes: fighter, mage, rogue, ranger
* 4 races: human, half-elf, elf, drow
* character sheet
* inventory
* random damage
* AC implemented
* attack roll implemented
* hit points tied to Hit Dice
* hit points, experience and dungeon level on-screen display
* saving throws implemented
* some 0 and 1st level spells implemented [Sebsebeleb]
* attributes rolled before character generation
* enemies: kobolds

0.0.2 - 26/06/2013
* bugfixes
* possible to equip a weapon in both hands
* spells hotbar &  spellbook [Sebsebeleb]
* new enemies: rats, skeletons
* new classes: barbarian and cleric
* new races: dwarf and half-orc
* starting equipment
* potions of cure X wounds

0.0.3 - 30/06/2013
* new classes: druid and warlock
* leveling up gives +1 to BAB and saves (temporary solution)
* new enemies: spider, snake, orc, tiefling
* calendar
* new items: torch, lantern, food rations, water flask
* new races: duergar, deep gnome
* faerzress

0.0.4 - 6/07/2013
* new enemies: zombies, brain flayers
* armor proficiency
* critical hits
* feat select screen
* alignment
* a batch of weaponry added
