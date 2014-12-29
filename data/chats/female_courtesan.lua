--Veins of the Earth
--Zireael 2014

--Let's get this on, shall we?
newChat{id="start",
    text=[[Hello handsome! Are you interested in some girls?]],
    answers = {
        {[[Oh yeah!]], action = function(npc, player)
        --Deduce the gold
        player.money = player.money - 10
        --rest
        if rng.dice(1,20) + player:getConMod() > 18 then
            player.kid = true
            player.kid_date = game.calendar:getDayOfYear(self.turn)
        end
    end,
    cond=function(npc, player)
            if player.money < 10 then return end
            return true
        end
    },
        {[[No, I have no need of your services.]], cond=function(npc, player) 
        if player:getInt() < 10 then return end
        return true
    end},
        {[[I no want you.]], cond=function(npc, player) 
        if player:getInt() > 10 then return end
        return true
    end}
    },
}

--Wrong sex!
newChat{id="welcome",
    text = [[Oh girl, I think you might be more interested in one of the guys...]],
    answers = {
        {[[I suppose so.]], cond=function(npc, player) 
        if player:getInt() < 10 then return end
        return true
    end},
        {[[Yeah.]], cond=function(npc, player) 
        if player:getInt() > 10 then return end
        return true
    end}
    },
}

return (game.player.descriptor.sex == "Male") and "start" or "welcome"