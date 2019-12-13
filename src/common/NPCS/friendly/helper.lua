return {
    npcType = script.Name,
    name = "Helper",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 99999,
                health = 99999,
                moveSpeed = 0,
                baseDamage = 0,
                knockbackMultiplier = 0,
                friendly = true,
            },
            AI = {
                aiType = "NoAI",
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,4.5,2),
        Color = Color3.fromRGB(255, 231, 19),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}