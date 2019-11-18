-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local questConversation = newConversation({
    speaker = "Door Guardian",

    rootNode = newNode({
        text = "Turn back small one. The forest of giants is no place for you.",
        options = {
            newOption({
                text = "Let me through!",
                nextNode = newNode({
                    text =
                        "You would last for less than an hour. Come back when you're stronger.\n"..
                        "(Quest WIP)"
                })
            }),
        }
    })
})

return {
    id = script.Name,
    closeOnWalkAway = true,
    create = function(player, server)
        return questConversation
    end
}