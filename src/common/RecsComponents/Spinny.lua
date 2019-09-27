local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "Spinny",
    generator = function()
        return {
            spinRate = 1, -- per sec
            hoverDist = 1,
            hoverRate = 2,
        }
    end,
})