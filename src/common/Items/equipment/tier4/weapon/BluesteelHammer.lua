local targetDPS = 120
local fireRate = 1.3

return {
    id = "hammerBluesteel",
    name = "Bluesteel Hammer",
    tier = 4,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,2),

    onlyOne = true,
    recipe = {
        ingotBluesteel = 10,
    },

    stats = {
        damageType = "melee",
        baseDamage = math.floor(targetDPS/fireRate),
    },

    metadata = {
        fireRate = fireRate,
        attackRange = 14,
        attackArc = 90, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}