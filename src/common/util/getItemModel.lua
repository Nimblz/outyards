local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local model = ReplicatedStorage.model

local Items = require(common.Items)

local function nameMap(root,condition)
    assert(root and typeof(root) == "Instance", "Root must be an Instance! Got: "..typeof(root))
    condition = condition or function() return true end

    local result = {}
    for _,v in pairs(root:GetDescendants()) do
        if condition(v) then
            result[v.Name] = v
        end
    end

    return result
end

local weapons = nameMap(model:WaitForChild("weapon"), function(child)
    if child:FindFirstChild("grip") or child:FindFirstChild("Handle") then return true end
end)

local cataFuncs = {
    weapon = function(id, asset)
        local weaponModel = weapons[id]
        if not weaponModel then
            warn("weapon model "..id.." does not exist")
            return model:WaitForChild("error"):Clone()
        end
        local newWeaponModel = weaponModel:Clone()

        if newWeaponModel:IsA("BasePart") then
            newWeaponModel.Anchored = false
            newWeaponModel.Massless = true
            newWeaponModel.CanCollide = false
        else
            for _, child in pairs(newWeaponModel:GetDescendants()) do
                if child:IsA("BasePart") then
                    child.Anchored = false
                    child.Massless = true
                    child.CanCollide = false
                end
            end
        end

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
    pet = function(id, asset)
        local itemModel = model:WaitForChild("pet"):FindFirstChild(id)
        if not itemModel then
            warn("itemModel model "..id.." does not exist")
            return itemModel:WaitForChild("error"):Clone()
        end
        local newModel = itemModel:Clone()
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