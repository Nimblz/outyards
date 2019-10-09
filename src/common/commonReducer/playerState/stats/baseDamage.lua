return function(state, action)
    state = state or 0

    if action.type == "BASEDAMAGE_SET" then
        return action.baseDamage
    end

    return state
end