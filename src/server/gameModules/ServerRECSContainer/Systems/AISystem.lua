local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local src = script:FindFirstAncestor("server")
local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local AI = require(src.ai:WaitForChild("AI"))
local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local AISystem = RECS.System:extend("AISystem")

function AISystem:onComponentAdded(instance,aiComponent)
    local newAI = AI.new(instance,self.core,self.pzCore, aiComponent.aiType)
    self.AIs[aiComponent] = newAI

    local actorStats = self.core:getComponent(instance,RecsComponents.ActorStats)
    local changedConnection
    changedConnection = actorStats.changed:connect(function(key,new,old)
        if key == "health" then
            if new <= 0 then
                changedConnection:disconnect()
                self.AIs[aiComponent]:kill()
                self.AIs[aiComponent] = nil
                instance:Destroy()
            end
        end
    end)
end

function AISystem:onComponentRemoving(instance,component)

end

function AISystem:init()
    self.AIs = {}

    for instance,component in self.core:components(RecsComponents.AI) do
        self:onComponentAdded(instance, component)
    end
    -- on component add create a bodyvelocity bodyforce and bodygyro
    self.core:getComponentAddedSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentAdded(instance,component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentRemoving(instance,component)
    end)
end

function AISystem:step()
    for _,ai in pairs(self.AIs) do
        ai:step()
    end
end

return AISystem