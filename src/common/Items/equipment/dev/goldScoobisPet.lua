-- +defense

return {
    id = "goldScoobisPet",
    name = "Golden Scoobis",
    desc = "Scoob!",
    tier = 1,

    equipmentType = "pet",
    behaviorType = "none",
    rendererType = "pet",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,3),

    metadata = {
        projectileType = "scoobis",
        fireRate = 10,
    }
}