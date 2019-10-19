return {
    npcType = script.Name,
    name = "Goblin",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 1000,
                health = 1000,
                moveSpeed = 12,
            },
            ItemDrops = {
                items = {
                    -- {itemId = "leather", dropRange = {min = 5, max = 15}, dropRate = 0.75},
                    -- {itemId = "stone", dropRange = {min = 5, max = 15}, dropRate = 0.75},
                    -- {itemId = "wood", dropRange = {min = 5, max = 15}, dropRate = 0.75},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,6,2),
        Color = Color3.fromRGB(81, 204, 24),
    }
}