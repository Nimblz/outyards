-- +defense

return {
    id = "ironArmor",
    name = "Iron Armor",
    equipmentType = "armor",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,1),
    recipe = {
        leather = 80,
        ingotIron = 50,
        wood = 30,
        ingotCopper = 20,
    },

    stats = {
        defense = 75,
    }
}