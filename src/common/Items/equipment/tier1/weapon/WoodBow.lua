return {
    id = "shortbow",
    name = "Shortbow",

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "weapon",
    spriteCoords = Vector2.new(1,4),
    tier = 1,
    onlyOne = true,
    recipe = {
        wood = 15,
        stone = 10,
    },

    stats = {
        baseDamage = 4,
    },

    metadata = {
        fireRate = 2
    }
}