-- Veins of the Earth
-- Zireael 2013-2015
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

-- Entities that are ASCII are outline
local Entity = require "engine.Entity"
Entity.ascii_outline = {x=2, y=2, r=0, g=0, b=0, a=0.8}

local Map = require 'engine.Map'
-- Dodgy Hack(TM):  This modifies Map functions in place.
local MapEffects = require 'mod.class.MapEffects'

local ActorInventory = require "engine.interface.ActorInventory"
local Keybind = require "engine.KeyBind"
local Faction = require "engine.Faction"
local DamageType = require "engine.DamageType"
local ActorStats = require "engine.interface.ActorStats"
local ActorResource = require "engine.interface.ActorResource"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorAI = require "engine.interface.ActorAI"
local ActorLevel = require "engine.interface.ActorLevel"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Store = require "mod.class.Store"
local WorldAchievements = require "mod.class.interface.WorldAchievements"
--local Birther = require "engine.Birther"
local Birther = require "mod.class.patch.Birther"
local PlayerLore = require "mod.class.interface.PlayerLore"

local UIBase = require "engine.ui.Base"

local Object = require 'mod.class.Object'
local ActorSkills = require 'mod.class.interface.ActorSkills'

-- Init settings
config.settings.veins = config.settings.veins or {}

--Graphics
if not config.settings.veins.gfx then
	config.settings.veins.gfx = {size="32x32", tiles="default"}
end

--Variants
--[[if not config.settings.veins.difficulty or
	(not config.settings.veins.difficulty == "Easy" or not config.settings.veins.difficulty == "Normal" or not config.settings.veins.difficulty == "Hard")
	then
	config.settings.veins.difficulty = "Normal" end]]
if type(config.settings.veins.difficulty) == "nil" then
	config.settings.veins.difficulty = "Normal" end
if not config.settings.veins.body_parts then config.settings.veins.body_parts = false end
if not config.settings.veins.piecemeal_armor then config.settings.veins.piecemeal_armor = false end
if not config.settings.veins.defensive_roll then config.settings.veins.defensive_roll = false end
if not config.settings.veins.spellbooks then config.settings.veins.spellbooks = false end
if not config.settings.veins.training then config.settings.veins.training = false end
if not config.settings.veins.money_weight then config.settings.veins.money_weight = false end
if not config.settings.veins.pathfinder_feat then config.settings.veins.pathfinder_feat = false end

--UI stuff
--[[require("engine.ui.Base").ui_conf = {
	tweaked_simple = {
	--	frame_shadow = {x=15, y=15, a=0.5},
		frame_shadow = nil,
		frame_alpha = 0.8,
		frame_ox1 = -42,
		frame_ox2 =  42,
		frame_oy1 = -42,
		frame_oy2 =  42,
		title_bar = {x=0, y=-21, w=4, h=25},
	},
	--copied over default UI definitions to end nil ui_conf lua errors
	metal = {
	frame_shadow = {x=15, y=15, a=0.5},
	frame_alpha = 0.9,
	frame_ox1 = -42,
	frame_ox2 =  42,
	frame_oy1 = -42,
	frame_oy2 =  42,
	title_bar = {x=0, y=-18, w=4, h=25},
	},

	stone = {
	frame_shadow = {x=15, y=15, a=0.5},
	frame_alpha = 1,
	frame_ox1 = -42,
	frame_ox2 =  42,
	frame_oy1 = -42,
	frame_oy2 =  42,
},

	simple = {
	frame_shadow = nil,
	frame_alpha = 0.9,
	frame_ox1 = -2,
	frame_ox2 =  2,
	frame_oy1 = -2,
	frame_oy2 =  2,
},

	parchment = {
	frame_shadow = {x = 10, y = 10, a = 0.5},
	frame_ox1 = -16,
	frame_ox2 = 16,
	frame_oy1 = -16,
	frame_oy2 = 16,
},

	achievement = {
	frame_shadow = {x = 10, y = 10, a = 0.5},
	frame_ox1 = -16,
	frame_ox2 = 16,
	frame_oy1 = -16,
	frame_oy2 = 16,
},

	tombstone = {
	frame_shadow = {x = 10, y = 10, a = 0.5},
	frame_ox1 = -16,
	frame_ox2 = 16,
	frame_oy1 = -16,
	frame_oy2 = 16,
}
}]]

