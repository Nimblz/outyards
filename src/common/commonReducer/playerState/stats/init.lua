local baseDamage = require(script:WaitForChild("baseDamage"))
local attackRate = require(script:WaitForChild("attackRate"))
local attackRange = require(script:WaitForChild("attackRange"))
local cash = require(script:WaitForChild("cash"))

return function(state,action)
    state = state or {}

    if action.type == "STATS_RESET" then
        state = {}
    end

    return {
        baseDamage = baseDamage(state.baseDamage, action),
        attackRate = attackRate(state.attackRate, action),
        attackRange = attackRange(state.attackRange, action),
        cash = cash(state.cash, action),
    }
end