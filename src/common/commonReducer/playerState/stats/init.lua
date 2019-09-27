local baseDamage = require(script:WaitForChild("baseDamage"))
local attackRate = require(script:WaitForChild("attackRate"))
local attackRange = require(script:WaitForChild("attackRange"))
local moveSpeed = require(script:WaitForChild("moveSpeed"))
local defense = require(script:WaitForChild("defense"))
local autoAttack = require(script:WaitForChild("autoAttack"))
local cash = require(script:WaitForChild("cash"))

return function(state,action)
    state = state or {}

    if action.type == "STATS_RESET" then
        state = {
            cash = state.cash
        }
    end
    return {
        baseDamage = baseDamage(state.baseDamage, action),
        attackRate = attackRate(state.attackRate, action),
        attackRange = attackRange(state.attackRange, action),
        moveSpeed = moveSpeed(state.moveSpeed, action),
        defense = defense(state.defense, action),
        autoAttack = autoAttack(state.autoAttack, action),
        cash = cash(state.cash, action),
    }
end