local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")

local Selectors = require(common:WaitForChild("Selectors"))
local Roact = require(lib:WaitForChild("Roact"))
local RoactRodux = require(lib:WaitForChild("RoactRodux"))

local StatsLabel = Roact.Component:extend("StatsLabel")

local ICON_SIZE = 24*3
local TEXT_WIDTH = 64

function StatsLabel:init()
end

function StatsLabel:didMount()
end

function StatsLabel:render()

    local iconImage = self.props.iconImage
    local statValue = self.props.statValue
    local layoutOrder = self.props.layoutOrder

    local children = {
        layout = Roact.createElement("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            Padding = UDim.new(0,0),
            FillDirection = Enum.FillDirection.Horizontal,
        }),
        icon = Roact.createElement("ImageLabel", {
            Image = iconImage,
            Size =  UDim2.new(0,ICON_SIZE,0,ICON_SIZE),
            BackgroundTransparency = 1,

            LayoutOrder = 1,
        }),
        value = Roact.createElement("TextLabel", {
            Text = " "..statValue,
            Size = UDim2.new(0,TEXT_WIDTH,0,ICON_SIZE),
            BackgroundTransparency = 1,

            TextSize = 32,
            Font = Enum.Font.GothamBlack,
            TextColor3 = Color3.new(1,1,1),
            TextStrokeTransparency = 0,
            TextXAlignment = Enum.TextXAlignment.Left,

            LayoutOrder = 2,
        }),
    }

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,ICON_SIZE + TEXT_WIDTH,0,ICON_SIZE),
        BackgroundTransparency = 1,

        LayoutOrder = layoutOrder,
    }, children)
end

return StatsLabel