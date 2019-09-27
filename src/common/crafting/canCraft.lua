local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")

local Selectors = require(common:WaitForChild("Selectors"))
local Items = require(common:WaitForChild("Items"))

local function canCraft(state,player,itemId)
    local item = Items.byId[itemId]
    if not item then return false end
    local recipe = item.recipe
    if not recipe then return false end

    if item.onlyOne and Selectors.getItem(state, player, itemId) >= 1 then return false end

    for id, quantity in pairs(recipe) do
        if Selectors.getItem(state, player, id) < quantity then
            return false
        end
    end
    return true
end

return canCraft