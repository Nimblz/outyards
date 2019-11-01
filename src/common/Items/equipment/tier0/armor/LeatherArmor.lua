-- +defense

return {
    id = "leatherArmor",
    name = "Leather Armor",
    tier = 1,

    equipmentType = "armor",
    behaviorType = "none",
    rendererType = "armor",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(1,1),

    onlyOne = true,
    recipe = {
        wood = 10,
        leather = 30,
    },

    stats = {
        defense = 25,
    },

    tags = {
        "armor",
    },
}