-- local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
-- local Workspace = game:GetService("Workspace")
-- local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))
local NPCS = require(common:WaitForChild("NPCS"))

local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local NPCCreationSystem = RECS.System:extend("NPCCreationSystem")

function NPCCreationSystem:onComponentAdded(instance, component)
    local npcDesc = NPCS.byType[component.npcType]

    assert(npcDesc, "Cannot find npc of type: "..component.npcType)

    local overrideProps = npcDesc.propsGenerator()

    local npcComponents = { -- order matters!
        "NPCDriver",
        "DamagedBy",
        "ActorStats",
        "ItemDrops",
        "AI",
    }

    for _,componentName in pairs(npcComponents) do
        local propsOverride = Dictionary.join(overrideProps[componentName], {
            npcType = component.npcType
        })
        self.core:addComponent(instance, self.core:getComponentClass(componentName), propsOverride)
        CollectionService:AddTag(instance,componentName)
    end

    local driver = self.core:getComponent(instance, "NPCDriver")
    driver:updateProperty("targetDirection", CFrame.Angles(0,math.random()*2*math.pi,0).LookVector)
end

function NPCCreationSystem:onComponentRemoving(instance,component)
end

function NPCCreationSystem:init()

    for instance,component in self.core:components(RecsComponents.NPC) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.NPC):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)
    self.core:getComponentRemovingSignal(RecsComponents.NPC):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function NPCCreationSystem:step()
end

return NPCCreationSystem