return {
    npcType = script.Name,
    name = "Black Knight",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 1000,
                health = 1000,
                moveSpeed = 24,
            },
            ItemDrops = {
                items = {
                },
                cash = 2000,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(4,8,4),
        Color = Color3.fromRGB(51, 43, 53),
    }
}