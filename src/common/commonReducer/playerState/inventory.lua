return function(state,action)
    state = state or {}
    local newState = {}



    if action.type == "ITEM_ADD" then
        for id,quantity in pairs(state) do
            newState[id] = quantity
        end
        local itemQuantity = state[action.itemId] or 0
        newState[action.id] = itemQuantity + action.quantity
        return newState
    end

    if action.type == "ITEM_REMOVE" then
        for id,quantity in pairs(state) do
            newState[id] = quantity
        end
        local itemQuantity = state[action.itemId]
        newState[action.id] = math.max(itemQuantity - action.quantity, 0)
        return newState
    end

    return state
end