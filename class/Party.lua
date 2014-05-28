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

	if #self.m_list >= 6 then
		game:getPlayer(true):attr("huge_party", 1)
	end

	actor.ai_state = actor.ai_state or {}
	actor.ai_state.tactic_leash_anchor = actor.ai_state.tactic_leash_anchor or game.player
	actor.ai_state.tactic_leash = actor.ai_state.tactic_leash or 10

	-- actor.addEntityOrder = function(self, level)
	-- 	print("[PARTY] New member, add after", self.name, game.party.m_list[1].name)
	-- 	return game.party.m_list[1] -- Make the sure party is always consecutive in the level entities list
	-- end

	-- -- Turn NPCs into party members
	-- if not actor.no_party_class then
	-- 	local uid = actor.uid
	-- 	actor.replacedWith = false
	-- 	actor:replaceWith(require("mod.class.PartyMember").new(actor))
	-- 	actor.uid = uid
	-- 	__uids[uid] = actor
	-- 	actor.replacedWith = nil
	-- end

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
	game.hotkeys_display.actor = actor
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