local targetDPS = 200
local fireRate = 3

return {
    id = "swordVoidmetal",
    name = "Voidmetal Sword",
    tier = 7,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(8,1),

    onlyOne = true,
    recipe = {
        ingotVoidmetal = 10,
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