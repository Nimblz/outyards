return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 5,
                health = 5,
                moveSpeed = 0,
            },
            ItemDrops = {
                items = {
                    {itemId = "wood", dropRange = {min = 5, max = 15}, dropRate = 1},
                },
                cash = 0,
            },
            AI = {
                aiType = "NoAI",
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,16,2),
        Color = Color3.fromRGB(95, 56, 33),
    }
}