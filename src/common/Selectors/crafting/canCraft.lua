local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common

local Items = require(common.Items)

local selectors = script:FindFirstAncestor("Selectors")
local inventory = selectors.inventory

local getItem = require(inventory.getItem)

local function canCraft(state,player,itemId)
    local item = Items.byId[itemId]
    if not item then return false end
    local recipe = item.recipe
    if not recipe then return false end

    if item.onlyOne and getItem(state, player, itemId) >= 1 then return false end

    for id, quantity in pairs(recipe) do
        if getItem(state, player, id) < quantity then
            return false
        end
    end
    return true
end

return canCraft