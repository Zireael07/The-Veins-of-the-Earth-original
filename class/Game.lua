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

require "engine.class"
require "engine.GameTurnBased"
require "engine.interface.GameTargeting"
require "engine.interface.GameSound"
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
local LogFlasher = require "mod.class.patch.LogFlasher"
local DebugConsole = require "engine.DebugConsole"
local FlyingText = require "engine.FlyingText"
--local Tooltip = require "engine.Tooltip"
local Tooltip = require "mod.class.patch.Tooltip"
local Calendar = require "engine.Calendar"

local Birther = require "mod.dialogs.Birther"

local QuitDialog = require "mod.dialogs.Quit"

local HighScores = require "engine.HighScores"
local MapMenu = require "mod.dialogs.MapMenu"
--local Store = require "engine.Store"
local Store = require "mod.class.Store"

local Tiles = require "engine.Tiles" --required for tiles
local Shader = require "engine.Shader" --required for fbo + prettiness

local EntityTracker = require "mod.dialogs.debug.EntityTracker"
local MapMenu = require "mod.dialogs.MapMenu"
local Dialog = require "engine.ui.Dialog"

local GameState = require "mod.class.GameState"

module(..., package.seeall, class.inherit(engine.GameTurnBased, engine.interface.GameSound, engine.interface.GameTargeting))

-- Tell the engine that we have a fullscreen shader that supports gamma correction
support_shader_gamma = true

function _M:init()
--	self.level_random_seed = self.level_random_seed or nil

	engine.GameTurnBased.init(self, engine.KeyBind.new(), 1000, 100)
	engine.interface.GameSound.init(self)

	-- Pause at birth
	self.paused = true

	-- Same init as when loaded from a savefile
	self:loaded()

	self.visited_zones = {}

	--Moddable tiles
	self.tiles_attachements = {}
end

--Thanks DG!
function _M:load()
	Zone.alter_filter = function(zone, e, filter, type)
	if filter.max_cr then
			if e.challenge >= zone.base_level + game.level.level + filter.max_cr then return false end
 	end
 	if filter.challenge then
 		if e.challenge >= filter.challenge or e.challenge <= filter.challenge then return false end
	end
	end
end

function _M:run()
	veins.saveMarson()

	self.uiset:activate()

	local flysize = veins.fonts.flying.size or 16
	self.tooltip = Tooltip.new(veins.fonts.tooltip.style, veins.fonts.tooltip.size, {255,255,255}, {30,30,30,255})
	self.tooltip2 = Tooltip.new(veins.fonts.tooltip.style, veins.fonts.tooltip.size, {255,255,255}, {30,30,30,255})
	self.flyers = FlyingText.new(veins.fonts.flying.style, flysize, veins.fonts.flying.style, flysize + 3)

	self:setFlyingText(self.flyers)

	-- Ok everything is good to go, activate the game in the engine!
	self:setCurrent()

	self.calendar = Calendar.new("/data/calendar.lua", "#GOLD#Today is the %s %s of %s DR. \nThe time is %02d:%02d.", 1371, 1, 11)

	self.log("Welcome to #SANDY_BROWN#the Veins of the Earth! #WHITE#You can press F1 or h to open the help screen.")

	-- Start time
	self.real_starttime = os.time()
	self:setupDisplayMode(false, "postinit")

--	if self.level and self.level.data.day_night then self.state:dayNightCycle() end
	if self.level then self.state:dayNightCycle() end

	-- Setup inputs
	self:setupCommands()
	self:setupMouse()

	-- Starting from here we create a new game
	if not self.player then self:newGame() end


	self.uiset.hotkeys_display.actor = self.player
	self.uiset.npcs_display.actor = self.player

	-- Setup the targetting system
	engine.interface.GameTargeting.init(self)


	self.inited = true

--	if self.level then self:setupDisplayMode() end
end

--- Resize the hotkeys
function _M:resizeIconsHotkeysToolbar()
	self.uiset:resizeIconsHotkeysToolbar()
end

function _M:newGame()

-- Enable party
	self.party = Party.new{}
	local player = Player.new{name=self.player_name, game_ender=true}
	self.party:addMember(player, {
		control="full",
		type="player",
		title="Main character",
		main=true,
		orders = {target=true, anchor=true, behavior=true, leash=true, talents=true},
	})
	self.party:setPlayer(player)

	-- Create the entity to store various game state things
	self.state = GameState.new{}

	Map:setViewerActor(self.player)
	self:setupDisplayMode()

	self.always_target = true

	self.creating_player = true

	local birth = Birther.new(nil, self.player, {"base", 'sex', 'race', 'class', 'background', 'alignment', 'deity'}, function()

--[[     	--Display game options
        self:registerDialog(require("mod.dialogs.GameOptions").new(true))]]


   	    game:changeLevel(1, "tunnels")
        print("[PLAYER BIRTH] resolve...")
        game.player:resolve()
        game.player:resolve(nil, true)
        game.player.energy.value = game.energy_to_act
        --Faction display
        Map:setViewerFaction(self.player.faction)
        game.paused = true
        game.player.changed = true
        print("[PLAYER BIRTH] resolved!")

        profile.chat:setupOnGame()
        game.player:onBirth()

        local d = require("engine.dialogs.ShowText").new("Welcome to Veins of the Earth", "intro-"..game.player.starting_intro, {name=game.player.name}, nil, nil, function()

		--Tutorial popup
        Dialog:yesnoPopup("Tutorial", "Go through the tutorial", function(ok)
			if ok then game:changeLevel(1, "tutorial")
			else end
		end, "Yes", "No")



        game.creating_player = false

        game.player:levelPassives()
        game.player.changed = true
        end, true)
        game:registerDialog(d)

        end, quickbirth, game.w*0.6, game.h*0.6)

    game:registerDialog(birth)
--end

end

function _M:loaded()
	engine.GameTurnBased.loaded(self)
	engine.interface.GameSound.loaded(self)
	
	Zone:setup{npc_class="mod.class.NPC", grid_class="mod.class.Grid", object_class="mod.class.Object", trap_class="mod.class.Trap"}
	--New filters from GameState go here
	Zone.check_filter = function(...) return self.state:entityFilter(...) end
	Zone.default_prob_filter = true
	Zone.default_filter = function(...) return self.state:defaultEntityFilter(...) end
	Zone.alter_filter = function(...) return self.state:entityFilterAlter(...) end
