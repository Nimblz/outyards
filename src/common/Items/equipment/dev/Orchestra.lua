return {
    id = "orchestra",
    name = "Orchestra",
    desc = "Chorus of screams.",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,11),

    onlyOne = true,
    recipe = {
        requiem = 1,
        symphony = 1,
        crescendo = 1,
    },

    stats = {
        baseDamage = 250,
    },

    metadata = {
        fireRate = 6,
        attackRange = 24,
        attackArc = 220, -- in degrees
    }
}