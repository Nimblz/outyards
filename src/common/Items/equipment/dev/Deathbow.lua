return {
    id = "deathbow",
    name = "Deathbow",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(8,4),
    tier = 99,

    stats = {
        damageType = "ranged",
        baseDamage = 200,
    },

    metadata = {
        fireRate = 2,
        projectileType = "arrow",
        projectileCount = 1,
        projectileDeviation = 0,
    },

    tags = {
        "weapon",
        "ranged",
    }
}