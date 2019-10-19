return {
    npcType = script.Name,
    name = "Big Slime",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 1500,
                health = 1500,
                moveSpeed = 5,
            },
            ItemDrops = {
                items = {
                    -- {itemId = "slime", dropRange = {min = 5, max = 15}, dropRate = 1},
                },
                cash = 5,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(6,6,6),
        Color = Color3.fromRGB(73, 133, 168),
    }
}