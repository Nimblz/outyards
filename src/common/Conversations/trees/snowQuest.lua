-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local questConversation = newConversation({
    speaker = "Gate Guard",

    rootNode = newNode({
        text =  "Past this gate is the tundra. "..
                "There's lots of monsters there as of late - "..
                "I suppose that's why the town put up this gate.",
        options = {
            newOption({
                text = "Let me through!",
                nextNode = newNode({
                    text =
                        "It's dangerous out there! You're gonna need to prove to me that you can survive.\n"..
                        "Come back with the ogre king's crown and I'll unlock the gate for you."
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