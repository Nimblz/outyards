local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer
local PhysicsService = game:GetService("PhysicsService")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
-- local util = common:WaitForChild("util")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))
local Selectors = require(common:WaitForChild("Selectors"))

local ItemDoorSystem = RECS.System:extend("ItemDoorSystem")

local function playerFromHit(hit)
    return Players:GetPlayerFromCharacter(hit.Parent)
end

function ItemDoorSystem:onComponentChange(instance, component)
end

function ItemDoorSystem:onComponentAdded(instance, component)
    if not instance:IsA("Model") then return end
    local trigger = instance.PrimaryPart
    assert(trigger, "Door does not have trigger: "..instance:GetFullName())

    trigger.Touched:connect(function(hit)
        local state = self.store:getState()

        local player = playerFromHit(hit)

        if player then
            local itemCount = Selectors.getItem(state,player,component.keyItem)
            if itemCount >= 1 then
                instance:Destroy()
            else
            end
        end
    end)
end

function ItemDoorSystem:onComponentRemoving(instance,component)
end

function ItemDoorSystem:init()

    for instance,component in self.core:components(RecsComponents.ItemDoor) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.NPCDriver):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.NPCDriver):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function ItemDoorSystem:step()
end

return ItemDoorSystem