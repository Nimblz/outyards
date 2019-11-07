local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")

local Animations = require(common:WaitForChild("Animations"))
local NPCS = require(common:WaitForChild("NPCS"))
local RECS = require(lib:WaitForChild("RECS"))
local RecsComponents = require(common:WaitForChild("RecsComponents"))

local RigAnimationSystem = RECS.System:extend("RigAnimationSystem")

function RigAnimationSystem:onComponentAdded(instance, component)
    local aiComponent = self.core:getComponent(instance, RecsComponents.AI)
    local npcComponent = self.core:getComponent(instance, RecsComponents.NPC)
    local rig = component.rigModel
    local npcDesc = NPCS.byType[npcComponent.npcType or "noob"]

    if aiComponent and rig then
        local animationController = rig:FindFirstChildOfClass("AnimationController")

        local animations = {}

        for stateTrigger, animName in pairs(npcDesc.animations or {}) do
            local animationInstance = Animations[animName]
            if animationInstance then
                animations[stateTrigger] = animationController:LoadAnimation(animationInstance)
            end
        end

        local playingAnimation

        aiComponent.changed:connect(function(key, newValue, oldValue)
            if key == "animationState" then
                local newState = newValue.state
                if playingAnimation then playingAnimation:Stop() end
                if animations[newState] then
                    print(animations[newState])
                    playingAnimation = animations[newState]
                    animations[newState]:Play()
                end
            end
        end)

        if animations.idle then
            animations.idle:Play(0.2)
        end
    end
end

function RigAnimationSystem:onComponentRemoving(instance, component)
end

function RigAnimationSystem:init()
    for instance,component in self.core:components(RecsComponents.Rig) do
        self:onComponentAdded(instance, component)
    end

    self.core:getComponentAddedSignal(RecsComponents.Rig):connect(function(instance,component)
        self:onComponentAdded(instance, component)
    end)

    self.core:getComponentRemovingSignal(RecsComponents.Rig):connect(function(instance,component)
        self:onComponentRemoving(instance, component)
    end)
end

function RigAnimationSystem:step()
end

return RigAnimationSystem