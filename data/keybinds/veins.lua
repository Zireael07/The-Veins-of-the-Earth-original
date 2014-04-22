--Veins of the Earth
--Zireael

--New stuff
defineAction{
	default = { "sym:_b:false:false:false:false" },
	type = "OPEN_SPELLBOOK",
	group = "actions",
	name = "Open Spellbook",
}

defineAction{
	default = { "sym:_F1:false:false:false:false" },
	type = "SHOW_HELP",
	group = "actions",
	name = "Open help screen",
}

--Message log
defineAction{
	default = { "sym:_F2:false:false:false:false" },
	type = "SHOW_MESSAGE_LOG",
	group = "actions",
	name = "Show message log",
}

--From Marson's AWOL addon
defineAction{
	default = { "sym:_b:true:false:false:false" },
	type = "MARSON_AWOL",
	group = "debug",
	name = "Display NPC tracking screen",
}
defineAction{
	default = { "sym:_c:true:false:false:false" },
	type = "MARSON_CLONE",
	group = "debug",
	name = "Clear clones off current level",
}



-- Character movements
defineAction{
	default = { "sym:_LEFT:false:false:false:false", "sym:_KP_4:false:false:false:false" },
	type = "MOVE_LEFT",
	group = "movement",
	name = "Move left",
}
defineAction{
	default = { "sym:_RIGHT:false:false:false:false", "sym:_KP_6:false:false:false:false" },
	type = "MOVE_RIGHT",
	group = "movement",
	name = "Move right",
}
defineAction{
	default = { "sym:_UP:false:false:false:false", "sym:_KP_8:false:false:false:false" },
	type = "MOVE_UP",
	group = "movement",
	name = "Move up",
}
defineAction{
	default = { "sym:_DOWN:false:false:false:false", "sym:_KP_2:false:false:false:false" },
	type = "MOVE_DOWN",
	group = "movement",
	name = "Move down",
}
defineAction{
	default = { "sym:_KP_7:false:false:false:false" },
	type = "MOVE_LEFT_UP",
	group = "movement",
	name = "Move diagonally left and up",
}
defineAction{
	default = { "sym:_KP_9:false:false:false:false" },
	type = "MOVE_RIGHT_UP",
	group = "movement",
	name = "Move diagonally right and up",
}
defineAction{
	default = { "sym:_KP_1:false:false:false:false" },
	type = "MOVE_LEFT_DOWN",
	group = "movement",
	name = "Move diagonally left and down",
}
defineAction{
	default = { "sym:_KP_3:false:false:false:false" },
	type = "MOVE_RIGHT_DOWN",
	group = "movement",
	name = "Move diagonally right and down",
}

defineAction{
	default = { "sym:=.:false:false:false:false" },
	type = "MOVE_STAY",
	group = "movement",
	name = "Stay for a turn",
}

-- Running
defineAction{
	default = { "sym:=SHIFT:false:false:false:false" },
	type = "RUN",
	group = "movement",
	name = "Run",
}
defineAction{
	default = { "sym:_LEFT:false:true:false:false", "sym:_KP_4:false:true:false:false" },
	type = "RUN_LEFT",
	group = "movement",
	name = "Run left",
}
defineAction{
	default = { "sym:_RIGHT:false:true:false:false", "sym:_KP_6:false:true:false:false" },
	type = "RUN_RIGHT",
	group = "movement",
	name = "Run right",
}
defineAction{
	default = { "sym:_UP:false:true:false:false", "sym:_KP_8:false:true:false:false" },
	type = "RUN_UP",
	group = "movement",
	name = "Run up",
}
defineAction{
	default = { "sym:_DOWN:false:true:false:false", "sym:_KP_2:false:true:false:false" },
	type = "RUN_DOWN",
	group = "movement",
	name = "Run down",
}
defineAction{
	default = { "sym:_KP_7:false:true:false:false" },
	type = "RUN_LEFT_UP",
	group = "movement",
	name = "Run diagonally left and up",
}
defineAction{
	default = { "sym:_KP_9:false:true:false:false" },
	type = "RUN_RIGHT_UP",
	group = "movement",
	name = "Run diagonally right and up",
}
defineAction{
	default = { "sym:_KP_1:false:true:false:false" },
	type = "RUN_LEFT_DOWN",
	group = "movement",
	name = "Run diagonally left and down",
}
defineAction{
	default = { "sym:_KP_3:false:true:false:false" },
	type = "RUN_RIGHT_DOWN",
	group = "movement",
	name = "Run diagonally right and down",
}