--UIBase.ui = "tweaked_simple"

local size = 12
UIBase.font = core.display.newFont("/data/font/DroidSansFallback.ttf", size)

--test (original being { 0.6, 0.6, 0.6, 0.5 })
Map:setObscure(0.1, 0.1, 0.1, 0.3)

--Resolvers
dofile('/mod/resolvers.lua')
--Ported utility functions from ToME
dofile('/mod/util.lua')

-- Achievements
WorldAchievements:loadDefinition("/data/achievements/")

-- Useful keybinds
Keybind:load("veins")

-- Damage types
DamageType:loadDefinition("/data/damage_types.lua")

-- Talents
ActorTalents:loadDefinition("/data/talents.lua")

-- Timed Effects
ActorTemporaryEffects:loadDefinition("/data/timed_effects.lua")

-- Actor inventory
ActorInventory:defineInventory("MAIN_HAND", "In main hand", true, "Most weapons are wielded in the main hand.", nil, {equipdoll_back="ui/equipdoll/mainhand_inv.png"})
ActorInventory:defineInventory("OFF_HAND", "In off hand", true, "You can use shields or a second weapon in your off-hand, if you have the talents for it.", nil, {equipdoll_back="ui/equipdoll/offhand_inv.png"})
ActorInventory:defineInventory("BODY", "Main armor", true, "Armor protects you from physical attacks. The heavier the armor the more it hinders the use of talents and spells.", nil, {equipdoll_back="ui/equipdoll/armor_inv.png"})
ActorInventory:defineInventory("CLOAK", "Cloak", true, "A cloak can simply keep you warm or grant you wondrous powers should you find a magical one.", nil, {equipdoll_back="ui/equipdoll/cloak_inv.png"})
ActorInventory:defineInventory("BELT", "Around waist", true, "Belts are worn around your waist.", nil, {equipdoll_back="ui/equipdoll/belt_inv.png"})
ActorInventory:defineInventory("QUIVER", "Quiver", true, "Your readied ammo.", nil, {equipdoll_back="ui/equipdoll/ammo_inv.png"})
ActorInventory:defineInventory("GLOVES", "On hands", true, "Various gloves can be worn on your hands.", nil, {equipdoll_back="ui/equipdoll/gloves_inv.png"})
ActorInventory:defineInventory("BOOTS", "On feet", true, "Sandals or boots can be worn on your feet.", nil, {equipdoll_back="ui/equipdoll/boots_inv.png"})
ActorInventory:defineInventory("HELM", "On head", true, "You can wear helmets or crowns on your head.", nil, {equipdoll_back="ui/equipdoll/head_inv.png"})
ActorInventory:defineInventory("RING", "On fingers", true, "Rings are worn on fingers.", nil, {equipdoll_back="ui/equipdoll/ring_inv.png"})
ActorInventory:defineInventory("AMULET", "Around neck", true, "Amulets are worn around the neck.", nil, {equipdoll_back="ui/equipdoll/amulet_inv.png"})
ActorInventory:defineInventory("LITE", "Light source", true, "A light source allows you to see in the dark places of the world.", nil, {equipdoll_back="ui/equipdoll/light_inv.png"})
ActorInventory:defineInventory("TOOL", "Tool", true, "This is your readied tool, usually a shovel.", nil, {equipdoll_back="ui/equipdoll/tool_inv.png"})
--For swapping weapons
ActorInventory:defineInventory("SHOULDER", "Shouldered weapon", true, "This is your readied weapon, usually a ranged one.", nil, {equipdoll_back="ui/equipdoll/shoulder_inv.png"})
--For piecemeal armor
ActorInventory:defineInventory("LEGS", "Legs armor", true, "This is the kind of armor you wear on your legs", nil, {equipdoll_back="ui/equipdoll/legs_inv.png"})
ActorInventory:defineInventory("ARMS", "Arms armor", true, "This is the kind of armor you wear on your arms", nil, {equipdoll_back="ui/equipdoll/arms_inv.png"})

