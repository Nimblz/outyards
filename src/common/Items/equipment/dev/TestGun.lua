return {
    id = "testgun",
    name = "Test Gun",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(3,8),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 15,
        stone = 10,
    },

    stats = {
        baseDamage = 999,
    },

    metadata = {
        fireRate = 10,
        projectileType = "superbullet",
        projectileCount = 3,
        projectileDeviation = 3,
    }
}