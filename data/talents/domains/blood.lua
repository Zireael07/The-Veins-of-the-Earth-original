newTalentType{ passive=true, type="domains/blood", name="blood", description="Blood Domain" }

newTalent{
	name = "Blood Vengance",
	type = {"domains/blood", 1},
	mode = 'passive',
	require = {
		special = {
			fct = function(self, t, offset) return true end,
			desc = "Blood Domain",		 -- Should be base attack bonus of 1
		},
	},
	acquired = "You recieved this feat because you have the Blood domain", 
	points = 1,
	is_feat = true,

	info = [[While below 50% of your hp, you recieve a bonus of 2 strength]],
}