--Inventory
defineAction{
	default = { "sym:=i:false:false:false:false", },
	type = "SHOW_INVENTORY",
	group = "inventory",
	name = "Show inventory",
}
defineAction{
	default = { "sym:=e:false:false:false:false", },
	type = "SHOW_EQUIPMENT",
	group = "inventory",
	name = "Show equipment",
}

defineAction{
	default = { "sym:=g:false:false:false:false" },
	type = "PICKUP_FLOOR",
	group = "inventory",
	name = "Pickup items",
}
defineAction{
	default = { "sym:=d:false:false:false:false" },
	type = "DROP_FLOOR",
	group = "inventory",
	name = "Drop items",
}

defineAction{
	default = { "sym:=w:false:false:false:false", },
	type = "WEAR_ITEM",
	group = "inventory",
	name = "Wield/wear items",
}
defineAction{
	default = { "sym:=t:false:false:false:false", },
	type = "TAKEOFF_ITEM",
	group = "inventory",
	name = "Takeoff items",
}

defineAction{
	default = { "sym:=u:false:false:false:false", },
	type = "USE_ITEM",
	group = "inventory",
	name = "Use items",
}

--Interface
defineAction{
	default = { "sym:=l:false:false:false:false", },
	type = "SHOW_MESSAGE_LOG",
	group = "actions",
	name = "Show message log",
}

defineAction{
	default = { "sym:_PRINTSCREEN:false:false:false:false" },
	type = "SCREENSHOT",
	group = "actions",
	name = "Take a screenshot",
}

defineAction{
	default = { "sym:_TAB:false:false:false:false" },
	type = "SHOW_MAP",
	group = "actions",
	name = "Show map",
}

-- Hotkeys
defineAction{
	default = { "sym:_1:false:false:false:false" },
	type = "HOTKEY_1",
	group = "hotkeys",
	name = "Hotkey 1",
}
defineAction{
	default = { "sym:_2:false:false:false:false" },
	type = "HOTKEY_2",
	group = "hotkeys",
	name = "Hotkey 2",
}
defineAction{
	default = { "sym:_3:false:false:false:false" },
	type = "HOTKEY_3",
	group = "hotkeys",
	name = "Hotkey 3",
}
defineAction{
	default = { "sym:_4:false:false:false:false" },
	type = "HOTKEY_4",
	group = "hotkeys",
	name = "Hotkey 4",
}
defineAction{
	default = { "sym:_5:false:false:false:false" },
	type = "HOTKEY_5",
	group = "hotkeys",
	name = "Hotkey 5",
}
defineAction{
	default = { "sym:_6:false:false:false:false" },
	type = "HOTKEY_6",
	group = "hotkeys",
	name = "Hotkey 6",
}
defineAction{
	default = { "sym:_7:false:false:false:false" },
	type = "HOTKEY_7",
	group = "hotkeys",
	name = "Hotkey 7",
}
defineAction{
	default = { "sym:_8:false:false:false:false" },
	type = "HOTKEY_8",
	group = "hotkeys",
	name = "Hotkey 8",
}
defineAction{
	default = { "sym:_9:false:false:false:false" },
	type = "HOTKEY_9",
	group = "hotkeys",
	name = "Hotkey 9",
}
defineAction{
	default = { "sym:_0:false:false:false:false" },
	type = "HOTKEY_10",
	group = "hotkeys",
	name = "Hotkey 10",
}
defineAction{
	default = { "sym:_MINUS:false:false:false:false" },
	type = "HOTKEY_11",
	group = "hotkeys",
	name = "Hotkey 11",
}
defineAction{
	default = { "sym:_EQUALS:false:false:false:false" },
	type = "HOTKEY_12",
	group = "hotkeys",
	name = "Hotkey 12",
}

