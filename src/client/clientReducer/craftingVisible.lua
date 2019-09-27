return function(state, action)
    state = state or false

    if action.type == "VIEW_CRAFTING_TOGGLE" then
        return not state
    end
end