-- REMEMBER: YOU GOTTA USE component:updateProperty(key,value) TO TRIGGER CHANGED EVENT!

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "NPCDriver",
    generator = function()
        return {
            gravityWeight = 1,
            targetVelocity = Vector3.new(0,0,0),
            targetDirection = Vector3.new(0,0,-1),
            maxMoveForce = Vector3.new(1000,0,1000),
        }
    end,
})