ActorInventory.equipdolls = {
	default = { w=48, h=48, itemframe="ui/equipdoll/itemframe48.png", itemframe_sel="ui/equipdoll/itemframe-sel48.png", ix=3, iy=3, iw=42, ih=42, doll_x=116, doll_y=168+64, list={
		MAIN_HAND = {{weight=1, x=48, y=120}},
		OFF_HAND = {{weight=2, x=48, y=192}},
		BODY = {{weight=3, x=48, y=264}},
		QUIVER = {{weight=4, x=48, y=336}},
		RING = {{weight=5, x=48, y=408}, {weight=6, x=120, y=408, text="bottom"}},
		LITE = {{weight=7, x=192, y=408}},
		TOOL = {{weight=8, x=264, y=408, text="bottom"}},
		BOOTS = {{weight=9, x=264, y=336}},
		BELT = {{weight=10, x=264, y=264}},
		GLOVES = {{weight=11, x=264, y=192}},
		CLOAK = {{weight=12, x=264, y=120}},
		AMULET = {{weight=13, x=192, y=48, text="topright"}},
		HELM = {{weight=14, x=120, y=48, text="topleft"}},
		SHOULDER = {{weight=15, x=120, y=120, text="bottom"}},
		LEGS = {{weight=16, x=48, y=48}},
		ARMS = {{weight=17, x=264, y=48}},
	}},
}

--Actor resources
ActorResource:defineResource("Mana", "mana", ActorTalents.T_SPELL_POINTS_POOL, "spell_regen", "Spell points represent your reserve of magical energies. Each spell cast consumes spell points and each sustained spell reduces your maximum spell points.", 0, 500)
ActorResource:defineResource("Psi", "psi", ActorTalents.T_PSI_POOL, "psi_regen", "Psionic power represents your reserve of psionic energies. Each power used consumes psionic power and each sustained power reduces your maximum psionic power.", 0, 500)

-- Actor stats
ActorStats:defineStat("Strength",	    "str", 0, 0, 30, "Strength measures your character's muscle and physical power.")
ActorStats:defineStat("Dexterity",	    "dex", 0, 0, 30, "Dexterity measures hand-eye coordination, agility, reflexes, and balance.")
ActorStats:defineStat("Constitution",	"con", 0, 0, 30, "Constitution represents your character's health and stamina.")
ActorStats:defineStat("Intelligence",   "int", 0, 0, 30, "Intelligence determines how well your character learns and reasons.")
ActorStats:defineStat("Wisdom",         "wis", 0, 0, 30, "Wisdom describes a character's willpower, common sense, perception, and intuition. While Intelligence represents one's ability to analyze information, Wisdom represents being in tune with and aware of one's surroundings.")
ActorStats:defineStat("Charisma",       "cha", 0, 0, 30, "Charisma measures a character's force of personality, persuasiveness, personal magnetism, ability to lead, and physical attractiveness. This ability represents actual strength of personality, not merely how one is perceived by others in a social setting.")
ActorStats:defineStat("Luck",           "luc", 0, 0, 30, "Luck measures your character's good fortune and favor of the gods.")

-- Add D20-style stat modifiers.
for i, s in ipairs(ActorStats.stats_def) do
    ActorStats["get"..s.short_name:lower():capitalize().."Mod"] = function(self, scale, raw, no_inc)
        return math.floor((self:getStat(ActorStats["STAT_"..s.short_name:upper()], scale, raw, no_inc) - 10) / 2)
    end
end

--Factions
dofile("/data/factions.lua")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")
ActorAI:loadDefinition("/mod/ai/")

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

--Stores
Store:loadStores("/data/general/stores/general.lua")

-- Configure chat dialogs
require("mod.dialogs.Chat").show_portraits = true

-- Lore
PlayerLore:loadDefinition("/data/lore/lore.lua")

Object:loadFlavors('/data/object_flavors.lua')

--Un-hardcoded skills
ActorSkills:loadDefinition('/data/skills.lua')

--More shenanigans

--- Request a line to send
function engine.UserChat:talkBox(on_end)
	if not profile.auth then return end
--	local Talkbox = require "mod.class.patch.Talkbox"
--	local d = Talkbox.new(self, on_end)
--	game:registerDialog(d)

	game:registerDialog(require("mod.class.patch.Talkbox").new(self, self.player, on_end))

	self:updateChanList()
end

dofile("/mod/marson.lua")

return {require "mod.class.Game", require "mod.class.World" }
