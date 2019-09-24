local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Items = require(common:WaitForChild("Items"))

local hasAnIngredient = require(script.Parent:WaitForChild("hasAnIngredient"))

local function getItemsWithIngredientOwned(state,player)
    local hasAnIngredientItems = {}

    for id, item in pairs(Items.byId) do
        if item.recipe then
            if hasAnIngredient(state,player,id) then
                hasAnIngredientItems[id] = true
            end
        end
    end
    return hasAnIngredientItems
end

return getItemsWithIngredientOwned