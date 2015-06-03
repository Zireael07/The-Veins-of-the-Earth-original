--Veins of the Earth
--Zireael 2015

local function store_money(npc, player, sum)
    --take the money away
    player:incMoney(-sum)

    --charge the 5% fee
    local depo = player:bankCharge(sum)

    --keep the rest in bank
    player:incBank(math.max(depo))
end

local function withdraw_money(npc, player, sum)
    --if no sum specified we withdraw everything
    if not sum then sum = (player.bank_money or 0) end

    player:incBank(-sum)
    player:incMoney(sum)
end

newChat{id="start",
    text=[[Welcome! Maybe you want to store some money with us?]],
    answers = {
        {[[No, I have no need of your services.]], cond=function(npc, player)
        if player:getInt() < 10 then return end
        return true
    end},
        {[[Me no need bank.]], cond=function(npc, player)
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Yes, I would like to withdraw my money.]], action = withdraw_money(npc, player),
        cond=function(npc, player)
        if player.bank_money <= 0 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Yes, I would like to store 1 gold piece.]], action = store_money(npc, player, 200),
        cond=function(npc, player)
        if player.money < 200 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Yes, I would like to store 2 gold pieces.]], action = store_money(npc, player, 400),
        cond=function(npc, player)
        if player.money < 400 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Yes, I would like to store 4 gold pieces.]], action = store_money(npc, player, 800),
        cond=function(npc, player)
        if player.money < 800 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Yes, I would like to store 1 platinum piece.]], action = store_money(npc, player, 2000),
        cond=function(npc, player)
        if player.money < 2000 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
    --The dumb versions
        {[[Me want my money.]], action = withdraw_money(npc, player),
        cond=function(npc, player)
        if player.bank_money < 0 then return end
        if player:getInt() < 10 then return end
        return true
    end
    },
        {[[Me want save one gold.]], action = store_money(npc, player, 200),
        cond=function(npc, player)
        if player.money < 200 then return end
        if player:getInt() >= 10 then return end
        return true
    end
    },
        {[[Me want save two gold.]], action = store_money(npc, player, 400),
        cond=function(npc, player)
            if player.money < 400 then return end
            if player:getInt() >= 10 then return end
            return true
        end
    },
        {[[Me want save four gold.]], action = store_money(npc, player, 800),
        cond=function(npc, player)
        if player.money < 800 then return end
        if player:getInt() >= 10 then return end
        return true
        end
        },
        {[[Me want save one platinum.]], action = store_money(npc, player, 2000),
        cond=function(npc, player)
        if player.money < 2000 then return end
        if player:getInt() >= 10 then return end
        return true
        end
        },
    {[[Back away.]], action = function(npc, player) player:displace(npc) end    },
    },
}

return "start"
