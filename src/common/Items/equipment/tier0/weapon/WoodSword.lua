return {
    id = "swordWood",
    name = "Wooden Shortsword",
    desc = "More of stick than a sword",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,1),

    onlyOne = true,
    recipe = {
        wood = 10,
    },

    stats = {
        baseDamage = 2,
    },

    metadata = {
        fireRate = 2,
        attackRange = 9,
        attackArc = 120, -- in degrees
    }
}