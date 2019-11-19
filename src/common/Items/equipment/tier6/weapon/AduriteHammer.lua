local targetDPS = 200
local fireRate = 1.3

return {
    id = "aduriteHammer",
    name = "Adurite Hammer",
    tier = 6,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(7,2),

    onlyOne = true,
    recipe = {
        aduriteIngot = 10,
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