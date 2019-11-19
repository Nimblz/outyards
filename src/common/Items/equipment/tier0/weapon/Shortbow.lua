return {
    id = "shortbow",
    name = "Shortbow",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,4),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 10,
    },

    stats = {
        damageType = "ranged",
        baseDamage = 3,
    },

    metadata = {
        fireRate = 1,
        projectileType = "slowarrow",
        projectileCount = 1,
        projectileDeviation = 3,
    },

    tags = {
        "weapon",
        "ranged",
    },
}