local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))
local Actions = require(common:WaitForChild("Actions"))

local statActions = {
    baseDamage = "BASEDAMAGE_SET",
    attackRate = "ATTACKRATE_SET",
    attackRange = "ATTACKRANGE_SET",
    defense = "DEFENSE_SET",
    moveSpeed = "MOVESPEED_SET",
    autoAttack = "AUTOATTACK_SET",
}

local function applyStats(stats,item)
    item = Items.byId[item]
    if not item then return stats end
    if not item.stats then return stats end

    local newStats = {}

    for stat,value in pairs(stats) do
        newStats[stat] = value
    end

    for stat,value in pairs(item.stats) do
        if typeof(value) == "number" then
            newStats[stat] = newStats[stat] + value
        else
            newStats[stat] = newStats[stat] or value
        end
    end

    return newStats
end

return function(player)
    return function (store)
        store:dispatch(Actions.STATS_RESET(player))
        local state = store:getState()
        local equipment = Selectors.getEquipped(state,player)

        local stats = Selectors.getStats(state,player)
        -- for each piece of equipment apply stats

        stats = applyStats(stats, equipment.head)
        stats = applyStats(stats, equipment.armor)
        stats = applyStats(stats, equipment.feet)
        stats = applyStats(stats, equipment.trinket)
        stats = applyStats(stats, equipment.weapon)

        for stat, value in pairs(stats) do
            if statActions[stat] then
                local statChangeAction = Actions[statActions[stat]](player,value)
                store:dispatch(statChangeAction)
            end
        end
    end
end