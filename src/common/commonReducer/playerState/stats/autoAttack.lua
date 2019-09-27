return function(state, action)
    state = state or false

    if action.type == "AUTOATTACK_SET" then
        return action.autoAttack
    end

    return state
end