-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

local pickaxeResponse = newNode({
    text = "I would give you one of my old ones, but it doesnt exist yet!"
})

return {
    id = script.Name,
    closeOnWalkAway = true,
    create = function(server, player)
        return newConversation({
            speaker = "Miner",

            rootNode = newNode({
                text = "There are lots of ores in caves! You'll need a pickaxe to mine them, though!",
                options = {
                    newOption({
                        text = "Where do I get a pickaxe?",
                        nextNode = pickaxeResponse
                    }),
                }
            })
        })
    end
}