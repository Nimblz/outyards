local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Items = require(common:WaitForChild("Items"))
local Actions = require(common:WaitForChild("Actions"))

return function(context, targetPlayer, quantity)
    targetPlayer = targetPlayer or context.Executor
    local store = context.State.store

    if store then
        for _, item in pairs(Items.all) do
            store:dispatch(Actions.ITEM_ADD(targetPlayer, item.id, quantity))
        end
    end
end