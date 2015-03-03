local Dialog = require "engine.ui.Dialog"
local Talents = require "engine.interface.ActorTalents"
local TextzoneList = require "engine.ui.TextzoneList"
local Textzone = require "engine.ui.Textzone"
local Button = require "engine.ui.Button"
local ImageList = require "engine.ui.ImageList"
local Player = require "mod.class.Player"
local UI = require "engine.ui.Base"
local List = require "engine.ui.List"

local TreeList = require "engine.ui.TreeList"


module(..., package.seeall, class.inherit(Dialog))

--Taken from ToME 4
local function restore(dest, backup)
	local bx, by = dest.x, dest.y
	backup.replacedWith = false
	dest:replaceWith(backup)
	dest.replacedWith = nil
	dest.x, dest.y = bx, by
	dest.changed = true
	dest:removeAllMOs()
	if game.level and dest.x then game.level.map:updateMap(dest.x, dest.y) end
end

function _M:init(actor)
	self.player = actor
	self.actor = actor
	self.actor_dup = actor:clone()
	Dialog.init(self, "Feats", math.max(900, game.w*0.8), game.h*0.6)
	self:generateLists()

	self.c_points = Textzone.new{width=self.iw, height = 30, text = "Available feat points: "..self.player.feat_point}
	self.c_learned_text = Textzone.new{auto_width=true, auto_height=true, text="#SANDY_BROWN#Learned feats#LAST#"}
	self.c_avail_text = Textzone.new{auto_width=true, auto_height=true, text="#SANDY_BROWN#Available feats#LAST#"}
	self.c_barred_text = Textzone.new{auto_width=true, auto_height=true, text="#SANDY_BROWN#Barred feats#LAST#"}
	self.c_desc = TextzoneList.new{width=self.iw/4-20, height = 400, text="Hello from description"}

	self.c_learned = List.new{width=250, height=self.ih*0.8, scrollbar=true,
		list=self.learned_feats,
		fct=function() end,
		select=function(item, sel) self:on_select(item) end,
	}

	self.c_avail = TreeList.new{width=250, height=self.ih*0.8, scrollbar=true, columns={
		{width=100, display_prop="name"},
	}, tree=self.all_feats,
		fct=function(item, sel, v) self:featUse(item, sel, v) end,
		select=function(item, sel) self:on_select(item) end,
		on_expand=function(item) end,
		on_drawitem=function(item) end,
	}

	self.c_barred = TreeList.new{width=250, height=self.ih*0.8, scrollbar=true, columns={
		{width=100, display_prop="name"},
	}, tree=self.barred_feats,
		fct=function(item, sel, v) end,
		select=function(item, sel) self:on_select(item) end,
		on_expand=function(item) end,
		on_drawitem=function(item) end,
	}


	self.c_bonus = Button.new{text="Bonus feats", fct=function() self:onBonus() end}

	self:loadUI{
		{left=0, top=0, ui = self.c_points},
		{left=0, top=40, ui = self.c_bonus},
		{left=0, top=90, ui=self.c_learned_text},
		{left=250, top=90, ui=self.c_avail_text},
		{left=500, top=90, ui=self.c_barred_text},
		{left=0, top=self.c_points.h + 5 + self.c_bonus.h + 5 + self.c_learned_text.h + 15, ui=self.c_learned},
		{left=250, top=self.c_points.h + 5 + self.c_bonus.h + 5 + self.c_learned_text.h + 15, ui=self.c_avail},
		{left=500, top=self.c_points.h + 5 + self.c_bonus.h + 5 + self.c_learned_text.h + 15, ui=self.c_barred},
		{left=750, top=self.c_points.h + 5 + self.c_bonus.h + 5 + self.c_learned_text.h + 15, ui=self.c_desc}
	}

	self:hideButton()

	self:setFocus(self.c_avail)
--	self:setupUI(false, true)
	self:setupUI()

	self:hideButton()

--	self.key:addBind("EXIT", function() game:unregisterDialog(self) end)
	--Taken from ToME 4
	self.key:addBinds{
		EXIT = function()
			if self.actor.feat_point~=self.actor_dup.feat_point then
				self:yesnocancelPopup("Finish","Do you accept changes?", function(yes, cancel)
				if cancel then
					return nil
				else
					if yes then ok = true else ok = true self:cancel() end
				end
				if ok then
					game:unregisterDialog(self)
					self.actor_dup = {}
					if self.on_finish then self.on_finish() end
				end
				end)
			else
				game:unregisterDialog(self)
				self.actor_dup = {}
				if self.on_finish then self.on_finish() end
			end
		end,
	}


