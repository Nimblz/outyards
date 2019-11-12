local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local event = ReplicatedStorage.event
local interactionEvent = event.interaction

local RECS = require(lib.RECS)
local RecsComponents = require(common.RecsComponents)

local eRequestInteract = interactionEvent.eRequestInteract

local DialogueSystem = RECS.System:extend("DialogueSystem")

function DialogueSystem:init()
    eRequestInteract.OnServerEvent:connect(function(player, instance)
        local interactableComponent = self.core:getComponent(instance, RecsComponents.Interactable)
        local dialogueComponent = self.core:getComponent(instance, RecsComponents.Dialogue)

        if interactableComponent and dialogueComponent then
            local conversationId = dialogueComponent.conversationId

            local dialogue = self.pzCore:getModule("Dialogue")
            dialogue:startConversation(player, conversationId)
        end
    end)
end

return DialogueSystem