return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 120,
                health = 120,
                moveSpeed = 10,
            },
            ItemDrops = {
                items = {
                    {itemId = "stardust", dropRange = {min = 15, max = 40}, dropRate = 0.5},
                    {itemId = "starCloth", dropRange = {min = 15, max = 40}, dropRate = 0.5},
                    {itemId = "oreVoid", dropRange = {min = 15, max = 40}, dropRate = 0.5},
                    {itemId = "powerShard", dropRange = {min = 1, max = 1}, dropRate = 1},
                },
                cash = 5,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,9,4),
        Color = Color3.fromRGB(51, 88, 130),
    }
}