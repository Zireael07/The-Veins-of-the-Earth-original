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

	Dialog.init(self, "Favored Enemy", game.w*0.2, game.h*0.5)

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
		self.player.favored_enemy = item.name
	end
	game:unregisterDialog(self)
	
end

function _M:generateList()
	local list = { {name="aberration"}, {name="animal"}, {name="humanoid_drow"}, {name="humanoid_elf"}, {name="humanoid_goblin"}, {name="humanoid_human"}, {name="humanoid_kobold"}, {name="planetouched"}, {name="humanoid_orc"}, {name="magical beast"}, {name="vermin"}, }
	self.list = list
end