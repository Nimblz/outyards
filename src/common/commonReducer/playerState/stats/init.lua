local baseDamage = require(script:WaitForChild("baseDamage"))
local attackRate = require(script:WaitForChild("attackRate"))
local attackRange = require(script:WaitForChild("attackRange"))
local cash = require(script:WaitForChild("cash"))

return (function(state,action)
    state = state or {}

    state.baseDamage = baseDamage(state.baseDamage, action)
    state.attackRate = attackRate(state.attackRate, action)
    state.attackRange = attackRange(state.attackRange, action)
    state.cash = cash(state.cash, action)

    return state
end)