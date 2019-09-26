return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 50,
                health = 50,
                moveSpeed = 10,
            },
            ItemDrops = {
                items = {
                    {itemId = "oreIron", dropRange = {min = 10, max = 30}, dropRate = 1},
                    {itemId = "oreCopper", dropRange = {min = 10, max = 30}, dropRate = 1},
                },
                cash = 5,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,9,4),
        Color = Color3.fromRGB(170, 85, 0),
    }
}