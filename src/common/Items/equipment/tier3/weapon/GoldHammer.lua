local targetDPS = 70
local fireRate = 1.3

return {
    id = "goldHammer",
    name = "Gold Hammer",
    tier = 3,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(4,2),

    onlyOne = true,
    recipe = {
        goldIngot = 10,
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