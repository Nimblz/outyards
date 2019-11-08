local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

local commonReducer = require(common.commonReducer)

return function(state, action)
    state = state or {}

    return Dictionary.join(commonReducer(state,action), {
    })
end