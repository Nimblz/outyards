return function(state, action)
    state = state or 0

    if action.type == "ARMOR_SET" then
        return action.armor
    end

    return state
end