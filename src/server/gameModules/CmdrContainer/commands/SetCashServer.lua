local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Actions = require(common:WaitForChild("Actions"))

return function(context, targetPlayer, amount)
    targetPlayer = targetPlayer or context.Executor
    local store = context.State.store

    if store then
        store:dispatch(Actions.CASH_SET(targetPlayer, amount))
    end
end