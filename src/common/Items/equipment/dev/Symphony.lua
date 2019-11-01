return {
    id = "symphony",
    name = "Symphony",
    desc = "Strange runes are inscibed on the hilt...",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(3,10),

    stats = {
        baseDamage = 75,
        defense = 200,
    },

    metadata = {
        fireRate = 3,
        attackRange = 12,
        attackArc = 180, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}