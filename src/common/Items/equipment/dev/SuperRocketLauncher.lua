return {
    id = "superrocketlauncher",
    name = "Super Rocket",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(7,7),
    tier = 99,
    onlyOne = true,
    recipe = {
        wood = 1,
    },

    stats = {
        baseDamage = 99,
    },

    metadata = {
        fireRate = 3,
        projectileType = "rocket",
        projectileCount = 3,
        projectileDeviation = 3,
    }
}