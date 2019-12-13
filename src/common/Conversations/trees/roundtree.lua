-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local questConversation = newConversation({
    speaker = "Tree Hugger",

    rootNode = newNode({
        text =  "What an odd tree.",
        options = {
            newOption({
                text = "What's with this tree",
                nextNode = newNode({
                    text =
                        "I dunno lol"
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