-- creates a new instance of this conversation

local conversations = script:FindFirstAncestor("Conversations")

local newNode = require(conversations.newDialogueNode)
local newOption = require(conversations.newDialogueOption)
local newConversation = require(conversations.newConversation)

return {
    id = script.Name,
    closeOnWalkAway = true,
    create = function()
        return newConversation({
            speaker = "Not implemented conversation!",

            rootNode = newNode({
                text = "I'm not implemented! Tell nimbles!",
                options = {
                    newOption({
                        text = "Oh noes!"
                    }),
                    newOption({
                        text = "Uh oh!"
                    }),
                    newOption({
                        text = "Lol no thanks"
                    }),
                    math.random() < 0.5 and newOption({
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