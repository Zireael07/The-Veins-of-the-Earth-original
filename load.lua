-- Veins of the Earth
-- Zireael 2013-2014
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
local Birther = require "engine.Birther"
local PlayerLore = require "mod.class.interface.PlayerLore"

local UIBase = require "engine.ui.Base"

-- Init settings
config.settings.veins = config.settings.veins or {}
if not config.settings.veins.tiles then
	config.settings.veins.tiles = "tiles"
end

require("engine.ui.Base").ui_conf = {
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
}

UIBase.ui = "tweaked_simple"

local size = 12
UIBase.font = core.display.newFont("/data/font/DroidSansFallback.ttf", size)

--Resolvers
dofile('/mod/resolvers.lua')

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
ActorInventory:defineInventory('MAIN_HAND', 'Main hand', true, 'Weapon')
ActorInventory:defineInventory('OFF_HAND', 'Off hand', true, 'Shield')
ActorInventory:defineInventory('BODY', 'Armor', true, 'Body armor')
ActorInventory:defineInventory('CLOAK', 'Cloak', true, 'Cloak')
ActorInventory:defineInventory('BELT', 'Belt', true, 'Belt')
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

--Factions
dofile("/data/factions.lua")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")
ActorAI:loadDefinition("/mod/ai/")

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

--Stores
Store:loadStores("/data/general/stores/general.lua")

-- Lore
PlayerLore:loadDefinition("/data/lore/lore.lua")

--Trying to debug Dialog.lua
--[[require "engine.class"
function engine.ui.Dialog:init(title, w, h, x, y, alpha, font, showup, skin)
	self.title = title
	self.alpha = self.alpha or 255
	if showup ~= nil then
		self.__showup = showup
	else
		self.__showup = 2
	end
	self.color = self.color or {r=255, g=255, b=255}
	if skin then self.ui = skin end

	print ("[DEBUG] self.ui is "..self.ui)

	if not self.ui_conf[self.ui] then self.ui = "metal" end

	local conf = self.ui_conf[self.ui]
	self.frame = self.frame or {
		b7 = "ui/dialogframe_7.png",
		b8 = "ui/dialogframe_8.png",
		b9 = "ui/dialogframe_9.png",
		b1 = "ui/dialogframe_1.png",
		b2 = "ui/dialogframe_2.png",
		b3 = "ui/dialogframe_3.png",
		b4 = "ui/dialogframe_4.png",
		b6 = "ui/dialogframe_6.png",
		b5 = "ui/dialogframe_5.png",
		shadow = conf.frame_shadow or nil,
		a = conf.frame_alpha or 1,
		particles = table.clone(conf.particles, true),
	}
	self.frame.ox1 = self.frame.ox1 or conf.frame_ox1
	self.frame.ox2 = self.frame.ox2 or conf.frame_ox2
	self.frame.oy1 = self.frame.oy1 or conf.frame_oy1
	self.frame.oy2 = self.frame.oy2 or conf.frame_oy2

	self.particles = {}

	self.frame.title_x = 0
	self.frame.title_y = 0
	if conf.title_bar then
		self.frame.title_x = conf.title_bar.x
		self.frame.title_y = conf.title_bar.y
		self.frame.title_w = conf.title_bar.w
		self.frame.title_h = conf.title_bar.h
		self.frame.b7 = self.frame.b7:gsub("dialogframe", "title_dialogframe")
		self.frame.b8 = self.frame.b8:gsub("dialogframe", "title_dialogframe")
		self.frame.b9 = self.frame.b9:gsub("dialogframe", "title_dialogframe")
	end

	self.uis = {}
	self.ui_by_ui = {}
	self.focus_ui = nil
	self.focus_ui_id = 0

	self.force_x = x
	self.force_y = y

	self.first_display = true

	UIBase.init(self, {}, true)

	self:resize(w, h, true)
end]]

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




return {require "mod.class.Game", require "mod.class.World" }
