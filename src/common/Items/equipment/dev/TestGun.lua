return {
    id = "testgun",
    name = "Test Gun",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,4),
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
        fireRate = 30,
        projectileType = "superbullet",
        projectileCount = 3,
        projectileDeviation = 3,
    }
}