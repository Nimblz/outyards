-- +attack

return {
    id = "ironBoots",
    name = "Iron Boots",
    equipmentType = "feet",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,2),
    onlyOne = true,
    recipe = {
        leather = 50,
        wood = 50,
        ingotIron = 10,
        ingotCopper = 10,
    },

    stats = {
        defense = 25,
        moveSpeed = 10,
    }
}