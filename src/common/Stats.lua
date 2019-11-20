local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local by = require(util.by)

local stats = {
    {
        id = "baseDamage",
        name = "Damage",
        desc = "Base amount of damage dealt to monsters."
    },
    {
        id = "armor",
        name = "Armor"
    },
    {
        id = "defense",
        name = "Defense",
        isNormal = true,
        suffix = "%",
    },
    {
        id = "attackRate",
        name = "Attack Speed",
        isNormal = true,
        suffix = "%",
    },
    {
        id = "meleeModifier",
        name = "Melee Damage",
        desc = "Melee damage multiplier",
        isNormal = true,
        suffix = "%",
    },
    {
        id = "rangedModifier",
        name = "Ranged Damage",
        desc = "Ranged damage multiplier",
        isNormal = true,
        suffix = "%",
    },
    {
        id = "magicModifier",
        name = "Magic Damage",
        desc = "Magic damage multiplier",
        isNormal = true,
        suffix = "%",
    },
    {
        id = "moveSpeed",
        name = "Move Speed",
    }
}

return {
    all = stats,
    byId = by("id", stats)
}