-- Veins of the Earth
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

require "engine.class"
require "engine.GameTurnBased"
require "engine.interface.GameTargeting"
require "engine.KeyBind"
local Savefile = require "engine.Savefile"
local DamageType = require "engine.DamageType"
local Zone = require "mod.class.Zone"
local Map = require "engine.Map"
local Level = require "engine.Level"

local Party = require "mod.class.Party"
local Grid = require "mod.class.Grid"
local Actor = require "mod.class.Actor"
local Player = require "mod.class.Player"
local NPC = require "mod.class.NPC"

local PlayerDisplay = require "mod.class.PlayerDisplay"
local HotkeysIconsDisplay = require "mod.class.HotkeysIconsDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local DebugConsole = require "engine.DebugConsole"
local FlyingText = require "engine.FlyingText"
local Tooltip = require "engine.Tooltip"
local Calendar = require "engine.Calendar"

local Birther = require "mod.dialogs.Birther"

local QuitDialog = require "mod.dialogs.Quit"

local HighScores = require "engine.HighScores"
local MapMenu = require "mod.dialogs.MapMenu"

local Tiles = require "engine.Tiles" --required for tiles
local Shader = require "engine.Shader" --required for fbo + prettiness

module(..., package.seeall, class.inherit(engine.GameTurnBased, engine.interface.GameTargeting))

-- Tell the engine that we have a fullscreen shader that supports gamma correction
support_shader_gamma = true

function _M:init()
	engine.GameTurnBased.init(self, engine.KeyBind.new(), 1000, 100)

	-- Pause at birth
	self.paused = true

	-- Same init as when loaded from a savefile
	self:loaded()
end

--Thanks DG!
function _M:load()
	Zone.alter_filter = function(zone, e, filter, type)
	if filter.max_cr then
			if e.challenge >= zone.base_level + game.level.level + filter.max_cr then return false end
 	end
end
end

function _M:run()
	self.flash = LogFlasher.new(0, 0, self.w - 20, 20, nil, nil, nil, {255,255,255}, {0,0,0})
	self.logdisplay = LogDisplay.new(290, self.h - 150, self.w*0.45, self.h*0.15, nil, nil, 14, {255,255,255}, {30,30,30})
	self.hotkeys_display = HotkeysIconsDisplay.new(nil, self.w * 0.5, self.h * 0.75, self.w * 0.5, self.h * 0.2, {30,30,0}, nil, nil, 48, 48)
	self.npcs_display = ActorsSeenDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,0})
	self.tooltip = Tooltip.new(nil, 13, {255,255,255}, {30,30,30})
	self.player_display = PlayerDisplay.new(0, self.h*0.75, 200, 150, {0,0,0}, "/data/font/DroidSansMono.ttf", 14)
	
	self.flyers = FlyingText.new()
	self:setFlyingText(self.flyers)

	self.log = function(style, ...) if type(style) == "number" then self.logdisplay(...) self.flash(style, ...) else self.logdisplay(style, ...) self.flash(self.flash.NEUTRAL, style, ...) end end
	self.logSeen = function(e, style, ...) if e and self.level.map.seens(e.x, e.y) then self.log(style, ...) end end
	self.logPlayer = function(e, style, ...) if e == self.player then self.log(style, ...) end end

-- Start time
	self.real_starttime = os.time()
	self.calendar = Calendar.new("/data/calendar.lua", "#GOLD#Today is the %s %s of %s DR. \nThe time is %02d:%02d.", 1371, 1, 11)

	self.log(self.flash.GOOD, "Welcome to #SANDY_BROWN#the Veins of the Earth! #WHITE#You can press F1 to open the help screen.")

	-- Setup inputs
	self:setupCommands()
	self:setupMouse()

	-- Starting from here we create a new game
	if not self.player then self:newGame() end

	self.hotkeys_display.actor = self.player
	self.npcs_display.actor = self.player

	-- Setup the targetting system
	engine.interface.GameTargeting.init(self)

	-- Ok everything is good to go, activate the game in the engine!
	self:setCurrent()

	if self.level then self:setupDisplayMode() end
end

function _M:newGame()
	self.player = Player.new{name=self.player_name, game_ender=true}
	Map:setViewerActor(self.player)
	self:setupDisplayMode()

	self.creating_player = true
	
    --Displays attributes roller before the birther
    local birther = mod.dialogs.Birther.new(self.player)
    self:registerDialog(birther)

