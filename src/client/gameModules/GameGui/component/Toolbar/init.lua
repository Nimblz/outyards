local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")
local util = common.util

local Selectors = require(common.Selectors)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local withScale = require(component.withScale)
local Weaponbar = require(script.Weaponbar)

local Toolbar = Roact.Component:extend("Toolbar")

local FrameWithScale = withScale("Frame")

function Toolbar:init()
end

function Toolbar:render()
    return self.props.visible and Roact.createElement(FrameWithScale,{
        Size = UDim2.fromScale(1,1),
        Position = UDim2.fromScale(0.5,1),
        AnchorPoint = Vector2.new(0.5,1),
        BackgroundTransparency = 1,
    }, {
        padding = Roact.createElement("UIPadding", {
            PaddingTop = UDim.new(0,16),
            PaddingBottom = UDim.new(0,16),
            PaddingLeft = UDim.new(0,16),
            PaddingRight = UDim.new(0,16),
        }),
        layout = Roact.createElement("UIListLayout",{
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0,16),
        }),
        weaponbar = Roact.createElement(Weaponbar),
    })
end

local function mapStateToProps(state, props)
    return {
        visible = Selectors.getToolbarVisible(state),
    }
end

Toolbar = RoactRodux.connect(mapStateToProps)(Toolbar)

return Toolbar