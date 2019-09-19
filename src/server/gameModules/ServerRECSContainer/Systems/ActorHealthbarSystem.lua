-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local template = ReplicatedStorage:WaitForChild("template")
-- local util = common:WaitForChild("util")

local healthbarTemplate = template:WaitForChild("Healthbar")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local ActorHealthbarSystem = RECS.System:extend("ActorHealthbarSystem")



function ActorHealthbarSystem:onComponentChange(instance, component)
    local healthbar = instance:FindFirstChild("Healthbar")
    if not healthbar then return end
    local redFrame = healthbar:WaitForChild("redFrame")
    local greenFrame = redFrame:WaitForChild("greenFrame")

    local health = component.health
    local maxHealth = component.maxHealth

    if health/maxHealth >= 1 then
        healthbar.Enabled = false
        return
    else
        healthbar.Enabled = true
        greenFrame.Size = UDim2.new(component.health/component.maxHealth,0,1,0)
    end
end

function ActorHealthbarSystem:onComponentAdded(instance, component)
    -- on component add create a bodyvelocity bodyforce and bodygyro
    local healthbar = healthbarTemplate:clone()

    component.changed:connect(function(prop, new, old)
        if not prop == "health" and not prop == "maxHealth" then return end
        self:onComponentChange(instance, component)
    end)

    healthbar.Parent = instance

    self:onComponentChange(instance,component)
end

function ActorHealthbarSystem:onComponentRemoving(instance,component)
    local healthbar = instance:FindFirstChild("Healthbar")
    if not healthbar then return end
    healthbar:Destroy()
end

function ActorHealthbarSystem:init()

    for instance,component in self.core:components(RecsComponents.ActorStats) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.ActorStats):connect(function(instance,component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.ActorStats):connect(function(instance,component)
    end)
end

function ActorHealthbarSystem:step()
end

return ActorHealthbarSystem