--	Zone.post_filter = function(...) return self.state:entityFilterPost(...) end
--	Zone.ego_filter = function(...) return self.state:egoFilter(...) end

	self.uiset = require("mod.class.uiset.Veins").new()

	Map:setViewerActor(self.player)
	self:setupDisplayMode(false, "init")
	self:setupDisplayMode(false, "postinit")

	if self.player then self.player.changed = true end
	if self.always_target == true then Map:setViewerFaction(self.player.faction) end

--	selfppp = engine.KeyBind.new()
	self.key = engine.KeyBind.new()

	--if self.zone and self.zone.on_loaded then self.zone.on_loaded(self.level.level) end
end

--Taken from ToME 4
function _M:computeAttachementSpotsFromTable(ta)
	local base = ta.default_base or 32
	local res = { }

	for tile, data in pairs(ta.tiles or {}) do
		local base = data.base or base
		local yoff = data.yoff or 0
		local t = {}
		res[tile] = t
		for kind, d in pairs(data) do if kind ~= "base" and kind ~= "yoff" then
			t[kind] = { x=d.x / base, y=(d.y + yoff) / base }
		end end
	end

	for race, data in pairs(ta.dolls or {}) do
		local base = data.base or base
		for sex, d in pairs(data) do if sex ~= "base" then
			local t = {}
			res["dolls_"..race.."_"..sex] = t
			local yoff = d.yoff or 0
			local base = d.base or base
			for kind, d in pairs(d) do if kind ~= "yoff" and kind ~= "base" then
				t[kind] = { x=d.x / base, y=(d.y + yoff) / base }
			end end
		end end
	end

	self.tiles_attachements = res
end

function _M:computeAttachementSpots()
	local t = {}
	if fs.exists(Tiles.prefix.."attachements.lua") then
		print("Loading tileset attachements from ", Tiles.prefix.."attachements.lua")
		local f, err = loadfile(Tiles.prefix.."attachements.lua")
		if not f then print("Loading tileset attachements error", err)
		else
			setfenv(f, t)
			local ok, err = pcall(f)
			if not ok then print("Loading tileset attachements error", err) end
		end
	end
	for _, file in ipairs(fs.list(Tiles.prefix)) do if file:find("^attachements%-.+.lua$") then
		print("Loading tileset attachements from ", Tiles.prefix..file)
		local f, err = loadfile(Tiles.prefix..file)
		if not f then print("Loading tileset attachements error", err)
		else
			setfenv(f, t)
			local ok, err = pcall(f)
			if not ok then print("Loading tileset attachements error", err) end
		end
	end end
	self:computeAttachementSpotsFromTable(t)
end

--Taken from ToME 4

function _M:getMapSize()
--	return self.uiset:getMapSize()
	local w, h = core.display.size()
	return 200, 0, w - 200, h
--	return 0, 0, w, h
--	return 216, 0, w - 216, h
end

function _M:setupDisplayMode(reboot, mode)
	if not mode or mode == "init" then
		local gfx = config.settings.veins.gfx
		self:saveSettings("veins.gfx", ('veins.gfx = {tiles=%q, size=%q, tiles_custom_dir=%q, tiles_custom_moddable=%s, tiles_custom_adv=%s}\n'):format(gfx.tiles, gfx.size, gfx.tiles_custom_dir or "", gfx.tiles_custom_moddable and "true" or "false", gfx.tiles_custom_adv and "true" or "false"))

		if reboot then
			self.change_res_dialog = true
			self:saveGame()
			util.showMainMenu(false, nil, nil, self.__mod_info.short_name, self.save_name, false)
		end

		Map:resetTiles()
	end

	if not mode or mode == "postinit" then
		local gfx = config.settings.veins.gfx

		-- Select tiles
		Tiles.prefix = "/data/gfx/"..gfx.tiles.."/"
		if config.settings.veins.gfx.tiles == "customtiles" then
			Tiles.prefix = "/data/gfx/"..config.settings.veins.gfx.tiles_custom_dir.."/"
		end
		print("[DISPLAY MODE] Tileset: "..gfx.tiles)
		print("[DISPLAY MODE] Size: "..gfx.size)

		-- Load attachement spots for this tileset
		self:computeAttachementSpots()

		local do_bg = gfx.tiles == "ascii_full"
		local _, _, tw, th = gfx.size:find("^([0-9]+)x([0-9]+)$")
		tw, th = tonumber(tw), tonumber(th)
		if not tw then tw, th = 64, 64 end
		local pot_th = math.pow(2, math.ceil(math.log(th-0.1) / math.log(2.0)))
		local fsize = math.floor( pot_th/th*(0.7 * th + 5) )

		local map_x, map_y, map_w, map_h = self:getMapSize()
	--	local map_x, map_y, map_w, map_h = self.uiset:getMapSize()

		if th <= 20 then
			Map:setViewPort(map_x, map_y, map_w, map_h, tw, th, "/data/font/DroidSansFallback.ttf", pot_th, do_bg)
		else
			Map:setViewPort(map_x, map_y, map_w, map_h, tw, th, nil, fsize, do_bg)
		end

		-- Show a count for stacked objects
		Map.object_stack_count = true

		if self.level and self.player then
		self.calendar = Calendar.new("/data/calendar.lua", "#GOLD#Today is the %s %s of %s DR. \nThe time is %02d:%02d.", 1371, 1, 11)
 		end

		Map.tiles.use_images = true
		if gfx.tiles == "ascii" then
			Map.tiles.use_images = false
			Map.tiles.force_back_color = {r=0, g=0, b=0, a=255}
			Map.tiles.no_moddable_tiles = true
		elseif gfx.tiles == "ascii_full" then
			Map.tiles.use_images = false
			Map.tiles.no_moddable_tiles = true
		elseif gfx.tiles == "default" then
			Map.tiles.sharp_scaling = true
		elseif gfx.tiles == "customtiles" then
			Map.tiles.no_moddable_tiles = not config.settings.veins.gfx.tiles_custom_moddable
			Map.tiles.nicer_tiles = config.settings.veins.gfx.tiles_custom_adv
		end

		if self.level then
			if self.level.map.finished then
				self.level.map:recreate()
				self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8)
			end
			engine.interface.GameTargeting.init(self)
		end
		self:setupMiniMap()

		self:createFBOs()

