--Integrate most of Marson's UI mod
--[[package.loaded['engine.ui.Base'] = nil
package.loaded['engine.ui.Dialog'] = nil
package.loaded['engine.Dialog'] = nil
--package.loaded['engine.UserChat'] = nil
package.loaded['engine.dialogs.Talkbox'] = nil]]


local Base = require "engine.ui.Base"
local Textzone = require "engine.ui.Textzone"
local FontList = require "mod.class.patch.FontList"
local Separator = require "engine.ui.Separator"

local Mouse = require "engine.Mouse"
local Slider = require "engine.ui.Slider"
	veins = veins or {}

	--Helper functions
	veins.parseTable = function (root, key, value)
		if type(value) == "table" then
			assert(loadstring("veins.lines[#veins.lines+1] = '"..root..key.." = {}'"))()
			assert(loadstring("for k2,v2 in next, config.settings."..root..key.." do veins.parseTable('"..root..key..".', k2, v2) end"))()
		elseif type(key) ~= "nil" then
			assert(loadstring("veins.setting_type = ({number='s', boolean='s', string='q'})[type(config.settings."..root..key..")] or 'q'"))()
			assert(loadstring("veins.lines[#veins.lines+1] = ('"..root..key.." = %"..veins.setting_type.."'):format(config.settings."..root..key..")"))()
		end
	end
	veins.saveMarson = function()
		veins.lines = {"veins = {}"}
		for k,v in next, config.settings.veins do
			veins.parseTable("veins.", k, v)
		end
		game:saveSettings("veins", table.concat(veins.lines, "\n"))
		veins.fonts.assign()
	end

	if type(config.settings.veins.tooltip_location) == "nil" or config.settings.veins.tooltip_location == "Lower-right" then
		config.settings.veins.tooltip_location = "Lower-Right"
  end
	if type(config.settings.veins.inventory_tooltip) == "nil" then
		config.settings.veins.inventory_tooltip = "Original"
	end
	if type(config.settings.veins.play_ambient_sounds) == "nil" then
		config.settings.veins.play_ambient_sounds = true
	end
	if type(config.settings.veins.dialog_alpha) ~= "number" then
		config.settings.veins.dialog_alpha = 1
	end
	if type(config.settings.veins.tooltip_alpha) ~= "number" then
		config.settings.veins.tooltip_alpha = 0.75
	end
	if type(config.settings.veins.explore_behavior) == "nil" then
		config.settings.veins.explore_behavior = "Original"
	end

	config.settings.veins.fonts = config.settings.veins.fonts or {}
	veins.fonts = {}
	veins.fonts.available_list = {
		-- ToME fonts
		DroidSans = {name="Droid Sans", file="DroidSans", tome=true},
		DroidSansMono = {name="Droid Sans Mono", file="DroidSansMono", tome=true, mono=true},
		DroidSerif = {name="Droid Serif", file="DroidSerif", tome=true},
		square = {name="Square", file="square", tome=true, mono=true},
		Vera = {name="Bitstream Vera Sans", file="Vera", tome=true},
		VeraMono = {name="Bitstream Vera Sans Mono", file="VeraMono", tome=true, mono=true},
	--	Insula = {name="Insula", file="INSULA__", tome=true},
	--	SVBasicManual = {name="SV Basic Manual", file="SVBasicManual", tome=true},
	--	Usenet = {name="Usenet", file="USENET_", tome=true},
		-- Added fonts
		Augusta = {name="Augusta", file="Augusta"},
		Blkchcry = {name="Black Chancery", file="Blkchcry"},
		CutiveMono = {name="Cutive Mono", file="CutiveMono-Regular", mono=true},
		dum1 = {name="Dumbledor 1", file="dum1"},
		dum1thin = {name="Dumbledor 1 Thin", file="dum1thin"},
		dum1wide = {name="Dumbledor 1 Wide", file="dum1wide"},
		EagleLake = {name="Eagle Lake", file="EagleLake-Regular"},
		FantasqueSansMono = {name="Fantasque Sans Mono", file="FantasqueSansMono-Regular", mono=true},
		Grange = {name="Grange", file="Grange"},
		HamletOrNot = {name="Hamlet Or Not", file="HamletOrNot"},
		Immortal = {name="Immortal", file="IMMORTAL"},
		LiberationMono = {name="Liberation Mono", file="LiberationMono-Regular", mono=true},
		Monofonto = {name="Monofonto", file="MONOFONT", mono=true},
		Monofur = {name="Monofur", file="monofur55", mono=true},
		Nosfer = {name="Nosfer", file="Nosfer"},
		NotCourierSans = {name="Not Courier Sans", file="NotCourierSans", mono=true},
		NovaMono = {name="Nova Mono", file="NovaMono", mono=true},
		OxygenMono = {name="Oxygen Mono", file="OxygenMono-Regular", mono=true},
		PTM55FT = {name="PT Mono", file="PTM55FT", mono=true},
		SaintAndrewsQueen = {name="Saint-Andrews Queen", file="SaintAndrewsQueen"},
		Tangerine = {name="Tangerine Regular", file="Tangerine_Regular"},
		--Veins font
		DroidSansFallback = {name="Droid Sans Fallback", file="DroidSansFallback"},
		Symbola = {name="Symbola", file="Symbola"},
	}

	veins.fonts.assign = function()
		veins.fonts.dialog = {}
		veins.fonts.dialog.key = config.settings.veins.fonts.dialogstyle or "DroidSansFallback"
		veins.fonts.dialog.size = config.settings.veins.fonts.dialogsize or 14

		veins.fonts.hud = {}
		veins.fonts.hud.key = config.settings.veins.fonts.hudstyle or
			veins.fonts.dialog.key
		veins.fonts.hud.size = config.settings.veins.fonts.hudsize or
			veins.fonts.dialog.size

		veins.fonts.tooltip = {}
		veins.fonts.tooltip.key = config.settings.veins.fonts.tooltipstyle or "VeraMono"
		veins.fonts.tooltip.size = config.settings.veins.fonts.tooltipsize or
			veins.fonts.dialog.size

		veins.fonts.chat = {}
		veins.fonts.chat.key = config.settings.veins.fonts.chatstyle or
			veins.fonts.dialog.key
		veins.fonts.chat.size = config.settings.veins.fonts.chatsize or
			veins.fonts.dialog.size

		veins.fonts.flying = {}
		veins.fonts.flying.key = config.settings.veins.fonts.flyingstyle or
			veins.fonts.dialog.key
		veins.fonts.flying.size = config.settings.veins.fonts.flyingsize or
			veins.fonts.dialog.size

		veins.fonts.lore = {}
		veins.fonts.lore.key = config.settings.veins.fonts.lorestyle or
			veins.fonts.dialog.key
		veins.fonts.lore.size = config.settings.veins.fonts.loresize or
			veins.fonts.dialog.size

		veins.fonts.dialog.style = "/data/font/"..veins.fonts.available_list[veins.fonts.dialog.key].file..".ttf"
		veins.fonts.hud.style = "/data/font/"..veins.fonts.available_list[veins.fonts.hud.key].file..".ttf"
		veins.fonts.tooltip.style = "/data/font/"..veins.fonts.available_list[veins.fonts.tooltip.key].file..".ttf"
		veins.fonts.chat.style = "/data/font/"..veins.fonts.available_list[veins.fonts.chat.key].file..".ttf"
		veins.fonts.flying.style = "/data/font/"..veins.fonts.available_list[veins.fonts.flying.key].file..".ttf"
		veins.fonts.lore.style = "/data/font/"..veins.fonts.available_list[veins.fonts.lore.key].file..".ttf"

    veins.fonts.hud.font = core.display.newFont(veins.fonts.hud.style, veins.fonts.hud.size, true)
    veins.fonts.hud.h = veins.fonts.hud.font:lineSkip()
    veins.fonts.chat.font = core.display.newFont(veins.fonts.chat.style, veins.fonts.chat.size, true)
    veins.fonts.chat.h = veins.fonts.chat.font:lineSkip()
		veins.fonts.lore.font = core.display.newFont(veins.fonts.lore.style, veins.fonts.lore.size, true)

		Base.font = core.display.newFont(veins.fonts.dialog.style, veins.fonts.dialog.size, true)
		Base.font_h = Base.font:lineSkip()
		Base.font_bold = core.display.newFont(veins.fonts.dialog.style, veins.fonts.dialog.size, true)
		Base.font_bold:setStyle("bold")
		Base.font_bold_h = Base.font_bold:lineSkip()
		Base.font_mono = core.display.newFont(veins.fonts.tooltip.style, veins.fonts.tooltip.size, true)
		Base.font_mono_w = Base.font_mono:size(" ")
		Base.font_mono_h = Base.font_mono:lineSkip()+2

		veins.dialog_scale = veins.fonts.dialog.size / 14
		Base.ui_conf.metal.title_bar.h = 32
	end

	veins.fonts.assign()
