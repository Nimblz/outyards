return function(state, action)
    if action.type == "SELECTEDITEM_SET" then
        return action.itemId
    end

    return state
end