local good = [[You are an outcast, fleeing from your evil brethren.

Brave adventurer, you are now lost in the underground corridors of the #SANDY_BROWN#Veins of the Earth#LAST#. There is no way to return to your homeland.

How long can you survive...?

Press ESC or click to close.]]

local evil = [[You were leading a war party in the wilds. However, things took a turn for the worse and you are now the only survivor.

Brave adventurer, you are now lost in the underground corridors of the #SANDY_BROWN#Veins of the Earth#LAST#. There is no way to return to your homeland.

How long can you survive...?

Press ESC or click to close.

]]

return game.player:isPlayerGood() and good or evil