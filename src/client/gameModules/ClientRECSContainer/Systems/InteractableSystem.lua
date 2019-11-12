local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local event = ReplicatedStorage.event

local RECS = require(lib.RECS)
local RecsComponents = require(common.RecsComponents)
local Selectors = require(common.Selectors)
local Actions = require(common.Actions)

local eRequestInteract = event.interaction.eRequestInteract

local InteractableSystem = RECS.System:extend("InteractableSystem")

function InteractableSystem:init()
    local inputHandler = self.pzCore:getModule("InputHandler")
    local interactSignal = inputHandler:getActionSignal("interact")

    interactSignal.ended:connect(function()
        local state = self.store:getState()
        local targetInteractable = Selectors.getTargetInteractable(state)

        if targetInteractable then
            eRequestInteract:FireServer(targetInteractable)
        end
    end)
end

function InteractableSystem:step()
    local targetInstance = nil
    local targetDist = math.huge

    local char = LocalPlayer.Character
    if not char then return end
    local root = char.PrimaryPart
    if not root then return end

    local charPos = root.Position

    for instance, component in self.core:components(RecsComponents.Interactable) do
        local instanceRoot = instance
        if instance:IsA("Model") then
            instanceRoot = instance.PrimaryPart
            if not instanceRoot then return end
        end

        local dist = (instanceRoot.Position - charPos).magnitude

        if dist < component.maxUseDistance and dist < targetDist then
            targetInstance = instance
            targetDist = dist
        end
    end

    -- check if closest valid interactable is diff to current target
    -- if it is dispatch an action to change target
    local state = self.store:getState()
    local targetInteractable = Selectors.getTargetInteractable(state)

    if targetInstance ~= targetInteractable then
        self.store:dispatch(Actions.TARGETINTERACTABLE_SET(targetInstance))
    end
end

return InteractableSystem