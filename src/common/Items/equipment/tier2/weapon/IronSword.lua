return {
    id = "ironSword",
    name = "Iron Sword",
    tier = 2,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(3,1),

    onlyOne = true,
    recipe = {
        ironIngot = 10,
    },

    stats = {
        damageType = "melee",
        baseDamage = 10,
    },

    metadata = {
        fireRate = 2.5,
        attackRange = 9,
        attackArc = 120, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}