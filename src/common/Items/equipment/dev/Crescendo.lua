return {
    id = "crescendo",
    name = "Crescendo",
    desc = "Strange runes are inscibed on the hilt...",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(6,1),

    stats = {
        baseDamage = 100,
    },

    metadata = {
        fireRate = 10,
        attackRange = 18,
        attackArc = 180, -- in degrees
    }
}