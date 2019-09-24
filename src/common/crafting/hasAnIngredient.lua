local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Selectors = require(common:WaitForChild("Selectors"))
local Items = require(common:WaitForChild("Items"))

local function hasAnIngredient(state,player,itemId)
    local item = Items.byId[itemId]
    if not item then return false end
    local recipe = item.recipe
    if not recipe then return false end

    for id, _ in pairs(recipe) do
        if Selectors.getItem(state, player, id) > 0 then
            return true
        end
    end

    return false
end

return hasAnIngredient