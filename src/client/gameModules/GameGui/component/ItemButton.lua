local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lib = ReplicatedStorage.lib
local common = ReplicatedStorage.common
local util = common.util
local component = script:FindFirstAncestor("component")

local Roact = require(lib.Roact)
local Items = require(common.Items)
local Sprites = require(common.Sprites)

local beautifyNumber = require(util.beautifyNumber)

local SpriteLabel = require(component.SpriteLabel)
local RoundButton = require(component.RoundButton)

local ItemButton = Roact.Component:extend("ItemButton")

local errors = {
    invalidItemId = "Invalid itemId [%s]!",
    invalidSpriteSheet = "Invalid sprite sheet [%s]!",
}

function ItemButton:activated(rbx)
    if self.props.onActivated then self.props.onActivated(rbx) end
end

function ItemButton:hovered(rbx)
    if self.props.onHovered then self.props.onHovered(rbx) end
end

function ItemButton:unhovered(rbx)
    if self.props.onUnhovered then self.props.onUnhovered(rbx) end
end

function ItemButton:render()
    local itemId = self.props.itemId
    local layoutOrder = self.props.layoutOrder
    local isHidden = self.props.isHidden
    local scale = self.props.scale or 4
    local quantity = self.props.quantity

    local item = Items.byId[itemId]
    assert(item, errors.invalidItemId:format(tostring(itemId)))
    local spriteSheet = Sprites[item.spriteSheet or "materials"]
    assert(spriteSheet, errors.invalidSpriteSheet:format(tostring(spriteSheet)))

    local spriteSize = spriteSheet.spriteSize
    local backgroundFrameSize = (spriteSize * scale) + Vector2.new(8,8)

    local spriteLabel = Roact.createElement(SpriteLabel, {
        itemId = itemId,
        layoutOrder = layoutOrder,
        color = isHidden and Color3.new(0.2, 0.2, 0.2),
        scale = scale,
    })

    local quantityLabel = Roact.createElement("TextLabel", {
        Size = UDim2.new(0,24,0,24),
        AnchorPoint = Vector2.new(1,1),
        Position = UDim2.new(1,-4,1,-4),
        BackgroundTransparency = 1,
        Text = beautifyNumber(quantity, nil, nil, 1),
        TextSize = 20,
        TextColor3 = Color3.new(1,1,1),
        TextStrokeTransparency = 0,
        Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Bottom,
        ZIndex = 3
    })

    return Roact.createElement(RoundButton, {
        Size = UDim2.fromOffset(backgroundFrameSize.X, backgroundFrameSize.Y),

        [Roact.Event.Activated] = function(rbx) self:activated(rbx) end,
        [Roact.Event.MouseEnter] = function(rbx) self:hovered(rbx) end,
        [Roact.Event.MouseLeave] = function(rbx) self:unhovered(rbx) end,
    }, {
        sprite = spriteLabel,
        quantity = quantityLabel,
    })
end

return ItemButton