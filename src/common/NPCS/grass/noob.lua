return {
    npcType = script.Name,
    name = "Noob",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 1,
                health = 1,
                moveSpeed = 32,
                baseDamage = 1/5,
            },
            ItemDrops = {
                items = {
                    {itemId = "banhammer", dropRange = {min = 1, max = 1}, dropRate = 1/500},
                },
                cash = 100,
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