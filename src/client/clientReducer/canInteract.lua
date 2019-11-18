return function(state, action)
    if state == nil then
        return true
    end
    if action.type == "CANINTERACT_SET" then
        return action.canInteract
    end
    return state
end