local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "ItemDrops",
    generator = function(props)
        return Dictionary.join({
            items = {
                -- {itemId = "matWood", dropRange = {min = 4, max = 10}, dropRate = 1.00}
            },
            cash = 1,
        }, props)
    end,
})