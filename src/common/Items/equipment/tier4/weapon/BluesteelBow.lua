local targetDPS = 70
local fireRate = 2

return {
    id = "bluesteelBow",
    name = "Bluesteel Bow",
    tier = 4,

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,4),

    onlyOne = true,
    recipe = {
        bluesteelIngot = 8,
    },

    stats = {
        damageType = "ranged",
        baseDamage = math.floor(targetDPS/fireRate),
    },

    metadata = {
        fireRate = fireRate,
        projectileType = "arrow",
        projectileCount = 1,
        projectileDeviation = 3,
    },

    tags = {
        "weapon",
        "ranged",
    },
}