local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local getItemModel = require(util.getItemModel)

local renderer = {
    id = "oneHandedWeapon"
}

local function convertToModel(part)
    local newModel = Instance.new("Model")

    part.Parent = newModel
    part.Name = "Handle"
    newModel.PrimaryPart = part

    return newModel
end

local function weldifyModel(model)
    local handle = model.PrimaryPart or model:FindFirstChild("Handle")

    local weldsFolder = Instance.new("Folder")
    weldsFolder.Name = "welds"
    weldsFolder.Parent = model

    for _, child in pairs(model:GetDescendants()) do
        if child:IsA("BasePart") then
            local newWeld = Instance.new("WeldConstraint")
            newWeld.Part0 = handle
            newWeld.Part1 = child

            newWeld.Parent = weldsFolder
        end
    end
end

local function addTransparencyLocks(model)
    for _,child in pairs(model:GetDescendants()) do
        if child:IsA("BasePart") then
            local transparencyLock = Instance.new("BoolValue")
            transparencyLock.Name = "TransparencyLock"
            transparencyLock.Value = true
            transparencyLock.Parent = child

            child.Anchored = false
            child.CanCollide = false
        end
    end
end


function renderer:create()
    local character = self.player.character or self.player.CharacterAdded:wait()
    local weaponModel = getItemModel(self.itemId)
    local rightHand = character:WaitForChild("RightHand", 5)
    local rightHandAttachment = rightHand:WaitForChild("RightGripAttachment", 5)

    assert(rightHand, "Character has no right hand!")
    assert(rightHandAttachment, "Character has no right grip attachment!")

    -- if the model is a part, convert it into the model weapon format, then run the model weapon equipping

    if weaponModel:IsA("BasePart") then
        weaponModel = convertToModel(weaponModel)
    end

    weldifyModel(weaponModel)
    addTransparencyLocks(weaponModel)

    do -- weld model to hand
        local handle = weaponModel.PrimaryPart
        local gripAttachment = handle:FindFirstChild("grip") or handle:FindFirstChild("Grip")
        assert(gripAttachment, "no grip for model: "..self.itemId)

        local weld = Instance.new("ManualWeld")
        weld.Part0 = handle
        weld.Part1 = rightHand

        weld.C0 = gripAttachment.CFrame
        weld.C1 = rightHandAttachment.CFrame

        weaponModel.Parent = character
        weld.Parent = handle
    end

    self.model = weaponModel
end

function renderer:destroy()
    if self.model then
        self.model:destroy()
    end
end

return renderer