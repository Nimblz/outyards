local targetDPS = 100
local fireRate = 3

return {
    id = "bluesteelSword",
    name = "Bluesteel Sword",
    tier = 4,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,1),

    onlyOne = true,
    recipe = {
        bluesteelIngot = 10,
    },

    stats = {
        damageType = "melee",
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