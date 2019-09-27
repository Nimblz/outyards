-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer

local src = script:FindFirstAncestor("server")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")

local Items = require(common:WaitForChild("Items"))
local Actions = require(common:WaitForChild("Actions"))

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local SpinnySystem = RECS.System:extend("SpinnySystem")

function SpinnySystem:onComponentAdded(instance, component)
    component.origCFrame = instance.CFrame
end

function SpinnySystem:init()
    for instance,component in self.core:components(RecsComponents.Spinny) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.Spinny):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
end

function SpinnySystem:step()
    for instance,spinnyComponent in self.core:components(RecsComponents.Spinny) do
        local hoverSin = (tick() * spinnyComponent.hoverRate) % (math.pi * 2)
        local hover = math.sin(hoverSin) * spinnyComponent.hoverDist
        local spinAngle = (tick() * spinnyComponent.spinRate) % (math.pi * 2)
        local spin = CFrame.new(0,hover,0) * CFrame.Angles(0,spinAngle,0)
        instance.CFrame = spinnyComponent.origCFrame * spin
    end
end

return SpinnySystem