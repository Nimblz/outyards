-- +defense

return {
    id = "hermesBoots",
    name = "Hermes Boots",
    equipmentType = "feet",
    spriteSheet = "armor",
    spriteCoords = Vector2.new(3,2),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 1,
    },

    stats = {
        moveSpeed = 50,
    }
}