--Taken from ToME
-- TE4 - T-Engine 4
-- Copyright (C) 2009 - 2014 Nicolas Casalini
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
local Dialog = require "engine.ui.Dialog"
local Inventory = require "engine.ui.Inventory"
local Separator = require "engine.ui.Separator"
local Map = require "engine.Map"
local Button = require "engine.ui.Button"
local Textzone = require "engine.ui.Textzone"

--local Store = require "mod.class.Store"

module(..., package.seeall, class.inherit(Dialog))

function _M:init(title, store_inven, actor_inven, store_filter, actor_filter, action, desc, descprice, allow_sell, allow_buy, on_select, store_actor, actor_actor)
	self.on_select = on_select
	self.allow_sell, self.allow_buy = allow_sell, allow_buy
	self.action = action
	self.desc = desc
	self.descprice = descprice
	self.store_inven = store_inven
	self.actor_inven = actor_inven
	self.store_filter = store_filter
	self.actor_filter = actor_filter
	self.actor_actor = actor_actor
	self.base_title = title or "Store"
	Dialog.init(self, self:getStoreTitle(), game.w * 0.8, game.h * 0.8)

	if store_actor.faction then
		local i = Map.tiles:loadImage("faction/"..store_actor.faction..".png")
		if i then  self.faction_image = {i:glTexture()} end
	end

	self.c_inven = Inventory.new{actor=actor_actor, inven=actor_inven, filter=actor_filter, width=math.floor(self.iw / 2 - 10), height=self.ih - 10,
		columns={
			{name="", width={20,"fixed"}, display_prop="char", sort="id"},
			{name="", width={24,"fixed"}, display_prop="object", direct_draw=function(item, x, y) item.object:toScreen(nil, x+4, y, 16, 16) end},
			{name="Inventory", width=80, display_prop="name", sort="name"},
			{name="Category", width=20, display_prop="cat", sort="cat"},
			{name="Price", width={70,"fixed"}, display_prop=function(item) return self.descprice("sell", item.object) end, sort=function(a, b) return descprice("sell", a.object) < descprice("sell", b.object) end},
		},
		fct=function(item, sel, button, event) self:use(item, button, event) end,
		select=function(item, sel) self:select(item) end,
		select_tab=function(item) self:select(item) end,
		on_drag=function(item) self:onDrag(item, "store-sell") end,
		on_drag_end=function() self:onDragTakeoff("store-buy") end,
	}

	local direct_draw= function(item, x, y, w, h, total_w, total_h, loffset_x, loffset_y, dest_area)
		-- if there is object and is withing visible bounds
		if core.display.FBOActive() and item.object and total_h + h > loffset_y and total_h < loffset_y + dest_area.h then
			local clip_y_start, clip_y_end = 0, 0
			-- if it started before visible area then compute its top clip
			if total_h < loffset_y then
				clip_y_start = loffset_y - total_h
			end
			-- if it ended after visible area then compute its bottom clip
			if total_h + h > loffset_y + dest_area.h then
			   clip_y_end = total_h + h - loffset_y - dest_area.h
			end
			-- get entity texture with everything it has i.e particles
			local texture = item.object:getEntityFinalTexture(nil, h, h)
			local one_by_tex_h = 1 / h
			texture:toScreenPrecise(x, y, h, h - clip_y_start - clip_y_end, 0, 1, clip_y_start * one_by_tex_h, (h - clip_y_end) * one_by_tex_h)
			return h, h, 0, 0, clip_y_start, clip_y_end
		end
		return 0, 0, 0, 0, 0, 0
	end

	self.c_store = Inventory.new{actor=store_actor, inven=store_inven, filter=store_filter, width=math.floor(self.iw / 2 - 10), height=self.ih - 10, tabslist=false,
		columns={
			{name="", width={20,"fixed"}, display_prop="char", sort="id"},
			{name="", width={24,"fixed"}, display_prop="object", direct_draw=direct_draw},
			{name="Store", width=80, display_prop="name"},
			{name="Category", width=20, display_prop="cat"},
			{name="Price", width={70,"fixed"}, display_prop=function(item) return self.descprice("buy", item.object) end, sort=function(a, b) return descprice("buy", a.object) < descprice("buy", b.object) end},
		},
		fct=function(item, sel, button, event) self:use(item, button, event) end,
		select=function(item, sel) self:select(item) end,
		on_drag=function(item) self:onDrag(item, "store-buy") end,
		on_drag_end=function() self:onDragTakeoff("store-sell") end,
	}

	self.c_buy = Button.new{text="Buy/Sell", fct=function() self:onBuy() end}

	self.c_buy_total = Textzone.new{width=self.iw/5, auto_height=true, text = "Total to buy: #GOLD#"..(self.total_buy or 0) }
	self.c_sell_total = Textzone.new{width=self.iw/5, auto_height=true, text = "Total to sell: #GOLD#"..(self.total_sell or 0) }

	self:loadUI{
		{left=0, top=0, ui=self.c_store},
		{right=0, top=0, ui=self.c_inven},
		{hcenter=0, top=5, ui=Separator.new{dir="horizontal", size=self.ih - 50}},
	--	{bottom=0, left=(self.iw/2)-5, ui=self.c_buy},
		{bottom=self.c_buy.h + 10, ui=Separator.new{dir="vertical", size=self.iw - 10}},
	--	{left=0, bottom=0, ui=self.c_buy_total},
	--	{right=0, bottom=0, ui=self.c_sell_total},
		
	}

	self.c_inven.c_inven.on_focus_change = function(ui_self, status) if status == true then self:select(ui_self.list[ui_self.sel]) end end
	self.c_store.c_inven.on_focus_change = function(ui_self, status) if status == true then self:select(ui_self.list[ui_self.sel]) end end

	self:setFocus(self.c_inven)
	self:setupUI()

	self.key:addCommands{
		__TEXTINPUT = function(c)
			if self.focus_ui and self.focus_ui.ui == self.c_store then
				self.c_store:keyTrigger(c)
			elseif self.focus_ui and self.focus_ui.ui == self.c_inven then
				self.c_inven:keyTrigger(c)
			end
		end,
	}
	self.key:addCommands{
		[{"_TAB","shift"}] = function() self:moveFocus(1) end,
	}
	self.key:addBinds{
		EXIT = function()
			if self.c_inven.c_inven.scrollbar then
				self.actor_actor.inv_scroll = self.c_inven.c_inven.scrollbar.pos or 0
			end
			if self.c_store.c_inven.scrollbar then
				self.actor_actor.store_scroll = self.c_store.c_inven.scrollbar.pos or 0
			end
			game:unregisterDialog(self)
		end,
	}

	-- Add tooltips
	self.on_select = function(item)
		if item.last_display_x and item.object then
			local x = nil
			if self.focus_ui and self.focus_ui.ui == self.c_store then
				x = self.c_store._last_ox + self.c_store.w
			elseif self.focus_ui and self.focus_ui.ui == self.c_inven then
				x = self.c_inven._last_ox - game.tooltip.max
			end

			game:tooltipDisplayAtMap(x or item.last_display_x, item.last_display_y, item.object:getDesc({do_color=true}, game.player:getInven(item.object:wornInven())))
		elseif item.last_display_x and item.data and item.data.desc then
			game:tooltipDisplayAtMap(item.last_display_x, item.last_display_y, item.data.desc, {up=true})
		end
	end


	self.key.any_key = function(sym)
		-- Control resets the tooltip
		if sym == self.key._LCTRL or sym == self.key._RCTRL then 
			local ctrl = core.key.modState("ctrl")
			if self.prev_ctrl ~= ctrl then self:select(self.cur_item, true) end
			self.prev_ctrl = ctrl
		end
	end
	if self.actor_actor.inv_scroll and self.c_inven.c_inven.scrollbar then
		self.c_inven.c_inven.scrollbar.pos = util.bound(self.actor_actor.inv_scroll, 0, self.c_inven.c_inven.scrollbar.max or 0)
	end
	if self.actor_actor.store_scroll and self.c_store.c_inven.scrollbar then
		self.c_store.c_inven.scrollbar.pos = util.bound(self.actor_actor.store_scroll, 0, self.c_store.c_inven.scrollbar.max or 0)
	end

	self.c_store.special_bg = function(item)
	if item.barter then
		 return colors.LIGHT_RED
    end
	end
