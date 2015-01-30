require "engine.class"
require "engine.Entity"
local Map = require "engine.Map"
local Dialog = require "engine.ui.Dialog"
local GetQuantity = require "engine.dialogs.GetQuantity"

module(..., package.seeall, class.inherit(
	engine.Entity
))

function _M:init(t, no_default)
	t.name = t.name or "party"
	engine.Entity.init(self, t, no_default)

	self.members = {}
	self.m_list = {}
	self.energy = {value = 0, mod=100000} -- "Act" every tick
	self.on_death_show_achieved = {}
end

function _M:addMember(actor, def)
	if self.members[actor] then
		print("[PARTY] error trying to add existing actor: ", actor.uid, actor.name)
		return false
	end
	if type(def.control) == "nil" then def.control = "no" end
	def.title = def.title or "Party member"
	self.members[actor] = def
	self.m_list[#self.m_list+1] = actor
	def.index = #self.m_list

--[[	if #self.m_list >= 6 then
		game:getPlayer(true):attr("huge_party", 1)
	end]]

	actor.ai_state = actor.ai_state or {}
	actor.ai_state.tactic_leash_anchor = actor.ai_state.tactic_leash_anchor or game.player
	actor.ai_state.tactic_leash = actor.ai_state.tactic_leash or 10

	 actor.addEntityOrder = function(self, level)
	 	print("[PARTY] New member, add after", self.name, game.party.m_list[1].name)
	 	return game.party.m_list[1] -- Make the sure party is always consecutive in the level entities list
	 end

	-- Turn NPCs into party members --[[]]
	if not actor.no_party_class then
	 	local uid = actor.uid
	 	actor.replacedWith = false
	 	actor:replaceWith(require("mod.class.PartyMember").new(actor))
	 	actor.uid = uid
	 	__uids[uid] = actor
	 	actor.replacedWith = nil
	end

	-- Notify the UI
	if game.player then game.player.changed = true end
end

function _M:removeMember(actor, silent)
	if not self.members[actor] then
		if not silent then
			print("[PARTY] error trying to remove non-existing actor: ", actor.uid, actor.name)
		end
		return false
	end
	table.remove(self.m_list, self.members[actor].index)
	self.members[actor] = nil

	actor.addEntityOrder = nil

	-- Update indexes
	for i = 1, #self.m_list do
		self.members[self.m_list[i]].index = i
	end

	-- Notify the UI
	game.player.changed = true
end

function _M:hasMember(actor)
	return self.members[actor]
end


function _M:setPlayer(actor, bypass)
	if type(actor) == "number" then actor = self.m_list[actor] end

	-- if not bypass then
	-- 	local ok, err = self:canControl(actor, true)
	-- 	if not ok then return nil, err end
	-- end

	if actor == game.player then return true end

	-- -- Stop!!
	-- if game.player and game.player.runStop then game.player:runStop("Switching control") end
	-- if game.player and game.player.restStop then game.player:restStop("Switching control") end

	local def = self.members[actor]
	local oldp = self.player
	self.player = actor

	-- Convert the class to always be a player
	if actor.__CLASSNAME ~= "mod.class.Player" and not actor.no_party_class then
		actor.__PREVIOUS_CLASSNAME = actor.__CLASSNAME
		local uid = actor.uid
		actor.replacedWith = false
		actor:replaceWith(mod.class.Player.new(actor))
		actor.replacedWith = nil
		actor.uid = uid
		__uids[uid] = actor
		actor.changed = true
	end

	-- Setup as the curent player
	actor.player = true
	game.paused = actor:enoughEnergy()
	game.player = actor
	game.uiset.hotkeys_display.actor = actor
	Map:setViewerActor(actor)
	if game.target then game.target.source_actor = actor end
	if game.level and actor.x and actor.y then game.level.map:moveViewSurround(actor.x, actor.y, 8, 8) end
	actor._move_others = actor.move_others
	actor.move_others = true

	-- Change back the old actor to a normal actor
	if oldp and oldp ~= actor then
		if self.members[oldp] and self.members[oldp].on_uncontrol then self.members[oldp].on_uncontrol(oldp) end

		if oldp.__PREVIOUS_CLASSNAME then
			local uid = oldp.uid
			oldp.replacedWith = false
			oldp:replaceWith(require(oldp.__PREVIOUS_CLASSNAME).new(oldp))
			oldp.replacedWith = nil
			oldp.uid = uid
			__uids[uid] = oldp
		end

		actor.move_others = actor._move_others
		oldp.changed = true
		oldp.player = nil
		if game.level and oldp.x and oldp.y then oldp:move(oldp.x, oldp.y, true) end
	end

	if def.on_control then def.on_control(actor) end

	if game.level and actor.x and actor.y then actor:move(actor.x, actor.y, true) end

	if not actor.hotkeys_sorted then actor:sortHotkeys() end

	game.logPlayer(actor, "#MOCCASIN#Character control switched to %s.", actor.name)

	return true
end

function _M:findMember(filter)
	for i, actor in ipairs(self.m_list) do
		local ok = true
		local def = self.members[actor]

		if filter.main and not def.main then ok = false end
		if filter.type and def.type ~= filter.type then ok = false end

		if ok then return actor end
	end
end

--From ToME 4
function _M:setDeathTurn(actor, turn)
	local def = self.members[actor]
	if not def then return end
	def.last_death_turn = turn
end

function _M:findLastDeath()
	local max_turn = -9999
	local last = nil

	for i, actor in ipairs(self.m_list) do
		local def = self.members[actor]

		if def.last_death_turn and def.last_death_turn > max_turn then max_turn = def.last_death_turn; last = actor end
	end
	return last or self:findMember{main=true}
end

function _M:findSuitablePlayer(type)
	for i, actor in ipairs(self.m_list) do
		local def = self.members[actor]
		if def.control == "full" and (not type or def.type == type) and not actor.dead and game.level:hasEntity(actor) then
			if self:setPlayer(actor, true) then
				return true
			end
		end
	end
	return false
end

function _M:canOrder(actor, order, vocal)
	if not actor then return false end
	if actor == game.player then return false end

	if not self.members[actor] then
		print("[PARTY] error trying to order, not a member of party: ", actor.uid, actor.name)
		return false
	end
	if (self.members[actor].control ~= "full" and self.members[actor].control ~= "order") or not self.members[actor].orders then
		print("[PARTY] error trying to order, not controlable: ", actor.uid, actor.name)
		return false
	end
	if actor.dead or (game.level and not game.level:hasEntity(actor)) then
		if vocal then game.logPlayer(game.player, "Can not give orders to this creature.") end
		return false
	end
	if actor.on_can_order and not actor:on_can_order(vocal) then
		print("[PARTY] error trying to order, can order forbade")
		return false
	end
	if order and not self.members[actor].orders[order] then
		print("[PARTY] error trying to order, unknown order: ", actor.uid, actor.name)
		return false
	end
	return true
end

function _M:giveOrders(actor)
	if type(actor) == "number" then actor = self.m_list[actor] end

	local ok, err = self:canOrder(actor, nil, true)
	if not ok then return nil, err end

	local def = self.members[actor]

	game:registerDialog(PartyOrder.new(actor, def))

	return true
end

function _M:giveOrder(actor, order)
	if type(actor) == "number" then actor = self.m_list[actor] end

	local ok, err = self:canOrder(actor, order, true)
	if not ok then return nil, err end

	local def = self.members[actor]

	if order == "leash" then
		game:registerDialog(GetQuantity.new("Set action radius: "..actor.name, "Set the maximum distance this creature can go from the party master", actor.ai_state.tactic_leash, actor.ai_state.tactic_leash_max or 100, function(qty)
			actor.ai_state.tactic_leash = util.bound(qty, 1, actor.ai_state.tactic_leash_max or 100)
			game.logPlayer(game.player, "%s maximum action radius set to %d.", actor.name:capitalize(), actor.ai_state.tactic_leash)
		end), 1)
	elseif order == "anchor" then
		local co = coroutine.create(function()
			local x, y, act = game.player:getTarget({type="hit", range=10, nowarning=true})
			local anchor
			if x and y then
				if act then
					anchor = act
				else
					anchor = {x=x, y=y, name="that location"}
				end
				actor.ai_state.tactic_leash_anchor = anchor
				game.logPlayer(game.player, "%s will stay near %s.", actor.name:capitalize(), anchor.name)
			end
		end)
		local ok, err = coroutine.resume(co)
		if not ok and err then print(debug.traceback(co)) error(err) end
	elseif order == "target" then
		local co = coroutine.create(function()
			local x, y, act = game.player:getTarget({type="hit", range=10})
			if act then
				actor:setTarget(act)
				game.player:logCombat(act, "%s targets #Target#.", actor.name:capitalize())
			end
		end)
		local ok, err = coroutine.resume(co)
		if not ok and err then print(debug.traceback(co)) error(err) end
	elseif order == "behavior" then
		game:registerDialog(require("mod.dialogs.orders."..order:capitalize()).new(actor, def))
	elseif order == "talents" then
		game:registerDialog(require("mod.dialogs.orders."..order:capitalize()).new(actor, def))
	end

	return true
end