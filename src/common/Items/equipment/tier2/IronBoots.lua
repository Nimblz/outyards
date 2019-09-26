-- +attack

return {
    id = "ironBoots",
    name = "Iron Boots",
    equipmentType = "feet",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,2),
    recipe = {
        leather = 40,
        wood = 20,
        ingotIron = 30,
        ingotCopper = 30,
    },

    stats = {
        defense = 25,
        moveSpeed = 10,
    }
}