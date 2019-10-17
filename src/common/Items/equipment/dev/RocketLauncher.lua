return {
    id = "rocketlauncher",
    name = "Test Rocket",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,11),
    tier = 99,
    onlyOne = true,
    recipe = {
        wood = 1,
    },

    stats = {
        baseDamage = 99,
    },

    metadata = {
        fireRate = 1,
        projectileType = "rocket",
        projectileCount = 1,
        projectileDeviation = 2,
    }
}