end

function _M:cancel()
	restore(self.actor, self.actor_dup)
end

function _M:hideButton()
	local ok = game.player.fighter_bonus and game.player.fighter_bonus > 0
	self:toggleDisplay(self.c_bonus, ok)
end


function _M:use(item)
	if self.player.feat_point > 0 then
		local t = item.talent
		local tid = item.talent.id
		--Have we already learned it?
		if self.player:getTalentLevelRaw(tid) >= t.points then
			return nil
		end

		-- Alright, lets learn it if we can
		local learned = self.player:learnTalent(item.talent.id) --returns false if not learned due to requirements
		if learned then
			self.player.feat_point = self.player.feat_point - 1
			self:update()
		end
	end
end

function _M:featUse(item, sel, v)
	if not item then return end
	if item.nodes then
		for _, other in ipairs(self.c_avail.tree) do
			if other.shown then self.c_avail:treeExpand(false, other) end
		end
		self.c_avail:treeExpand(true, item)
	elseif item.talent and self.player:canLearnTalent(item.talent) then
		self:use(item)
	end
end


function _M:on_select(item,sel)
	if self.c_desc then self.c_desc:switchItem(item, item.desc) end
	self.selection = sel
end

function _M:update()
	local sel = self.selection
	self:generateLists() -- Slow! Should just update the one changed and sort again
	self.c_points.text = "Available feat points: "..self.player.feat_point
	self.c_points:generate()
	self.c_avail.tree = self.all_feats
	self.c_barred.tree = self.barred_feats
	self.c_avail:generate()
	self.c_barred:generate()
--	if sel then self.c_list:select(sel) end
end

function _M:generateLists()
	self:generateLearned()
	self:generateAvail()
	self:generateBarred()
end

function _M:talentTextBlock(t)
	local player = self.actor
	local d = "#GOLD#"..t.name.."#LAST#\n"
	-- Workaround for double newline bug in T-Engine's getTalentReqDesc
	local s = player:getTalentReqDesc(t.id):toString():gsub('\n\n', '\n')
	d = d..s.."\n#WHITE#"
	d = d..t.info(player,t)
	return d
end

