local stats = script:FindFirstAncestor("stats")
local getStats = require(stats.getStats)

return function(state, player)
    local pstats = getStats(state,player)
    if pstats then
        return getStats(state,player).autoAttack
    end
end