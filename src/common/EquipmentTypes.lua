local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local by = require(util.by)

local equippables = {
    {
        id = "weapon",
    },
    {
        id = "armor",
    },
    {
        id = "hat",
    },
    {
        id = "feet",
    },
    {
        id = "trinket",
    },
}

return {
    all = equippables,
    byId = by("id", equippables),
}