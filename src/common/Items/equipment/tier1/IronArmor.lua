-- +defense

return {
    id = "ironArmor",
    name = "Iron Armor",
    equipmentType = "armor",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,1),
    onlyOne = true,
    recipe = {
        leather = 80,
        ingotIron = 25,
        wood = 30,
        ingotCopper = 15,
    },

    stats = {
        defense = 75,
    }
}