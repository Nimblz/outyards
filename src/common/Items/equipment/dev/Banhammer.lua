return {
    id = "banhammer",
    name = "Banhammer",
    desc = "Exploiters hate him!",
    tier = 99,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,11),

    stats = {
        baseDamage = 9999,
        moveSpeed = 50,
        defense = 9999,
    },

    metadata = {
        fireRate = 5,
        attackRange = 16,
        attackArc = 180, -- in degrees
        hitSound = "banned",
        swingSound = "hammer",
    },

    tags = {
        "reborn",
        "weapon",
        "melee",
    }
}