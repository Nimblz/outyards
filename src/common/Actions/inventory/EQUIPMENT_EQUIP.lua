return function(player, itemId, index)
    index = index or 1
    return {
        type = script.Name,
        player = player,
        itemId = itemId,
        index = index,

        replicateBroadcast = true,
    }
end