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
            speaker = "Big Smelly",

            rootNode = newNode({
                text = "I have a secret! Keep talking to me to find out more!",
                options = {
                    newOption({
                        text = "Oh noes!"
                    }),
                    math.random() < 0.1 and newOption({
                        text = "PEPPERONI SECRET!",
                        onSelect = function(player, server)
                            local storeContainer = server:getModule("StoreContainer")

                            storeContainer:getStore():andThen(function(store)
                                store:dispatch({
                                    type = "ITEM_ADD",
                                    player = player,
                                    itemId = "pepperoni",
                                    quantity = 1,
                                    replicateTo = player
                                })
                            end)
                        end
                    }) or nil,
                }
            })
        })
    end
}