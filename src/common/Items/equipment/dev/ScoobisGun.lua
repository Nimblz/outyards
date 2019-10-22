-- +defense

return {
    id = "scoobisGun",
    name = "Scoobis Gun",
    desc = "Scoob!",
    tier = 1,

    equipmentType = "weapon",
    behaviorType = "gun",
    rendererType = "oneHandedWeapon",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(1,3),

    stats = {
        moveSpeed = 64,
        baseDamage = 99999,
        attackRate = 10,
        defense = 10^12,
    },

    metadata = {
        projectileType = "scoobis",
        fireRate = 10,
    }
}