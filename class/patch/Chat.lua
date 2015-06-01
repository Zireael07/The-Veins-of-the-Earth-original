-- Veins of the Earth
-- Copyright (C) 2015 Zireael
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
--require "engine.dialogs.Chat"
require "mod.dialogs.Chat"
local slt2 = require "slt2"

--- Handle chats between the player and NPCs
module(..., package.seeall, class.make)

function _M:init(name, npc, player, data)
	self.quick_replies = 0
	self.chats = {}
	self.npc = npc
	self.player = player
	self.name = name
	data = setmetatable(data or {}, {__index=_G})
	self.data = data
	if not data.player then data.player = player end
	if not data.npc then data.npc = npc end

	local f, err = loadfile(self:getChatFile(name))
	if not f and err then error(err) end
	setfenv(f, setmetatable({
		newChat = function(c) self:addChat(c) end,
	}, {__index=data}))
	self.default_id = f()

	self:triggerHook{"Chat:load", data=data}
end

function _M:getChatFile(file)
	local _, _, addon, rfile = file:find("^([^+]+)%+(.+)$")
	if addon and rfile then
		return "/data-"..addon.."/chats/"..rfile..".lua"
	end
	return "/data/chats/"..file..".lua"
end

--- Switch the NPC talking
function _M:switchNPC(npc)
	local old = self.npc
	self.npc = npc
	return old
end

--- Adds a chat to the list of possible chats
function _M:addChat(c)
	self:triggerHook{"Chat:add", c=c}

	assert(c.id, "no chat id")
	assert(c.text or c.template, "no chat text or template")
	assert(c.answers, "no chat answers")
	self.chats[c.id] = c
	print("[CHAT] loaded", c.id, c)

	-- Parse answers looking for quick replies
	for i, a in ipairs(c.answers) do
		if a.quick_reply then
			a.jump = "quick_reply"..self.quick_replies
			self:addChat{id="quick_reply"..self.quick_replies, text=a.quick_reply, answers={{"[leave]"}}}
			self.quick_replies = self.quick_replies + 1
		end
	end
end

--- Invokes a chat
-- @param id the id of the first chat to run, if nil it will use the default one
function _M:invoke(id)
	if self.npc.onChat then self.npc:onChat() end
	if self.player.onChat then self.player:onChat() end

--	local d = engine.dialogs.Chat.new(self, id or self.default_id)
	local d = mod.dialogs.Chat.new(self, id or self.default_id)
	game:registerDialog(d)
	return d
end

--- Gets the chat with the given id
function _M:get(id)
	local c = self.chats[id]
	if c and c.template then
		local tpl = slt2.loadstring(c.template)
		c.text = slt2.render(tpl, {data=self.data, player=self.player, npc=self.npc})
	end
	return c
end

--- Replace some keywords in the given text
function _M:replace(text)
	--languages
	if not self.player:speakSameLanguage(self.npc) then
		if self.npc:speakLanguage("Drow") then
			text = self:drowLanguage(text)
		else
		--scramble text
		text = [[Foreign gibberish]]
		end
	else
		--apply dwarven accent always
		if self.npc:speakLanguage("Dwarven") or self.player:speakLanguage("Dwarven") then
			text = self:dwarvenAccent(text)
		end
	end

	text = text:gsub("@playername@", self.player.name):gsub("@npcname@", self.npc.name)
	text = text:gsub("@playerdescriptor.(.-)@", function(what) return self.player.descriptor["fake_"..what] or self.player.descriptor[what] end)
	return text
end

--Scramble languages

--Drow
function _M:drowLanguage(text)
	text = text:gsub(" welcome ", " vendui ")
	text = text:gsub(" I ", " usstan ")
	text = text:gsub(" the ", " lil ")
	text = text:gsub(" no ", " nau ")
	text = text:gsub(" do ", " xun ")
	text = text:gsub(" cast ", " luth ")
	text = text:gsub(" item ", " bol ")
	return text
end

--Dwarven accent from FK
function _M:dwarvenAccent(text)
	text = text:gsub(" I ", " Ah ")
	text = text:gsub(" do", " dae ")
	text = text:gsub(" does ", " diz ")
	text = text:gsub(" no ", " nae ")
	text = text:gsub(" poor ", " puir ")
	text = text:gsub(" too ", " tae ")
	text = text:gsub(" with ", "wi' ")
	text = text:gsub(" you ", " ye ")

	return text
end
