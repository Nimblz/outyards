local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "ItemDrops",
    generator = function()
        return {
            items = {
                -- {itemId = "matWood", dropRange = {min = 4, max = 10}, dropRate = 1.00}
            }
        }
    end,
})