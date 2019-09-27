return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 5,
                health = 5,
                moveSpeed = 10,
            },
            ItemDrops = {
                items = {
                    {itemId = "wood", dropRange = {min = 3, max = 10}, dropRate = 0.75},
                    {itemId = "leather", dropRange = {min = 3, max = 10}, dropRate = 0.75},
                    {itemId = "brick", dropRange = {min = 1, max = 3}, dropRate = 0.5},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,6,2),
        Color = Color3.fromRGB(190, 104, 98),
    }
}