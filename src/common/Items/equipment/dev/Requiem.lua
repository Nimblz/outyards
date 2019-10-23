return {
    id = "requiem",
    name = "Requiem",
    desc = "Strange runes are inscibed on the hilt...",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(4,10),

    stats = {
        baseDamage = 150,
    },

    metadata = {
        fireRate = 3,
        attackRange = 12,
        attackArc = 180, -- in degrees
    }
}