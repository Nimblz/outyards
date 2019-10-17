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

    onlyOne = true,
    recipe = {
        wood = 1,
    },

    stats = {
        baseDamage = 500,
        moveSpeed = 50,
    },

    metadata = {
        fireRate = 5,
        attackRange = 12,
        attackArc = 180, -- in degrees
    }
}