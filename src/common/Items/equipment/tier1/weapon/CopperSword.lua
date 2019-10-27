return {
    id = "swordIron",
    name = "Iron Sword",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,1),

    onlyOne = true,
    recipe = {
        ingotIron = 10,
    },

    stats = {
        baseDamage = 8,
    },

    metadata = {
        fireRate = 3,
        attackRange = 9,
        attackArc = 120, -- in degrees
    }
}