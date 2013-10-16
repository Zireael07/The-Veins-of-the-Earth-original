newTalentType{ passive=true, type="ranger/ranger", name="ranger", description="Ranger Feats" }

newTalent{
	name = "Favored Enemy",
	type = {"ranger/ranger", 1},
	mode = 'passive',
	points = 1,
	is_feat = true,

	info = [[You gain a +2 to damage versus a chosen monster type and also a +2 bonus to Listen, Spot, Hide and Move Silently versus them.]],
	on_learn = function(self, t)
		local d = require("mod.dialogs.FavoredEnemy").new(t)

		game:registerDialog(d)    
end
}