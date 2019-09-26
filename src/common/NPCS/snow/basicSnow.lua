return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 60,
                health = 60,
            },
            ItemDrops = {
                items = {
                    {itemId = "stardust", dropRange = {min = 5, max = 10}, dropRate = 0.5},
                    {itemId = "starCloth", dropRange = {min = 5, max = 10}, dropRate = 0.5},
                    {itemId = "oreVoid", dropRange = {min = 5, max = 10}, dropRate = 0.5},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,6,2),
        Color = Color3.fromRGB(110, 153, 202),
    }
}