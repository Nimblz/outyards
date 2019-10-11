return function(state, action)
    state = state or false

    if action.type == "VIEW_CRAFTING_SETVISIBLE" then
        return action.visible
    end

    return state
end