return {
    id = "swordSlime",
    name = "Slimy Katana",
    desc = "Ew! Sticky!",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "melee",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,1),

    onlyOne = true,
    recipe = {
        slime = 100,
    },

    stats = {
        baseDamage = 3,
    },

    metadata = {
        fireRate = 2,
        attackRange = 12,
        attackArc = 180, -- in degrees
    }
}