-- Ctrl + Hotkeys
defineAction{
	default = { "sym:_1:true:false:false:false" },
	type = "HOTKEY_SECOND_1",
	group = "hotkeys",
	name = "Secondary Hotkey 1",
}
defineAction{
	default = { "sym:_2:true:false:false:false" },
	type = "HOTKEY_SECOND_2",
	group = "hotkeys",
	name = "Secondary Hotkey 2",
}
defineAction{
	default = { "sym:_3:true:false:false:false" },
	type = "HOTKEY_SECOND_3",
	group = "hotkeys",
	name = "Secondary Hotkey 3",
}
defineAction{
	default = { "sym:_4:true:false:false:false" },
	type = "HOTKEY_SECOND_4",
	group = "hotkeys",
	name = "Secondary Hotkey 4",
}
defineAction{
	default = { "sym:_5:true:false:false:false" },
	type = "HOTKEY_SECOND_5",
	group = "hotkeys",
	name = "Secondary Hotkey 5",
}
defineAction{
	default = { "sym:_6:true:false:false:false" },
	type = "HOTKEY_SECOND_6",
	group = "hotkeys",
	name = "Secondary Hotkey 6",
}
defineAction{
	default = { "sym:_7:true:false:false:false" },
	type = "HOTKEY_SECOND_7",
	group = "hotkeys",
	name = "Secondary Hotkey 7",
}
defineAction{
	default = { "sym:_8:true:false:false:false" },
	type = "HOTKEY_SECOND_8",
	group = "hotkeys",
	name = "Secondary Hotkey 8",
}
defineAction{
	default = { "sym:_9:true:false:false:false" },
	type = "HOTKEY_SECOND_9",
	group = "hotkeys",
	name = "Secondary Hotkey 9",
}
defineAction{
	default = { "sym:_0:true:false:false:false" },
	type = "HOTKEY_SECOND_10",
	group = "hotkeys",
	name = "Secondary Hotkey 10",
}
defineAction{
	default = { "sym:_MINUS:true:false:false:false" },
	type = "HOTKEY_SECOND_11",
	group = "hotkeys",
	name = "Secondary Hotkey 11",
}
defineAction{
	default = { "sym:_EQUALS:true:false:false:false" },
	type = "HOTKEY_SECOND_12",
	group = "hotkeys",
	name = "Secondary Hotkey 12",
}

-- Shift + Hotkeys
defineAction{
	default = { "sym:_1:false:true:false:false" },
	type = "HOTKEY_THIRD_1",
	group = "hotkeys",
	name = "Third Hotkey 1",
}
defineAction{
	default = { "sym:_2:false:true:false:false" },
	type = "HOTKEY_THIRD_2",
	group = "hotkeys",
	name = "Third Hotkey 2",
}
defineAction{
	default = { "sym:_3:false:true:false:false" },
	type = "HOTKEY_THIRD_3",
	group = "hotkeys",
	name = "Third Hotkey 3",
}
defineAction{
	default = { "sym:_4:false:true:false:false" },
	type = "HOTKEY_THIRD_4",
	group = "hotkeys",
	name = "Third Hotkey 4",
}
defineAction{
	default = { "sym:_5:false:true:false:false" },
	type = "HOTKEY_THIRD_5",
	group = "hotkeys",
	name = "Third Hotkey 5",
}
defineAction{
	default = { "sym:_6:false:true:false:false" },
	type = "HOTKEY_THIRD_6",
	group = "hotkeys",
	name = "Third Hotkey 6",
}
defineAction{
	default = { "sym:_7:false:true:false:false" },
	type = "HOTKEY_THIRD_7",
	group = "hotkeys",
	name = "Third Hotkey 7",
}
defineAction{
	default = { "sym:_8:false:true:false:false" },
	type = "HOTKEY_THIRD_8",
	group = "hotkeys",
	name = "Third Hotkey 8",
}
defineAction{
	default = { "sym:_9:false:true:false:false" },
	type = "HOTKEY_THIRD_9",
	group = "hotkeys",
	name = "Third Hotkey 9",
}
defineAction{
	default = { "sym:_0:false:true:false:false" },
	type = "HOTKEY_THIRD_10",
	group = "hotkeys",
	name = "Third Hotkey 10",
}
defineAction{
	default = { "sym:_MINUS:false:true:false:false" },
	type = "HOTKEY_THIRD_11",
	group = "hotkeys",
	name = "Third Hotkey 11",
}
defineAction{
	default = { "sym:_EQUALS:false:true:false:false" },
	type = "HOTKEY_THIRD_12",
	group = "hotkeys",
	name = "Third Hotkey 12",
}

