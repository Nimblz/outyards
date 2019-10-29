local targetDPS = 15
local fireRate = 1.5

return {
    id = "bowCopper",
    name = "Copper Bow",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,4),
    tier = 1,
    onlyOne = true,
    recipe = {
        ingotCopper = 8,
    },

    stats = {
        baseDamage = targetDPS/fireRate,
    },

    metadata = {
        fireRate = fireRate,
        projectileType = "arrow",
        projectileCount = 1,
        projectileDeviation = 3,
    }
}