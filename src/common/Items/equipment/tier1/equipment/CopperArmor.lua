-- +defense

return {
    id = "copperArmor",
    name = "Copper Armor",
    tier = 1,

    equipmentType = "armor",
    behaviorType = "none",
    rendererType = "armor",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(2,1),

    onlyOne = true,
    recipe = {
        copperIngot = 25,
    },

    stats = {
        defense = 40,
    },

    tags = {
        "armor",
    },
}