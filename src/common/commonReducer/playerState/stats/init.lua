local baseDamage = require(script:WaitForChild("baseDamage"))
local attackRate = require(script:WaitForChild("attackRate"))
local attackRange = require(script:WaitForChild("attackRange"))
local moveSpeed = require(script:WaitForChild("moveSpeed"))
local defense = require(script:WaitForChild("defense"))
local meleeModifier = require(script:WaitForChild("meleeModifier"))
local rangedModifier = require(script:WaitForChild("rangedModifier"))
local magicModifier = require(script:WaitForChild("magicModifier"))
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
        meleeModifier = meleeModifier(state.meleeModifier, action),
        rangedModifier = rangedModifier(state.rangedModifier, action),
        magicModifier = magicModifier(state.magicModifier, action),
        moveSpeed = moveSpeed(state.moveSpeed, action),
        defense = defense(state.defense, action),
        cash = cash(state.cash, action),
    }
end