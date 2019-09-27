local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Items = require(common:WaitForChild("Items"))
local Selectors = require(common:WaitForChild("Selectors"))

local hasAnIngredient = require(script.Parent:WaitForChild("hasAnIngredient"))

local function getItemsWithIngredientOwned(state,player)
    local hasAnIngredientItems = {}

    for id, item in pairs(Items.byId) do
        if item.recipe then
            local hasOne = Selectors.getItem(state, player, id) >= 1
            local shouldShow = not (item.onlyOne and hasOne)
            if hasAnIngredient(state,player,id) and shouldShow then
                hasAnIngredientItems[id] = true
            end
        end
    end
    return hasAnIngredientItems
end

return getItemsWithIngredientOwned