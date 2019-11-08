local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local RECS = require(lib.RECS)

return RECS.defineComponent({
    name = "AI",
    generator = function(props)
        return Dictionary.join({
            aiType = "Fighter",
            aiState = nil,
            animationState = nil,
            replicates = true,
        },props)
    end,
})