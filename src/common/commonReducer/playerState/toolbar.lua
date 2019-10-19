local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

return function (state, action)
    state = state or {}

    if action.type == "TOOLBAR_SET" then
        return Dictionary.join(state, {
            [action.index] = action.itemId
        })
    end

    return state
end