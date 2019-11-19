local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local by = require(util.by)

local stats = {
    {
        id = "damageType",
        name = "Damage Type",
        desc = "Type of damage this weapon deals."
    },
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
        name = "Defense"
    },
    {
        id = "attackRate",
        name = "Attack Speed"
    },
    {
        id = "meleeModifier",
        name = "Melee Damage",
        desc = "Melee damage multiplier",
    },
    {
        id = "rangedModifier",
        name = "Ranged Damage",
        desc = "Ranged damage multiplier",
    },
    {
        id = "magicModifier",
        name = "Magic Damage",
        desc = "Magic damage multiplier",
    },
    {
        id = "moveSpeed",
        name = "Move Speed"
    }
}

return {
    all = stats,
    byId = by("id", stats)
}