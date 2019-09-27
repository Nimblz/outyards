local inventory = script:FindFirstAncestor("inventory")
local getInventory = require(inventory.getInventory)

return function(state,player,itemId)
    local inv = getInventory(state,player)
    if inv then
        return inv[itemId] or 0
    end
end