--		self:resizeMapViewport(self.w - 216, self.h - 16, 216, 0)

--[[		-- Create the framebuffer
		self.fbo = core.display.newFBO(Map.viewport.width, Map.viewport.height)
		if self.fbo then self.fbo_shader = Shader.new("main_fbo") if not self.fbo_shader.shad then self.fbo = nil self.fbo_shader = nil end end
		if self.player then self.player:updateMainShader() end]]

	end
end

--Grid lines option from git
--[[function _M:createMapGridLines()
	if not config.settings.tome.show_grid_lines then
		Map:setupGridLines(0, 0, 0, 0, 0)
	elseif self.posteffects and self.posteffects.line_grids and self.posteffects.line_grids.shad then
		Map:setupGridLines(6, unpack(colors.hex1alpha"d5990880"))
	else
		Map:setupGridLines(2, unpack(colors.hex1alpha"d5990880"))
	end
	if self.level and self.level.map then self.level.map:regenGridLines() end
end]]


--Taken from ToME
function _M:createFBOs()
	print("[GAME] Creating FBOs")

	-- Create the framebuffer
	self.fbo = core.display.newFBO(Map.viewport.width, Map.viewport.height)
	if self.fbo then
		self.fbo_shader = Shader.new("main_fbo")
	--[[	self.posteffects = {
			wobbling = Shader.new("main_fbo/wobbling"),
			underwater = Shader.new("main_fbo/underwater"),
			motionblur = Shader.new("main_fbo/motionblur"),
			blur = Shader.new("main_fbo/blur"),
		}
		self.posteffects_use = { self.fbo_shader.shad }]]
		if not self.fbo_shader.shad then self.fbo = nil self.fbo_shader = nil end
		self.fbo2 = core.display.newFBO(Map.viewport.width, Map.viewport.height)
	end

	if self.player then self.player:updateMainShader() end

	self.full_fbo = core.display.newFBO(self.w, self.h)
	if self.full_fbo then self.full_fbo_shader = Shader.new("full_fbo") if not self.full_fbo_shader.shad then self.full_fbo = nil self.full_fbo_shader = nil end end

	if self.fbo and self.fbo2
		then core.particles.defineFramebuffer(self.fbo)
	else core.particles.defineFramebuffer(nil) end

--	if self.target then self.target:enableFBORenderer("ui/targetshader.png", "target_fbo") end

--	Map:enableFBORenderer("target_fbo")

--	self.mm_fbo = core.display.newFBO(200, 200)
--	if self.mm_fbo then self.mm_fbo_shader = Shader.new("mm_fbo") if not self.mm_fbo_shader.shad then self.mm_fbo = nil self.mm_fbo_shader = nil end end
end

--Taken from ToME git
function _M:resizeMapViewport(w, h, x, y)
	x = x and math.floor(x) or Map.display_x
	y = y and math.floor(y) or Map.display_y
	w = math.floor(w)
	h = math.floor(h)

	-- convert from older faulty versions
--[[	if game.level.map and rawget(game.level.map, "display_x") == Map.display_x and rawget(game.level.map, "display_y") == Map.display_y then
		game.level.map.display_x, game.level.map.display_y = nil, nil
	end]]

	Map.display_x = x
	Map.display_y = y

	Map.viewport.width = w
	Map.viewport.height = h
	Map.viewport.mwidth = math.floor(w / Map.tile_w)
	Map.viewport.mheight = math.floor(h / Map.tile_h)

	self:createFBOs()

	if self.level then
		self.level.map:makeCMap()
		self.level.map:redisplay()
		if self.player then
			self.player:updateMainShader()
			self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8)
		end
	end
end

function _M:setupMiniMap()
	if self.level and self.level.map and self.level.map.finished then self.uiset:setupMinimap(self.level) end
end

--From ToME 4
--- Sets up a text flyers
function _M:setFlyingText(fl)
	self.flyers = fl
	function self.flyers:add(x, y, duration, xvel, yvel, str, color, bigfont)
		local slowness = 20/10
		return FlyingText.add(fl, x, y, duration*slowness, xvel/slowness, yvel/slowness, str, color, bigfont)
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
	self.time_stamp = os.date("%Y-%m-%d %H:%M:%S")

	self.total_playtime = (self.total_playtime or 0) + (os.time() - (self.last_update or self.real_starttime))
	self.last_update = os.time()

	return class.save(self, self:defaultSavedFields{party=true, time_stamp=true, total_playtime=true, always_target=true, visited_zones=true, }, true)
end

function _M:getSaveDescription()
	return {
		name = self.player.name,
		description = ([[Exploring level %d of %s.
			Last played on %s]]):format(self.level.level, self.zone.name,
			self.time_stamp
			),
	}
end

function _M:getVaultDescription(e)
	return {
		name = ([[%s the %s %s]]):format(e.name, e.descriptor.race, e.descriptor.class),
		descriptors = e.descriptor,

		description = ([[%s %s %s %s. AL %s
STR %s DEX %s CON %s INT %s WIS %s CHA %s LUC %s
Perk: %s
Deity: %s]]):format(
		e.name, e.descriptor.sex, e.descriptor.race, e.descriptor.class, e.descriptor.alignment,
		e:colorHighStats('str'), e:colorHighStats('dex'), e:colorHighStats('con'), e:colorHighStats('int'), e:colorHighStats('wis'), e:colorHighStats('cha'), e:colorHighStats('luc'),
		e.perk,
		e.descriptor.deity
		),
	}
end

