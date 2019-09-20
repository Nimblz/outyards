local baseDamage = require(script.Parent:WaitForChild("baseDamage"))
local attackRate = require(script.Parent:WaitForChild("attackRate"))
local attackRange = require(script.Parent:WaitForChild("attackRange"))
local cash = require(script.Parent:WaitForChild("cash"))

return (function(state,action)
    state = state or {}

    state.baseDamage = baseDamage(state.baseDamage, action)
    state.attackRate = attackRate(state.attackRate, action)
    state.attackRange = attackRange(state.attackRange, action)
    state.cash = cash(state.cash, action)

    return state
end)