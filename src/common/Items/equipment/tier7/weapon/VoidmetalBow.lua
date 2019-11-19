local targetDPS = 170
local fireRate = 2

return {
    id = "voidmetalBow",
    name = "Voidmetal Bow",
    tier = 7,

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(8,4),

    onlyOne = true,
    recipe = {
        voidmetalIngot = 8,
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