-- Underdark
-- Zireael
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.


-- This file loads the game module, and loads data
local ActorInventory = require "engine.interface.ActorInventory"
local KeyBind = require "engine.KeyBind"
local DamageType = require "engine.DamageType"
local ActorStats = require "engine.interface.ActorStats"
local ActorResource = require "engine.interface.ActorResource"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorAI = require "engine.interface.ActorAI"
local ActorLevel = require "engine.interface.ActorLevel"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Birther = require "engine.Birther"

dofile('/mod/resolvers.lua')

-- Useful keybinds
KeyBind:load("move,hotkeys,inventory,actions,interface,debug,underdark")

-- Damage types
DamageType:loadDefinition("/data/damage_types.lua")

-- Talents
ActorTalents:loadDefinition("/data/talents.lua")

-- Timed Effects
ActorTemporaryEffects:loadDefinition("/data/timed_effects.lua")

-- Actor resources
ActorResource:defineResource("SP", "SP", nil, "sp_regen", "SP represent your ability to cast spells.")

-- Actor inventory
ActorInventory:defineInventory('MAIN_HAND', 'Main hand', true, 'Weapon')
ActorInventory:defineInventory('OFF_HAND', 'Off hand', true, 'Shield')
ActorInventory:defineInventory('BODY', 'Armor', true, 'Body armor')
ActorInventory:defineInventory('CLOAK', 'Cloak', true, 'Cloak')
ActorInventory:defineInventory('LAUNCHER', 'Launcher', true, 'Bow, crossbow or sling')
ActorInventory:defineInventory('QUIVER', 'Quiver', true, 'Arrows, crossbow bolts or sling shots')
ActorInventory:defineInventory('GLOVES', 'Hands', true, 'Gloves or gauntlets')
ActorInventory:defineInventory('BOOTS', 'Feet', true, 'Boots')
ActorInventory:defineInventory('HELM', 'Head', true, 'Helmets or other headwear')
ActorInventory:defineInventory('RING', 'Fingers', true, 'Rings')
ActorInventory:defineInventory('AMULET', 'Neck', true, 'Amulet')
ActorInventory:defineInventory('LITE', 'Light', true, 'Torches or lantern')
ActorInventory:defineInventory('TOOL', 'Tool', true, 'Shovel or other tool')

-- Actor stats
ActorStats:defineStat("Strength",	"str", 0, -5, 30, "Strength measures your character’s muscle and physical power.")
ActorStats:defineStat("Dexterity",	"dex", 0, -5, 30, "Dexterity measures hand-eye coordination, agility, reflexes, and balance.")
ActorStats:defineStat("Constitution",	"con", 0, -5, 30, "Constitution represents your character’s health and stamina.")
ActorStats:defineStat("Intelligence",   "int", 0, -5, 30, "Intelligence determines how well your character learns and reasons.")
ActorStats:defineStat("Wisdom",         "wis", 0, -5, 30, "Wisdom describes a character’s willpower, common sense, perception, and intuition. While Intelligence represents one’s ability to analyze information, Wisdom represents being in tune with and aware of one’s surroundings.")
ActorStats:defineStat("Charisma",       "cha", 0, -5, 30, "Charisma measures a character’s force of personality, persuasiveness, personal magnetism, ability to lead, and physical attractiveness. This ability represents actual strength of personality, not merely how one is perceived by others in a social setting.")
ActorStats:defineStat("Luck",           "luc", 0, -5, 30, "Luck measures your character's good fortune and favor of the gods.")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")
ActorAI:loadDefinition("/mod/ai/")

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

return {require "mod.class.Game" }
