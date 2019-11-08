local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local getItemModel = require(util.getItemModel)

local renderer = {
    id = "armor"
}

function renderer:create()
    local character = self.player.character or self.player.CharacterAdded:wait()
    local model = getItemModel(self.itemId)
    local upperTorso = character:WaitForChild("UpperTorso")
    local gripAttachment = model:FindFirstChild("attachment")
    assert(gripAttachment, "no attachment for model: "..self.itemId)

    local weld = Instance.new("ManualWeld")
    weld.Part0 = model
    weld.Part1 = upperTorso

    weld.C0 = gripAttachment.CFrame
    weld.C1 = upperTorso:WaitForChild("NeckRigAttachment").CFrame

    model.Parent = character
    model.Anchored = false
    model.CanCollide = false
    weld.Parent = model

    local modelMesh = model:WaitForChild("Mesh")
    local worldSize = model:WaitForChild("MeshWorldSize").Value
    modelMesh.Scale = ((upperTorso.Size + Vector3.new(0,0.25,0)) / worldSize) + Vector3.new(0.1,0.1,0.15)

    self.model = model
end

function renderer:destroy()
    self.model:destroy()
end

return renderer