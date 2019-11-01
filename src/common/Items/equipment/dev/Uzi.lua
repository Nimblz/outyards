return {
    id = "uzi",
    name = "Uzi",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,8),
    tier = 99,

    stats = {
        baseDamage = 40,
    },

    metadata = {
        fireRate = 10,
        projectileType = "bullet",
        projectileCount = 1,
        projectileDeviation = 3,
    },

    tags = {
        "weapon",
        "ranged",
    },
}