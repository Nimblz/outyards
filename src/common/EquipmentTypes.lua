local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local by = require(util:WaitForChild("by"))

local catagories = {
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
    all = catagories,
    byId = by("id", catagories),
}