local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Actions = require(common.Actions)

return function(context, itemId, targetPlayer, quantity)
    targetPlayer = targetPlayer or context.Executor
    local store = context.State.store

    if store then
        store:dispatch(Actions.ITEM_ADD(targetPlayer, itemId, quantity))
    end
end