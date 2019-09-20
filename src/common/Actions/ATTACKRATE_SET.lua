return function(player,attackRate)
    return {
        type = script.Name,
        player = player,
        attackRate = attackRate,

        replicateTo = player,
    }
end