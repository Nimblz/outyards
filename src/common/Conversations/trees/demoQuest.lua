-- creates a new instance of this conversation

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event

local Selectors = require(common.Selectors)

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local questConversation = newConversation({
    speaker = "Guard Captian",

    rootNode = newNode({
        text =  "Hey! This is a demo!\nGo kill the Ogre king way over there!\n"..
                "If you bring me his crown I'll say thanks!",
        options = {
            newOption({
                text = "Rad!",
            }),
        }
    })
})

local completeConversation = newConversation({
    speaker = "Guard Captian",

    rootNode = newNode({
        text =  "Good job!",
        options = {
            newOption({
                text = "Rad!",
                nextNode = newNode({
                    text = "Thanks!",
                })
            }),
        }
    })
})

return {
    id = script.Name,
    closeOnWalkAway = true,
    create = function(player, server)
        local storeContainer = server:getModule("StoreContainer")
        local store = storeContainer.store
        if not store then store = storeContainer.storeCreated:wait() end
        local state = store:getState()

        local hasCrown = Selectors.getItem(state, player, "kingCrown") > 0
        if not hasCrown then
            return questConversation
        else
            return completeConversation
        end
    end
}