return {
    npcType = script.Name,
    name = "Goblin",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 10,
                health = 10,
                moveSpeed = 16,
                baseDamage = 10
            },
            ItemDrops = {
                items = {
                    {itemId = "pumpkin", dropRange = {min = 1, max = 1}, dropRate = 1},
                },
                cash = 20,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,4.5,2),
        Color = Color3.fromRGB(255, 123, 0),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}