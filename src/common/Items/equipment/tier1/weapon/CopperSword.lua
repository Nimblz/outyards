return {
    id = "swordCopper",
    name = "Copper Sword",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,1),

    onlyOne = true,
    recipe = {
        ingotCopper = 10,
    },

    stats = {
        baseDamage = 6,
    },

    metadata = {
        fireRate = 3,
        attackRange = 9,
        attackArc = 120, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}