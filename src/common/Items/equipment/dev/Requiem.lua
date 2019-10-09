return {
    id = "requiem",
    name = "Requiem",
    desc = "Strange runes are inscibed on the hilt...",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,1),

    stats = {
        baseDamage = 100,
    },

    metadata = {
        fireRate = 3,
        attackRange = 18,
        attackArc = 180, -- in degrees
    }
}