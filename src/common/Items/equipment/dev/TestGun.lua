return {
    id = "testgun",
    name = "Test Gun",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(4,8),
    tier = 99,

    stats = {
        baseDamage = 50,
    },

    metadata = {
        fireRate = 15,
        projectileType = "superbullet",
        projectileCount = 2,
        projectileDeviation = 5,
    },

    tags = {
        "weapon",
        "ranged",
        "reborn",
    },
}