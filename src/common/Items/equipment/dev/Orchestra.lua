return {
    id = "orchestra",
    name = "Orchestra",
    desc = "Chorus of screams.",
    tier = 9,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(5,10),

    onlyOne = true,
    recipe = {
        requiem = 1,
        symphony = 1,
        crescendo = 1,
    },

    stats = {
        damageType = "melee",
        baseDamage = 300,
        defense = 300,
        moveSpeed = 20,
    },

    metadata = {
        fireRate = 6,
        attackRange = 18,
        attackArc = 220, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}