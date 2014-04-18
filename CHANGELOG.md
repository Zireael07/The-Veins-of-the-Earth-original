CHANGELOG

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
* bug fix: assasin and shadowdancer not giving level-up bonuses
* new monsters: aboleth, athach, choker, chuul, cloaker, drider, ettercap, otyugh; ankheg, aranea, arrowhawk, assasin vine, barghest
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
* new prestige classes: assasin, shadowdancer
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
