local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "DamagedBy",
    generator = function()
        return {
            players = {}
        }
    end,
})