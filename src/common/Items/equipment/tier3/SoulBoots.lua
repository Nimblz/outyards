-- +defense

return {
    id = "soulBoots",
    name = "Soul Boots",
    equipmentType = "feet",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(7,2),
    recipe = {
        ingotVoid = 15,
        stardust = 150,
        starCloth = 100,
        powerShard = 1,
    },

    stats = {
        defense = 50,
        moveSpeed = 20,
    }
}