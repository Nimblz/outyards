local targetDPS = 100
local fireRate = 2.5

return {
    id = "swordBluesteel",
    name = "Bluesteel Sword",
    tier = 4,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,1),

    onlyOne = true,
    recipe = {
        ingotBluesteel = 10,
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