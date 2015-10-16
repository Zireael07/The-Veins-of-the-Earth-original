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
		text = self:scramble(text)
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
--ROT13 function from luausers.org 2004/10/21 Philippe Lhoste
function _M:scramble(text)
  local byte_a, byte_A = string.byte('a'), string.byte('A')
  return (string.gsub(t, "[%a]",
      function (char)
        local offset = (char < 'a') and byte_A or byte_a
        local b = string.byte(char) - offset -- 0 to 25
        b = math.mod(b  + 13, 26) + offset -- Rotate
        return string.char(b)
      end
    ))
end

--Drow
function _M:drowLanguage(text)
	text = text:gsub(" welcome ", " vendui ")
	text = text:gsub(" I ", " usstan ")
	text = text:gsub(" the ", " lil ")
	text = text:gsub(" no ", " nau ")
	text = text:gsub(" do ", " xun ")
	text = text:gsub(" cast ", " luth ")
	text = text:gsub(" item ", " bol ")

--	self:scramble(text)
	return text
end

--Dwarven accent from FK
function _M:dwarvenAccent(text)
	text = text:gsub(" about ", " aboot ")
	text = text:gsub(" after ", " efter ")
	text = text:gsub(" all ", " a' ")
	text = text:gsub(" alright ", " a'right ")
	text = text:gsub(" and ", " an' ")
	text = text:gsub(" being ", " bein' ")
	text = text:gsub(" before ", " afore ")
	text = text:gsub(" between ", " a'tween ")
	text = text:gsub(" call ", " ca' ")
	text = text:gsub(" can ", " kin ")
	text = text:gsub(" cannot ", " cannae ")
	text = text:gsub(" can't ", " cannae ")
	text = text:gsub(" children ", " weans ")
	text = text:gsub(" cold ", " cauld ")
	text = text:gsub(" couldn't ", " couldnae ")
	text = text:gsub(" crazy ", " daft ")
	text = text:gsub(" dead ", " deid ")
	text = text:gsub(" deaf ", " deef ")
	text = text:gsub(" down ", " doon ")
	text = text:gsub(" fellow ", " fella ")

	text = text:gsub(" I ", " Ah ")
	text = text:gsub(" do", " dae ")
	text = text:gsub(" does ", " diz ")
	text = text:gsub(" done ", " doon ")
	text = text:gsub(" don't ", " donnae ")
	text = text:gsub(" for ", " fur ")
	text = text:gsub(" girl ", " lass ")
	text = text:gsub(" boy ", " lad ")
	text = text:gsub(" give ", " gie ")
	text = text:gsub(" gonna ", " gonnae ")
	text = text:gsub(" haven't ", " havnae ")
	text = text:gsub(" into ", " intae ")
	text = text:gsub(" isn't ", " isnae ")
	text = text:gsub(" just ", " jist ")
	text = text:gsub(" my ", " ma ")
	text = text:gsub(" no ", " nae ")
	text = text:gsub(" not ", " no' ")
	text = text:gsub(" of ", " o' ")
	text = text:gsub(" on ", " oan ")
	text = text:gsub(" our ", " oor ")
	text = text:gsub(" out ", " oot ")
	text = text:gsub(" over ", " o'er ")
	text = text:gsub(" shouldn't ", " shouldnae ")
	text = text:gsub(" to ", " tae ")
	text = text:gsub(" too ", " tae ")
	text = text:gsub(" wasn't ", " wiznae ")
	text = text:gsub(" what ", " whit ")
	text = text:gsub(" won't ", " willnae ")
	text = text:gsub(" with ", "wi' ")
	text = text:gsub(" you ", " ye ")
	text = text:gsub(" your ", " yer ")

	text = text:gsub(" head ", " heid ")
	text = text:gsub(" herself ", " hersel' ")
	text = text:gsub(" himself ", " himsel' ")
	text = text:gsub(" home ", " hame ")
	text = text:gsub(" hundred ", " hunner ")
	text = text:gsub(" little ", " wee ")
	text = text:gsub(" messy ", " manky ")
	text = text:gsub(" more ", " mair ")
	text = text:gsub(" myself ", " masel' ")
	text = text:gsub(" poor ", " puir ")
	text = text:gsub(" round ", " roond ")
	text = text:gsub(" small ", " wee ")
	text = text:gsub(" south ", " sooth ")
	text = text:gsub(" those ", " thae ")
	text = text:gsub(" told ", " telt ")
	text = text:gsub(" would ", " wid ")
	text = text:gsub(" wouldn't ", " wouldnae ")
	text = text:gsub(" yourself ", "yersel' ")

	return text
end
