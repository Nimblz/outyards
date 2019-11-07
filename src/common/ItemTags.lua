local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local by = require(util:WaitForChild("by"))

local tags = {
    {
        id = "all",
        name = "All",
        prefix = "⁉",
    },
    {
        id = "material",
        name = "Material",
        prefix = "🌳",
    },
    {
        id = "weapon",
        name = "Weapon",
        prefix = "💀",
    },
    {
        id = "armor",
        name = "Armor",
        prefix = "👚",
    },
    {
        id = "trinket",
        name = "Trinket",
        prefix = "⚓"
    },
    {
        id = "melee",
        name = "Melee",
        prefix = "⚔",
    },
    {
        id = "ranged",
        name = "Ranged",
        prefix = "🔫",
    },
    {
        id = "magic",
        name = "Magic",
        prefix = "✨",
    },
    {
        id = "pet",
        name = "Pet",
        prefix = "🐶"
    },
    {
        id = "cosmetic",
        name = "Cosmetic",
        prefix = "👑"
    },
    {
        id = "reborn",
        name = "Reborn",
        prefix = "🌟"
    },
    {
        id = "event",
        name = "Event",
        prefix = "🎊"
    },
}

return {
    all = tags,
    byId = by("id", tags),
}