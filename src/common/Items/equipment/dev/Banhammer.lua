return {
    id = "banhammer",
    name = "Banhammer",
    desc = "Exploiters hate him!",
    tier = 99,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(8,10),

    stats = {
        baseDamage = 9999,
        moveSpeed = 50,
        defense = 9999,
    },

    metadata = {
        fireRate = 10,
        attackRange = 16,
        attackArc = 180, -- in degrees
        hitSound = "banned"
    }
}