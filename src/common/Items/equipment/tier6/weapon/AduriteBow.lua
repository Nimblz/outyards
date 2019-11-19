local targetDPS = 100
local fireRate = 2

return {
    id = "bowAdurite",
    name = "Adurite Bow",
    tier = 6,

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(7,4),

    onlyOne = true,
    recipe = {
        ingotAdurite = 8,
    },

    stats = {
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