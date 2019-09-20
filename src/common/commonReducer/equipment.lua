--[[
    
]]

return function(state,action)
    state = state or {}
    local newState = {}



    if action.type == "EQUIPMENT_EQUIP" then
        for id,quantity in pairs(state) do
            newState[id] = quantity
        end
        local itemQuantity = state[action.id]
        newState[action.id] = itemQuantity + action.quantity
        return newState
    end

    if action.type == "EQUIPMENT_UNEQUIP" then
        for id,quantity in pairs(state) do
            newState[id] = quantity
        end
        local itemQuantity = state[action.id]
        newState[action.id] = math.max(itemQuantity - action.quantity, 0)
        return newState
    end

    return state
end