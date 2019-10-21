local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local thunks = script:FindFirstAncestor("Thunks")
local stats = thunks:WaitForChild("stats")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))
local Actions = require(common:WaitForChild("Actions"))

local EQUIPMENT_APPLYSTATS = require(stats:WaitForChild("EQUIPMENT_APPLYSTATS"))

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