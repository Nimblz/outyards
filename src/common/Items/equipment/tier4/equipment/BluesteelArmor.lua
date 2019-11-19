return {
    id = "bluesteelArmor",
    name = "Bluesteel Armor",
    tier = 4,

    equipmentType = "armor",
    behaviorType = "none",
    rendererType = "armor",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(5,1),

    onlyOne = true,
    recipe = {
        ingotBluesteel = 25,
    },

    stats = {
        defense = 250,
    },

    tags = {
        "armor",
    },
}