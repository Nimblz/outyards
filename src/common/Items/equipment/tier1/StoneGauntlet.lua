-- +attack

return {
    id = "stoneGauntlet",
    name = "Stone Gauntlet",
    equipmentType = "trinket",
    spriteSheet = "armor",
    spriteCoords = Vector2.new(1,3),
    tier = 1,
    onlyOne = true,
    recipe = {
        brick = 15,
        wood = 100,
        leather = 50,
    },

    stats = {
        baseDamage = 4,
        attackRate = 2,
    }
}