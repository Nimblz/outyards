return function(player, itemId, quantity)
    return {
        type = script.Name,
        player = player,
        itemId = itemId,
        quantity = quantity or 1,

        replicateTo = player,
    }
end