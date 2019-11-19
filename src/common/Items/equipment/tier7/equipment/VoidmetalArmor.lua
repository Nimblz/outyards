return {
    id = "voidmetalArmor",
    name = "Voidmetal Armor",
    tier = 7,

    equipmentType = "armor",
    behaviorType = "none",
    rendererType = "armor",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(8,1),

    onlyOne = true,
    recipe = {
        voidmetalIngot = 25,
    },

    stats = {
        defense = 600,
    },

    tags = {
        "armor",
    },
}