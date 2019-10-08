local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local model = ReplicatedStorage:WaitForChild("model")

local Items = require(common:WaitForChild("Items"))

local cataFuncs = {
    weapon = function(id, asset)
        local weaponModel = model:WaitForChild("weapon"):FindFirstChild(id)
        if not weaponModel then
            warn("weapon model "..id.." does not exist")
            return model:WaitForChild("error"):Clone()
        end
        return weaponModel:Clone()
    end,
}

return function(id)
    local item = Items.byId[id]
    assert(item, "Invalid item id, cannot produce model")
    local equipmentType = item.equipmentType
    assert(equipmentType, "Item must have a type to produce model, got nil")
    assert(cataFuncs[equipmentType], "Model rendering for this type not implemented yet. :(")
    return cataFuncs[equipmentType](id,item)
end