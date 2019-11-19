return {
    id = "superrocketlauncher",
    name = "Super Rocket",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(3,12),
    tier = 99,

    stats = {
        damageType = "ranged",
        baseDamage = 99,
    },

    metadata = {
        fireRate = 3,
        projectileType = "rocket",
        projectileCount = 3,
        projectileDeviation = 6,
    },

    tags = {
        "weapon",
        "ranged",
    },
}