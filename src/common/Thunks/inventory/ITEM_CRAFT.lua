local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local crafting = common:WaitForChild("crafting")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))
local Actions = require(common:WaitForChild("Actions"))

local canCraft = require(crafting:WaitForChild("canCraft"))

return function(player,itemToCraftId)
    return function (store)
        local state = store:getState()
        local itemToCraft = Items.byId[itemToCraftId]
        local recipe = itemToCraft.recipe

        if not recipe then return end

        if canCraft(state, player, itemToCraftId) then
            for id, quantity in pairs(recipe) do
                store:dispatch(Actions.ITEM_REMOVE(player, id, quantity))
            end
            store:dispatch(Actions.ITEM_ADD(player, itemToCraftId, itemToCraft.craftQuantity or 1))
        end
    end
end