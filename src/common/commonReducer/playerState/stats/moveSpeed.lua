local StarterPlayer = game:GetService("StarterPlayer")

local DEFAULT_SPEED = StarterPlayer.CharacterWalkSpeed

return function(state, action)
    state = state or DEFAULT_SPEED

    if action.type == "MOVESPEED_SET" then
        return action.moveSpeed
    end

    return state
end