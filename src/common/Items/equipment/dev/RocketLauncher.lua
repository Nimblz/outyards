return {
    id = "rocketlauncher",
    name = "Test Rocket",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,12),
    tier = 99,

    stats = {
        damageType = "ranged",
        baseDamage = 99,
    },

    metadata = {
        fireRate = 1,
        projectileType = "rocket",
        projectileCount = 1,
        projectileDeviation = 2,
    },

    tags = {
        "weapon",
        "ranged",
    },
}