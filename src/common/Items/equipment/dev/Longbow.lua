return {
    id = "longbow",
    name = "Longbow",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,4),
    tier = 99,

    stats = {
        baseDamage = 200,
    },

    metadata = {
        fireRate = 3/2,
        projectileType = "arrow",
        projectileCount = 1,
        projectileDeviation = 0,
    }
}