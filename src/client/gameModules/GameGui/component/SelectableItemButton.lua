local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Dictionary = require(util.Dictionary)

local ItemButton = require(component.ItemButton)

local InvItemButton = Roact.PureComponent:extend("InvItemButton")

function InvItemButton:init()
end

function InvItemButton:didMount()
end

function InvItemButton:render()
    local itemButton = Roact.createElement(ItemButton, self.props)

    local selectionOutline = Roact.createElement("ImageLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,4,1,4),
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.fromScale(0.5,0.5),

        Image = "rbxassetid://4482432252",
        ImageColor3 = Color3.fromRGB(0, 0, 0),

        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(32,32,32,32),

        ZIndex = 3,
    })

    return Roact.createElement("Frame", {
        BackgroundTransparency = 1,
        LayoutOrder = self.props.LayoutOrder
    }, {
        button = itemButton,
        selectionOutline = self.props.selected and selectionOutline
    })
end

return InvItemButton