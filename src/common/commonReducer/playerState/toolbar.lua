local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util

local Dictionary = require(util.Dictionary)

return function (state, action)
    state = state or {}

    if action.type == "TOOLBAR_SET" then
        return Dictionary.join(state, {
            [action.index] = action.itemId
        })
    end

    return state
end