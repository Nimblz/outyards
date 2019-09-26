return function(state, action)

    if action.type == "TOOLTIP_STRINGS_SET" then
        return action.strings
    end

    return state or {}
end