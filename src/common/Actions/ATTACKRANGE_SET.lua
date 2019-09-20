return function(player,attackRange)
    return {
        type = script.Name,
        player = player,
        attackRange = attackRange,

        replicateTo = player,
    }
end