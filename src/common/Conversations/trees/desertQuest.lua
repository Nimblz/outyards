-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local questConversation = newConversation({
    speaker = "Guard Captian",

    rootNode = newNode({
        text =  "Past this gate is the desert.\n"..
                "You dont want to go there. "..
                "Things that die there get back up as monsters.",
        options = {
            newOption({
                text = "Let me through!",
                nextNode = newNode({
                    text = "I cant do that. You'll just be killed and end up a problem for the town later.",
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