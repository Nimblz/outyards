local targetDPS = 150
local fireRate = 3

return {
    id = "aduriteSword",
    name = "Adurite Sword",
    tier = 6,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(7,1),

    onlyOne = true,
    recipe = {
        aduriteIngot = 10,
    },

    stats = {
        baseDamage = math.floor(targetDPS/fireRate),
    },

    metadata = {
        fireRate = fireRate,
        attackRange = 12,
        attackArc = 120, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}