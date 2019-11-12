return function(state, action)
    if action.type == "TARGETINTERACTABLE_SET" then
        return action.interactable
    end
    return state
end