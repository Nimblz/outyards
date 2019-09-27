-- +defense

return {
    id = "leatherArmor",
    name = "Leather Armor",
    equipmentType = "armor",
    spriteSheet = "armor",
    spriteCoords = Vector2.new(1,1),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 75,
        leather = 150,
    },

    stats = {
        defense = 25,
        moveSpeed = 5,
    }
}