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
                    {itemId = "stone", dropRange = {min = 1, max = 5}, dropRate = 1},
                },
                cash = 0,
            },
            AI = {
                aiType = "NoAI",
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,4,4),
        Color = Color3.fromRGB(91, 93, 105),
    }
}