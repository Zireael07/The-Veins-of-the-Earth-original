-- Veins of the Earth
-- Zireael 2014-2015
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

--Code taken from ToME 4

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"
local Button = require "engine.ui.Button"
local Checkbox = require "engine.ui.Checkbox"
local Textzone = require "engine.ui.Textzone"
local Textbox = require "engine.ui.Textbox"
local GetQuantity = require "engine.dialogs.GetQuantity"
local Map = require "engine.Map"

module(..., package.seeall, class.inherit(Dialog))

tiles_packs = {
	default = {name= "Modern", order=1},
	ascii_full = {name= "ASCII with background", order=2},
--	ascii = {name= "ASCII", order=3},
	customtiles = {name= "Custom Tileset", order=3},
}

function _M:init()
	self.cur_sel = "main"
	self:generateList()
	self.changed = false

	Dialog.init(self, "Change graphic mode", 300, 20)

	self.c_list = List.new{width=self.iw, nb_items=4, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBinds{
		EXIT = function()
			if self.changed then game:setupDisplayMode(true) end
			game:unregisterDialog(self)
		end,
	}
end

function _M:doCustomTiles()
	local d = Dialog.new("Custom Tileset", 100, 100)

	local help = Textzone.new{width=500, auto_height=true, text=[[You can configure the game to use a custom tileset.
You must place all files of your tileset in a subfolder of the modules's data/gfx/ folder, just like the existing tilesets.
Each tile must be correctly named according to the existing tilesets.]]}
	local dir = Textbox.new{title="Folder: ", text="", chars=30, max_len=50, fct=function() end}
	local moddable_tiles = Checkbox.new{title="Use moddable tiles (equipment showing on player)", default=false, fct=function() end }
	local adv_tiles = Checkbox.new{title="Use advanced tiles (transitions, wide tiles, ...)", default=false, fct=function() end }
	local ok = Button.new{text="Use custom tileset", fct=function()
		config.settings.veins.gfx.tiles = "customtiles"
		config.settings.veins.gfx.tiles_custom_dir = dir.text
		config.settings.veins.gfx.tiles_custom_moddable = moddable_tiles.checked
		config.settings.veins.gfx.tiles_custom_adv = adv_tiles.checked
		self.changed = true
		self:use{change_sel = "main"}
		game:unregisterDialog(d)
	end}
	local cancel = Button.new{text="Cancel", fct=function() game:unregisterDialog(d) end}

	d:loadUI{
		{left=0, top=0, ui=help},
		{left=0, top=help.h, ui=dir},
		{left=0, top=help.h+dir.h, ui=moddable_tiles},
		{left=0, top=help.h+dir.h+moddable_tiles.h, ui=adv_tiles},
		{left=0, bottom=0, ui=ok},
		{right=0, bottom=0, ui=cancel},
	}
	d:setFocus(dir)
	d:setupUI(true, true)

	game:registerDialog(d)
end

function _M:use(item)
	if not item then return end

	if item.sub and item.val then
		if item.val == "customsize" then
			game:registerDialog(GetQuantity.new("Tile size", "From 10 to 128", Map.tile_w or 64, 128, function(qty)
				qty = math.floor(util.bound(qty, 10, 128))
				self:use{name=qty.."x"..qty, sub=item.sub, val=qty.."x"..qty}
			end, 10))
		elseif item.val == "customtiles" then
			self:doCustomTiles()
		else
			config.settings.veins.gfx[item.sub] = item.val
			self.changed = true
			item.change_sel = "main"
		end
	end

	if item.change_sel then
		self.cur_sel = item.change_sel
		self:generateList()
		self.c_list.list = self.list
		self.c_list:generate()
	end
end

function _M:generateList()
	local list

	if self.cur_sel == "main" then
		local cur = tiles_packs[config.settings.veins.gfx.tiles]
		list = {
			{name="Select style [current: "..(cur and cur.name or "???").."]", change_sel="tiles"},
			{name="Select tiles size [current: "..config.settings.veins.gfx.size.."]", change_sel="size"},
		}
	elseif self.cur_sel == "tiles" then
		list = {}
		for s, n in pairs(tiles_packs) do
			list[#list+1] = {name=n.name, order=n.order, sub="tiles", val=s}
		end
		table.sort(list, function(a, b) return a.order < b.order end)
	elseif self.cur_sel == "size" then
		list = {
			{name="64x64", sub="size", val="64x64"},
			{name="48x48", sub="size", val="48x48"},
			{name="32x32", sub="size", val="32x32"},
			{name="16x16", sub="size", val="16x16"},
			{name="Custom", sub="size", val="customsize"},
		}
	end

	self.list = list
end
