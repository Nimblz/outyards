return {
    id = "goldBoots",
    name = "Gold Boots",
    tier = 3,

    equipmentType = "feet",

    spriteSheet = "armor",
    spriteCoords = Vector2.new(4,2),

    onlyOne = true,
    recipe = {
        goldIngot = 10,
    },

    stats = {
        defense = 50,
        moveSpeed = 10,
    },

    tags = {
        "armor",
    },
}