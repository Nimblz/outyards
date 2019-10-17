-- +defense

return {
    id = "goldGodArmor",
    name = "Golden God Armor",
    equipmentType = "armor",
    spriteSheet = "armor",
    spriteCoords = Vector2.new(3,1),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 1,
    },

    stats = {
        moveSpeed = 50,
        defense = 99999999-100,
    }
}