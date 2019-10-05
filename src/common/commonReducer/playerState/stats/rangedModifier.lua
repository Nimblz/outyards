return function(state, action)
    state = state or 1

    if action.type == "RANGEDMODIFIER_SET" then
        return action.rangedModifier
    end

    return state
end