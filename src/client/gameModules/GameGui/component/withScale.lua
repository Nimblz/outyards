local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local util = common:WaitForChild("util")
local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("component")

local Dictionary = require(util:WaitForChild("Dictionary"))
local Roact = require(lib:WaitForChild("Roact"))

local ScreenScaler = require(component:WaitForChild("ScreenScaler"))

local function withScale(kind, scaleProps)
    return function(props)
        local children = props[Roact.Children]

        local prunedProps = Dictionary.join(props, {
            [Roact.Children] = Dictionary.None,
        })

        local joinedChildren = Dictionary.join(children, {
            ["scaler"] = Roact.createElement(ScreenScaler, scaleProps or ScreenScaler.defaultProps)
        })

        return Roact.createElement(kind, prunedProps, joinedChildren)
    end
end

return withScale