--end)

--New functions
-- Added for font selection feature
function engine.ui.Dialog:fontSelect(rawlist, fct)
	local w = game.w * 0.5
	local h = game.h * 0.7
	local list_w = 0
	local desc_w
	local text = "."
    local list = {}
    for k, v in pairs(assert(rawlist, "no list list")) do
		v.key = k
		table.insert(list, v)
	end
    table.sort(list, function(x,y) return x.name < y.name end)

	local d = engine.ui.Dialog.new("Available Fonts", 1, 1)
	local l = FontList.new{width=(w/4)-3, height=h-16, list=list, fct=function() d.key:triggerVirtual("ACCEPT") end}
	local vsep = Separator.new{dir="horizontal", size=h-6}
	local desc = Textzone.new{width=(w/4*3)-vsep.w-3, auto_height=true, text=text, scrollbar=true}
	d:loadUI{
		{left = 3, top = 3, ui=l},
		{left = 400, top = 3, ui=vsep},
		{left = 400+vsep.w, top = 3, ui=desc},
	}
	d.key:addBind("EXIT", function() game:unregisterDialog(d) if fct then fct() end end)
	d.key:addBind("ACCEPT", function() game:unregisterDialog(d) if list[l.sel].fct then list[l.sel].fct(list[l.sel]) return end if fct then fct(list[l.sel]) end end)
	d:setFocus(l)
	d:setupUI(true, true)
	game:registerDialog(d)
	return d
