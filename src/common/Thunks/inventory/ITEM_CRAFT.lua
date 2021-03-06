local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Items = require(common.Items)
local Selectors = require(common.Selectors)
local Actions = require(common.Actions)


return function(player,itemToCraftId)
    return function (store)
        local state = store:getState()
        local itemToCraft = Items.byId[itemToCraftId]
        if not itemToCraft then return end
        local recipe = itemToCraft.recipe
        if not recipe then return end

        if Selectors.canCraft(state, player, itemToCraftId) then
            for id, quantity in pairs(recipe) do
                store:dispatch(Actions.ITEM_REMOVE(player, id, quantity))
            end
            store:dispatch(Actions.ITEM_ADD(player, itemToCraftId, itemToCraft.craftQuantity or 1))
        end
    end
end