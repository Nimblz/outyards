local targetDPS = 50
local fireRate = 2

return {
    id = "goldBow",
    name = "Gold Bow",
    tier = 3,

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(4,4),

    onlyOne = true,
    recipe = {
        goldIngot = 8,
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