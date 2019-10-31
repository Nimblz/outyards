return {
    npcType = script.Name,
    name = "Goblin",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 5,
                health = 5,
                moveSpeed = 12,
                baseDamage = 1
            },
            ItemDrops = {
                items = {
                    {itemId = "leather", dropRange = {min = 1, max = 3}, dropRate = 0.75},
                    {itemId = "wood", dropRange = {min = 1, max = 3}, dropRate = 0.75},
                },
                cash = 1,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,4.5,2),
        Color = Color3.fromRGB(81, 204, 24),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}