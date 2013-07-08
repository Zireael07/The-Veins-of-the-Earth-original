newTalentType{ passive=true, type="domains/blood", name="blood", description="Blood Domain" }

newTalent{
	name = "Blood Vengance",
	type = {"domains/blood", 1},
	mode = 'passive',
	acquired = "You recieved this feat because you have the Blood domain", 
	points = 1,
	is_feat = true,

	info = [[While below 50% of your hp, you recieve a bonus of 2 strength]],
}