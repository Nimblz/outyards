local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "SpawnZone",
    generator = function(props)
        return Dictionary.join({
            spawnables = {},
            spawnRate = 20, -- every n ticks
            counter = 0, -- when counter == rate, counter gets set to 0 and mob is spawned
            groupRadius = 32,
            groupCount = NumberRange.new(5,10),
            spawnCap = 50,
        }, props)
    end,
})