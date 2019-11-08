local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local by = require(util.by)

local catagories = {
    {
        id = "weapon",
        name = "Weapon",
        icon = "",
    },
    {
        id = "armor",
        name = "Armor",
        icon = "",
    },
    {
        id = "hat",
        name = "Hat",
        icon = "",
    },
    {
        id = "feet",
        name = "Feet",
        icon = "",
    },
    {
        id = "trinket",
        name = "Trinket",
        icon = "",
    },
}

return {
    all = catagories,
    byId = by("id", catagories),
}