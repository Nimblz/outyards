local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Actions = require(common.Actions)

return function(context, targetPlayer, amount)
    targetPlayer = targetPlayer or context.Executor
    local store = context.State.store

    if store then
        store:dispatch(Actions.CASH_ADD(targetPlayer, amount))
    end
end