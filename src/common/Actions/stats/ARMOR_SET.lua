return function(player, armor)
    return {
        type = script.Name,
        player = player,
        armor = armor,

        replicateTo = player,
    }
end