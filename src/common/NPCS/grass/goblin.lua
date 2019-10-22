return {
    npcType = script.Name,
    name = "Goblin",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 20,
                health = 20,
                moveSpeed = 12,
            },
            ItemDrops = {
                items = {
                    {itemId = "leather", dropRange = {min = 1, max = 3}, dropRate = 0.75},
                    {itemId = "stone", dropRange = {min = 3, max = 3}, dropRate = 0.75},
                    {itemId = "wood", dropRange = {min = 1, max = 3}, dropRate = 0.75},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,4.5,2),
        Color = Color3.fromRGB(81, 204, 24),
    }
}