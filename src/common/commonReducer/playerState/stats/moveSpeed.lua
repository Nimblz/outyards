return function(state, action)
    state = state or 16

    if action.type == "MOVESPEED_SET" then
        return action.moveSpeed
    end

    return state
end