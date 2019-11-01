return {
    id = "hammerCopper",
    name = "Copper Hammer",
    desc = "Slow and powerful",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(2,2),

    onlyOne = true,
    recipe = {
        ingotCopper = 10,
    },

    stats = {
        baseDamage = 22,
    },

    metadata = {
        fireRate = 1,
        attackRange = 12,
        attackArc = 90, -- in degrees
    },

    tags = {
        "weapon",
        "melee",
    },
}