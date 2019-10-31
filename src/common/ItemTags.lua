local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local by = require(util:WaitForChild("by"))

local tags = {
    {
        id = "material",
        name = "Material",
        icont = "",
    },
    {
        id = "melee",
        name = "Melee",
        icon = "",
    },
    {
        id = "ranged",
        name = "Ranged",
        icon = "",
    },
    {
        id = "magic",
        name = "Magic",
        icon = "",
    },
    {
        id = "reborn",
        name = "Reborn",
        icon = "",
    },
    {
        id = "event",
        name = "Event",
        icon = "",
    },
}

return {
    all = tags,
    byId = by("id", tags),
}