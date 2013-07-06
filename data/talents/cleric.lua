newTalentType{ passive=true, type="cleric/cleric", name="cleric", description="Cleric Feats" }

newTalent{
	name = "Spontanous Conversion",
	type = {"cleric/cleric", 1},
	mode = 'passive',
	require = { level = 2 },
	points = 1,
	is_feat = true,

	info = [[Test!.]],
}