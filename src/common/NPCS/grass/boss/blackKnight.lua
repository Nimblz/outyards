return {
    npcType = script.Name,
    name = "Black Knight",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 500,
                health = 500,
                moveSpeed = 24,
            },
            ItemDrops = {
                items = {
                    {itemId = "blackKnightSword", dropRange = {min = 1, max = 1}, dropRate = 1},
                },
                cash = 200,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,12,4),
        Color = Color3.fromRGB(51, 43, 53),
    },

    animations = {
        attack = "r6attack",
        chase = "r6run",
        idle = "r6idle",
    },
}