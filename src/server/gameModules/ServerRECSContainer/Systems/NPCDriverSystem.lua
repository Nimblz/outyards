-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer
local PhysicsService = game:GetService("PhysicsService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local NPCDriverSystem = RECS.System:extend("NPCDriverSystem")

function NPCDriverSystem:onComponentChange(instance, component)
    local bodyVelocity = instance:FindFirstChild("BodyVelocity")
    local bodyForce = instance:FindFirstChild("BodyForce")
    local bodyGyro = instance:FindFirstChild("BodyGyro")

    if not bodyVelocity then return end
    if not bodyForce then return end
    if not bodyGyro then return end

    bodyVelocity.MaxForce = component.maxMoveForce
    bodyVelocity.Velocity = component.targetVelocity
    bodyForce.Force = Vector3.new(0, instance:GetMass() * workspace.Gravity * (1-component.gravityWeight), 0)
    bodyGyro.MaxTorque = Vector3.new(20000,20000,20000)
    bodyGyro.P = 5000
    bodyGyro.D = 500
    bodyGyro.CFrame = CFrame.new(Vector3.new(0,0,0),component.targetDirection)
end

function NPCDriverSystem:onComponentAdded(instance, component)
    -- on component add create a bodyvelocity bodyforce and bodygyro
    local bodyVelocity = Instance.new("BodyVelocity")
    local bodyForce = Instance.new("BodyForce")
    local bodyGyro = Instance.new("BodyGyro")

    component.changed:connect(function(prop, new, old)
        self:onComponentChange(instance, component)
    end)

    bodyVelocity.Parent = instance
    bodyForce.Parent = instance
    bodyGyro.Parent = instance

    PhysicsService:SetPartCollisionGroup(instance,"monsters")

    self:onComponentChange(instance,component)
end

function NPCDriverSystem:onComponentRemoving(instance,component)
    local bodyVelocity = instance:FindFirstChild("BodyVelocity")
    local bodyForce = instance:FindFirstChild("BodyForce")
    local bodyGyro = instance:FindFirstChild("BodyGyro")

    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    if bodyForce then
        bodyForce:Destroy()
    end
    if bodyGyro then
        bodyGyro:Destroy()
    end
end

function NPCDriverSystem:init()
    for instance,component in self.core:components(RecsComponents.NPCDriver) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.NPCDriver):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.NPCDriver):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function NPCDriverSystem:step()
end

return NPCDriverSystem