end

-- golden urn soiled
-- grandfather desecrated
-- by a confused cat

function engine.UserChat:resize(x, y, w, h, fontname, fontsize, color, bgcolor)
	self.color = color or {255,255,255}
	if type(bgcolor) ~= "string" then
		self.bgcolor = bgcolor or {0,0,0}
	else
		self.bgcolor = {0,0,0}
		self.bg_image = bgcolor
	end
	self.font = veins.fonts.chat.font
	self.font_h = self.font:lineSkip()

	self.scroll = 0
	self.changed = true

	self.frame_sel = self:makeFrame("ui/selector-sel", 1, 5 + self.font_h)
	self.frame = self:makeFrame("ui/selector", 1, 5 + self.font_h)

	self.display_x, self.display_y = math.floor(x), math.floor(y)
	self.w, self.h = math.floor(w), math.floor(h)
	self.fw, self.fh = self.w - 4, self.font:lineSkip()
	self.max_display = math.floor(self.h / self.fh)

	if self.bg_image then
		local fill = core.display.loadImage(self.bg_image)
		local fw, fh = fill:getSize()
		self.bg_surface = core.display.newSurface(w, h)
		self.bg_surface:erase(0, 0, 0)
		for i = 0, w, fw do for j = 0, h, fh do
			self.bg_surface:merge(fill, i, j)
		end end
		self.bg_texture, self.bg_texture_w, self.bg_texture_h = self.bg_surface:glTexture()
	end

	self.scrollbar = Slider.new{size=self.h - 20, max=1, inverse=true}

	self.mouse = Mouse.new()
	self.mouse.delegate_offset_x = self.display_x
	self.mouse.delegate_offset_y = self.display_y
	self.mouse:registerZone(0, 0, self.w, self.h, function(button, x, y, xrel, yrel, bx, by, event) self:mouseEvent(button, x, y, xrel, yrel, bx, by, event) end)

	self.last_chan_update = 0
end
