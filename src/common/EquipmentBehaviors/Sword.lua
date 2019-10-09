local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Animations = require(common:WaitForChild("Animations"))

local eAttackActor = event:WaitForChild("eAttackActor")

local behavior = {
    id = "sword"
}

function behavior:create()
    local humanoid = self.character:FindFirstChild("Humanoid")
    if not humanoid then return end
    local slashAnimation = Animations.swing
    local backSlashAnimation = Animations.backswing
    local holdAnimation = Animations.toolhold

    self.swingTrack = humanoid:LoadAnimation(slashAnimation)
    self.backSwingTrack = humanoid:LoadAnimation(backSlashAnimation)
    self.holdTrack = humanoid:LoadAnimation(holdAnimation)
end

function behavior:activated(props)
    self.props = props
    local mouse = props.mouse
    if not self.doBackSwing then
        self.doBackSwing = true
        self.backSwingTrack:stop()
        self.swingTrack:play()
    else
        self.doBackSwing = false
        self.swingTrack:stop()
        self.backSwingTrack:play()
    end

    local character = self.character
    local rootPart = character.PrimaryPart
    local rootCF = rootPart.CFrame
    local targetCFrame = rootCF * CFrame.new(0,0,-5)

    -- find npcs
    local cornerOffset = Vector3.new(1,1,1)*8
    local topCorner = targetCFrame.p + cornerOffset
    local bottomCorner = targetCFrame.p - cornerOffset
    local testRegion = Region3.new(bottomCorner,topCorner)

    local parts = workspace:FindPartsInRegion3WithWhiteList(testRegion, CollectionService:GetTagged("ActorStats"))

    for _,v in pairs(parts) do
        eAttackActor:FireServer(v)
    end
end

function behavior:deactivated()
end

function behavior:updateProps(newProps)
    self.props = newProps
end

function behavior:update()
end

function behavior:equipped()
    self.holdTrack:play()
end

function behavior:unequipped()
    self.holdTrack:stop()
end

function behavior:destroy()
end

return behavior