end

function _M:on_register()
	game:onTickEnd(function() self.key:unicodeInput(true) end)
end

function _M:getStoreTitle()
	return self.base_title..(" (Gold available: %0.2f)"):format(self.actor_actor.money)
end

function _M:updateStore()
	self.c_store.special_bg = function(item)
	if item.barter then
		 return colors.LIGHT_RED
    end
	end


	self:generateList()
	self:updateTitle(self:getStoreTitle())
	if self.actor_actor.inv_scroll and self.c_inven.c_inven.scrollbar then
		self.c_inven.c_inven.scrollbar.pos = util.bound(self.actor_actor.inv_scroll, 0, self.c_inven.c_inven.scrollbar.max or 0)
	end
	if self.actor_actor.store_scroll and self.c_store.c_inven.scrollbar then
		self.c_store.c_inven.scrollbar.pos = util.bound(self.actor_actor.store_scroll, 0, self.c_store.c_inven.scrollbar.max or 0)
	end
end

function _M:select(item, force)
	if self.cur_item == item and not force then return end
	if item then if self.on_select then self.on_select(item) end end
	self.cur_item = item
end

function _M:use(item, force)
	self.actor_actor.inv_scroll = self.c_inven.c_inven.scrollbar and self.c_inven.c_inven.scrollbar.pos or 0
	self.actor_actor.store_scroll = self.c_store.c_inven.scrollbar and self.c_store.c_inven.scrollbar.pos or 0
	if item and item.object then
		if self.focus_ui and self.focus_ui.ui == self.c_store then
		--[[		item.barter = true
				self:addtoBarterBuy(item, item.item)]]
			if util.getval(self.allow_buy, item.object, item.item) then
				self.action("buy", item.object, item.item)
			end
		else
		--[[		item.barter = true
				self:addtoBarterSell(item, item.item)]]
			if util.getval(self.allow_sell, item.object, item.item) then
				self.action("sell", item.object, item.item)
			end
		end
	end
