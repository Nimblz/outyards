return {
    npcType = script.Name,
    name = "Scoobis",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 1,
                health = 1,
                moveSpeed = 64,
            },
            ItemDrops = {
                items = {
                    {itemId = "testgun", dropRange = {min = 1, max = 1}, dropRate = 1},
                },
                cash = 999999,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(8,8,8),
        Color = Color3.fromRGB(255, 193, 143),
    }
}