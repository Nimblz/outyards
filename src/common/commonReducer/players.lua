local Players = game:GetService("Players")
local playerState = require(script.Parent.playerState)

return (function(state,action)
    state = state or {}

    if action.player then
        local newPlayerState = {}
        for _,player in pairs(Players:GetPlayers()) do
            local playerKey = "player_"..player.UserId
            if player == action.player then -- we need to rebuild this player state
                newPlayerState[playerKey] = playerState(state[playerKey], action)
            else -- this state is untouched
                newPlayerState[playerKey] = state[playerKey]
            end
        end
        return newPlayerState
    end

    return state
end)