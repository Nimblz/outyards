return function(state, action)
    state = state or 1

    if action.type == "MAGICMODIFIER_SET" then
        return action.modifier
    end

    return state
end