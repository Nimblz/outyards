local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")

local Dictionary = require(util:WaitForChild("Dictionary"))

local commonReducer = require(common:WaitForChild("commonReducer"))

local screenSize = require(script:WaitForChild("screenSize"))
local tooltipStrings = require(script:WaitForChild("tooltipStrings"))
local tooltipVisible = require(script:WaitForChild("tooltipVisible"))

return function(state, action)
    state = state or {}

    return Dictionary.join(commonReducer(state,action), {
        screenSize = screenSize(state.screenSize, action),
        tooltipStrings = tooltipStrings(state.tooltipStrings, action),
        tooltipVisible = tooltipVisible(state.tooltipVisible, action),
    })
end