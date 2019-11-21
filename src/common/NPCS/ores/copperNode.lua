return {
    npcType = script.Name,
    name = "Copper Ore",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 10,
                health = 10,
                moveSpeed = 0,
                baseDamage = 0
            },
            ItemDrops = {
                items = {
                    {itemId = "copperOre", dropRange = {min = 5, max = 15}, dropRate = 1},
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