function _M:getStore(def)
	return Store.stores_def[def]:clone()
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
	local old_zone = self.zone
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
	--mark zone as visited
	self.visited_zones[self.zone.short_name] = true
	world:seenZone(self.zone.short_name)


	--Actually get the events to work
	self.state:startEvents()

	--Anti stairscum
	if self.level.last_turn and self.turn < self.level.last_turn + 10 then
		self.logPlayer("You may not use the stairs again so soon")
		return
	end

	--From ToME 2 by Zizzo
	local startxy = self.zone.entry_point and self.zone.entry_point(lev, old_lev, old_zone) or nil
  	if startxy then
    	print('[GAME] changeLevel:  moving to zone entry point ('..startxy.x..','..startxy.y..')')
    	self.player:move(startxy.x, startxy.y, true)
  	elseif lev > old_lev then
    	print('[GAME] changeLevel:  moving to level default_up')
    	self.player:move(self.level.default_up.x, self.level.default_up.y, true)
  	else
    	print('[GAME] changeLevel:  moving to level default_down')
    	self.player:move(self.level.default_down.x, self.level.default_down.y, true)
  	end
  	self.level:addEntity(self.player)

  	if self.zone.on_enter then
		self.zone.on_enter(lev, old_lev, zone)
	end

	-- Update the minimap
	self:setupMiniMap()

	-- Tell the map to use path strings to speed up path calculations
	for uid, e in pairs(self.level.entities) do
		if e.getPathString then
			self.level.map:addPathString(e:getPathString())
		end
	end

	--Level feeling
	local player = self.player
	local feeling
	local item_feeling
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
		for i = 0, game.level.map.w - 1 do for j = 0, game.level.map.h - 1 do
        	for z = game.level.map:getObjectTotal(i, j), 1, -1 do
            local e = game.level.map:getObject(i, j, z)

				if e.egoed then magic = 2
				elseif e.egoed and e.greater_ego then magic = 4
				else end

				if magic > max_magic then max_magic = magic
				else end
			end
		end end

		if max_magic > 2 then item_feeling = "You get goosebumps on your skin. A magic item is radiating power."
		elseif max_magic > 4 then item_feeling = "The feeling of power threatens to overwhelm you. A powerful magic item must be nearby."
		else item_feeling = "You get a feeling that there is only junk here."
		end


		if max_cr > player.level + 4 then feeling = "You get the feeling that there is a powerful enemy here."
		elseif max_cr < player.level -4 then feeling = "You feel very confident in your power."
		else feeling = "You walk cautiously, feeling slightly anxious."
		end
	end

	if feeling then self.log("#TEAL#%s", feeling) end
	if item_feeling then self.log("#TEAL#%s", item_feeling) end

	--Bones
	if world.bone_levels and world.bone_levels[game.level.level] then

	local bones = game.zone:makeEntityByName(game.level, "object", "BONES")
	local x, y = rng.range(0, self.level.map.w-1), rng.range(0, self.level.map.h-1)
	local tries = 0
	while (self.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or self.level.map(x, y, Map.OBJECT) or self.level.map.room_map[x][y].special) and tries < 100 do
		x, y = rng.range(0, self.level.map.w-1), rng.range(0, self.level.map.h-1)
		tries = tries + 1
	end
	if tries < 100 then
		self.zone:addEntity(self.level, bones, "object", x, y)
		print("Placed bones", o.name, x, y)
		o:identify(true)
	end

--[[		local x, y = util.findFreeGrid(player.x, player.y, 50, true, {[Map.ACTOR]=true})
		local bones = game.zone:makeEntityByName(game.level, "object", "BONES")
		if not x then return end
		if bones then
			game.zone:addEntity(game.level, bones, "object", x, y)
		end]]

	end

	--Day/night
--	if self.level.data.day_night then self.state:dayNightCycle() end
	self.state:dayNightCycle()

	--Kill off clones automatically
	for loc, tile in ipairs(game.level.map.map) do
		local actor = tile[Map.ACTOR]
		if actor and loc ~= actor.x + actor.y * game.level.map.w then
			local x = loc % game.level.map.w
			local y = math.floor(loc / game.level.map.w)
		--	game.log("#LIGHT_RED#[DEBUG] Removed clone of %d '%s' from tile %d (%d, %d)", actor.uid, actor.name, loc, x, y)
		--	print("[DEBUG] Removed clone of "..actor.uid.." '"..actor.name.."' from tile "..loc.." ("..x..", "..y..")")
			game.level.map:remove(x, y, Map.ACTOR)
		end
	end

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
    --Castler's fix for textbox input
    else
        engine.Game.tick(self)
    end

    if self.creating_player then return true end
    -- When paused (waiting for player input) we return true: this means we wont be called again until an event wakes us
    if self.paused and not savefile_pipe.saving then return true end
end

--Taken from ToME 4
-- Game Log management functions:
-- logVisible to determine if a message should be visible to the player
-- logMessage to add a message to the display
-- delayedLogMessage to queue an actor-specific message for display at the end of the current game tick
-- displayDelayedLogMessages() to display the queued messages (before combat damage messages)
-- delayedLogDamage to queue a combat (damage) message for display at the end of the current game tick
-- displayDelayedLogDamage to display the queued combat messages

-- output a message to the log based on the visibility of an actor to the player
function _M.logSeen(e, style, ...)
	if e and e.player or (not e.dead and e.x and e.y and game.level and game.level.map.seens(e.x, e.y) and game.player:canSee(e)) then game.log(style, ...) end
end

-- determine whether an action between 2 actors should produce a message in the log and if the player
-- can identify them
-- output: src, srcSeen: source display?, identify?
-- tgt, tgtSeen: target display?, identify?
-- output: Visible? and srcSeen (source is identified by the player), tgtSeen(target is identified by the player)
function _M:logVisible(source, target)
	-- target should display if it's the player, an actor in a seen tile, or a non-actor without coordinates
	local tgt = target and (target.player or (target.__is_actor and game.level.map.seens(target.x, target.y)) or (not target.__is_actor and not target.x))
	local tgtSeen = tgt and (target.player or game.player:canSee(target)) or false
	local src, srcSeen = false, false
--	local srcSeen = src and (not source.x or (game.player:canSee(source) and game.player:canSee(target)))
	-- Special cases
	if not source.x then -- special case: unpositioned source uses target parameters (for timed effects on target)
		if tgtSeen then
			src, srcSeen = tgt, tgtSeen
		else
			src, tgt = nil, nil
		end
	else -- source should display if it's the player or an actor in a seen tile, or same as target for non-actors
		src = source.player or (source.__is_actor and game.level.map.seens(source.x, source.y)) or (not source.__is_actor and tgt)
		srcSeen = src and game.player:canSee(source) or false
	end

	return src or tgt or false, srcSeen, tgtSeen
