return function(player,baseDamage)
    return {
        type = script.Name,
        player = player,
        baseDamage = baseDamage,

        replicateTo = player,
    }
end