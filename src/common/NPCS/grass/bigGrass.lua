return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 15,
                health = 15,
                moveSpeed = 10,
            },
            ItemDrops = {
                items = {
                    {itemId = "wood", dropRange = {min = 10, max = 30}, dropRate = 1.0},
                    {itemId = "brick", dropRange = {min = 5, max = 15}, dropRate = 1.0},
                    {itemId = "leather", dropRange = {min = 10, max = 30}, dropRate = 1.0},
                },
                cash = 5,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,9,4),
        Color = Color3.fromRGB(163, 75, 75),
    }
}