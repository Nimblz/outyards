local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local event = ReplicatedStorage.event
local component = script:FindFirstAncestor("component")

local Selectors = require(common.Selectors)
local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)

local RoundFrame = require(component.RoundFrame)
local Codes = Roact.Component:extend("Codes")

local makeView = require(script.Parent.makeView)

function Codes:init()
end

function Codes:didMount()
end

function Codes:render()
    local visible = self.props.visible

    return Roact.createElement(RoundFrame, {
        ImageTransparency = 0,
        Position = UDim2.new(0.5,0,0.5,0),
        Size = UDim2.new(0,600,0,400),
        AnchorPoint = Vector2.new(0.5,0.5),
        Visible = visible
    }, {
        Roact.createElement("TextLabel", {
            Text = "WIP LOL",
            Font = Enum.Font.GothamBlack,
            Size = UDim2.new(1,0,1,0),
            TextSize = 64,
            BackgroundTransparency = 1,
        })
    })
end

Codes = makeView(Codes, "codes")

return Codes