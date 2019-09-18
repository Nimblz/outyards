local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local NPCDriverSystem = RECS.System:extend("NPCDriverSystem")

function NPCDriverSystem:init()
    -- on component add create a bodyvelocity bodyforce and bodygyro
    self.core:getComponentAddedSignal(RecsComponents.NPCDriver):connect(function(instance,component)
        local bodyVelocity = Instance.new("BodyVelocity")
        local bodyForce = Instance.new("BodyForce")
        local bodyGyro = Instance.new("BodyGyro")

        bodyVelocity.Parent = instance
        bodyForce.Parent = instance
        bodyGyro.Parent = instance
    end)
    self.core:getComponentRemovingSignal(RecsComponents.NPCDriver):connect(function(instance,component)
        local bodyVelocity = instance:FindFirstChild("BodyVelocity")
        local bodyForce = instance:FindFirstChild("BodyForce")
        local bodyGyro = instance:FindFirstChild("BodyGyro")

        bodyVelocity:Destroy()
        bodyForce:Destroy()
        bodyGyro:Destroy()
    end)
end

function NPCDriverSystem:step()
end

return NPCDriverSystem