end

function _M:generateList()
	self.c_store.special_bg = function(item)
	if item.barter then
		 return colors.LIGHT_RED
    end
	end 

	self.c_inven:generateList()
	self.c_store:generateList()
end

function _M:onDrag(item, what)
	if item and item.object then
		local s = item.object:getEntityFinalSurface(nil, 64, 64)
		local x, y = core.mouse.get()
		game.mouse:startDrag(x, y, s, {kind=what, item_idx=item.item, inven=item.inven, object=item.object, id=item.object:getName{no_add_name=true, force_id=true, no_count=true}}, function(drag, used)
			if not used then
				local x, y = core.mouse.get()
				game.mouse:receiveMouse("drag-end", x, y, true, nil, {drag=drag})
			end
		end)
	end
end

function _M:onDragTakeoff(what)
	local drag = game.mouse.dragged.payload
	if drag.kind == what then
		if what == "store-buy" then
			if util.getval(self.allow_buy, drag.object, drag.item_idx) then
				self.action("buy", drag.object, drag.item_idx)
			end
		else
			if util.getval(self.allow_sell, drag.object, drag.item_idx) then
				self.action("sell", drag.object, drag.item_idx)
			end
		end

		game.mouse:usedDrag()
	end
end

function _M:innerDisplayBack(x, y, nb_keyframes)
	if not self.faction_image then return end

	local w, h = self.title_tex.h + 4, self.title_tex.h + 4
	local x, y = x + (self.w - self.title_tex.w) / 2 + self.frame.title_x - 5 - w, y + self.frame.title_y
	self.faction_image[1]:toScreenFull(x, y, w, h, self.faction_image[2] * w / self.faction_image[6], self.faction_image[3] * h / self.faction_image[7])
end

--Barter stuff

function _M:addtoBarterSell(item, id)
	self.barter_list_sell = self.barter_list_sell or {}

	local who, o = self.actor, item.object:cloneFull()

	local list = self.barter_list_sell

	local name = o:getName{do_color=true, no_image=true}

	local item_item = id

	local price = self.descprice("sell", item.object)

    list[#list+1] = {object = o, name = name, item_item = item_item, store_name = self.store_name, price = price, barter = barter }

end

function _M:addtoBarterBuy(item, id)
	self.barter_list_buy = self.barter_list_buy or {}

	local who, o = self.actor, item.object:cloneFull()
	local list = self.barter_list_buy

	local name = o:getName{do_color=true, no_image=true}

	local item_item = id

	local price = self.descprice("sell", item.object)

    list[#list+1] = {object = o, name = name, item_item = item_item, store_name = self.store_name, price = price, barter = barter }

end


function _M:onBuy()

	local list_buy = self.barter_list_buy
	local list_sell = self.barter_list_sell

	local total_buy = self.total_buy or 0
	local total_sell = self.total_sell or 0

	--Count the totals

	--PROBLEM: Doesn't account for ids changing when sortInven() is called.

	for i, item in ipairs(list_sell) do
		total_sell = total_sell + item.price

		self.action("sell", item.object, item.item_item)
	end

	for i, item in ipairs(list_buy) do
		total_buy = total_buy + item.price

		self.actor_actor:incMoney(total_buy)

		self.action("buy", item.object, item.item_item)
	end

	--Clear the lists when done!
	self.barter_list_buy = {}
	self.barter_list_sell = {}
	--Remove added money
	self.actor_actor:incMoney(-total_buy)

end