local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)
local Items = require(common.Items)

return function(state,action)
    state = state or {
        head = nil,
        armor = nil,
        feet = nil,
        trinket = nil,
        weapon = nil,
    }

    if action.type == "EQUIPMENT_EQUIP" then
        -- get equipment type
        -- apply to correct slot
        -- if not equipment then do nothing

        local item = Items.byId[action.itemId]
        if not item then return state end
        local equipmentType = item.equipmentType
        if not equipmentType then return state end
        return Dictionary.join(state, {[equipmentType] = action.itemId})
    end

    if action.type == "EQUIPMENT_UNEQUIP" then
        -- get equipment type
        -- set slot to nil
        local item = Items.byId[action.itemId]
        if not item then return state end
        local equipmentType = item.equipmentType
        if not equipmentType then return state end
        return Dictionary.join(state, {[equipmentType] = Dictionary.None})
    end

    return state
end