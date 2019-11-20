local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)

local RoundButton = require(component.RoundButton)

local ToolbarButton = Roact.PureComponent:extend("ToolbarButton")

local BUTTON_SIZE = 64
local PADDING = 16

function ToolbarButton:init()
end

function ToolbarButton:didMount()
end

function ToolbarButton:render()
    return Roact.createElement(RoundButton, {
        Size = UDim2.fromOffset(BUTTON_SIZE+PADDING*2,BUTTON_SIZE+PADDING*2),
        color = Color3.fromRGB(225, 225, 225),
    })
end

return ToolbarButton