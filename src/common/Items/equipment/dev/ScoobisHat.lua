-- +defense

return {
    id = "scoobisHat",
    name = "Scoobis Hat",
    desc = "Scoob!",
    tier = 1,

    equipmentType = "hat",
    behaviorType = "none",
    rendererType = "hat",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(1,3),

    stats = {
        moveSpeed = 1000,
        baseDamage = 99999,
        attackRate = 10,
        defense = 9999999999,
    },

    tags = {
        "armor",
        "reborn",
    },
}