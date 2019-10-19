return function(player, index, itemId)
    return {
        type = script.Name,
        player = player,
        index = index,
        itemId = itemId,

        replicateTo = player,
    }
end