return function(player, itemId, quantity)
    return {
        type = script.Name,
        player = player,
        itemId = itemId,
        quantity = quantity,

        replicateTo = player,
    }
end