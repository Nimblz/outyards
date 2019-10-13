local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")
local event = ReplicatedStorage:WaitForChild("event")
local component = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local RoundFrame = require(component:WaitForChild("RoundFrame"))
local MenuButton = Roact.Component:extend("MenuButton")

function MenuButton:init()
end

function MenuButton:didMount()
end

function MenuButton:render()
    return Roact.createElement(RoundFrame, {
        class = "ImageButton",

        Size = UDim2.new(0,100,0,100),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.new(1,1,1),
        LayoutOrder = self.props.layoutOrder,
    }, {
        icon = Roact.createElement("ImageLabel", {
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            BackgroundTransparency = 1,
            Image = self.props.icon,
            ImageColor3 = Color3.new(0,0,0),
            Size = UDim2.new(0,64,0,64),
        }),
    })
end

return MenuButton