-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local swordResponse = newNode({
    text = "You spawned with a sword ya dingus."
})

return {
    id = script.Name,
    closeOnWalkAway = true,
    create = function(server, player)
        return newConversation({
            speaker = "Miner",

            rootNode = newNode({
                text = "There are lots of monsters outside town! Best bring a weapon if you're going adventuring.",
                options = {
                    newOption({
                        text = "Where can I get a weapon?",
                        nextNode = swordResponse
                    }),
                }
            })
        })
    end
}