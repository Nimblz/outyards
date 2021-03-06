local baseDamage = require(script.baseDamage)
local attackRate = require(script.attackRate)
local moveSpeed = require(script.moveSpeed)
local defense = require(script.defense)
local meleeModifier = require(script.meleeModifier)
local rangedModifier = require(script.rangedModifier)
local magicModifier = require(script.magicModifier)
local cash = require(script.cash)

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
        meleeModifier = meleeModifier(state.meleeModifier, action),
        rangedModifier = rangedModifier(state.rangedModifier, action),
        magicModifier = magicModifier(state.magicModifier, action),
        moveSpeed = moveSpeed(state.moveSpeed, action),
        defense = defense(state.defense, action),
        cash = cash(state.cash, action),
    }
end