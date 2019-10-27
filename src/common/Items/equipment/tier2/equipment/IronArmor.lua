-- +defense

return {
    id = "ironArmor",
    name = "Iron Armor",
    tier = 2,

    equipmentType = "armor",
    behaviorType = "none",
    rendererType = "armor",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(3,1),

    onlyOne = true,
    recipe = {
        ingotIron = 25,
    },

    stats = {
        defense = 70,
    }
}