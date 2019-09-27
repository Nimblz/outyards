return function(state, action)
    state = state or 1

    if action.type == "DEFENSE_SET" then
        return action.defense
    end

    return state
end