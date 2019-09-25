local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "SpawnZone",
    generator = function()
        return {
            spawnables = {},
            spawnRate = 1, -- every n ticks
            counter = 0, -- when counter == rate, cointer gets set to 0 and mob is spawned
            spawnCap = 100,
        }
    end,
})