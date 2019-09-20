return function(player, itemId, quanitity)
    return {
        type = script.Name,
        player = player,
        itemId = itemId,
        quanitity = quanitity,

        replicateTo = player,
    }
end