-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

return {
    id = script.Name,
    closeOnWalkAway = true,
    create = function(server, player)
        return newConversation({
            speaker = "Someone",

            rootNode = newNode({
                text = "I'm not implemented yet!",
                options = {
                    newOption({
                        text = "Oh noes!"
                    })
                }
            })
        })
    end
}