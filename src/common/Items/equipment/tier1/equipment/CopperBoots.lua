-- +attack

return {
    id = "copperBoots",
    name = "Copper Boots",
    equipmentType = "feet",
    tier = 1,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,2),
    onlyOne = true,
    recipe = {
        copperIngot = 10,
    },

    stats = {
        defense = 20,
        moveSpeed = 5,
    },

    tags = {
        "armor",
    },
}