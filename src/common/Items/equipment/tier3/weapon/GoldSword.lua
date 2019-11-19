local targetDPS = 60
local fireRate = 2.5

return {
    id = "goldSword",
    name = "Gold Sword",
    tier = 3,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(4,1),

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
        attackRange = 12,
        attackArc = 120, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}