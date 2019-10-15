local ReplicatedStorage = game:GetService("ReplicatedStorage")

local common = ReplicatedStorage:WaitForChild("common")
local lib = ReplicatedStorage:WaitForChild("lib")

local Roact = require(lib:WaitForChild("Roact"))

local NotificationLabel = Roact.Component:extend("NotificationLabel")

function NotificationLabel:init(initialProps)
end

function NotificationLabel:render()
    local children = {}

    children.content = Roact.createElement("Frame", {
        Size = UDim2.new(1,0,1,-4),
        BackgroundTransparency = 1,
    }, {
        listlayout = Roact.createElement("UIListLayout", {
            Padding = UDim.new(0,16),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
        }),
        uipadding = Roact.createElement("UIPadding", {
            PaddingBottom = UDim.new(0,8),
            PaddingLeft = UDim.new(0,8),
            PaddingRight = UDim.new(0,8),
            PaddingTop = UDim.new(0,8),
        }),
        thumbnail = Roact.createElement("ImageLabel", {
            Size = UDim2.new(0,64,0,64),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Image = self.props.thumbnail or "rbxasset://textures/ui/GuiImagePlaceholder.png",
            ImageRectSize = self.props.rectSize or Vector2.new(0,0),
            ImageRectOffset = self.props.rectOffset or Vector2.new(0,0),
            LayoutOrder = 1,
        }),
        textLabel = Roact.createElement("TextLabel", {
            Size = UDim2.new(1,-80,0,50),
            BackgroundTransparency = 1,
            Text = self.props.text or "/I SEE YOU/",
            Font = Enum.Font.GothamSemibold,
            TextSize = 16,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2,
        })
    })

    children.statusBar = Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0,1),
        Position = UDim2.new(0,0,1,0),
        Size = UDim2.new(1,0,0,4),

        BackgroundColor3 = self.props.statusColor or Color3.fromRGB(20,20,40),
        BorderSizePixel = 0,
    })

    return Roact.createElement("Frame", {
        Size = UDim2.new(0,300,0,80),
        BackgroundColor3 = Color3.fromRGB(255,255,255),
        BorderSizePixel = 0,
        LayoutOrder = self.props.layoutIndex or 0,
    }, children)
end

return NotificationLabel