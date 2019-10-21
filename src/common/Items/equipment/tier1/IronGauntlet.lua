-- +attack

return {
    id = "ironGauntlet",
    name = "Iron Gauntlet",
    equipmentType = "trinket",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,3),
    onlyOne = true,
    recipe = {
        leather = 50,
        wood = 50,
        ingotIron = 20,
        ingotCopper = 20,
    },

    stats = {
        defense = 10,
        baseDamage = 10,
        attackRate = 3,
    }
}