-- +attack

return {
    id = "ironGauntlet",
    name = "Iron Gauntlet",
    equipmentType = "trinket",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,3),
    recipe = {
        leather = 40,
        wood = 20,
        ingotIron = 50,
        ingotCopper = 50,
    },

    stats = {
        defense = 10,
        baseDamage = 10,
        attackRate = 3,
    }
}