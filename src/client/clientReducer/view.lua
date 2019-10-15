return function(state, action)

    if action.type == "VIEW_SET" then
        return action.viewId
    end

    return state or "default"
end