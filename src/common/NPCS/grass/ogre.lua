return {
    npcType = script.Name,
    name = "Ogre",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 25,
                health = 25,
                moveSpeed = 14,
            },
            ItemDrops = {
                items = {
                    {itemId = "oreCopper", dropRange = {min = 1, max = 3}, dropRate = 0.75},
                },
                cash = 5,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,12,4),
        Color = Color3.fromRGB(105, 141, 88),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}