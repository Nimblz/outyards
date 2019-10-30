return {
    npcType = script.Name,
    name = "Ogre King",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 500,
                health = 500,
                moveSpeed = 28,
            },
            ItemDrops = {
                items = {
                    {itemId = "oreBluesteel", dropRange = {min = 75, max = 150}, dropRate = 1},
                    {itemId = "oreGold", dropRange = {min = 100, max = 200}, dropRate = 1},
                },
                cash = 2000,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(8,24,4),
        Color = Color3.fromRGB(51, 43, 53),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}