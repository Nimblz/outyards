return {
    npcType = script.Name,
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 5,
                health = 5,
                moveSpeed = 8,
            },
            ItemDrops = {
                items = {
                    {itemId = "slime", dropRange = {min = 1, max = 3}, dropRate = 0.75},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(3,3,3),
        Color = Color3.fromRGB(140, 186, 212),
    }
}