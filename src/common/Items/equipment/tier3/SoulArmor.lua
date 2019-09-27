-- +defense

return {
    id = "soulArmor",
    name = "Soul Armor",
    equipmentType = "armor",
    tier = 2,
    spriteSheet = "armor",
    spriteCoords = Vector2.new(7,1),
    recipe = {
        ingotVoid = 50,
        stardust = 150,
        starCloth = 150,
        powerShard = 3,
    },

    stats = {
        defense = 150,
        moveSpeed = 10,
    }
}