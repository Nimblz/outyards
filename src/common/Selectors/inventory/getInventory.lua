local selectors = script:FindFirstAncestor("Selectors")
local getPlayerState = require(selectors.getPlayerState)

return function(state,player)
    local pstate = getPlayerState(state,player)
    if pstate then
        return pstate.inventory
    end
end