end

-- Generate a message (string) for the log with possible source and target,
-- highlighting the player and taking visibility into account
-- srcSeen, tgtSeen = can player see(identify) the source, target?
-- style text message to display, may contain:
-- #source#|#Source# -> <displayString>..self.name|self.name:capitalize()
-- #target#|#Target# -> target.name|target.name:capitalize()
function _M:logMessage(source, srcSeen, target, tgtSeen, style, ...)
	style = style:format(...)
	local srcname = "something"
	local Dstring
		if source.player then
			srcname = "#fbd578#"..source.name.."#LAST#"
		elseif srcSeen then
			srcname = engine.Entity.check(source, "getName") or source.name or "unknown"
		end
		if srcname ~= "something" then Dstring = source.__is_actor and source.getDisplayString and source:getDisplayString() end
	style = style:gsub("#source#", srcname)
	style = style:gsub("#Source#", (Dstring or "")..srcname:capitalize())
	if target then
		local tgtname = "something"
			if target.player then
				tgtname = "#fbd578#"..target.name.."#LAST#"
			elseif tgtSeen then
				tgtname = engine.Entity.check(target, "getName") or target.name or "unknown"
			end
		style = style:gsub("#target#", tgtname)
		style = style:gsub("#Target#", tgtname:capitalize())
	end
	return style
end

-- log an entity-specific message for display later with displayDelayedLogDamage
-- only one message (processed with logMessage) will be logged for each source and label
-- useful to avoid spamming repeated messages
-- target is optional and is used only to resolve the msg
function _M:delayedLogMessage(source, target, label, msg, ...)
	local visible, srcSeen, tgtSeen = self:logVisible(source, target)
	if visible then
		self.delayed_log_messages[source] = self.delayed_log_messages[source] or {}
		local src = self.delayed_log_messages[source]
		src[label] = self:logMessage(source, srcSeen, target, tgtSeen, msg, ...)
	end
end

-- display the delayed log messages
function _M:displayDelayedLogMessages()
	if not self.uiset or not self.uiset.logdisplay then return end
	for src, msgs in pairs(self.delayed_log_messages) do
		for label, msg in pairs(msgs) do
			game.uiset.logdisplay(self:logMessage(src, true, nil, nil, msg))
		end
	end
	self.delayed_log_messages = {}
end

-- Note: There can be up to a 1 tick delay in displaying log information
function _M:displayDelayedLogDamage()
--	if not self.uiset or not self.uiset.logdisplay then return end
	for src, tgts in pairs(self.delayed_log_damage) do
		for target, dams in pairs(tgts) do
			if #dams.descs > 1 then
				game.uiset.logdisplay(self:logMessage(src, dams.srcSeen, target, dams.tgtSeen, "#Source# hits #Target# for %s (%0.0f total damage)%s.", table.concat(dams.descs, ", "), dams.total, dams.healing<0 and (" #LIGHT_GREEN#[%0.0f healing]#LAST#"):format(-dams.healing) or ""))
			else
				if dams.healing >= 0 then
					game.uiset.logdisplay(self:logMessage(src, dams.srcSeen, target, dams.tgtSeen, "#Source# hits #Target# for %s damage.", table.concat(dams.descs, ", ")))
				elseif src == target then
					game.uiset.logdisplay(self:logMessage(src, dams.srcSeen, target, dams.tgtSeen, "#Source# receives %s.", table.concat(dams.descs, ", ")))
				else
					game.uiset.logdisplay(self:logMessage(src, dams.srcSeen, target, dams.tgtSeen, "#Target# receives %s from #Source#.", table.concat(dams.descs, ", ")))
				end
			end
			local rsrc = src.resolveSource and src:resolveSource() or src
			local rtarget = target.resolveSource and target:resolveSource() or target
			local x, y = target.x or -1, target.y or -1
			local sx, sy = self.level.map:getTileToScreen(x, y)
			if target.dead then
				if dams.tgtSeen and (rsrc == self.player or rtarget == self.player or self.party:hasMember(rsrc) or self.party:hasMember(rtarget)) then
					self.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, rng.float(-2.5, -1.5), ("Kill (%d)!"):format(dams.total), {255,0,255}, true)
					self:delayedLogMessage(target, nil,  "death", self:logMessage(src, dams.srcSeen, target, dams.tgtSeen, "#{bold}##Source# killed #Target#!#{normal}#"))
				end
			elseif dams.total > 0 or dams.healing == 0 then
				if dams.tgtSeen and (rsrc == self.player or self.party:hasMember(rsrc)) then
					self.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, rng.float(-3, -2), tostring(-math.ceil(dams.total)), {0,255,dams.is_crit and 200 or 0}, dams.is_crit)
				elseif dams.tgtSeen and (rtarget == self.player or self.party:hasMember(rtarget)) then
					self.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -rng.float(-3, -2), tostring(-math.ceil(dams.total)), {255,dams.is_crit and 200 or 0,0}, dams.is_crit)
				end
			end
		end
	end
	if self.delayed_death_message then game.log(self.delayed_death_message) end
	self.delayed_death_message = nil
	self.delayed_log_damage = {}
end

