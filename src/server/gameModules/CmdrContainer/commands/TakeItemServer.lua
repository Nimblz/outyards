local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Actions = require(common:WaitForChild("Actions"))

return function(context, itemId, targetPlayer, quantity)
    targetPlayer = targetPlayer or context.Executor
    local store = context.State.store

    if store then
        store:dispatch(Actions.ITEM_REMOVE(targetPlayer, itemId, quantity))
    end
end