return {
    npcType = script.Name,
    name = "Armored Ogre",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 75,
                health = 75,
                moveSpeed = 18,
            },
            ItemDrops = {
                items = {
                    {itemId = "ironOre", dropRange = {min = 2, max = 4}, dropRate = 0.75},
                    {itemId = "goldOre", dropRange = {min = 1, max = 3}, dropRate = 0.2},
                },
                cash = 10,
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