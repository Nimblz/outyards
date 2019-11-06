return function(state, action)
    state = state or 0

    if action.type == "CASH_ADD" then
        return math.max(state + action.cash, 0)
    elseif action.type == "CASH_REMOVE" then
        return math.max(state - action.cash, 0)
    elseif action.type == "CASH_SET" then
        return action.cash or 0
    end

    return state
end