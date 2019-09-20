return function(state, action)
    state = state or 1

    if action.type == "ATTACKRATE_SET" then
        return action.attackRate
    end

    return state
end