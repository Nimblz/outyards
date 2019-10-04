return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 15,
                health = 15,
                moveSpeed = 0,
            },
            ItemDrops = {
                items = {
                    {itemId = "wood", dropRange = {min = 15, max = 30}, dropRate = 1},
                },
                cash = 0,
            },
            AI = {
                aiType = "NoAI",
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,32,4),
        Color = Color3.fromRGB(95, 56, 33),
    }
}