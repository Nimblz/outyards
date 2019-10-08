return {
    id = "requiem",
    name = "Requiem",
    desc = "Strange runes are inscibed on the hilt...",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "sword",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,1),

    stats = {
        baseDamage = 100,
    },

    metadata = {
        fireRate = 5,
        attackDepth = 24,
        attackArc = 180, -- in degrees
    }
}