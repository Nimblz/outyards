return function(state, action)
    if action.type == "ISEQUIPPING_SET" then
        return action.isEquipping
    end

    return state
end