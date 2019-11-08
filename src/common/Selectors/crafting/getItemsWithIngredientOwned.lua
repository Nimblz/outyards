local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Items = require(common.Items)

local selectors = script:FindFirstAncestor("Selectors")
local inventory = selectors.inventory

local getItem = require(inventory.getItem)
local hasAnIngredient = require(script.Parent.hasAnIngredient)

local function getItemsWithIngredientOwned(state,player)
    local hasAnIngredientItems = {}

    for id, item in pairs(Items.byId) do
        if item.recipe then
            local hasOne = getItem(state, player, id) >= 1
            local shouldShow = not (item.onlyOne and hasOne)
            if hasAnIngredient(state,player,id) and shouldShow then
                hasAnIngredientItems[id] = true
            end
        end
    end
    return hasAnIngredientItems
end

return getItemsWithIngredientOwned