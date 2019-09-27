return function(state, action)

    if action.type == "TOOLTIP_VISIBLE_SET" then
        return action.visible
    end

    return state or false
end