end

function _M:loaded()
	engine.GameTurnBased.loaded(self)
	Zone:setup{npc_class="mod.class.NPC", grid_class="mod.class.Grid", object_class="mod.class.Object", }
	Map:setViewerActor(self.player)
	local th, tw = 32, 32
	Map:setViewPort(0, 0, self.w, self.h*0.7, tw, th, nil, 32, true)
--	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.75) - 20, 32, 32, "/data/font/DroidSansFallback.ttf", 22, true)
	selfppp = engine.KeyBind.new()
end

function _M:setupDisplayMode()
	if not mode or mode == "init" then
		Map:resetTiles()
	end
	
	if not mode or mode == "postinit" then
		Tiles.prefix = "/data/gfx/"
	
		local th, tw = 32, 32
		
		--switched from "fsize" to 32.
		Map:setViewPort(0, 0, self.w, self.h*0.7, tw, th, nil, 32, true)
		--Map:setViewPort(map_x, map_y, map_w, map_h, tw, th, nil, fsize, do_bg)
		Map.tiles.use_images = true
	
--[[	print("[DISPLAY MODE] 32x32 ASCII/background")
	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.80) - 20, 32, 32, "/data/font/DroidSansFallback.ttf", 22, true)
	Map:resetTiles()
	Map.tiles.use_images = false]]

	if self.level and self.player then self.calendar = Calendar.new("/data/calendar.lua", "#GOLD#Today is the %s %s of %s DR. \nThe time is %02d:%02d.", 1371, 1, 11)
 end

	if self.level then
		self.level.map:recreate()
		engine.interface.GameTargeting.init(self)
		self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8)
	end

	end
end

--Highscore stuff, unused until 1.0.5
function _M:getPlayer(main)
	return self.player
end

-- added for engine.dialogs.viewhighscores
function _M:getCampaign()
	return "Veins"
end

function _M:registerHighscore()
	local player = self:getPlayer(true)
	local campaign = "Veins"
	local score = 0
	local temp = 0

	--Hiscores are based on your total kills
	temp = player.kills or 0

	score = score + temp

	local details = {
		level = player.level,
		role = player.descriptor.class,
		name = player.name,
		world = "Veins",
		where = self.zone and self.zone.name or "???",
		dlvl = self.level and self.level.level or 1,
		score = score
	}


	if player.dead then
		HighScores.registerScore(campaign, details)
	else
		HighScores.noteLivingScore(campaign, player.name, details)
	end
end


function _M:save()
	return class.save(self, self:defaultSavedFields{}, true)
end

function _M:getSaveDescription()
	return {
		name = self.player.name,
		description = ([[Exploring level %d of %s.]]):format(self.level.level, self.zone.name),
	}
end

function _M:leaveLevel(level, lev, old_lev)
	if level:hasEntity(self.player) then
		level.exited = level.exited or {}
		if lev > old_lev then
			level.exited.down = {x=self.player.x, y=self.player.y}
		else
			level.exited.up = {x=self.player.x, y=self.player.y}
		end
		level.last_turn = game.turn
		level:removeEntity(self.player)
	end
end

