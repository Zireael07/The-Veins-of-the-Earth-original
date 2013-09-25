--Veins of the Earth
--Zireael

require "engine.class"
local Dialog = require "engine.ui.Dialog"
local List = require "engine.ui.List"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(talent)
	self.talent = talent
	self.player = game.player
	self:generateList()

	Dialog.init(self, "Weapon Types", 300, 20)

	self.c_list = List.new{width=self.iw, nb_items=#self.list, list=self.list, fct=function(item) self:use(item) end}

	self:loadUI{
		{left=0, top=0, ui=self.c_list},
	}
	self:setFocus(self.c_list)
	self:setupUI(false, true)

	self.key:addBinds{
		EXIT = function() game:unregisterDialog(self) end,
	}
end

function _M:use(item)
	if self.talent then 
		self.talent.choice = item.name 
		self.player.weapon_type = item.name end
	game:unregisterDialog(self)
	
end

function _M:generateList()
	local list = { {name="axe"}, {name="battleaxe"}, {name="bow"}, {name="club"}, {name="crossbow"}, {name="dagger"}, {name="falchion"}, {name="flail"}, {name="halberd"}, {name="hammer"}, {name="handaxe"}, {name="javelin"}, {name="kukri"}, {name="mace"}, {name="morningstar"}, {name="rapier"}, {name="scimitar"}, {name="scythe"}, {name="shortsword"}, {name="sling"}, {name="spear"}, {name="staff"}, {name="sword"}, {name="trident"} }
	self.list = list
end