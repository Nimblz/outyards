local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local thunks = script:FindFirstAncestor("Thunks")
local stats = thunks.stats

local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local EQUIPMENT_APPLYSTATS = require(stats.EQUIPMENT_APPLYSTATS)

return function(player,itemId)
    return function (store)
        local state = store:getState()

        local doesHaveEquipped = Selectors.getIsEquipped(state, player, itemId)

        if doesHaveEquipped then
            store:dispatch(Actions.EQUIPMENT_UNEQUIP(player, itemId))
            store:dispatch(EQUIPMENT_APPLYSTATS(player))
        end
    end
end