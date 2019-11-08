local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local selectors = script:FindFirstAncestor("Selectors")
local inventory = selectors.inventory

local Items = require(common.Items)

local getItem = require(inventory.getItem)

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