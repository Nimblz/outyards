local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local thunks = script:FindFirstAncestor("Thunks")
local stats = thunks:WaitForChild("stats")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))
local Actions = require(common:WaitForChild("Actions"))

local EQUIPMENT_APPLYSTATS = require(stats:WaitForChild("EQUIPMENT_APPLYSTATS"))

return function(player,itemToEquip)
    return function (store)
        local state = store:getState()

        local doesHave = Selectors.getItem(state, player, itemToEquip) > 0

        if doesHave then
            store:dispatch(Actions.EQUIPMENT_EQUIP(player, itemToEquip))
            store:dispatch(EQUIPMENT_APPLYSTATS(player))
        end
    end
end