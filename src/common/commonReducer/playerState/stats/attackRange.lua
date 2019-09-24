return function(state, action)
    state = state or 8

    if action.type == "ATTACKRANGE_SET" then
        return action.attackRange
    end

    return state
end