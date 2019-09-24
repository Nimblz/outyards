return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 24,
                health = 24,
                moveSpeed = 10,
            },
            ItemDrops = {
                items = {
                    {itemId = "wood", dropRange = {min = 10, max = 30}, dropRate = 1.0},
                    {itemId = "stone", dropRange = {min = 10, max = 30}, dropRate = 1.0},
                    {itemId = "leather", dropRange = {min = 10, max = 30}, dropRate = 1.0},
                },
                cash = 5,
            }
        }
    end,
}