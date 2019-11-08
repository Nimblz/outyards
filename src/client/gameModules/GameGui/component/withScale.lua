local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local util = common.util
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Dictionary = require(util.Dictionary)
local Roact = require(lib.Roact)

local ScreenScaler = require(component.ScreenScaler)

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