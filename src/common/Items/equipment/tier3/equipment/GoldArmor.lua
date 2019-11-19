return {
    id = "goldArmor",
    name = "Gold Armor",
    tier = 3,

    equipmentType = "armor",
    behaviorType = "none",
    rendererType = "armor",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(4,1),

    onlyOne = true,
    recipe = {
        goldIngot = 25,
    },

    stats = {
        defense = 150,
    },

    tags = {
        "armor",
    },
}