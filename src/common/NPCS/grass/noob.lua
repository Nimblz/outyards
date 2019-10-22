return {
    npcType = script.Name,
    name = "Noob",
    propsGenerator = function()
        return {
            ActorStats = {
                maxHealth = 1,
                health = 1,
                moveSpeed = 32,
            },
            ItemDrops = {
                items = {
                },
                cash = 100,
            }
        }
    end,
    boundingBoxProps = {
        Size = Vector3.new(2,4.5,2),
        Color = Color3.fromRGB(255, 231, 19),
    }
}