defineAction{
	default = { "sym:_b:false:false:false:false" },
	type = "OPEN_SPELLBOOK",
	group = "actions",
	name = "Open Spellbook",
}

defineAction{
	default = { "sym:_h:false:false:false:false" },
	type = "SHOW_HELP",
	group = "actions",
	name = "Open help screen",
}

defineAction{
	default = { "sym:_LEFT:true:false:false:false", "sym:_KP_4:true:false:false:false" },
	type = "ATTACK_OR_MOVE_LEFT",
	group = "movement",
	name = "Attack left",
}

defineAction{
	default = { "sym:_RIGHT:true:false:false:false", "sym:_KP_6:true:false:false:false" },
	type = "ATTACK_OR_MOVE_RIGHT",
	group = "movement",
	name = "Attack right",
}

defineAction{
	default = { "sym:_UP:true:false:false:false", "sym:_KP_8:true:false:false:false" },
	type = "ATTACK_OR_MOVE_UP",
	group = "movement",
	name = "Attack up",
}

defineAction{
	default = { "sym:_DOWN:true:false:false:false", "sym:_KP_2:true:false:false:false" },
	type = "ATTACK_OR_MOVE_DOWN",
	group = "movement",
	name = "Attack down",
}

defineAction{
	default = { "sym:_KP_7:true:false:false:false" },
	type = "ATTACK_OR_MOVE_LEFT_UP",
	group = "movement",
	name = "Attack diagonally left and up",
}

defineAction{
	default = { "sym:_KP_9:true:false:false:false" },
	type = "ATTACK_OR_MOVE_RIGHT_UP",
	group = "movement",
	name = "Attack diagonally right and up",
}

defineAction{
	default = { "sym:_KP_1:true:false:false:false" },
	type = "ATTACK_OR_MOVE_LEFT_DOWN",
	group = "movement",
	name = "Attack diagonally left and down",
}

defineAction{
	default = { "sym:_KP_3:true:false:false:false" },
	type = "ATTACK_OR_MOVE_RIGHT_DOWN",
	group = "movement",
	name = "Attack diagonally right and down",
}
