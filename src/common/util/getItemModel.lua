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
        local newWeaponModel = weaponModel:Clone()
        newWeaponModel.Anchored = false
        newWeaponModel.Massless = true
        newWeaponModel.CanCollide = false

        return newWeaponModel
    end,
    trinket = function(id, asset)
        local trinketModel = model:WaitForChild("trinket"):FindFirstChild(id)
        if not trinketModel then
            warn("trinket model "..id.." does not exist")
            return model:WaitForChild("error"):Clone()
        end
        local newTrinketModel = trinketModel:Clone()
        newTrinketModel.Anchored = false
        newTrinketModel.Massless = true
        newTrinketModel.CanCollide = false

        return newTrinketModel
    end,
    armor = function(id, asset)
        local armorModel = model:WaitForChild("armor"):FindFirstChild(id)
        if not armorModel then
            warn("armor model "..id.." does not exist")
            return model:WaitForChild("error"):Clone()
        end
        local newArmorModel = armorModel:Clone()
        newArmorModel.Anchored = false
        newArmorModel.Massless = true
        newArmorModel.CanCollide = false

        return newArmorModel
    end,
    hat = function(id, asset)
        local hatModel = model:WaitForChild("hat"):FindFirstChild(id)
        if not hatModel then
            warn("hat model "..id.." does not exist")
            return model:WaitForChild("error"):Clone()
        end
        local newModel = hatModel:Clone()
        newModel.Anchored = false
        newModel.Massless = true
        newModel.CanCollide = false

        return newModel
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