-- log and collate combat damage for later display with displayDelayedLogDamage
function _M:delayedLogDamage(src, target, dam, desc, crit)
	if not target or not src then return end
	src = src.__project_source or src -- assign message to indirect damage source if available
	local visible, srcSeen, tgtSeen = self:logVisible(src, target)
	if visible then -- only log damage the player is aware of
		self.delayed_log_damage[src] = self.delayed_log_damage[src] or {}
		self.delayed_log_damage[src][target] = self.delayed_log_damage[src][target] or {total=0, healing=0, descs={}}
		local t = self.delayed_log_damage[src][target]
		t.descs[#t.descs+1] = desc
		if dam>=0 then
			t.total = t.total + dam
		else
			t.healing = t.healing + dam
		end
		t.is_crit = t.is_crit or crit
		t.srcSeen = srcSeen
		t.tgtSeen = tgtSeen
	end
end

--- Called every game turns
-- Does nothing, you can override it
function _M:onTurn()
	--Actually do zone on turn stuff
	if self.zone then
		if self.zone.on_turn then self.zone:on_turn() end
	end

	-- The following happens only every 10 game turns (once for every turn of 1 mod speed actors)
	if self.turn % 10 ~= 0 then return end

	-- Day/Night cycle
--	if self.level.data.day_night then self.state:dayNightCycle() end
	self.state:dayNightCycle()

	-- Process overlay effects
	self.level.map:processEffects()
	--Calendar
	if not self.day_of_year or self.day_of_year ~= self.calendar:getDayOfYear(self.turn) then
		self.log(self.calendar:getTimeDate(self.turn))
		self.day_of_year = self.calendar:getDayOfYear(self.turn)
	end

end

function _M:updateFOV()
	self.player:playerFOV()
end

function _M:displayMap(nb_keyframes)
	-- Now the map, if any
	if self.level and self.level.map and self.level.map.finished then
		local map = self.level.map
		-- Display the map and compute FOV for the player if needed
		local changed = map.changed
		if changed then self:updateFOV() end

		-- Display using Framebuffer, so that we can use shaders and all
		if self.fbo then
			self.fbo:use(true)
				if self.level.data.background then self.level.data.background(self.level, 0, 0, nb_keyframes) end
			--	map:display(0, 0, nb_keyframes, false, self.fbo)
				map:display(0, 0, nb_keyframes, true, self.fbo)
			--	if self.level.data.foreground then self.level.data.foreground(self.level, 0, 0, nb_keyframes) end
			--	if self.level.data.weather_particle then self.state:displayWeather(self.level, self.level.data.weather_particle, nb_keyframes) end
			--	if self.level.data.weather_shader then self.state:displayWeatherShader(self.level, self.level.data.weather_shader, map.display_x, map.display_y, nb_keyframes) end
				map._map:drawSeensTexture(0, 0, nb_keyframes)
			self.fbo:use(false, self.full_fbo)

	--		self.fbo:toScreen(0, 0, self.w, self.h, self.fbo_shader.shad)
		-- NOTE: this sets screen size if/when fbos are in use, not map size
			self.fbo:toScreen(map.display_x, map.display_y, self.w - map.display_x, self.h - map.display_y, self.fbo_shader.shad)


		-- Basic display; no FBOs
		else
			if self.level.data.background then self.level.data.background(self.level, map.display_x, map.display_y, nb_keyframes) end
			--self.level.map:display(nil, nil, nb_keyframes)
			map:display(nil, nil, nb_keyframes, true)
		--[[	if self.level.data.foreground then self.level.data.foreground(self.level, map.display_x, map.display_y, nb_keyframes) end
			if self.level.data.weather_particle then self.state:displayWeather(self.level, self.level.data.weather_particle, nb_keyframes) end
			if self.level.data.weather_shader then self.state:displayWeatherShader(self.level, self.level.data.weather_shader, map.display_x, map.display_y, nb_keyframes) end
		]]--	core.particles.drawAlterings()
			map._map:drawSeensTexture(map.display_x, map.display_y, nb_keyframes)
		end

		-- Handle ambient sounds
	--	if self.level.data.ambient_bg_sounds then self.state:playAmbientSounds(self.level, self.level.data.ambient_bg_sounds, nb_keyframes) end

	--	if not self.zone_name_s then self:updateZoneName() end

		-- Display the targetting system if active
		self.target:display()


		-- emotes display
		map:displayEmotes(nb_keyframe or 1)
	end
end

--- Called when screen resolution changes
function _M:checkResolutionChange(w, h, ow, oh)
	self:createFBOs()

	return self.uiset:handleResolutionChange(w, h, ow, oh)
end

function _M:display(nb_keyframes)

	-- If switching resolution, blank everything but the dialog
	if self.change_res_dialog then engine.GameTurnBased.display(self, nb_keyframes) return end

	-- Reset gamma setting, something somewhere is disrupting it, this is a stop gap solution
	if self.support_shader_gamma and self.full_fbo_shader and self.full_fbo_shader.shad then self.full_fbo_shader.shad:uniGamma(config.settings.gamma_correction / 100) end

	if self.full_fbo then self.full_fbo:use(true) end

	-- Now the ui
	self.uiset:display(nb_keyframes)

	if self.player then self.player.changed = false end

	engine.GameTurnBased.display(self, nb_keyframes)

	-- Tooltip is displayed over all else
	local mx, my, button = core.mouse.get()
	  if self.target and self.target.target and self.target.target.x and self.target.target.y and self.level and self.level.map then
    mx, my = self.level.map:getTileToScreen(self.target.target.x, self.target.target.y)
    --mx, my = self.target.target.x, self.target.target.y
  end


	-- If user wants the tooltip to be on the left or top, move the exception box.
  -- The tooltip will stay in the original positions for now, but will be moved
  -- in engine.Tooltip.displayAtMap() - Marson
  if config.settings.veins.tooltip_location == "Lower-Left" and self.tooltip.w and mx < self.tooltip.w and my > Tooltip:tooltip_bound_y2() - self.tooltip.h and not self.tooltip.locked then
    self:targetDisplayTooltip(Map.display_x, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
  elseif config.settings.veins.tooltip_location == "Upper-Left" and self.tooltip.w and mx < self.tooltip.w and my < Map.display_y + self.tooltip.h and not self.tooltip.locked then
    self:targetDisplayTooltip(Map.display_x, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
  elseif config.settings.veins.tooltip_location == "Upper-Right" and self.tooltip.w and mx > self.w - self.tooltip.w and my < Map.display_y + self.tooltip.h and not self.tooltip.locked then
    self:targetDisplayTooltip(Map.display_x, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
  -- otherwise proceed as normal
  elseif config.settings.veins.tooltip_location == "Lower-Right" and self.tooltip.w and mx > self.w - self.tooltip.w and my > Tooltip:tooltip_bound_y2() - self.tooltip.h and not self.tooltip.locked then
    self:targetDisplayTooltip(Map.display_x, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
  else
    self:targetDisplayTooltip(self.w, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
  end


	if self.tooltip.w and mx > self.w - self.tooltip.w and my > Tooltip:tooltip_bound_y2() - self.tooltip.h and not self.tooltip.locked then
		self:targetDisplayTooltip(Map.display_x, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
	else
		self:targetDisplayTooltip(self.w, self.h, self.old_ctrl_state~=self.ctrl_state, nb_keyframes )
	end

	if self.full_fbo then
		self.full_fbo:use(false)
		self.full_fbo:toScreen(0, 0, self.w, self.h, self.full_fbo_shader.shad)
	end

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

		RUN_AUTO = function()
			local ae = function() if self.level and self.zone then
				local seen = {}
				-- Check for visible monsters.  Only see LOS actors, so telepathy wont prevent it
				core.fov.calc_circle(self.player.x, self.player.y, self.level.map.w, self.level.map.h, self.player.sight or 5,
					function(_, x, y) return self.level.map:opaque(x, y) end,
					function(_, x, y)
						local actor = self.level.map(x, y, self.level.map.ACTOR)
						if actor and actor ~= self.player and self.player:reactionToward(actor) < 0 and
							self.player:canSee(actor) and self.level.map.seens(x, y) then seen[#seen + 1] = {x=x, y=y, actor=actor} end
					end, nil)
				if self.zone.no_autoexplore or self.level.no_autoexplore then
					self.log("You may not auto-explore this level.")
				elseif #seen > 0 then
					local dir = game.level.map:compassDirection(seen[1].x - self.player.x, seen[1].y - self.player.y)
					self.log("You may not auto-explore with enemies in sight (%s to the %s%s)!", seen[1].actor.name, dir, self.level.map:isOnScreen(seen[1].x, seen[1].y) and "" or " - offscreen")
--[[					for _, node in ipairs(seen) do
						node.actor:addParticles(engine.Particles.new("notice_enemy", 1))
					end]]
				elseif not self.player:autoExplore() then
					self.log("There is nowhere left to explore.")
				end
			end end

			ae()
		end,

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
				--Implement min_depth
				local days = math.floor(self.turn / game.calendar.DAY) + (game.calendar.start_day - 1)
				local min_depth = math.max(1, days/3)
				local level = self.level.level
				if level + e.change_level < min_depth then
					game.logPlayer(self.player, "#SANDY_BROWN#You cannot ascend higher.#LAST#")
					level = min_depth
				end
				if rng.percent(75) then
					level = level + e.change_level
					self.player:gainExp(math.floor(level*50))
				else
					level = level + 0.001
					game.logPlayer(self.player, "#SANDY_BROWN#You feel like you have not delved much further.#LAST#")

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
				{ "#GOLD#Help#LAST#", function() self:unregisterDialog(menu) self:registerDialog(require("mod.dialogs.Help").new()) end},
				"keybinds",
				{ "Show Achievements", function() self:unregisterDialog(menu) self:registerDialog(require("engine.dialogs.ShowAchievements").new("Veins of the Earth Achievements", self.player)) end },
				{ "Show known Lore", function() self:unregisterDialog(menu) self:registerDialog(require("mod.dialogs.LoreList").new("Veins of the Earth Lore", self.player)) end },
				"highscores",
				{"Graphic Mode", function() self:unregisterDialog(menu) self:registerDialog(require("mod.dialogs.GraphicMode").new()) end},
				"video",
				{"Game Options", function() self:unregisterDialog(menu) self:registerDialog(require("mod.dialogs.GameOptions").new(false)) end},
				{"#RED#Debug Menu#LAST#", function() self:unregisterDialog(menu) self:registerDialog(require("mod.dialogs.debug.DebugMenu").new()) end},
				"save",
				"quit"
			}
			self:registerDialog(menu)
		end,

		-- Show time
		SHOW_TIME = function()
			self.log(self.calendar:getTimeDate(self.turn))
		end,

		--Auto talents
		--[[
		TOGGLE_AUTOTALENT = function()
			self.player.no_automatic_talents = not self.player.no_automatic_talents
			game.log("#GOLD#Automatic talent usage: %s", not self.player.no_automatic_talents and "#LIGHT_GREEN#enabled" or "#LIGHT_RED#disabled")
		end,]]

		-- Lua console, you probably want to disable it for releases
		LUA_CONSOLE = function()
			if config.settings.cheat then
				self:registerDialog(DebugConsole.new())
			end
		end,

		DEBUG_MODE = function()
			if config.settings.cheat then
				self:registerDialog(require("mod.dialogs.debug.DebugMenu").new())
			end
		end,

		-- Toggle monster list
		TOGGLE_NPC_LIST = function()
			self.show_npc_list = not self.show_npc_list
			self.player.changed = true

			if (self.show_npc_list) then
				self.log("Displaying creatures.")
			else
				self.log("Displaying talents.")
			end
	--		if self.uiset.resizeIconsHotkeysToolbar then self.uiset:resizeIconsHotkeysToolbar() end
		end,

		SCREENSHOT = function() self:saveScreenshot() end,

		TACTICAL_DISPLAY = function()
			if self.always_target == true then
				self.always_target = "health"
				Map:setViewerFaction(nil)
				self.log("Showing healthbars only.")
			elseif self.always_target == nil then
				self.always_target = true
				Map:setViewerFaction("players")
				self.log("Showing healthbars and tactical borders.")
			elseif self.always_target == "health" then
				self.always_target = nil
				Map:setViewerFaction(nil)
				self.log("Showing no tactical information.")
			end
		end,

		LOOK_AROUND = function()
		--	self.flash:empty(true)
			self.log("Looking around... (direction keys to select interesting things, shift+direction keys to move freely)")
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
    			game.logPlayer("Sorry, you do not have a spellbook")
    		end
		end,

		--Helpful stuff
		SHOW_HELP = function()
			self:registerDialog(require("mod.dialogs.Help").new(self.player))
		end,

		SHOW_MESSAGE_LOG = function()
			self:registerDialog(require("mod.dialogs.ShowChatLog").new("Message Log", 0.6, self.uiset.logdisplay, profile.chat))
		end,

		SHOW_CHAT_CHANNELS = function()
		self:registerDialog(require("engine.dialogs.ChatChannels").new(profile.chat))
		--[[
		Chat:showLogDialog("Chat log")]]
		end,

		USERCHAT_TALK = function()
		local Chat = require("mod.class.patch.UserChat")
	--	local Chat = require("engine.UserChat")
			Chat:talkBox()
		end,

		--From Marson's AWOL addon
		MARSON_AWOL = function()
			self:registerDialog(EntityTracker.new())
		end,

		MARSON_CLONE = function()
			for loc, tile in ipairs(game.level.map.map) do
				local actor = tile[Map.ACTOR]
				if actor and loc ~= actor.x + actor.y * game.level.map.w then
					local x = loc % game.level.map.w
					local y = math.floor(loc / game.level.map.w)
					game.log("#LIGHT_RED#[DEBUG] Removed clone of %d '%s' from tile %d (%d, %d)", actor.uid, actor.name, loc, x, y)
					print("[DEBUG] Removed clone of "..actor.uid.." '"..actor.name.."' from tile "..loc.." ("..x..", "..y..")")
					game.level.map:remove(x, y, Map.ACTOR)
				end
			end
		end,

		--More Marson stuff
		MARSON_FLUSH = function()
			io.flush(stderr)
		end,



	}
	engine.interface.PlayerHotkeys:bindAllHotkeys(self.key, function(i) self.player:activateHotkey(i) end)

    self.key:setCurrent()
    self.key:bindKeys()
end

function _M:setupMouse(reset)
	if reset == nil or reset then self.mouse:reset() end

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
--[[	self.mouse:registerZone(self.logdisplay.display_x, self.logdisplay.display_y, self.w, self.h, function(button)
		if button == "wheelup" then self.logdisplay:scrollUp(1) end
		if button == "wheeldown" then self.logdisplay:scrollUp(-1) end
	end, {button=true})]]
	-- Use hotkeys with mouse
--[[	self.mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, self.w, self.h, function(button, mx, my, xrel, yrel, bx, by, event)
		self.hotkeys_display:onMouse(button, mx, my, event == "button", function(text) self.tooltip:displayAtMap(nil, nil, self.w, self.h, tostring(text)) end)
	end)]]

	self.uiset:setupMouse(self.mouse)

	if not reset then self.mouse:setCurrent() end
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

--From ToME 4
function _M:playSoundNear(who, name)
	if who and (not who.attr or not who:attr("_forbid_sounds")) and self.level and self.level.map.seens(who.x, who.y) then
		local pos = {x=0,y=0,z=0}
		if self.player and self.player.x then pos.x, pos.y = who.x - self.player.x, who.y - self.player.y end
		self:playSound(name, pos)
	end
end


--Based on ToME 4
--- Create a random lore object and place it close to entrance
function _M:placeRandomLoreObject(define)
	if type(define) == "table" then define = rng.table(define) end
	local o = self.zone:makeEntityByName(self.level, "object", define)
	if not o then return end
	if o.checkFilter and not o:checkFilter({}) then return end

	local x, y = util.findFreeGrid(self.level.default_up.x, self.level.default_up.y, 5, true, {[Map.OBJECT]=true})

	self.zone:addEntity(self.level, o, "object", x, y)
	print("Placed lore", o.name, x, y)
	o:identify(true)
end

--Taken from ToME 4
--Create a random lore object in a set distance
function _M:placeRandomLoreObjectScale(base, nb, level)
	local dist = ({
		[5] = { {1}, {2,3}, {4,5} }, -- 5 => 3
		[7] = { {1,2}, {3,4}, {5,6}, {7} }, -- 7 => 4
	})[nb][level]
	if not dist then return end
	for _, i in ipairs(dist) do self:placeRandomLoreObject(base..i) end
end

--Create a random lore object anywhere in map
function _M:placeRandomLoreObjectonMap(define)
	if type(define) == "table" then define = rng.table(define) end
	local o = self.zone:makeEntityByName(self.level, "object", define)
	if not o then return end
	if o.checkFilter and not o:checkFilter({}) then return end

	local x, y = rng.range(0, self.level.map.w-1), rng.range(0, self.level.map.h-1)

		local tries = 0
	while (self.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or self.level.map(x, y, Map.OBJECT) or self.level.map.room_map[x][y].special) and tries < 100 do
		x, y = rng.range(0, self.level.map.w-1), rng.range(0, self.level.map.h-1)
		tries = tries + 1
	end
	if tries < 100 then
		self.zone:addEntity(self.level, o, "object", x, y)
		print("Placed lore", o.name, x, y)
		o:identify(true)
	end

end

function _M:placeDungeonEntrance(define)
	if type(define) == "table" then define = rng.table(define) end
	local l = self.zone:makeEntityByName(self.level, "terrain", define)
	if not l then
		print("Dungeon entrance not found", l.change_zone)
		return end

	local x, y = rng.range(2, self.level.map.w-2), rng.range(2, self.level.map.h-2)

	local tries = 0
	while (self.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or self.level.map(x, y, Map.OBJECT) or self.level.map.room_map[x][y].special) and tries < 100 do
		x, y = rng.range(2, self.level.map.w-2), rng.range(2, self.level.map.h-2)
		tries = tries + 1
	end
	if tries < 100 then
		self.zone:addEntity(self.level, l, "terrain", x, y)
		self.level.spots[#self.level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="zone-change", subtype=l.spot}
		print("Placed dungeon entrance", l.change_zone, x, y)
	else
		self.level.force_recreate = true
	end
end

function _M:placeTerrainMulti(define, n)
	while n > 0 do
		self:placeTerrain(define)
		n = n - 1
	end
end


function _M:placeTerrain(define)
	if type(define) == "table" then define = rng.table(define) end
	local l = self.zone:makeEntityByName(self.level, "terrain", define)

	if not l then return end

	local x, y = rng.range(0, self.level.map.w-1), rng.range(0, self.level.map.h-1)

	local tries = 0
	while (self.level.map:checkEntity(x, y, Map.TERRAIN, "block_move") or self.level.map(x, y, Map.OBJECT) or self.level.map.room_map[x][y].special) and tries < 100 do
		x, y = rng.range(0, self.level.map.w-1), rng.range(0, self.level.map.h-1)
		tries = tries + 1
	end
	if tries < 100 then
		self.zone:addEntity(self.level, l, "terrain", x, y)
	end
end
