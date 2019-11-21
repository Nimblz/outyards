return {
    npcType = script.Name,
    name = "Slime",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 3,
                health = 3,
                moveSpeed = 8,
                baseDamage = 1/4
            },
            ItemDrops = {
                items = {
                    {itemId = "slime", dropRange = {min = 50, max = 150}, dropRate = 1},
                    {itemId = "slimeSword", dropRange = {min = 50, max = 150}, dropRate = 1},
                },
                cash = 200,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(16,16,16),
        Color = Color3.fromRGB(140, 186, 212),
    },
}