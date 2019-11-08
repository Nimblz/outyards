local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local RECS = require(lib.RECS)

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