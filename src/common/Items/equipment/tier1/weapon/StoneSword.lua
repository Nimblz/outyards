return {
    id = "swordStone",
    name = "Stone Shortsword",
    desc = "More of club than a sword",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,1),

    onlyOne = true,
    recipe = {
        wood = 10,
        stone = 15,
    },

    stats = {
        baseDamage = 2,
    },

    metadata = {
        fireRate = 2,
        attackRange = 7,
        attackArc = 120, -- in degrees
    }
}