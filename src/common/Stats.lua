local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local by = require(util.by)

local stats = {
    {
        id = "baseDamage",
        name = "Damage"
    },
    {
        id = "defense",
        name = "Damage"
    },
    {
        id = "defense",
        name = "Damage"
    },
}

return {
    all = stats,
    byId = by("id", stats)
}