local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local getItemModel = require(util.getItemModel)

local renderer = {
    id = "hat"
}

function renderer:create()
    local character = self.player.character or self.player.CharacterAdded:wait()

    self.hats = {}

    for _,child in pairs(character:GetChildren()) do
        if child:IsA("Accoutrement") then
            local handle = child:FindFirstChild("Handle")
            if handle then
                self.hats[child] = {
                    originalTransparency = handle.Transparency
                }
            end

            handle.Transparency = 1
        end
    end

    local model = getItemModel(self.itemId)
    local head = character:WaitForChild("Head")
    local gripAttachment = model:FindFirstChild("hatAttachment")
    assert(gripAttachment, "no attachment for model: "..self.itemId)

    local weld = Instance.new("ManualWeld")
    weld.Part0 = model
    weld.Part1 = head

    weld.C0 = gripAttachment.CFrame
    weld.C1 = head:WaitForChild("HatAttachment").CFrame

    model.Parent = character
    model.Anchored = false
    model.CanCollide = false
    weld.Parent = model

    self.model = model
end

function renderer:destroy()
    if self.model then
        self.model:destroy()
    end

    for hat,desc in pairs(self.hats) do
        local handle = hat:FindFirstChild("Handle")
        if handle then
            handle.Transparency = desc.originalTransparency
        end
    end
end

return renderer