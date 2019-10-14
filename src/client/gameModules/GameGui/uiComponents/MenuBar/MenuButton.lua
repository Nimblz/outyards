local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage:WaitForChild("lib")
local component = script:FindFirstAncestor("uiComponents")

local Roact = require(lib:WaitForChild("Roact"))

local RoundButton = require(component:WaitForChild("RoundButton"))
local MenuButton = Roact.Component:extend("MenuButton")

function MenuButton:render()
    return Roact.createElement(RoundButton, {
        Size = UDim2.new(0,72,0,72),
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
            Size = UDim2.new(0,48,0,48),
        }),
    })
end

return MenuButton