return {
    id = "scatterblaster",
    name = "Scatterblaster",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(7,7),
    tier = 99,

    stats = {
        damageType = "ranged",
        baseDamage = 100,
    },

    metadata = {
        fireRate = 2,
        projectileType = "bullet",
        projectileCount = 9,
        projectileDeviation = 5,
        projectileMetadata = {
            color = Color3.new(1,0,0)
        }
    },

    tags = {
        "weapon",
        "ranged",
    },
}