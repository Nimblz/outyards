return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 8,
                health = 8,
            },
            ItemDrops = {
                items = {
                    {itemId = "wood", dropRange = {min = 1, max = 3}, dropRate = 0.5},
                    {itemId = "leather", dropRange = {min = 1, max = 3}, dropRate = 0.5},
                    {itemId = "stone", dropRange = {min = 1, max = 3}, dropRate = 0.5},
                },
                cash = 1,
            }
        }
    end
}