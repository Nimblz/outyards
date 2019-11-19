local targetDPS = 200
local fireRate = 1.3

return {
    id = "viridiumHammer",
    name = "Viridium Hammer",
    tier = 5,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(6,2),

    onlyOne = true,
    recipe = {
        viridiumIngot = 10,
    },

    stats = {
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