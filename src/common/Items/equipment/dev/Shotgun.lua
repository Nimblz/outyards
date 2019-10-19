return {
    id = "shotgun",
    name = "Shotgun",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,7),
    tier = 99,
    onlyOne = true,
    recipe = {
        wood = 1,
    },

    stats = {
        baseDamage = 80,
    },

    metadata = {
        fireRate = 3/2,
        projectileType = "bullet",
        projectileCount = 8,
        projectileDeviation = 5,
    }
}