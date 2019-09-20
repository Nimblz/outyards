
return function(state,action)
    state = state or {
        head = nil,
        armor = nil,
        boots = nil,
        trinket = nil,
        weapon = nil,
    }

    if action.type == "EQUIPMENT_EQUIP" then
        -- get equipment type
        -- apply to correct slot
        -- if not equipment then do nothing
    end

    if action.type == "EQUIPMENT_UNEQUIP" then
        -- get equipment type
        -- set slot to nil
    end

    return state
end