function _M:generateAvail()
	local player = game.player
	local oldtree = {}
	for i, t in ipairs(self.all_feats or {}) do oldtree[t.id] = t.shown end

	local tree = {}
	local newsel = nil
	for i, tt in ipairs(self.actor.talents_types_def) do
		if self.actor:knowTalentType(tt.type) then
			--exclude some categories
			if tt.type ~= "special/special" and tt.type ~= "arcane/arcane" and tt.type ~= "divine" and tt.type ~= "arcane_divine"
				--exclude spells
				and tt.type ~= "abjuration" and tt.type ~= "conjuration" and tt.type ~= "divination" and tt.type ~= "enchantment" and tt.type ~= "evocation" and tt.type ~= "illusion" and tt.type ~= "necromancy" and tt.type ~= "transmutation"

				--exclude class skills categories
				and tt.type ~= "barbarian/barbarian" and tt.type ~= "cleric/cleric" and tt.type ~= "druid/druid" and tt.type ~= "eldritch/eldritch" and tt.type ~= "paladin/paladin" and tt.type ~= "ranger/ranger"
				then

				local nodes = {}

				for j, t in ipairs(tt.talents) do
					if t.is_feat and player:canLearnTalent(t) and not player:knowTalent(t) then
						nodes[#nodes+1] = {
							name = t.name,
							id = t.name,
							pid = tt.name,
							desc = self:talentTextBlock(t),
							talent = t,
						}

						if self.sel_feat and self.sel_feat.id == sd.name then newsel = nodes[#nodes] end
					end
				end

				if #nodes > 0 then
					tree[#tree+1] = {
						name = tt.name,
						id = tt.name,
						shown = oldtree[tt.name],
						nodes = nodes,
					}
				end
			end
		end
	end

	self.all_feats = tree
	if self.c_avail then
		self.c_avail.tree = self.all_feats
		self.c_avail:generate()
		if newsel then self:featUse(newsel)
		else
			self.sel_feat = nil
		end
	end
end


--[[ --Sort it alphabetically
	table.sort(self.list_avail, function (a,b)
			return a.name < b.name
	end)]]

function _M:generateBarred()
	local player = game.player
	local oldtree = {}
	for i, t in ipairs(self.barred_feats or {}) do oldtree[t.id] = t.shown end

	local tree = {}
	local newsel = nil
	for i, tt in ipairs(self.actor.talents_types_def) do
		if self.actor:knowTalentType(tt.type) then
			 --exclude some categories
			if tt.type ~= "special/special" and tt.type ~= "arcane/arcane" and tt.type ~= "divine" and tt.type ~= "arcane_divine"

				--exclude spells
				and tt.type ~= "abjuration" and tt.type ~= "conjuration" and tt.type ~= "divination" and tt.type ~= "enchantment" and tt.type ~= "evocation" and tt.type ~= "illusion" and tt.type ~= "necromancy" and tt.type ~= "transmutation"

				--exclude class skills categories
				and tt.type ~= "barbarian/barbarian" and tt.type ~= "cleric/cleric" and tt.type ~= "druid/druid" and tt.type ~= "eldritch/eldritch" and tt.type ~= "paladin/paladin" and tt.type ~= "ranger/ranger"
				then

				local nodes = {}

				for j, t in ipairs(tt.talents) do
					if t.is_feat and not player:canLearnTalent(t) and not player:knowTalent(t) then
						nodes[#nodes+1] = {
							name = t.name,
							id = t.name,
							pid = tt.name,
							desc = self:talentTextBlock(t),
							talent = t,
						--	color = color,
						}

						if self.sel_barred and self.sel_barred.id == sd.name then newsel = nodes[#nodes] end
					end
				end

				if #nodes > 0 then
					tree[#tree+1] = {
						name = tt.name,
						id = tt.name,
						shown = oldtree[tt.name],
						nodes = nodes,
					}
				end
			end
		end
	end

	self.barred_feats = tree
	if self.c_barred then
		self.c_barred.tree = self.barred_feats
		self.c_barred:generate()
		if newsel then self:featUse(newsel)
		else
			self.sel_barred = nil
		end
	end

end

function _M:onBonus()
	--pop the are you sure thing
	if self.actor.feat_point~=self.actor_dup.feat_point then
		self:yesnocancelPopup("Finish","Do you accept changes?", function(yes, cancel)
			if cancel then
				return nil
			else
				if yes then ok = true else ok = true self:cancel() end
			end
			if ok then
				game:unregisterDialog(self)
				self.actor_dup = {}
				if self.on_finish then self.on_finish() end
			end
		end)
	else
		game:unregisterDialog(self)
		self.actor_dup = {}
		if self.on_finish then self.on_finish() end
	end

	game:unregisterDialog(self)
	game:registerDialog(require("mod.dialogs.BonusFeatDialog").new(game.player))
end

function _M:mouseZones(t, no_new)
	-- Offset the x and y with the window position and window title
	if not t.norestrict then
		for i, z in ipairs(t) do
			if not z.norestrict then
				z.x = z.x + self.display_x + 5
				z.y = z.y + self.display_y + 20 + 3
			end
		end
	end

	if not no_new then self.mouse = engine.Mouse.new() end
	self.mouse:registerZones(t)
end

function _M:mouseTooltip(text, _, _, _, w, h, x, y)
	self:mouseZones({
		{ x=x, y=y, w=w, h=h, fct=function(button) game.tooltip_x, game.tooltip_y = 100, 100; game:tooltipDisplayAtMap(game.w*0.8, game.h*0.8, text) end},
	}, true)
end

function _M:generateLearned()
	local player = self.actor
	local list = {}
	for j, t in pairs(player.talents_def) do
		if player:knowTalent(t.id) and t.is_feat then
			if player:classFeat(t.id) then name = "#GOLD#"..t.name
			else name = ("%s"):format(t.name) end

			list[#list+1] = {
				name = name,
				desc = self:talentTextBlock(t),
			}
		end
	end

	table.sort(list, function(a,b) return a.name < b.name end)

	self.learned_feats = list
end
