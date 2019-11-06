return function(player, cash)
    return {
        type = script.Name,
        player = player,
        cash = cash,

        replicateTo = player,
    }
end