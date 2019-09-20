return function(state, action)
    state = state or 0

    if action.type == "CASH_ADD" then
        return state + action.cash
    elseif action.type == "CASH_REMOVE" then
        return math.max(state - action.cash, 0)
    end

    return state
end