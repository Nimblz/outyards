local targetDPS = 35
local fireRate = 1.1

return {
    id = "hammerIron",
    name = "Iron Hammer",
    tier = 2,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(3,2),

    onlyOne = true,
    recipe = {
        ingotIron = 10,
    },

    stats = {
        baseDamage = math.floor(targetDPS/fireRate),
    },

    metadata = {
        fireRate = fireRate,
        attackRange = 12,
        attackArc = 90, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}