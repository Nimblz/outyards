local getInventory = require(script.Parent.getInventory)

return function(state,player,itemId)
    local inv = getInventory(state,player)
    if inv then
        return inv[itemId] or 0
    end
end