function _M:changeLevel(lev, zone)
	local old_lev = (self.level and not zone) and self.level.level or -1000
	if zone then
		if self.zone then
			self.zone:leaveLevel(false, lev, old_lev)
			self.zone:leave()
		end
		if type(zone) == "string" then
			self.zone = Zone.new(zone)
		else
			self.zone = zone
		end
	end
	self.zone:getLevel(self, lev, old_lev)

	if lev > old_lev then
		self.player:move(self.level.default_up.x, self.level.default_up.y, true)
	else
		self.player:move(self.level.default_down.x, self.level.default_down.y, true)
	end
	self.level:addEntity(self.player)

	--Level feeling
	local player = self.player
	local feeling
	local cr = 0
	local max_cr = 0
	if self.level.special_feeling then
		feeling = self.level.special_feeling
	else

	for uid, e in pairs(game.level.entities) do --list[#list+1] = e 
	cr = e.challenge
	if cr > max_cr then max_cr = cr 
	else end
	end

	local magic = 0
	local max_magic = 0

	--Detect powerful magic items
--[[	for uid, o in pairs(game.level.entities) do --list[#list+1] = o
		local magic_bonus = o.combat.magic_bonus
		local magic_armor = o.wielder.combat_magic_armor
		local magic_shield = o.wielder.combat_magic_shield
		local natural = o.wielder.combat_natural
		local protection = o.wielder.combat_protection

		if o.type == "weapon" and magic_bonus and magic_bonus > 0 then magic = o.magic_bonus
		elseif o.type == "armor" and magic_armor and magic_armor > 0 then magic = o.magic_armor
		elseif o.type == "shield" and magic_shield and magic_shield > 0 then magic = o.magic_shield
		elseif o.type == "amulet" and natural and natural > 0 then magic = o.natural
		elseif o.type == "ring" and protection and protection > 0 then magic = o.protection
		else end

		if magic > max_magic then max_magic = magic
		else end
	end

		if max_magic > 2 then feeling = "You get goosebumps on your skin. A magic item is radiating power."
		elseif max_magic > 4 then feeling = "The feeling of power threatens to overwhelm you. A powerful magic item must be nearby."

		else]]if max_cr > player.level + 4 then feeling = "You get the feeling that there is a powerful enemy here."
		elseif max_cr < player.level -4 then feeling = "You feel very confident in your power."
		else feeling = "You walk cautiously, feeling slightly anxious."	
		end
	end
	if feeling then self.log("#TEAL#%s", feeling) end

end

function _M:getPlayer()
	return self.player
end

--- Says if this savefile is usable or not
function _M:isLoadable()
	return not self:getPlayer(true).dead
end

function _M:tick()
	if self.level then
		self:targetOnTick()

		engine.GameTurnBased.tick(self)
	end
	-- When paused (waiting for player input) we return true: this means we wont be called again until an event wakes us
	if self.paused and not savefile_pipe.saving then return true end
end

--- Called every game turns
-- Does nothing, you can override it
function _M:onTurn()
	-- The following happens only every 10 game turns (once for every turn of 1 mod speed actors)
	if self.turn % 10 ~= 0 then return end

	-- Process overlay effects
	self.level.map:processEffects()
	--Calendar
	if not self.day_of_year or self.day_of_year ~= self.calendar:getDayOfYear(self.turn) then
		self.log(self.calendar:getTimeDate(self.turn))
		self.day_of_year = self.calendar:getDayOfYear(self.turn)
	end

end

function _M:display(nb_keyframe)
	
	-- If switching resolution, blank everything but the dialog
	if self.change_res_dialog then engine.GameTurnBased.display(self, nb_keyframe) return end

	-- Now the map, if any
	if self.level and self.level.map and self.level.map.finished then
		local map = self.level.map
		-- Display the map and compute FOV for the player if needed
		if self.level.map.changed then
			self.player:playerFOV()
		end

		-- Display using Framebuffer, so that we can use shaders and all
		if self.fbo then
			self.fbo:use(true)
				if self.level.data.background then self.level.data.background(self.level, 0, 0, nb_keyframes) end
				--map:display(0, 0, nb_keyframe)
				map:display(0, 0, nb_keyframe, true)
				map._map:drawSeensTexture(0, 0, nb_keyframe)
			self.fbo:use(false, self.full_fbo)

			self.fbo:toScreen(0, 0, self.w, self.h, self.fbo_shader.shad)


		-- Basic display; no FBOs
		else
			if self.level.data.background then self.level.data.background(self.level, map.display_x, map.display_y, nb_keyframes) end
			--self.level.map:display(nil, nil, nb_keyframe)
			map:display(nil, nil, nb_keyframe, true)
			map._map:drawSeensTexture(map.display_x, map.display_y, nb_keyframe)
		end


	--	self.level.map:display(nil, nil, nb_keyframe)

		-- Display the targetting system if active
		self.target:display()

		-- And the minimap
		self.level.map:minimapDisplay(self.w - 200, 20, util.bound(self.player.x - 25, 0, self.level.map.w - 50), util.bound(self.player.y - 25, 0, self.level.map.h - 50), 50, 50, 0.6)
		self.player_display:toScreen()
	end

	-- We display the player's interface
	self.flash:toScreen(nb_keyframe)
	self.logdisplay:toScreen()
	if self.show_npc_list then
		self.npcs_display:toScreen()
	else
		self.hotkeys_display:toScreen()
	end
	if self.player then self.player.changed = false end

	engine.GameTurnBased.display(self, nb_keyframe)
	
	-- Tooltip is displayed over all else
	self:targetDisplayTooltip()
end

function _M:onRegisterDialog(d)
	-- Clean up tooltip
	self.tooltip_x, self.tooltip_y = nil, nil
	self.tooltip2_x, self.tooltip2_y = nil, nil
--	if self.player then self.player:updateMainShader() end
end
function _M:onUnregisterDialog(d)
	-- Clean up tooltip
	self.tooltip_x, self.tooltip_y = nil, nil
	self.tooltip2_x, self.tooltip2_y = nil, nil
--	if self.player then self.player:updateMainShader() self.player.changed = true end
end

--- Setup the keybinds
function _M:setupCommands()
	-- Make targeting work
	self.normal_key = self.key
	self:targetSetupKey()

	-- One key handled for normal function
	self.key:unicodeInput(true)
	self.key:addBinds
	{
		-- Movements
		MOVE_LEFT = function() self.player:moveDir(4) end,
		MOVE_RIGHT = function() self.player:moveDir(6) end,
		MOVE_UP = function() self.player:moveDir(8) end,
		MOVE_DOWN = function() self.player:moveDir(2) end,
		MOVE_LEFT_UP = function() self.player:moveDir(7) end,
		MOVE_LEFT_DOWN = function() self.player:moveDir(1) end,
		MOVE_RIGHT_UP = function() self.player:moveDir(9) end,
		MOVE_RIGHT_DOWN = function() self.player:moveDir(3) end,
		MOVE_STAY = function() self.player:useEnergy() end,

		RUN_LEFT = function() self.player:runInit(4) end,
		RUN_RIGHT = function() self.player:runInit(6) end,
		RUN_UP = function() self.player:runInit(8) end,
		RUN_DOWN = function() self.player:runInit(2) end,
		RUN_LEFT_UP = function() self.player:runInit(7) end,
		RUN_LEFT_DOWN = function() self.player:runInit(1) end,
		RUN_RIGHT_UP = function() self.player:runInit(9) end,
		RUN_RIGHT_DOWN = function() self.player:runInit(3) end,

		-- Hotkeys
		HOTKEY_1 = function() self.player:activateHotkey(1) end,
		HOTKEY_2 = function() self.player:activateHotkey(2) end,
		HOTKEY_3 = function() self.player:activateHotkey(3) end,
		HOTKEY_4 = function() self.player:activateHotkey(4) end,
		HOTKEY_5 = function() self.player:activateHotkey(5) end,
		HOTKEY_6 = function() self.player:activateHotkey(6) end,
		HOTKEY_7 = function() self.player:activateHotkey(7) end,
		HOTKEY_8 = function() self.player:activateHotkey(8) end,
		HOTKEY_9 = function() self.player:activateHotkey(9) end,
		HOTKEY_10 = function() self.player:activateHotkey(10) end,
		HOTKEY_11 = function() self.player:activateHotkey(11) end,
		HOTKEY_12 = function() self.player:activateHotkey(12) end,
		HOTKEY_SECOND_1 = function() self.player:activateHotkey(13) end,
		HOTKEY_SECOND_2 = function() self.player:activateHotkey(14) end,
		HOTKEY_SECOND_3 = function() self.player:activateHotkey(15) end,
		HOTKEY_SECOND_4 = function() self.player:activateHotkey(16) end,
		HOTKEY_SECOND_5 = function() self.player:activateHotkey(17) end,
		HOTKEY_SECOND_6 = function() self.player:activateHotkey(18) end,
		HOTKEY_SECOND_7 = function() self.player:activateHotkey(19) end,
		HOTKEY_SECOND_8 = function() self.player:activateHotkey(20) end,
		HOTKEY_SECOND_9 = function() self.player:activateHotkey(21) end,
		HOTKEY_SECOND_10 = function() self.player:activateHotkey(22) end,
		HOTKEY_SECOND_11 = function() self.player:activateHotkey(23) end,
		HOTKEY_SECOND_12 = function() self.player:activateHotkey(24) end,
		HOTKEY_THIRD_1 = function() self.player:activateHotkey(25) end,
		HOTKEY_THIRD_2 = function() self.player:activateHotkey(26) end,
		HOTKEY_THIRD_3 = function() self.player:activateHotkey(27) end,
		HOTKEY_THIRD_4 = function() self.player:activateHotkey(28) end,
		HOTKEY_THIRD_5 = function() self.player:activateHotkey(29) end,
		HOTKEY_THIRD_6 = function() self.player:activateHotkey(30) end,
		HOTKEY_THIRD_7 = function() self.player:activateHotkey(31) end,
		HOTKEY_THIRD_8 = function() self.player:activateHotkey(32) end,
		HOTKEY_THIRD_9 = function() self.player:activateHotkey(33) end,
		HOTKEY_THIRD_10 = function() self.player:activateHotkey(34) end,
		HOTKEY_THIRD_11 = function() self.player:activateHotkey(35) end,
		HOTKEY_THIRD_12 = function() self.player:activateHotkey(36) end,
		HOTKEY_PREV_PAGE = function() self.player:prevHotkeyPage() end,
		HOTKEY_NEXT_PAGE = function() self.player:nextHotkeyPage() end,

		-- Actions
		CHANGE_LEVEL = function()
			local e = self.level.map(self.player.x, self.player.y, Map.TERRAIN)
			if self.player:enoughEnergy() and e.change_level then
				local level = self.level.level
				if rng.percent(75) then
					level = level + e.change_level
					self.player:gainExp(math.floor(level*50))
				else
					level = level + 0.001
					game.logPlayer(self.player, "#SANDY_BROWN#You feel like you have not delved much further")

				end
				self:changeLevel(e.change_zone and e.change_level or level, e.change_zone)
			else
				self.log("There is no way out of this level here.")
			end
		end,

		REST = function()
			self.player:restInit()
		end,

		USE_TALENTS = function()
			self.player:useTalents()
		end,

		LEVELUP = function()
			self:registerDialog(require("mod.dialogs.LevelupDialog").new(self.player))
		end,

		SAVE_GAME = function()
			self:saveGame()
		end,

		SHOW_CHARACTER_SHEET = function()
			self:registerDialog(require("mod.dialogs.CharacterSheet").new(self.player))
		end,
		
		-- Exit the game
		QUIT_GAME = function()
			self:onQuit()
		end,

		SCREENSHOT = function() self:saveScreenshot() end,

		EXIT = function()
			local menu menu = require("engine.dialogs.GameMenu").new{
				"resume",
				"keybinds",
				"highscores",
				"video",
				"save",
				"quit"
			}
			self:registerDialog(menu)
		end,

		-- Lua console, you probably want to disable it for releases
		LUA_CONSOLE = function()
			self:registerDialog(DebugConsole.new())
		end,

		-- Toggle monster list
		--[[TOGGLE_NPC_LIST = function()
			self.show_npc_list = not self.show_npc_list
			self.player.changed = true
		end,

		TACTICAL_DISPLAY = function()
			if Map.view_faction then
				self.always_target = nil
				Map:setViewerFaction(nil)
			else
				self.always_target = true
				Map:setViewerFaction("players")
			end
		end,]]

		LOOK_AROUND = function()
			self.flash:empty(true)
			self.flash(self.flash.GOOD, "Looking around... (direction keys to select interesting things, shift+direction keys to move freely)")
			local co = coroutine.create(function() self.player:getTarget{type="hit", no_restrict=true, range=2000} 
				if x and y then
                    local tmx, tmy = self.level.map:getTileToScreen(x, y)
                    self:registerDialog(MapMenu.new(tmx, tmy, x, y))
                end
			end)
			local ok, err = coroutine.resume(co)
			if not ok and err then print(debug.traceback(co)) error(err) end
		end,
		
		--Inventory
		PICKUP_FLOOR = function()
    		if self.player.no_inventory_access then return end
    		self.player:playerPickup()
		end,
		DROP_FLOOR = function()
    		if self.player.no_inventory_access then return end
    		self.player:playerDrop()
		end, 

		SHOW_INVENTORY = function()
    		if self.player.no_inventory_access then return end
    		local d
    		d = self.player:showEquipInven("Inventory", nil, function(o, inven, item, button, event)
	        	if not o then return end
	    		local ud = require("mod.dialogs.UseItemDialog").new(event == "button", self.player, o, item, inven, function(_, _, _, stop)
		        	d:generate()
		        	d:generateList()
		        	if stop then self:unregisterDialog(d) end
	        	end)
	        	self:registerDialog(ud)
	    	end)
		end,

    	--New functions
    	OPEN_SPELLBOOK = function()
    		if self.player.knowTalent and self.player:knowTalent(self.player.T_SHOW_SPELLBOOK) then 
    			self.player:useTalent(self.player.T_SHOW_SPELLBOOK)
    		else
    			game.log("Sorry, you do not have a spellbook")
    		end 
		end,

		--Helpful stuff
		SHOW_HELP = function()
			self:registerDialog(require("mod.dialogs.Help").new(self.player))
		end,

		SHOW_MESSAGE_LOG = function()
			self:registerDialog(require("mod.dialogs.ShowChatLog").new("Message Log", 0.6, self.logdisplay, profile.chat))
		end,

		SHOW_CHAT_CHANNELS = function()
		self:registerDialog(require("engine.dialogs.ChatChannels").new(profile.chat))
		--[[
		Chat:showLogDialog("Chat log")]]
		end,

		USERCHAT_TALK = function()
		local Chat = require("engine.UserChat")
			Chat:talkBox()
		end,
	 
	}
	engine.interface.PlayerHotkeys:bindAllHotkeys(self.key, function(i) self.player:activateHotkey(i) end)

    self.key:setCurrent()
    self.key:bindKeys()
end

function _M:setupMouse(reset)
	if reset then self.mouse:reset() end
	self.mouse:registerZone(Map.display_x, Map.display_y, Map.viewport.width, Map.viewport.height, function(button, mx, my, xrel, yrel, bx, by, event, extra)
		-- Handle targeting
		if self:targetMouse(button, mx, my, xrel, yrel, event) then return end

		-- Handle right click menu
        if button == "right" and event == "button" and not xrel and not yrel then
            self:mouseRightClick(mx, my)
        end

		-- Handle the mouse movement/scrolling
		self.player:mouseHandleDefault(self.key, self.key == self.normal_key, button, mx, my, xrel, yrel, event)
	end)

	-- Scroll message log
	self.mouse:registerZone(self.logdisplay.display_x, self.logdisplay.display_y, self.w, self.h, function(button)
		if button == "wheelup" then self.logdisplay:scrollUp(1) end
		if button == "wheeldown" then self.logdisplay:scrollUp(-1) end
	end, {button=true})
	-- Use hotkeys with mouse
	self.mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, self.w, self.h, function(button, mx, my, xrel, yrel, bx, by, event)
		self.hotkeys_display:onMouse(button, mx, my, event == "button", function(text) self.tooltip:displayAtMap(nil, nil, self.w, self.h, tostring(text)) end)
	end)
	self.mouse:setCurrent()
end

--- Right mouse click on the map
function _M:mouseRightClick(mx, my, extra)
	if not self.level then return end
	local tmx, tmy = self.level.map:getMouseTile(mx, my)
	self:registerDialog(MapMenu.new(mx, my, tmx, tmy))
end

--- Ask if we really want to close, if so, save the game first
function _M:onQuit()
	self.player:restStop()

	if not self.quit_dialog then
		self.quit_dialog = QuitDialog.new()
		self:registerDialog(self.quit_dialog)
	end
end


--- Requests the game to save
function _M:saveGame()
	self:registerHighscore()
	-- savefile_pipe is created as a global by the engine
	savefile_pipe:push(self.save_name, "game", self)
	self.log("Saving game...")
end


--Events stuff taken from ToME
function _M:doneEvent(id)
	return self.used_events[id]
end

function _M:canEventGrid(level, x, y)
	return game.player:canMove(x, y) and not level.map.attrs(x, y, "no_teleport") and not level.map:checkAllEntities(x, y, "change_level") and not level.map:checkAllEntities(x, y, "special")
end

function _M:canEventGridRadius(level, x, y, radius, min)
	local list = {}
	for i = -radius, radius do for j = -radius, radius do
		if game.state:canEventGrid(level, x+i, y+j) then list[#list+1] = {x=x+i, y=y+j} end
	end end

	if #list < min then return false
	else return list end
end

function _M:findEventGrid(level)
	local x, y = rng.range(1, level.map.w - 2), rng.range(1, level.map.h - 2)
	local tries = 0
	while not self:canEventGrid(level, x, y) and tries < 100 do
		x, y = rng.range(1, level.map.w - 2), rng.range(1, level.map.h - 2)
		tries = tries + 1
	end
	if tries >= 100 then return false end
	return x, y
end

function _M:findEventGridRadius(level, radius, min)
	local x, y = rng.range(3, level.map.w - 4), rng.range(3, level.map.h - 4)
	local tries = 0
	while not self:canEventGridRadius(level, x, y, radius, min) and tries < 100 do
		x, y = rng.range(3, level.map.w - 4), rng.range(3, level.map.h - 4)
		tries = tries + 1
	end
	if tries >= 100 then return false end
	return self:canEventGridRadius(level, x, y, radius, min)
end

function _M:startEvents()
	if not game.zone.events then print("No zone events loaded") return end

	if not game.zone.assigned_events then
		local levels = {}
		if game.zone.events_by_level then
			levels[game.level.level] = {}
		else
			for i = 1, game.zone.max_level do levels[i] = {} end
		end

		-- Generate the events list for this zone, eventually loading from group files
		local evts, mevts = {}, {}
		for i, e in ipairs(game.zone.events) do
			if e.name then if e.minor then mevts[#mevts+1] = e else evts[#evts+1] = e end
			elseif e.group then
				local f, err = loadfile("/data/general/events/groups/"..e.group..".lua")
				if not f then error(err) end
				setfenv(f, setmetatable({level=game.level, zone=game.zone}, {__index=_G}))
				local list = f()
				for j, ee in ipairs(list) do
					if e.percent_factor and ee.percent then ee.percent = math.floor(ee.percent * e.percent_factor) end
					if ee.name then if ee.minor then mevts[#mevts+1] = ee else evts[#evts+1] = ee end end
				end
			end
		end

		-- Randomize the order they are checked as
		table.shuffle(evts)
		table.print(evts)
		table.shuffle(mevts)
		table.print(mevts)
		for i, e in ipairs(evts) do
			-- If we allow it, try to find a level to host it
			if (e.always or rng.percent(e.percent) or (e.special and e.special() == true)) and (not e.unique or not self:doneEvent(e.name)) then
				local lev = nil
				local forbid = e.forbid or {}
				forbid = table.reverse(forbid)
				if game.zone.events_by_level then
					lev = game.level.level
				else
					if game.zone.events.one_per_level then
						local list = {}
						for i = 1, #levels do if #levels[i] == 0 and not forbid[i] then list[#list+1] = i end end
						if #list > 0 then
							lev = rng.table(list)
						end
					else
						if forbid then
							local t = table.genrange(1, game.zone.max_level, true)
							t = table.minus_keys(t, forbid)
							lev = rng.table(table.keys(t))
						else
							lev = rng.range(1, game.zone.max_level)
						end
					end
				end

				if lev then
					lev = levels[lev]
					lev[#lev+1] = e.name
				end
			end
		end
		for i, e in ipairs(mevts) do
			local forbid = e.forbid or {}
			forbid = table.reverse(forbid)

			local start, stop = 1, game.zone.max_level
			if game.zone.events_by_level then start, stop = game.level.level, game.level.level end
			for lev = start, stop do
				if rng.percent(e.percent) and not forbid[lev] then
					local lev = levels[lev]
					lev[#lev+1] = e.name

					if e.max_repeat then
						local nb = 1
						local p = e.percent
						while nb <= e.max_repeat do
							if rng.percent(p) then
								lev[#lev+1] = e.name
								nb = nb + 1
							else
								break
							end
							p = p / 2
						end
					end
				end
			end
		end

		game.zone.assigned_events = levels
	end

	return function()
		print("Assigned events list")
		table.print(game.zone.assigned_events)

		for i, e in ipairs(game.zone.assigned_events[game.level.level] or {}) do
			local f, err = loadfile("/data/general/events/"..e..".lua")
			if not f then error(err) end
			setfenv(f, setmetatable({level=game.level, zone=game.zone, event_id=e.name, Map=Map}, {__index=_G}))
			f()
		end
		game.zone.assigned_events[game.level.level] = {}
		if game.zone.events_by_level then game.zone.assigned_events = nil end
	end
end
