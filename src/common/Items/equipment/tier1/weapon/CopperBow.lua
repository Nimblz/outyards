local targetDPS = 15
local fireRate = 1.5

return {
    id = "copperBow",
    name = "Copper Bow",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,4),
    tier = 1,
    onlyOne = true,
    recipe = {
        copperIngot = 8,
    },

    stats = {
        damageType = "ranged",
        baseDamage = targetDPS/fireRate,
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