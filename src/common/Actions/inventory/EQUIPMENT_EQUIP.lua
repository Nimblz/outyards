return function(player, itemId)
    return {
        type = script.Name,
        player = player,
        itemId = itemId,

        replicateTo = player,
    }
end