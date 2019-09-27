local inventory = script:FindFirstAncestor("inventory")
local getEquipped = require(inventory.getEquipped)

return function(state,player,itemId)
    local equipped = getEquipped(state,player)
    if equipped then
        for _,equippedId in pairs(equipped) do
            if equippedId == itemId then
                return true
            end
        end
    end
    return false
end