local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "SpawnZone",
    generator = function(props)
        return Dictionary.join({
            spawnables = {},
            spawnRate = 1, -- every n ticks
            counter = 0, -- when counter == rate, cointer gets set to 0 and mob is spawned
            spawnCap = 30,
        },props)
    end,
})