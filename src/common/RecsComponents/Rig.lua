local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local RECS = require(lib:WaitForChild("RECS"))

return RECS.defineComponent({
    name = "Rig",
    generator = function(props)
        return Dictionary.join({
            rigModel = nil,
        }, props)
    end,
})