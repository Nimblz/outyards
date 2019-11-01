-- +defense

return {
    id = "leatherBoots",
    name = "Leather Boots",
    equipmentType = "feet",
    spriteSheet = "armor",
    spriteCoords = Vector2.new(1,2),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 10,
        leather = 30,
    },

    stats = {
        defense = 10,
        moveSpeed = 5,
    },

    tags = {
        "armor",
    },
}