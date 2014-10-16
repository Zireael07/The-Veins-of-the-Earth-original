--Veins of the Earth
--Zireael 2014

-- Check for unidentified stuff
local function can_auto_id(npc, player)
    for inven_id, inven in pairs(player.inven) do
        for item, o in ipairs(inven) do
            if not o:isIdentified() then return true end
        end
    end
end

newChat{id="start",
    text=[[Welcome! Maybe you need me to identify an item?]]
    answers = {
        {[[Yes, please.]], action = function(npc, player)
        player:incMoney(-1100)
        --ID item

    end,
    cond=function(npc, player)
            if not can_auto_id then return end
            if player.money < 1100 then return end
            return true
        end
    },
        {[[No, I have no need of your services.]]},
    },
}