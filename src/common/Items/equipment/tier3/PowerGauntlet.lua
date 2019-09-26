-- +attack

return {
    id = "powerGauntlet",
    name = "Power Gauntlet",
    equipmentType = "trinket",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(7,3),
    recipe = {
        ingotVoid = 30,
        starCloth = 100,
        stardust = 150,
        powerShard = 5,
    },

    stats = {
        defense = 30,
        baseDamage = 30,
        attackRate = 5,
        autoAttack = true,
    }
}