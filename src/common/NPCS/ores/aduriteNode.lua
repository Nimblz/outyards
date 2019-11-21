return {
    npcType = script.Name,
    name = "Adurite Ore",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 500,
                health = 500,
                moveSpeed = 0,
                baseDamage = 0
            },
            ItemDrops = {
                items = {
                    {itemId = "aduriteOre", dropRange = {min = 5, max = 15}, dropRate = 1},
                },
                cash = 0,
            },
            AI = {
                aiType = "NoAI",
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(6,4,6),
        Color = Color3.fromRGB(84, 87, 88),
    }
}