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
        stone = 15,
        leather = 10,
    },

    stats = {
        baseDamage = 4,
        attackRate = 2,
    }
}