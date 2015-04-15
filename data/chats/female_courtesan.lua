--Veins of the Earth
--Zireael 2014-2015

--Let's get this on, shall we?
newChat{id="start",
    text=[[Hello handsome! Are you interested in some girls?]],
    answers = {
        {[[Oh yeah!]], action = function(npc, player)
        --Deduce the silver
        player:incMoney(-10)
        --rest
        player:cityRest()
        --normal healing
        --use Wis instead of Con if have Mind over Body feat
        local con = player:getCon()
        local heal = ((player.level +3)*con)/5

        --Heal skill
        if (player.skill_heal or 0) > 0 then
             heal = ((player.level + player.skill_heal +3)*con)/5
        end

        player.life = math.min(player.max_life, player.life + heal)

        --heal one wound
        if player.wounds < player.max_wounds then
            player.wounds = player.wounds + 1
        end

        --chance to get a kid
        if rng.dice(1,20) + player:getConMod() > 18 and not npc.pregnant then
            npc.pregnant = true
            kid = player:generateKid(npc)
            player.kid_date = game.calendar:getDayOfYear(game.turn)

            local x, y = util.findFreeGrid(player.x, player.y, 1, true, {[engine.Map.ACTOR]=true})
            game.zone:addEntity(game.level, kid, "actor", x, y)
            player:addKid(kid)

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
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Back away.]], action = function(npc, player) player:displace(npc) end    },
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
        if player:getInt() >= 10 then return end
        return true
    end},
        {[[Back away.]], action = function(npc, player) player:displace(npc) end    },
    },
}

return (game.player.descriptor.sex == "Male") and "start" or "welcome"
