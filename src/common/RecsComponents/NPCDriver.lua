-- REMEMBER: YOU GOTTA USE component:updateProperty(key,value) TO TRIGGER CHANGED EVENT!

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "NPCDriver",
    generator = function(props)
        return Dictionary.join({
            disabled = false,
            knockbacking = false,
            gravityWeight = 1,
            targetVelocity = Vector3.new(0,0,0),
            targetDirection = Vector3.new(0,0,-1),
            maxMoveForce = Vector3.new(1000,0,1000),
        },props)
    end,
})