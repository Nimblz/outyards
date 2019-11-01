-- +attack

return {
    id = "ironBoots",
    name = "Iron Boots",
    equipmentType = "feet",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(3,2),
    onlyOne = true,
    recipe = {
        ingotIron = 10,
    },

    stats = {
        defense = 30,
        moveSpeed = 10,
    },

    tags = {
        "armor",
    },
}