return {
    npcType = script.Name,
    name = "Ogre King",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 500,
                health = 500,
                moveSpeed = 28,
                aggroRadius = 96,
                baseDamage = 20,
                attackRate = 1/2,
                knockbackMultiplier = 5,
            },
            ItemDrops = {
                items = {
                    {itemId = "kingCrown", dropRange = {min = 1, max = 1}, dropRate = 1},
                },
                cash = 200,
            },
            AI = {
                aiType = "OgreKing",
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(16,24,4),
        Color = Color3.fromRGB(51, 43, 53),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}