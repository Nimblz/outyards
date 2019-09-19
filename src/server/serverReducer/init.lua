local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local commonReducer = require(common:WaitForChild("commonReducer"))

return function(state, action)
    local state = state or {}

    return Dictionary.join(commonReducer(state,action), {
    })
end