local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local model = ReplicatedStorage:WaitForChild("model")
local npcModel = model:WaitForChild("npc")

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local flashModel = require(util:WaitForChild("flashModel"))

local ActorRigSystem = RECS.System:extend("ActorRigSystem")

local npcModels = {}
for _,child in pairs(npcModel:GetDescendants()) do
    if child:IsA("Model") and child:FindFirstChild("AnimationController") then
        npcModels[child.Name] = child
    end
end

function ActorRigSystem:onComponentAdded(instance)
    local alreadyrig = self.rigs[instance]
    if alreadyrig then return end

    local npcComponent = self.core:getComponent(instance, RecsComponents.NPC)
    local actorStats = self.core:getComponent(instance, RecsComponents.ActorStats)
    local ai = self.core:getComponent(instance, RecsComponents.AI)

    if not npcComponent then return end
    if not actorStats then return end
    if not ai then return end

    local npcType = npcComponent.npcType

    local rig = npcModels[npcType]
    if not rig then return end

    rig = rig:Clone()
    rig.PrimaryPart.Anchored = false
    rig:SetPrimaryPartCFrame(instance.CFrame)

    local weld = Instance.new("Motor6D")
    weld.Part0 = rig.PrimaryPart
    weld.Part1 = instance
    weld.Parent = rig.PrimaryPart

    rig.Parent = self.rigBin

    self.core:addComponent(instance, RecsComponents.Rig, {
        rigModel = rig
    })

    if actorStats then
        actorStats.changed:connect(function(key, new, old)
            if key == "health" and new < old then
                flashModel(rig,Color3.new(1,0,0),0.2,0.1)
            end
        end)
    end

    self.rigs[instance] = rig

    instance.Transparency = 1
end

function ActorRigSystem:onComponentRemoving(instance, component)
    local rig = self.rigs[instance]
    if rig then rig:Destroy() end
end

function ActorRigSystem:init()
    self.rigBin = Instance.new("Folder")
    self.rigBin.Name = "rigbin"
    self.rigBin.Parent = Workspace

    self.rigs = {}

    for instance in self.core:components(RecsComponents.NPC, RecsComponents.ActorStats, RecsComponents.AI) do
        self:onComponentAdded(instance)
    end

    self.core:getComponentAddedSignal(RecsComponents.NPC):connect(function(instance,component)
        self:onComponentAdded(instance)
    end)
    self.core:getComponentAddedSignal(RecsComponents.ActorStats):connect(function(instance,component)
        self:onComponentAdded(instance)
    end)
    self.core:getComponentAddedSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentAdded(instance)
    end)

    self.core:getComponentRemovingSignal(RecsComponents.AI):connect(function(instance,component)
        self:onComponentRemoving(instance)
    end)
end

function ActorRigSystem:step()
end

return ActorRigSystem