-- Alt + Hotkeys
defineAction{
	default = { "sym:_1:false:false:true:false" },
	type = "HOTKEY_FOURTH_1",
	group = "hotkeys",
	name = "Fourth Hotkey 1",
}
defineAction{
	default = { "sym:_2:false:false:true:false" },
	type = "HOTKEY_FOURTH_2",
	group = "hotkeys",
	name = "Fourth Hotkey 2",
}
defineAction{
	default = { "sym:_3:false:false:true:false" },
	type = "HOTKEY_FOURTH_3",
	group = "hotkeys",
	name = "Fourth Hotkey 3",
}
defineAction{
	default = { "sym:_4:false:false:true:false" },
	type = "HOTKEY_FOURTH_4",
	group = "hotkeys",
	name = "Fourth Hotkey 4",
}
defineAction{
	default = { "sym:_5:false:false:true:false" },
	type = "HOTKEY_FOURTH_5",
	group = "hotkeys",
	name = "Fourth Hotkey 5",
}
defineAction{
	default = { "sym:_6:false:false:true:false" },
	type = "HOTKEY_FOURTH_6",
	group = "hotkeys",
	name = "Fourth Hotkey 6",
}
defineAction{
	default = { "sym:_7:false:false:true:false" },
	type = "HOTKEY_FOURTH_7",
	group = "hotkeys",
	name = "Fourth Hotkey 7",
}
defineAction{
	default = { "sym:_8:false:false:true:false" },
	type = "HOTKEY_FOURTH_8",
	group = "hotkeys",
	name = "Fourth Hotkey 8",
}
defineAction{
	default = { "sym:_9:false:false:true:false" },
	type = "HOTKEY_FOURTH_9",
	group = "hotkeys",
	name = "Fourth Hotkey 9",
}
defineAction{
	default = { "sym:_0:false:false:true:false" },
	type = "HOTKEY_FOURTH_10",
	group = "hotkeys",
	name = "Fourth Hotkey 10",
}
defineAction{
	default = { "sym:_MINUS:false:false:true:false" },
	type = "HOTKEY_FOURTH_11",
	group = "hotkeys",
	name = "Fourth Hotkey 11",
}
defineAction{
	default = { "sym:_EQUALS:false:false:true:false" },
	type = "HOTKEY_FOURTH_12",
	group = "hotkeys",
	name = "Fourth Hotkey 12",
}

-- Alt + Shift + Hotkeys
defineAction{
	default = { "sym:_1:false:true:true:false" },
	type = "HOTKEY_FIFTH_1",
	group = "hotkeys",
	name = "Fifth Hotkey 1",
}
defineAction{
	default = { "sym:_2:false:true:true:false" },
	type = "HOTKEY_FIFTH_2",
	group = "hotkeys",
	name = "Fifth Hotkey 2",
}
defineAction{
	default = { "sym:_3:false:true:true:false" },
	type = "HOTKEY_FIFTH_3",
	group = "hotkeys",
	name = "Fifth Hotkey 3",
}
defineAction{
	default = { "sym:_4:false:true:true:false" },
	type = "HOTKEY_FIFTH_4",
	group = "hotkeys",
	name = "Fifth Hotkey 4",
}
defineAction{
	default = { "sym:_5:false:true:true:false" },
	type = "HOTKEY_FIFTH_5",
	group = "hotkeys",
	name = "Fifth Hotkey 5",
}
defineAction{
	default = { "sym:_6:false:true:true:false" },
	type = "HOTKEY_FIFTH_6",
	group = "hotkeys",
	name = "Fifth Hotkey 6",
}
defineAction{
	default = { "sym:_7:false:true:true:false" },
	type = "HOTKEY_FIFTH_7",
	group = "hotkeys",
	name = "Fifth Hotkey 7",
}
defineAction{
	default = { "sym:_8:false:true:true:false" },
	type = "HOTKEY_FIFTH_8",
	group = "hotkeys",
	name = "Fifth Hotkey 8",
}
defineAction{
	default = { "sym:_9:false:true:true:false" },
	type = "HOTKEY_FIFTH_9",
	group = "hotkeys",
	name = "Fifth Hotkey 9",
}
defineAction{
	default = { "sym:_0:false:true:true:false" },
	type = "HOTKEY_FIFTH_10",
	group = "hotkeys",
	name = "Fifth Hotkey 10",
}
defineAction{
	default = { "sym:_MINUS:false:true:true:false" },
	type = "HOTKEY_FIFTH_11",
	group = "hotkeys",
	name = "Fifth Hotkey 11",
}
defineAction{
	default = { "sym:_EQUALS:false:true:true:false" },
	type = "HOTKEY_FIFTH_12",
	group = "hotkeys",
	name = "Fifth Hotkey 12",
}

defineAction{
	default = { "sym:_PAGEUP:false:false:false:false" },
	type = "HOTKEY_PREV_PAGE",
	group = "hotkeys",
	name = "Previous Hotkey Page",
}
defineAction{
	default = { "sym:_PAGEDOWN:false:false:false:false" },
	type = "HOTKEY_NEXT_PAGE",
	group = "hotkeys",
	name = "Next Hotkey Page",
}

