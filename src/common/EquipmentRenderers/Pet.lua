local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local getItemModel = require(util.getItemModel)

local renderer = {
    id = "pet"
}

function renderer:create()
    self.viewModel = getItemModel(self.itemId)

    local root = self.character:WaitForChild("HumanoidRootPart")

    self.viewModel.CFrame = root.CFrame * CFrame.new(0,0,-5)
    self.cframe = self.viewModel.CFrame
    self.lastCF = self.cframe
    self.followDist = 8
    self.hoverTimeOffset = math.random()*math.pi*2
    self.cycleTime = 1/3

    self.viewModel.Parent = workspace
end

function renderer:update()
    local root = self.character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if not self.viewModel then return end

    local diffVector = self.cframe.p-root.Position
    local separationVector = diffVector.Unit * self.followDist
    local targetPos = root.Position + separationVector
    local targetCFrame = CFrame.new(targetPos) * (self.cframe - self.cframe.p)
    local heightOffset = math.sin(((tick() + self.hoverTimeOffset)*math.pi*2*self.cycleTime)%(math.pi*2))*0.5

    if (targetPos-self.lastCF.p).Magnitude > 0.3 then -- moving, need to turn
        targetCFrame = CFrame.new(targetPos,targetPos + (targetPos-self.lastCF.p))
        local offsetAttachment = self.viewModel:FindFirstChild("offset")
        if offsetAttachment then
            targetCFrame = targetCFrame * offsetAttachment.CFrame:inverse()
        end
    end


    self.offset = Vector3.new(0,heightOffset,0)
    self.cframe = self.cframe:lerp(targetCFrame,0.1)
    self.lastCF = self.cframe

    self.viewModel.CFrame = self.cframe + self.offset
end

function renderer:destroy()
    self.viewModel:destroy()
end

return renderer