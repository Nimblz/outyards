return {
    id = "crescendo",
    name = "Crescendo",
    desc = "Strange runes are inscibed on the hilt...",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,10),

    stats = {
        baseDamage = 100,
        moveSpeed = 10,
        defense = -10,
    },

    metadata = {
        fireRate = 5,
        attackRange = 12,
        attackArc = 180, -- in degrees
    }
}