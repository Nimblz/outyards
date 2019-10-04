-- REMEMBER: YOU GOTTA USE component:updateProperty(key,value) TO TRIGGER CHANGED EVENT!

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "NPCDriver",
    generator = function(props)
        return Dictionary.join({
            gravityWeight = 1,
            targetVelocity = Vector3.new(0,0,0),
            targetDirection = Vector3.new(0,0,-1),
            maxMoveForce = Vector3.new(2000,0,2000),
        },props)
    end,
})