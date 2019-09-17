local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "NPCDriver",
    generator = function()
        return {
            gravityWeight = 1,
            targetVelocity = Vector3.new(0,0,0),
            targetDirection = Vector3.new(0,0,0),
        }
    end,
})