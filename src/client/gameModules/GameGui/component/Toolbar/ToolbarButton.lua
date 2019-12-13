local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local common = ReplicatedStorage.common
local lib = ReplicatedStorage.lib
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local RoactRodux = require(lib.RoactRodux)
local Selectors = require(common.Selectors)

local RoundButton = require(component.FancyButton)
local SpriteLabel = require(component.SpriteLabel)

local ToolbarButton = Roact.PureComponent:extend("ToolbarButton")

local BUTTON_SIZE = 64
local PADDING = 8

function ToolbarButton:init()
end

function ToolbarButton:didMount()
end

function ToolbarButton:render()
    local index = self.props.index
    local itemId = self.props.itemId
    local isEquipped = self.props.isEquipped
    local isEquipping = self.props.isEquipping

    local spriteLabel = itemId and Roact.createElement(SpriteLabel, {
        itemId = itemId,
    })

    local equippedIndicator = isEquipped and Roact.createElement("ImageLabel", {
        Image = "rbxassetid://4360912343",

        AnchorPoint = Vector2.new(0,0),
        Position = UDim2.new(0,8,0,8),
        Size = UDim2.fromOffset(24,24),

        BackgroundTransparency = 1,
    })

    local equippingIndicator = isEquipping and Roact.createElement("ImageLabel", {
        Image = "rbxassetid://153287167",

        AnchorPoint = Vector2.new(0.5,1),
        Position = UDim2.new(0.5,0,0,-8),
        Size = UDim2.fromScale(0.5,0.5),

        BackgroundTransparency = 1,
    })

    local keyLabel = Roact.createElement("ImageLabel", {
        Image = "rbxassetid://4448180888",

        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(1,-4,1,-4),
        Size = UDim2.fromOffset(24,24),
        ImageColor3 = Color3.fromRGB(216, 216, 216),

        BackgroundTransparency = 1,
    }, {
        textLabel = Roact.createElement("TextLabel", {
            Text = tostring(index),
            Font = Enum.Font.GothamSemibold,
            TextSize = 18,
            Size = UDim2.fromScale(1,1),
            BackgroundTransparency = 1,
        })
    })

    return Roact.createElement(RoundButton, {
        Size = UDim2.fromOffset(BUTTON_SIZE+PADDING*2,BUTTON_SIZE+PADDING*2),
        color = Color3.fromRGB(255,255,255),
        LayoutOrder = index,

        [Roact.Event.Activated] = function()
            self.props.onClick(index)
        end
    }, {
        spriteLabel = spriteLabel,
        equippedIndicator = equippedIndicator,
        equippingIndicator = equippingIndicator,
        keyLabel = keyLabel
    })
end

local function mapStateToProps(state, props)
    local isEquipping = Selectors.getIsEquipping(state)
    local isEquipped = Selectors.getIsEquipped(state, LocalPlayer, props.itemId)

    return {
        isEquipping = isEquipping,
        isEquipped = isEquipped,
    }
end

ToolbarButton = RoactRodux.connect(mapStateToProps)(ToolbarButton)

return ToolbarButton