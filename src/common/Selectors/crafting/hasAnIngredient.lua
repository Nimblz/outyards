local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local selectors = script:FindFirstAncestor("Selectors")
local inventory = selectors:WaitForChild("inventory")

local Items = require(common:WaitForChild("Items"))

local getItem = require(inventory:WaitForChild("getItem"))

local function hasAnIngredient(state,player,itemId)
    local item = Items.byId[itemId]
    if not item then return false end
    local recipe = item.recipe
    if not recipe then return false end

    for id, _ in pairs(recipe) do
        if getItem(state, player, id) > 0 then
            return true
        end
    end

    return false
end

return hasAnIngredient