return {
    id = "blackKnightSword",
    name = "Black Knight's Sword",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,10),

    stats = {
        baseDamage = 12,
    },

    metadata = {
        damageType = "melee",
        fireRate = 3,
        attackRange = 12,
        attackArc = 120, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}