return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 25,
                health = 25,
            },
            ItemDrops = {
                items = {
                    {itemId = "oreIron", dropRange = {min = 3, max = 10}, dropRate = 0.5},
                    {itemId = "oreCopper", dropRange = {min = 1, max = 10}, dropRate = 0.5},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,6,2),
        Color = Color3.fromRGB(218, 133, 65),
    }
}